extends Node2D

signal fishes_collected

func _on_Area2D_body_entered(body):
	emit_signal("fishes_collected")
	queue_free()
