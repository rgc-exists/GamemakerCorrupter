global.total_object_indexes = 0
while(object_exists(global.total_object_indexes + 1)){
    global.total_object_indexes++
}

global.total_sprite_indexes = 0
while(sprite_exists(global.total_sprite_indexes + 1)){
    global.total_sprite_indexes++
}

global.total_room_indexes = 0
while(room_exists(global.total_room_indexes + 1)){
    global.total_room_indexes++
}
