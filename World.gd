extends Node

var noise

var house_hp = 1000



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
pass # Replace with function body.

func deal_damage_to_house(amount : float):
	house_hp -= amount
	pass
