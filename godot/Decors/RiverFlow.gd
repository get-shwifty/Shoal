extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var index = randi() % 5
	$AnimatedSprite.frame = index
	if index % 2 == 1:
		scale.x = -scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
