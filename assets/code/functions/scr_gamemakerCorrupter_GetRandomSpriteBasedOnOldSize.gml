var oldSprite = argument0
var oldWidth = sprite_get_width(oldSprite)
var oldHeight = sprite_get_height(oldSprite)
var distanceInSizeX = irandom(180)
var distanceInSizeY = irandom(180)
var hasChosenSprite = false
var newSprite = 0
var chanceOfBeingSelected = irandom(10)
while(!hasChosenSprite){
    distanceInSizeX += irandom(30)
    distanceInSizeY += irandom(30)
    newSprite = irandom(global.total_sprite_indexes)
    var newWidth = sprite_get_width(newSprite)
    var newHeight = sprite_get_height(newSprite)
    if(abs(oldWidth - newWidth) < distanceInSizeX && abs(newHeight - oldHeight) < distanceInSizeY){
        if(irandom(chanceOfBeingSelected) == 0){
            hasChosenSprite = true
        }
    }
}
return newSprite