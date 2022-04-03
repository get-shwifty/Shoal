extends Node2D

export (Array, PackedScene) var scenes

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var current_position = Vector2.ZERO
var chunks

onready var camera = get_tree().get_root().get_node("Main/AnimatedObjects")

func _ready():
	random_scene.randomize()
	add_chunk()
	add_chunk()
	add_chunk()
	pass

func _process(delta):
	chunks = self.get_children()
	
	if(chunks[chunks.size()-1].global_position.y > camera.global_position.y):
		add_chunk()
		drop_chunk()

func add_chunk():
	selected_scene_index = random_scene.randi_range(0, scenes.size()-1)
	var new_scene = scenes[selected_scene_index].instance()

	current_position.y -= new_scene.get_chunck_height()
	new_scene.position.y = current_position.y
	
	add_child(new_scene)
	
func drop_chunk():
	self.remove_child(chunks[0])

