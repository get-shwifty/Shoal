extends Node2D

signal traveled_distance

export(int) var CAMERA_SPEED = 80
export(int) var MIN_CAMERA_SPEED = 40
export(int) var MAX_CAMERA_SPEED = 120
export(int) var DISTANCE_MAX_SPEED = 1500

func _physics_process(delta):
	position.y -= camera_speed() * delta
	emit_signal("traveled_distance", get_distance_from_begin())

func camera_speed():
	return lerp(MIN_CAMERA_SPEED,
				MAX_CAMERA_SPEED,
				sqrt(
					clamp(get_distance_from_begin() / DISTANCE_MAX_SPEED, 0, 1)
				))

func get_distance_from_begin():
	return -position.y / 16
