extends PathFollow2D

export(int) var SPEED = 50

func _physics_process(delta):
	offset += SPEED * delta
