extends Node2D

func _on_Player_end_game():
	get_tree().change_scene("res://Game_Over.tscn")
