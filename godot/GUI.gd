extends MarginContainer

onready var main_node = get_tree().get_root().get_node("Main")

var max_of_fishes = 12
var score = 0

func _ready():

	$VBox/Max_Of_Fishes/Number_Fishes.text = str(max_of_fishes)
	$VBox/Score/Score.text = str(main_node.score)

func _get_nb_fishes(nb_fish):
	print(nb_fish)
	if nb_fish > max_of_fishes:
		max_of_fishes = nb_fish

func _on_Timer_timeout():
	$VBox/Distance/Distance.text = str(main_node.distance)
	$VBox/Max_Of_Fishes/Number_Fishes.text = str(max_of_fishes)
	$VBox/Score/Score.text = str(main_node.score)
	pass
	
