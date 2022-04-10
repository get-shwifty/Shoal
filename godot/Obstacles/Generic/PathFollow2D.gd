extends PathFollow2D
export(int) var SPEED = 50
var temp_speed

func _ready():
	var timer = get_parent().get_node('Timer')
	if timer.wait_time > 0.5:
		temp_speed = SPEED
		SPEED = 0
		timer.start()
		
func _physics_process(delta):
	offset += SPEED * delta
	if not loop and unit_offset == 1:
		get_parent().queue_free()


func _on_Timer_timeout():
	SPEED = temp_speed
