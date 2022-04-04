extends KinematicBody2D

class_name Fish

const SPEED = 80
const DIZZY_SPEED = 40
const ROTATION_SPEED = 15
const KP = 0.4

onready var pivot = $Pivot
onready var animatedSprite = $Pivot/AnimatedSprite
onready var pivotTarget = $PivotTarget

var disabled = false
var next_to_fish = 0

enum status {
	Normal,
	Stunned,
	Dizzy,
}
var target_pos = null
var velocity = Vector2.ZERO
var velocity_debuff = 1
var current_status = status.Normal
var stun_timer = -1
var dizzy_timer = -1

onready var old_position = global_position
var delta_pos = Vector2.ZERO

func _ready():
	animatedSprite.playing = true
	animatedSprite.animation = "swim"
	animatedSprite.frame = randi() % 5

func stun():
#	return
	if current_status != status.Normal:
		return
	current_status = status.Stunned
	animatedSprite.animation = "stun"
	animatedSprite.modulate = Color(0.0, 1.0, 1.0)
	yield(get_tree().create_timer(0.5), "timeout")
	current_status = status.Dizzy
	animatedSprite.animation = "swim"
	animatedSprite.modulate = Color(1.0, 0.0, 1.0)
	animatedSprite.speed_scale = 0.5
	yield(get_tree().create_timer(1.0), "timeout")
	current_status = status.Normal
	animatedSprite.modulate = Color(0.0, 0.0, 0.0)
	animatedSprite.speed_scale = 1.0

func _physics_process(delta):
	if current_status != status.Stunned:
		delta_pos = global_position - old_position
		old_position = global_position

		if target_pos != null:
			var speed = SPEED
			if is_next_to_fish() or current_status == status.Dizzy:
				speed = DIZZY_SPEED
			
			var direction = target_pos - position
			pivotTarget.rotation = direction.angle()
			velocity = direction.normalized() * pow(direction.length() * KP, 1) * speed
			velocity = velocity.clamped(speed)
			velocity = move_and_slide(velocity)
		
		var col_count = get_slide_count()
		if col_count > 0:
			for i in col_count:
				if get_slide_collision(i).collider is KinematicBody2D:
					# kinda hacky, we suppose fish are the only ones with kinematicBody2D
					continue
				stun()

func _process(delta):
	if current_status == status.Normal:
		if target_pos != null and delta_pos.length() > 0:
			pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)

#		var col_count = get_slide_count()
#		if col_count > 0:
#			for i in col_count:
#				if get_slide_collision(i).collider is KinematicBody2D:
#					# kinda hacky, we suppose fish are the only ones with kinematicBody2D
#					continue
#				print(get_slide_collision(i).collider)
#				stun()
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
