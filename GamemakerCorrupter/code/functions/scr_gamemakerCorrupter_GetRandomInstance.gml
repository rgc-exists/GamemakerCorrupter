if(instance_count > 0){
    while(true){
        var obj = irandom(global.total_object_indexes)
        if(instance_number(obj) > 0){
            var instance = instance_find(obj, irandom(instance_number(obj) - 1))
            return instance
        }
    }
} else {
    show_error("Tried to choose a random instance when there are no instances in the room. :(", true)
}