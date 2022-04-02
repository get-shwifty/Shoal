extends Position2D

enum Pattern {
	CIRCLE,
	TWO_CIRCLES,
	HORIZONTAL,
	VERTICAL
}

var current_pattern = Pattern.TWO_CIRCLES

onready var fishes = $Fishes
onready var target2CirclesLeft = $Target2CirclesLeft
onready var target2CirclesRight = $Target2CirclesRight

func _physics_process(delta):
	var children = []
	for child in fishes.get_children():
		children.push_back(child)
	
	if children.size() > 0:
		match current_pattern:
			Pattern.CIRCLE:
				set_target_pos_circle(children)
			Pattern.TWO_CIRCLES:
				set_target_pos_two_circles(children)

	position.y += 60 * delta
	position.x = 200 + cos(position.y / 20) * 30

func set_target_pos_circle(children):
	for child in children:
		child.target_pos = Vector2.ZERO

func set_target_pos_two_circles(children):
	var median_pos = Vector2.ZERO
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
