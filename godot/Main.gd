extends Node2D

export (int) var CAMERA_SPEED = 100

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$AnimatedObjects.position.y += CAMERA_SPEED  * delta
