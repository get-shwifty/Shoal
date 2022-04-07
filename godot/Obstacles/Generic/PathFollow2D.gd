extends PathFollow2D
export(int) var SPEED = 50
var temp_speed = SPEED

func _ready():
	SPEED = 0
	var timer = get_parent().get_node('Timer')
	timer.start()
		
func _physics_process(delta):
	offset += SPEED * delta
	if not loop and unit_offset == 1:
		get_parent().queue_free()


func _on_Timer_timeout():
	print("TIME TO SPEED UP")
	SPEED = temp_speed
