extends Area2D

func _on_StunFishZone_body_entered(fish: Fish):
	print_debug("enter")
	fish.stun()
