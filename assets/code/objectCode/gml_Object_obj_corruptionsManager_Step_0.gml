if(keyboard_check_pressed(vk_f9)){
    var answer = show_question("Are you sure you would like to start the corruptions? >:)")
    if(answer){
        global.frames_per_corruption = 1
        global.corruptions_active = true
    }
}

if(global.corruptions_active){
    global.corruption_timer--;
    if(global.corruption_timer < 0){
        global.corruption_timer = global.frames_per_corruption
        gml_Script_scr_gamemakerCorrupter_NewCorruption()
    }
}