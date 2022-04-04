extends Node2D

const gotya1 = preload("res://Assets/Sound/got_ya.ogg")
const gotya2 = preload("res://Assets/Sound/got_ya2.ogg")
const sounds = [gotya1, gotya2]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	$FishCatcher.catch_fish(body)


func _on_FishCatcher_fished(fish_list):
	if len(fish_list) > 0:
		randomize()
		$AudioStreamPlayer.stream = sounds[randi()%sounds.size()]
		$AudioStreamPlayer.play()
		$AnimatedSprite.play("Fish")
