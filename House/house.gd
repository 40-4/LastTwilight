extends Node

@onready var world = $".."

func deal_damage(amount : float):
	world.deal_damage_to_house(amount)
