extends Node2D

signal fishes_collected

func _on_body_entered(_body):
	emit_signal("fishes_collected")
	yield($Sound, "finished")
	queue_free()
