extends Node2D

export (Array, PackedScene) var scenes

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var current_position = Vector2.ZERO

func _ready():
	add_chunk()
	add_chunk()
	add_chunk()
	pass

func _on_Timer_timeout():
	add_chunk()
	
func add_chunk():
	random_scene.randomize()
	selected_scene_index = random_scene.randi_range(0,scenes.size()-1)
	var new_scene = scenes[selected_scene_index].instance()

	current_position.y -= new_scene.get_chunck_height()
	new_scene.position.y = current_position.y
	
	add_child(new_scene)
	
