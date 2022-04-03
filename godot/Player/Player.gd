extends Node2D

onready var fishes = $Fishes
onready var target2CirclesLeft = $Target2CirclesLeft
onready var target2CirclesRight = $Target2CirclesRight
onready var camera = get_tree().get_root().get_node("Main/AnimatedObjects")
onready var camera_position_init = camera.global_position.y

const SPEED = 100

enum Pattern {
	CIRCLE,
	TWO_CIRCLES,
	HORIZONTAL,
	VERTICAL
}

var current_pattern = Pattern.CIRCLE


var direction = Vector2.ZERO
var velocity = Vector2.ZERO
onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	# Player

	direction = get_direction()
	velocity = direction * SPEED
	translate(velocity * delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Fishes

	var children = fishes.get_children()
	
	if children.size() > 0:
		match current_pattern:
			Pattern.CIRCLE:
				set_target_pos_circle(children)
				if Input.is_action_just_pressed("change_formation"):
					current_pattern = Pattern.TWO_CIRCLES
			Pattern.TWO_CIRCLES:
				set_target_pos_two_circles(children)
				if Input.is_action_just_pressed("change_formation"):
					current_pattern = Pattern.CIRCLE
	for fish in children:
		if fish.global_position.y > (camera.global_position.y - camera_position_init):
			fish.queue_free()

func set_target_pos_circle(children):
	for child in children:
		child.target_pos = Vector2.ZERO

func set_target_pos_two_circles(children):
	var children_x = []
	for child in children:
		children_x.append(child.position.x)
	children_x.sort()
	var median_x = children_x[int(children_x.size() / 2)]

	for child in children:
		if child.position.x < median_x:
			child.target_pos = target2CirclesLeft.position
		else:
			child.target_pos = target2CirclesRight.position

# Target Player

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
