total_playing_sounds = 0
while(audio_is_playing(total_playing_sounds + 1)){
    total_playing_sounds++
}
if(audio_is_playing(total_playing_sounds)){
    chosen_sound = irandom(total_playing_sounds)
    while(!audio_is_playing(chosen_sound)){
        chosen_sound = irandom(total_playing_sounds)
    }
    return chosen_sound
}