extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal fished
var is_active = true
var fishing = false
var fished = []
export var fishing_time = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func catch_fish(body):
	if not is_active:
		return
	fished.append(body)
	if not fishing:
		$Timer.start(fishing_time)
		fishing = true


func _on_Timer_timeout():
	for fish in fished:
		fish.queue_free()
	is_active = false
	emit_signal("fished", fished)
