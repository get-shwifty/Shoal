extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$FishCatcher.catch_fish(body)


func _on_FishCatcher_fished(fished):
	print("toto")
	$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1,1,1,1), 
	Color(1,1,1,0), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
