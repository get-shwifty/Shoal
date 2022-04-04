extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.frame = int(rand_range(0, 4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(fish: Fish):
	print("slooooow")
	fish.velocity_debuff = 0.5


func _on_Area2D_body_exited(fish: Fish):
	fish.velocity_debuff = 1
