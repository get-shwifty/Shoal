extends Node2D

func get_chunck_height():
	return($TileMap.get_used_rect().size.y * $TileMap.cell_size.y)

func _ready():
	#$Fish_Shoal.connect("fishes_collected", self, "_fishes_collect")
	pass
