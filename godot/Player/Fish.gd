extends KinematicBody2D

const SPEED = 100
const ACCELERATION = 200

var target_pos = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	var direction = (target_pos - position).normalized()
	velocity = direction * SPEED
	velocity = move_and_slide(velocity)
	
	# rotation = velocity.angle()
