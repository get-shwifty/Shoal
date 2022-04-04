extends Node2D

export (Array, PackedScene) var scenes

var random_scene = RandomNumberGenerator.new()
var selected_scene_index = 0
var current_position = Vector2.ZERO

export var starting_chunks = [
	preload("res://Map_Chunk/Map_Chunk_1.tscn"), 
	preload("res://Map_Chunk/Map_Chunk_5.tscn"),
	preload("res://Map_Chunk/Map_Chunk_4.tscn")
]
export var max_distance = 600
export var randomness = 0.2
export var other_chunks = {
	"easy":[
		preload("res://Map_Chunk/Map_Chunk_5.tscn")
	],
	"medium": [
		preload("res://Map_Chunk/Map_Chunk_3.tscn"),
		preload("res://Map_Chunk/Map_Chunk_4.tscn"),
	],
	"hard": [
		preload("res://Map_Chunk/Map_Chunk_1.tscn"),
		preload("res://Map_Chunk/Map_Chunk_2.tscn")
	]
}
var elapsed_chunks = 0

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
	var new_scene = select_chunk().instance()

	current_position.y -= new_scene.get_chunck_height()
	new_scene.position.y = current_position.y
	
	add_child(new_scene)
	elapsed_chunks += 1

func select_chunk():
	if elapsed_chunks < len(starting_chunks):
		return starting_chunks[elapsed_chunks]
	else:
		var distance = movingCamera.get_distance_from_begin()
		distance += random_scene.randi_range(-max_distance * randomness, max_distance*randomness)
		if distance < 0:
			distance = 0
		if distance >= max_distance:
			distance = max_distance - 1
		var selected_level_index = floor(distance / (max_distance / len(other_chunks.keys())))
		var selected_level = other_chunks.values()[selected_level_index]
		return selected_level[random_scene.randi_range(0, selected_level.size() - 1)]
		
func drop_chunk():
	get_child(0).queue_free()
