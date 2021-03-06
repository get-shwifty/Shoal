extends Node2D

signal end_game
signal fish_added
signal nb_fishes

onready var target = $Target
onready var fishes = $Fishes
onready var target2CirclesLeft = $Target/Target2CirclesLeft
onready var target2CirclesRight = $Target/Target2CirclesRight
onready var screen_size = get_viewport_rect().size

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var current_pattern = Pattern.CIRCLE

const SPEED = 120

enum Pattern {
	CIRCLE,
	TWO_CIRCLES,
	HORIZONTAL,
	VERTICAL
}

func _physics_process(delta):
	var children = fishes.get_children()
	
	if children.size() > 0:
		var nearest_fish_dist = 1000000000.0
		var nearest_fish = null
		for child in fishes.get_children():
			var dist = (child.position - target.position).length()
			if dist < nearest_fish_dist:
				nearest_fish_dist = dist
				nearest_fish = child.position

		var factor = 1.0
		if nearest_fish_dist < 5:
			factor = 2.5

		direction = get_direction()
		velocity = direction * SPEED * factor
		target.translate(velocity * delta)
		target.position.x = clamp(target.position.x, 0, screen_size.x)
		target.position.y = clamp(target.position.y, 0, screen_size.y)
		target.position.x = clamp(target.position.x, nearest_fish.x - 30, nearest_fish.x + 30)
		target.position.y = clamp(target.position.y, nearest_fish.y - 30, nearest_fish.y + 30)

		emit_signal("nb_fishes", children.size())

		match current_pattern:
			Pattern.CIRCLE:
				set_target_pos_circle(children)
				if Input.is_action_just_pressed("change_formation"):
					current_pattern = Pattern.TWO_CIRCLES
			Pattern.TWO_CIRCLES:
				set_target_pos_two_circles(children)
				if Input.is_action_just_pressed("change_formation"):
					current_pattern = Pattern.CIRCLE
	else:
		emit_signal("end_game")

func set_target_pos_circle(children):
#	var phi = 0.0
#	var step_phi = 0.01
#	var a = 6
#	var cur_pos = Vector2.ZERO
	for child in children:
		child.target_pos = target.position # + cur_pos
#		var old_pos = cur_pos
#		while (cur_pos - old_pos).length() < 6:
#			phi += step_phi
#			cur_pos = Vector2(a*sqrt(phi)*cos(phi), a*sqrt(phi)*sin(phi))

func set_target_pos_two_circles(children):
	var children_x = []
	for child in children:
		children_x.append(child.position.x)
	children_x.sort()
	var median_x = children_x[int(children_x.size() / 2)]

	for child in children:
		if child.position.x < median_x:
			child.target_pos = target.position + target2CirclesLeft.position
		else:
			child.target_pos = target.position + target2CirclesRight.position

# Target Player

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()


