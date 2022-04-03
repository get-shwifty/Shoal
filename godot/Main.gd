extends Node2D

export (int) var CAMERA_SPEED = 80
export (int) var NB_FISH_INIT = 12

var distance = 0
var number_of_fishes = 0
var score = 0
var max_of_fishes = NB_FISH_INIT

func _ready():
	$AnimatedObjects/Player.connect("end_game", self, "_game_over")
	#$AnimatedObjects/Player.connect("nb_fishes", $AnimatedObjects/GUI, "_get_nb_fishes")

func _physics_process(delta):
	
	$AnimatedObjects.position.y -= CAMERA_SPEED  * delta
	
	# Calcul des mesures pour le score
	distance = floor(abs($AnimatedObjects/Camera2D.global_position.y) / 40) 
	number_of_fishes = ($AnimatedObjects/Player/Fishes.get_child_count())
	if number_of_fishes > max_of_fishes:
		max_of_fishes = number_of_fishes
	score = score + (distance*number_of_fishes)

func _game_over():
	get_tree().change_scene("res://Game_Over.tscn")
