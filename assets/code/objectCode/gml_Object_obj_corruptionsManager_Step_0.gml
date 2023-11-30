if(keyboard_check_pressed(vk_f9)){
    var answer = show_question("Are you sure you would like to start the corruptions? >:)")
    if(answer){
        global.frames_per_corruption = 1
        global.corruptions_active = true
        global.frames_per_corruption = get_integer("How many frames should be in between each corruption? (1 second = 60 frames)", 60)
        if(global.frames_per_corruption < 0){
            global.frames_per_corruption = 0
        }
        global.change_global_strings = show_question("Would you like to allow corruption global variables? IN MANY GAMES, SETTINGS MAY BE STORED HERE. USE AT YOUR OWN RISK.")
    }
}

if(global.corruptions_active){
    global.corruption_timer--;
    if(global.corruption_timer < 0){
        global.corruption_timer = global.frames_per_corruption
        gml_Script_scr_gamemakerCorrupter_NewCorruption()
    }
}