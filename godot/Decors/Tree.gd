extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var index = rng.randi_range(0, 2)
	$AnimatedSprite.frame = index
	scale *= rng.randf_range(0.8, 1.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
