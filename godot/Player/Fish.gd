extends KinematicBody2D

class_name Fish

const SPEED = 140
const ROTATION_SPEED = 20
const KP = 0.05

onready var pivot = $Pivot
onready var animatedSprite = $Pivot/AnimatedSprite

var disabled = false
var next_to_fish = 0

enum status {
	Normal,
	Stunned
}
var target_pos = null
var velocity = Vector2.ZERO
var velocity_debuff = 1
var current_status = status.Normal

onready var old_position = global_position
var delta_pos = Vector2.ZERO

func _ready():
	animatedSprite.playing = true
	animatedSprite.animation = "swim"
	animatedSprite.frame = randi() % 5

func stun():
	if current_status != status.Normal:
		return
	current_status = status.Stunned
	animatedSprite.animation = "stun"
	yield(get_tree().create_timer(0.5), "timeout")
	animatedSprite.animation = "swim"
	current_status = status.Normal

func _physics_process(delta):
	if current_status != status.Stunned:
		delta_pos = global_position - old_position
		global_position -= delta_pos * (1.0 - velocity_debuff)
		old_position = global_position

		if target_pos != null:
			var speed = SPEED
			
			var direction = target_pos - position
			velocity = direction.normalized() * pow(direction.length() * KP, 2) * speed
			velocity = velocity.clamped(speed)
#			if is_next_to_fish():
#				velocity *= 0.6
			velocity = move_and_slide(velocity, Vector2.ZERO, false, 2)
			
			if velocity.length() > 10 and delta_pos.length() > 0:
				pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)
	else:
		global_position = old_position

func disable():
	disabled = true
	collision_layer = 0
	collision_mask = 0
	target_pos = null


func _on_OtherFishDetector_body_entered(body):
	next_to_fish += 1

func _on_OtherFishDetector_body_exited(body):
	next_to_fish -= 1

func is_next_to_fish():
	return next_to_fish > 0
