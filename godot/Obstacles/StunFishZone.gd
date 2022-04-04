extends Area2D

func _on_StunFishZone_body_entered(fish: Fish):
	fish.stun()
