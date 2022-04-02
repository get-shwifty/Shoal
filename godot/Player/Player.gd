extends Node2D

enum Pattern {
	CIRCLE,
	TWO_CIRCLES,
	HORIZONTAL,
	VERTICAL
}

var current_pattern = Pattern.CIRCLE

onready var fishes = $Fishes
onready var target2CirclesLeft = $Target2CirclesLeft
onready var target2CirclesRight = $Target2CirclesRight

func _physics_process(_delta):
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
