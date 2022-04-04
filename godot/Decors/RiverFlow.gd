extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var index = rng.randi_range(0, 4)
	$AnimatedSprite.frame = index
	if index % 2 == 1:
		scale.x = -scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
