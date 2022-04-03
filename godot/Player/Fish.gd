extends KinematicBody2D

const SPEED = 80
const ROTATION_SPEED = 5
const KP = 0.05

onready var pivot = $Pivot

var target_pos = Vector2.ZERO
var velocity = Vector2.ZERO

onready var old_position = global_position
var delta_pos = Vector2.ZERO

func _physics_process(delta):
	delta_pos = global_position - old_position
	old_position = global_position
	
	var direction = target_pos - position
	velocity = direction.normalized() * pow(direction.length() * KP, 3) * SPEED
	velocity = velocity.clamped(SPEED)
	velocity = move_and_slide(velocity)
	
func _process(delta):
	if delta_pos.length() > 0:
		pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)
