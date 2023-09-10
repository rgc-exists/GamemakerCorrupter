var corruption_type = irandom(100)
if(corruption_type <= 0){
    //Do nothing

} else if(corruption_type > 0 && corruption_type <= 3){
    //Change object sprite index
    var object_to_messUp = irandom(global.total_object_indexes)
    var newSprite = gml_Script_scr_gamemakerCorrupter_GetRandomSpriteBasedOnOldSize(object_get_sprite(object_to_messUp))
    object_set_sprite(object_to_messUp, newSprite)

} else if(corruption_type > 5 && corruption_type <= 30){
    //Change instance sprite index
    var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
    var object_to_messUp = instance_to_messUp.object_index
    var newSprite = gml_Script_scr_gamemakerCorrupter_GetRandomSpriteBasedOnOldSize(object_get_sprite(object_to_messUp))
    instance_to_messUp.sprite_index = newSprite
    
} else if(corruption_type > 30 && corruption_type <= 40){
    //Change instance image_index
    var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
    instance_to_messUp.image_index = irandom(sprite_get_number(instance_to_messUp.sprite_index))

} else if(corruption_type > 40 && corruption_type <= 60){
    //Change instance built-in value
    var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
    var builtInVarIndex = irandom(array_length(global.builtIn_varNames_changeable) - 1)
    var varNameToChange = global.builtIn_varNames_changeable[builtInVarIndex]
    var varIntensityRange = global.builtIn_vars_randomization_intensities[builtInVarIndex]
    variable_instance_set(instance_to_messUp, varNameToChange, variable_instance_get(instance_to_messUp, varNameToChange) + random_range(varIntensityRange[0], varIntensityRange[1]))

} else if(corruption_type > 60 && corruption_type <= 65){
    //Change random string in instance (from list of preset strings)
    var hasFoundInstanceWithString = false
    var findInstanceTries = 0
    while(!hasFoundInstanceWithString && findInstanceTries < 40){
        var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
        findInstanceTries++
        var findVarThatIsStringTries = 0
        var foundVarWithString = false 
        var instance_varNames = variable_instance_get_names(instance_to_messUp)
        var varName = ""
        if(array_length(instance_varNames) > 0){
            while(!foundVarWithString && findVarThatIsStringTries < 20){
                findVarThatIsStringTries++
                varName = instance_varNames[irandom(array_length(instance_varNames) - 1)]
                if(is_string(variable_instance_get(instance_to_messUp, varName))){
                    foundVarWithString = true
                }
            }
        }
        if(foundVarWithString){
            hasFoundInstanceWithString = true
            variable_instance_set(instance_to_messUp, varName, global.funny_corruption_strings[irandom(array_length(global.funny_corruption_strings) - 1)])
        }
    }
} else if(corruption_type > 65 && corruption_type <= 70){
    //Change random string in instance (random string of characters)
    var hasFoundInstanceWithString = false
    var findInstanceTries = 0
    while(!hasFoundInstanceWithString && findInstanceTries < 40){
        var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
        findInstanceTries++
        var findVarThatIsStringTries = 0
        var foundVarWithString = false 
        var instance_varNames = variable_instance_get_names(instance_to_messUp)
        var varName = ""
        if(array_length(instance_varNames) > 0){
            while(!foundVarWithString && findVarThatIsStringTries < 20){
                findVarThatIsStringTries++
                varName = instance_varNames[irandom(array_length(instance_varNames) - 1)]
                if(is_string(variable_instance_get(instance_to_messUp, varName))){
                    foundVarWithString = true
                }
            }
        }
        if(foundVarWithString){
            hasFoundInstanceWithString = true
            variable_instance_set(instance_to_messUp, varName, gml_Script_scr_gamemakerCorrupter_RandomString())
        }
    }
} else if(corruption_type > 70 && corruption_type <= 73){
    //Change random string in global variable (from list of preset strings)
    var instance_varNames = variable_instance_get_names(global)
    var varName = ""
    if(array_length(instance_varNames) > 0){
        var findVarThatIsStringTries = 0
        var foundVarWithString = false 
        while(!foundVarWithString && findVarThatIsStringTries < 20){
            findVarThatIsStringTries++
            varName = instance_varNames[irandom(array_length(instance_varNames) - 1)]
            if(is_string(variable_global_get(varName))){
                foundVarWithString = true
            }
        }
    }
    if(foundVarWithString){
        hasFoundInstanceWithString = true
        variable_global_set(varName, global.funny_corruption_strings[irandom(array_length(global.funny_corruption_strings) - 1)])
    }
} else if(corruption_type > 73 && corruption_type <= 75){
    //Change random string in global variable (from list of preset strings)
    var instance_varNames = variable_instance_get_names(global)
    var varName = ""
    if(array_length(instance_varNames) > 0){
        var findVarThatIsStringTries = 0
        var foundVarWithString = false 
        while(!foundVarWithString && findVarThatIsStringTries < 20){
            findVarThatIsStringTries++
            varName = instance_varNames[irandom(array_length(instance_varNames) - 1)]
            if(is_string(variable_global_get(varName))){
                foundVarWithString = true
            }
        }
    }
    if(foundVarWithString){
        hasFoundInstanceWithString = true
        variable_global_set(varName, gml_Script_scr_gamemakerCorrupter_RandomString())
    }
} else if(corruption_type > 75 && corruption_type <= 85){
    //Change instance image_blend
    var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
    instance_to_messUp.image_blend = make_color_rgb(irandom(255), irandom(255), irandom(255))

} else if(corruption_type > 85 && corruption_type <= 90){
    //Change instance image_blend
    var sound_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomPlayingSound()
    if(audio_is_playing(sound_to_messUp)){
        audio_sound_pitch(sound_to_messUp, random(2))
    }
} else if(corruption_type > 90 && corruption_type <= 95){
    //Change instance image_blend
    var sound_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomPlayingSound()
    if(audio_is_playing(sound_to_messUp)){
        audio_sound_gain(sound_to_messUp, random_range(-3, 5), random(2))
    }
} else if(corruption_type > 95 && corruption_type <= 99){
    //Change instance image_blend
    var sound_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomPlayingSound()
    if(audio_is_playing(sound_to_messUp)){
        var listenerInfo = audio_get_listener_info(sound_to_messUp)
        if(ds_exists(listenerInfo, ds_type_map)){
            audio_sound_set_track_position(sound_to_messUp, random(audio_sound_length(ds_map_find_value(listenerInfo, "index"))))
            ds_map_destroy(listenerInfo)
        }
    }
} else if(corruption_type > 99 && corruption_type <= 100){
    //Change instance built-in value to ABSURD value
    var instance_to_messUp = gml_Script_scr_gamemakerCorrupter_GetRandomInstance()
    var builtInVarIndex = irandom(array_length(global.builtIn_varNames_absurd_changeable) - 1)
    var varNameToChange = global.builtIn_varNames_absurd_changeable[builtInVarIndex]
    var varIntensityRange = global.builtIn_vars_absurd_randomization_intensities[builtInVarIndex]
    variable_instance_set(instance_to_messUp, varNameToChange, variable_instance_get(instance_to_messUp, varNameToChange) + random_range(varIntensityRange[0], varIntensityRange[1]))

} 


/*
TO ADD:
-ABSURD built-in values (rare option that doesnt listen to the normal boundaries of randomly setting built in values, only listens to whether they can go positive or negative.)
*/