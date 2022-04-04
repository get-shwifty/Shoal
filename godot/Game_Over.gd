extends CanvasLayer


func _ready():
	$VBox/Distance/Distance.text = str(Global.traveled_distance)
	$VBox/Max_Of_Fishes/Number_Fishes.text = str(Global.max_of_fishes)
	$VBox/Score/Score.text = str(Global.score)
	
