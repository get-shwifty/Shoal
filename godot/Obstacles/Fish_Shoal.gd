extends Node2D

func _on_Area2D_body_entered(body):
	call_deferred("add_fish",body)

func add_fish(body):
	for child in $Fishes.get_children() :
		var gp = child.global_position
		$Fishes.remove_child(child)
		child.set_collision_layer(2)
		body.get_parent().add_child(child)
		child.global_position = gp
	queue_free()
