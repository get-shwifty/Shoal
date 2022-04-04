extends PathFollow2D

export(int) var SPEED = 50

func _physics_process(delta):
	offset += SPEED * delta
	if not loop and unit_offset == 1:
		get_parent().queue_free()
