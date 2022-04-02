extends KinematicBody2D

var SPEED = 300.0
var velocity = Vector2.ZERO
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var direction = get_direction()
	var sprite_size = $Sprite.texture.get_size() * $Sprite.scale
	
	velocity.x = SPEED * direction.x
	velocity.y = SPEED * direction.y
	velocity = move_and_slide(velocity)
	
	# Clamp : Pour éviter que le personnage sorte de l'écran
	# Sprite_size / 2 : Pour éviter qu'il soit découper en deux
	position.x = clamp(position.x, (sprite_size.x/2), screen_size.x - (sprite_size.x/2))
	position.y = clamp(position.y, 0, screen_size.y)
	
func get_direction() -> Vector2:
	return Vector2(Input.get_action_strength("move_right") - 
		Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - 
		Input.get_action_strength("move_up"))
