extends Node2D
export var fade_in = false
export var fade_delay = 3
export var boss = false
var splash = preload('res://Obstacles/Generic/Splash.tscn')
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if fade_in:
		$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1,1,1,0), Color(1,1,1,1),fade_delay, Tween.TRANS_LINEAR, Tween.EASE_IN, 2)
		$Tween.start()
	if boss:
		$FishCatcher.one_shot = false
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$FishCatcher.catch_fish(body)


func _on_FishCatcher_fished(_fished):
	var animation = splash.instance()
	get_parent().get_parent().add_child(animation)
	animation.global_position = $PositionSplash.global_position
	animation.show()
	animation.play("Splash")
	$AudioStreamPlayer.play()
	if not boss:
		$Tween.interpolate_property($AnimatedSprite, "modulate", Color(1,1,1,1), 
		Color(1,1,1,0),1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
