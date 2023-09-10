using GMHooker;
using UndertaleModLib;
using UndertaleModLib.Models;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Text.Json;
using System.Net;

namespace GamemakerCorrupter;

public partial class GameMakerMod
{

    public Dictionary<string, string> files = new();

    public UndertaleData data = new();

    public UndertaleGameObject obj_corruptionsManager;

    public void Load(int audioGroup, UndertaleData data_source)
    {
        data = data_source;

        Console.WriteLine("Adding Objects...");
        AddObjects();

        Console.WriteLine("Adding Code...");
        AddCode();

        Console.WriteLine("Done editing data!");
    }

    public void LoadFilesRecursively(string directoryPath, Action<string, string> fileAction)
    {
        foreach (var file in Directory.GetFiles(directoryPath))
        {
            Console.WriteLine("Loading " + file);
            string code = File.ReadAllText(file);
            fileAction.Invoke(code, file);
        }

        foreach (var subdirectory in Directory.GetDirectories(directoryPath))
        {
            LoadFilesRecursively(subdirectory, fileAction);
        }
    }
    public void AddObjects()
    {
        UndertaleString name = new UndertaleString("obj_corruptionsManager");
        obj_corruptionsManager = new UndertaleGameObject(){
            Persistent = true,
            Visible = true,
            Solid = false,
            Name = name
        };

        data.Strings.Add(name);
        data.GameObjects.Add(obj_corruptionsManager);
        

        UndertaleRoom start_room = data.Rooms[0];

        UndertaleRoom.GameObject obj_corruptionsManager_inst = new UndertaleRoom.GameObject()
        {
            InstanceID = data.GeneralInfo.LastObj,
            ObjectDefinition = obj_corruptionsManager,
            X = -120,
            Y = -120
        };
        data.GeneralInfo.LastObj++;

        start_room.Layers[0].InstancesData.Instances.Add(obj_corruptionsManager_inst);
        
        start_room.GameObjects.Add(obj_corruptionsManager_inst);
    }
    public void AddCode()
    {
        string baseDir = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) ?? "Error";

        if (baseDir == "Error")
        {
            Console.WriteLine("Can't find mod directory!");
            Console.WriteLine("Assembly.GetExecutingAssembly().Location is " + Assembly.GetExecutingAssembly().Location);
            Console.WriteLine("Please report this on the BSE discord (discord.gg/4RHXca3Dw6)");
            return;
        }

        Action<string, string> loadFunctionCode = (code, file) =>
        {
            MatchCollection matchList = Regex.Matches(code, @"(?<=argument)(\d*)");
            ushort argCount;
            if (matchList.Count > 0)
                argCount = (ushort)(matchList.Cast<Match>().Select(match => ushort.Parse(match.Value)).ToList().Max() + 1);
            else
                argCount = 0;

            data.CreateFunction(Path.GetFileNameWithoutExtension(file), code, argCount);
        };

        Action<string, string> loadCodeHook = (code, file) =>
        {
            data.HookCode(Path.GetFileNameWithoutExtension(file), code);
        };

        Action<string, string> loadFunctionHook = (code, file) =>
        {
            data.HookFunction(Path.GetFileNameWithoutExtension(file), code);
        };

        Action<string, string> loadObjectCode = (code, file) =>
        {
            if(!file.EndsWith(".json")){
                return;
            }
            ObjectFile? objCode = JsonSerializer.Deserialize<ObjectFile>(code);

            if (objCode == null)
            {
                Console.WriteLine(file + " is null, skipping...");
                return;
            }

            EventType type = (EventType)Enum.Parse(typeof(EventType), objCode.type);
            uint subtype;

            if (!objCode.hasSubtype) subtype = uint.Parse(objCode.subtype);
            else subtype = (uint)Enum.Parse(FindType("UndertaleModLib.Models.EventSubtype" + objCode.type), objCode.subtype);

            data.GameObjects.ByName(objCode.name).EventHandlerFor(type, subtype, data.Strings, data.Code, data.CodeLocals)
                .ReplaceGmlSafe(File.ReadAllText(Path.Combine(baseDir, "code", "objectCode", objCode.file)), data);
        };

        if(Directory.Exists(Path.Combine(baseDir, "code", "functions"))){
            LoadFilesRecursively(Path.Combine(baseDir, "code", "functions"), loadFunctionCode);
        }
        if(Directory.Exists(Path.Combine(baseDir, "code", "codeHooks"))){
            LoadFilesRecursively(Path.Combine(baseDir, "code", "codeHooks"), loadCodeHook);
        }
        if(Directory.Exists(Path.Combine(baseDir, "code", "functionHooks"))){
            LoadFilesRecursively(Path.Combine(baseDir, "code", "functionHooks"), loadFunctionHook);
        }
        if(Directory.Exists(Path.Combine(baseDir, "code", "objectCode"))){
            LoadFilesRecursively(Path.Combine(baseDir, "code", "objectCode"), loadObjectCode);
        }
    }



    public static Type? FindType(string qualifiedTypeName)
    {
        Type? t = Type.GetType(qualifiedTypeName);

        if (t != null)
        {
            return t;
        }
        else
        {
            foreach (Assembly asm in AppDomain.CurrentDomain.GetAssemblies())
            {
                t = asm.GetType(qualifiedTypeName);
                if (t != null)
                    return t;
            }
            return null;
        }
    }

}