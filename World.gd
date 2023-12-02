extends Node

var noise

# Called when the node enters the scene tree for the first time.
func _ready():
	noise = FastNoiseLite.new()
	var tilemap : TileMap = $TileMap
	
	for x in range(300):
		for y in range(300):
			x -= 150
			y -= 150
			tilemap.set_cell(0, Vector2i(x,y), 0)

func get_nice_noise(vec2: Vector2i):
	var n = noise.get_noise_2dv(vec2)
	if n < 0.25:
		return 1
	elif n < 0.5:
		return 2
	elif n < 0.75:
		return 3
	else:
		return 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
pass # Replace with function body.
