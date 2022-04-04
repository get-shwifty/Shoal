extends Node2D

const ROTATION_SPEED = 100 # deg/s

onready var fishes = $Fishes

func _ready():
#	$AudioStreamPlayer.play()
	pass
	
func _process(delta):
	fishes.rotation_degrees -= ROTATION_SPEED * delta

func _on_Area2D_body_entered(body):
	$AudioStreamPlayer.play()
	call_deferred("add_fish", body)

func add_fish(body):
	print("before")
	$AudioStreamPlayer.play()
	print("after")
	for child in fishes.get_children() :
		var gp = child.global_position
		fishes.remove_child(child)
		child.set_collision_layer(10)
		child.rotation = 0
		body.get_parent().add_child(child)
		child.global_position = gp


func _on_AudioStreamPlayer_finished():
	queue_free()
