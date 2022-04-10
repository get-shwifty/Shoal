extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TweenShadow.interpolate_property($Shadow, "scale", $Shadow.scale, Vector2(0.5,0.5), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$TweenBird.interpolate_property($BirdSprite, "position:x", $BirdSprite.position.x, -2.5, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$TweenBirdScale.interpolate_property($BirdSprite, "scale", $BirdSprite.scale, Vector2(0.5,0.5), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$TweenShadow.start()
	$TweenBird.start()
	$TweenBirdScale.start()

func _physics_process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$FishCatcher.catch_fish(body)


func _on_FishCatcher_fished(_fished):
	print(_fished)
	print("finished!")
	$AudioStreamPlayer.play()
	$Splash.show()
	$Splash.play("Splash")


func _on_TweenBird_tween_all_completed():
	$BirdSprite.play()
	$Shadow.play()
