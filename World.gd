extends Node

var noise

var house_hp = 1000

var menu_scene = "res://MainMenu/MainMenu.tscn"

var time = -60

var was_message_displayed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	%HouseHealthbar.max_value = house_hp
	%HouseHealthbar.value = house_hp
	
	noise = FastNoiseLite.new()
	var tilemap : TileMap = $TileMap
	
	for x in range(300):
		for y in range(300):
			x -= 150
			y -= 150
			tilemap.set_cell(0, Vector2i(x,y), 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/lights/Label.text = str(GlobalVariables.light)
	if !was_message_displayed && time > -2:
		var position_tween = create_tween()
		var rotation_tween = create_tween()
		position_tween.tween_property($UI/Label, "position", Vector2($UI/Label.position.x, 540/2), 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		position_tween.tween_property($UI/Label, "position", Vector2($UI/Label.position.x, (540 * 1.2) * 3), 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		rotation_tween.tween_property($UI/Label, "rotation", 0, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		rotation_tween.tween_property($UI/Label, "rotation_degrees", 15, 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		was_message_displayed = true
	
	time += delta
	%Timer.text = GameManager.time_to_string(time)
	pass

func deal_damage_to_house(amount : float):
	house_hp -= amount
	%HouseHealthbar.value = house_hp
	if house_hp <= 0:
		GameManager.end_game(int(time))
