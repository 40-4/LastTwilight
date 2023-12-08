extends CanvasLayer

var buttons
var totem_hovered = 0
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var menu = $Control/CenterContainer/TextureRect
@onready var texts = $Control/texts

@onready var title = $Control/texts/VBoxContainer/Label
@onready var article = $Control/texts/VBoxContainer/Label2
@onready var cost = $Control/texts/VBoxContainer/Label3

var descriptions = {1:{"title":"Totem of Light", "description":"Basic shooting totem", "cost":"cost: 10 light"},2:{"title":"Star Light", "description":"Reveals things that cannot be seen", "cost":"cost: 10 light"},3:{"title":"Totem of Power", "description":"Strong shooting totem", "cost":"cost: 20 light"},4:{"title":"Totem of Hemorrhage", "description":"Makes them bleed", "cost":"cost: 20 light"},5:{"title":"Totem of Destruction", "description":"Shoots explosive projectiles", "cost":"cost: 20 light"},6:{"title":"Totem of Pain", "description":"Creates an area of ​​pain", "cost":"cost: 20 light"},7:{"title":"Totem of Coldness", "description":"Slows down opponents", "cost":"cost: 20 light"},8:{"title":"Totem of Reduction", "description":"weakens enemies in the area", "cost":"cost: 20 light"},9:{"title":"Totem of Stability", "description":"Keeps totems charged longer", "cost":"cost: 20 light"}}
var cost_dict = {1:10, 2:10, 3:20, 4:20, 5:20, 6:20, 7:20, 8:20, 9:20, 10:20, 11:20, 12:20, 13:20, 14:20, 15:20}
# Called when the node enters the scene tree for the first time.
func _ready():
	#podstawić przyciski pod id
	buttons = {1:$buttons/TextureButton1, 2:$buttons/TextureButton2, 3:$buttons/TextureButton3, 4:$buttons/TextureButton4, 5:$buttons/TextureButton5, 6:$buttons/TextureButton6, 7:$buttons/TextureButton7, 8:$buttons/TextureButton8, 9:$buttons/TextureButton9, 10:$buttons/TextureButton10, 11:$buttons/TextureButton11, 12:$buttons/TextureButton12, 13:$buttons/TextureButton13, 14:$buttons/TextureButton14, 15:$buttons/TextureButton15}
	var totems = player.players_totems
	var amount = totems.size()
	var center = Vector2(0,0)
	var radius = 170
	var step = 2*PI / amount
	var angle = 0
	for button in totems:
		var direction = Vector2(cos(angle), sin(angle))
		var pos = center + direction * radius
		buttons[button].position = Vector2(464, 254) + pos
		buttons[button].visible = true
		
		angle +=step


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var najechany = false
	for i in player.players_totems:
		najechany = najechany or buttons[i].is_hovered()
	if najechany:
		texts.show()
	else:
		texts.hide()
	for i in range(15):
		if cost_dict[i+1]>GlobalVariables.light:
			buttons[i+1].modulate = "ffffff7a"
		else:
			buttons[i+1].modulate = "ffffffff"


func _on_texture_button_mouse_entered(id):
	totem_hovered = id
	title.text = descriptions[id].title
	article.text = descriptions[id].description
	cost.text = descriptions[id].cost
	if cost_dict[id] > GlobalVariables.light:
		cost.set("theme_override_colors/font_color", Color(0.76, 0.19, 0.26)) 
	else:
		cost.set("theme_override_colors/font_color", Color(1,1,1))


func _on_texture_button_mouse_exited():
	totem_hovered = 0
