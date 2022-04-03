extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal fished
var is_active = true
var fishing = false
var fished = []
export(float) var fishing_time = 1
export var max_fish = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func stop_fish(fish: Fish):
	var temp_pos = fish.global_position
	fish.get_parent().remove_child(fish)
	fish.set_collision_layer_bit(1,0)
	fish.set_collision_mask_bit(1,0)
	fish.target_pos = null
	add_child(fish)
	fish.global_position = temp_pos
	
func catch_fish(body):
	if not is_active or body in fished or fished.size() >= max_fish:
		return
	fished.append(body)
	call_deferred('stop_fish', body)
	if not fishing:
		$Timer.start(fishing_time)
		fishing = true


func _on_Timer_timeout():
	for fish in fished:
		fish.queue_free()
	is_active = false
	emit_signal("fished", fished)
