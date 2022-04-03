extends MarginContainer

onready var main_node = get_tree().get_root().get_node("Main")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBox/Distance/Distance.text = str(main_node.distance)
	$VBox/Max_Of_Fishes/Number_Fishes.text = str(main_node.max_of_fishes)


func _on_Timer_timeout():
	$VBox/Distance/Distance.text = str(main_node.distance)
	$VBox/Max_Of_Fishes/Number_Fishes.text = str(main_node.max_of_fishes)
	$VBox/Score/Score.text = str(main_node.score)
	
