extends KinematicBody2D

class_name Fish

const SPEED = 80
const ROTATION_SPEED = 5
const KP = 0.05

onready var pivot = $Pivot

var disabled = false

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
	$Pivot/AnimatedSprite.animation = "swim"
	$Pivot/AnimatedSprite.frame = int(rand_range(0, 5))

func stun():
	if current_status != status.Normal:
		return
	current_status = status.Stunned
	stun_timer = 1
	$Pivot/AnimatedSprite.animation = "stun"

func stun_process(delta):
	stun_timer -= delta
	
	global_position = old_position
	
	if stun_timer < 0:
		stun_timer = -1
		current_status = status.Dizzy;
		dizzy_timer = 10
		$Pivot/AnimatedSprite.animation = "swim"

func dizzy_process(delta):
	dizzy_timer -= delta
	
	if dizzy_timer < 0:
		dizzy_timer = -1
		current_status = status.Normal;

func _physics_process(_delta):
	if current_status != status.Stunned:
		delta_pos = global_position - old_position
		old_position = global_position
		
		if target_pos != null:
			var direction = target_pos - position
			velocity = direction.normalized() * pow(direction.length() * KP, 3) * SPEED
			velocity = velocity.clamped(SPEED)
			velocity = move_and_slide(velocity)
		
		var col_count = get_slide_count()
		if col_count > 0:
			for i in col_count:
				if get_slide_collision(i).collider is KinematicBody2D:
					# kinda hacky, we suppose fish are the only ones with kinematicBody2D
					continue
				print(get_slide_collision(i).collider)
				stun()

func _process(delta):
	if current_status == status.Normal:
		if target_pos != null and delta_pos.length() > 0:
			pivot.rotation = lerp_angle(pivot.rotation, delta_pos.angle() + PI / 2, delta * ROTATION_SPEED)
	elif current_status == status.Stunned:
		stun_process(delta)
	elif current_status == status.Dizzy:
		dizzy_process(delta)
	else:
		print("incorrect fish status")

func disable():
	disabled = true
	collision_layer = 0
	collision_mask = 0
	target_pos = null
