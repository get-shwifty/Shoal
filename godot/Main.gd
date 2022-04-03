extends Node2D

export (int) var CAMERA_SPEED = 50

func _ready():
	$AnimatedObjects/Player.connect("end_game", self, "_game_over")

func _physics_process(delta):
	$AnimatedObjects.position.y -= CAMERA_SPEED  * delta

func _game_over():
	get_tree().change_scene("res://Game_Over.tscn")
