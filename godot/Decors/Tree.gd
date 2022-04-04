extends Node2D

export var shadow = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
const probas = [[0.55, "green"], [0.85, "yellow"], [1, "red"]]

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var color_rand = rng.randf()
	for proba in probas:
		if proba[0] > color_rand:
			$TreeAnimation.animation = proba[1]
			break
	var frame_index = rng.randi_range(0, 2)
	$TreeAnimation.frame = frame_index
	if shadow == false:
		$Shadow.hide()
	else:
		$Shadow.frame = frame_index
	scale *= rng.randf_range(0.8, 1.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
