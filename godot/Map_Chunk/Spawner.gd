extends Node2D

export (Array, PackedScene) var scenes

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var current_position = Vector2.ZERO

onready var movingCamera = get_node("../MovingCamera")

func _ready():
	random_scene.randomize()
	add_chunk()
	add_chunk()

func _physics_process(_delta):
	var last_chunk = get_child(get_child_count() - 1)
	
	if last_chunk.global_position.y > (movingCamera.global_position.y - 100):
		drop_chunk()
		add_chunk()

func add_chunk():
	selected_scene_index = random_scene.randi_range(0, scenes.size()-1)
	var new_scene = scenes[selected_scene_index].instance()

	current_position.y -= new_scene.get_chunck_height()
	new_scene.position.y = current_position.y
	
	add_child(new_scene)
	
func drop_chunk():
	get_child(0).queue_free()
