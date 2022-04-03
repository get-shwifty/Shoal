extends KinematicBody2D

const SPEED = 80
const ROTATION_SPEED = 5
const FRICTION = 30

onready var pivot = $Pivot

var target_pos = Vector2.ZERO
var velocity = Vector2.ZERO

onready var old_position = global_position
var delta_pos = Vector2.ZERO

var fish_on_left = 0
var fish_on_right = 0

func _physics_process(delta):
	delta_pos = global_position - old_position
	old_position = global_position
	
	velocity = (target_pos - position).normalized() * SPEED
	velocity = move_and_slide(velocity, Vector2.ZERO, false, 2)
	
func _process(delta):
#	if has_friction():
#		$Pivot/Sprite.modulate = Color(0.2, 0.2, 0.2);
#	else:
#		$Pivot/Sprite.modulate = Color(1, 1, 1);

	if delta_pos.length() > 0:
		pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)

func has_friction():
	return (fish_on_left == 0) != (fish_on_right == 0)

func _on_FrictionLeft_body_entered(_body):
	fish_on_left += 1
func _on_FrictionLeft_body_exited(_body):
	fish_on_left -= 1

func _on_FrictionRight_body_entered(_body):
	fish_on_right += 1
func _on_FrictionRight_body_exited(_body):
	fish_on_right -= 1
