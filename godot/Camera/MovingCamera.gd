extends Node2D

class_name MovingCamera

signal traveled_distance

enum Control {
	SET_SPEED,
	RESTORE_SPEED,
	PAUSE
}

export(int) var CAMERA_SPEED = 80
export(int) var MIN_CAMERA_SPEED = 40
export(int) var MAX_CAMERA_SPEED = 120
export(int) var DISTANCE_MAX_SPEED = 1500

var forced_speed = null

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


func _on_CameraControlTrigger_area_entered(area):
	match area.type:
		Control.SET_SPEED:
			forced_speed = area.param
		Control.RESTORE_SPEED:
			forced_speed = null
		Control.PAUSE:
			pass


func _on_OutsideCameraArea_body_exited(body):
	if not body.disabled and not body.is_queued_for_deletion():
		body.queue_free()
