extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "_on_Area2D_body_enter")
	pass # Replace with function body.

func _on_Area2D_body_enter(body):
	$FishCatcher.catch_fish(body)
	
