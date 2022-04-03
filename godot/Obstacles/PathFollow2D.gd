extends PathFollow2D

const SPEED = 50

func _physics_process(delta):
	offset += SPEED * delta
