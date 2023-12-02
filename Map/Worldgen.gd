extends Node

@export var noise : FastNoiseLite = FastNoiseLite.new()




# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = 2137


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
