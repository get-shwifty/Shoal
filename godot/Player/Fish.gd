extends KinematicBody2D

const SPEED = 80
const ROTATION_SPEED = 5

onready var pivot = $Pivot

var target_pos = Vector2.ZERO
var velocity = Vector2.ZERO
onready var old_position = global_position

func _physics_process(delta):
	velocity = (target_pos - position).normalized() * SPEED
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 2)
	
func _process(delta):
	var delta_pos = global_position - old_position
	if delta_pos.length() > 0:
		pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)
	old_position = global_position
