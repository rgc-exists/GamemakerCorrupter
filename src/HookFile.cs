namespace GamemakerCorrupter;

class HookFile
{
    public string? name { get; set; } // Name of the code
    public string? functionName { get; set; } // Name of the function to hook if isFunction == true
    public string? file { get; set; } // File to get new code from
    public string? type { get; set; } // Type of hook, prepend or append
    public string? line { get; set; } // Code for line to hook, minus indentation
    public bool isFunction { get; set; } // Is code inside a function
}