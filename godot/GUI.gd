extends MarginContainer

onready var main_node = get_tree().get_root().get_node("Main")
onready var distanceTextNode = $VBox/Distance/Distance
onready var numberFishesTextNode = $VBox/Max_Of_Fishes/Number_Fishes
onready var ScoreTextNode = $VBox/Score/Score

var max_of_fishes = 0
var nb_fishes = 0
var score = 0
var traveled_distance = 0

func display_scores():
	
	#Je sais que c'est dégeullasse, mais je n'ai pas envie de tout refaire
	Global.score = score
	Global.traveled_distance = traveled_distance
	Global.max_of_fishes = max_of_fishes
	
	distanceTextNode.text = str(traveled_distance)
	numberFishesTextNode.text = str(max_of_fishes)
	ScoreTextNode.text = str(score)

func _on_MovingCamera_traveled_distance(distance):
	var diff = int(distance - traveled_distance)
	if diff > 0:
		traveled_distance += diff
		score += diff * nb_fishes
		display_scores()

func _on_Player_nb_fishes(fishes):
	nb_fishes = fishes
	if nb_fishes > max_of_fishes:
		max_of_fishes = nb_fishes
