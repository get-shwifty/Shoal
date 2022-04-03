extends Node2D

export (int) var CAMERA_SPEED = 50

func _ready():
	pass
	

func _physics_process(delta):
	$AnimatedObjects.position.y -= CAMERA_SPEED  * delta
