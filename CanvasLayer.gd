extends CanvasLayer

var buttons
@onready var player = $"../../player"
@onready var menu = $Control/CenterContainer/TextureRect
@onready var texts = $Control/texts

@onready var title = $Control/texts/VBoxContainer/Label
@onready var article = $Control/texts/VBoxContainer/Label2
@onready var cost = $Control/texts/VBoxContainer/Label3

var descriptions = {1:{"title":"Totem of Light", "description":"Basic shooting totem", "cost":"cost: 10 light"},2:{"title":"Star Light", "description":"Reveals things that cannot be seen", "cost":"cost: 10 light"},3:{"title":"Totem of Power", "description":"Strong shooting totem", "cost":"cost: 20 light"},4:{"title":"Totem of Hemorrhage", "description":"Makes them bleed", "cost":"cost: 20 light"},5:{"title":"Totem of Destruction", "description":"Shoots explosive projectiles", "cost":"cost: 20 light"},6:{"title":"Totem of Pain", "description":"Creates an area of ​​pain", "cost":"cost: 20 light"},7:{"title":"Totem of Coldness", "description":"Slows down opponents", "cost":"cost: 20 light"},8:{"title":"Totem of Reduction", "description":"weakens enemies in the area", "cost":"cost: 20 light"}}
# Called when the node enters the scene tree for the first time.
func _ready():
	#podstawić przyciski pod id
	buttons = {1:$buttons/TextureButton1, 2:$buttons/TextureButton2, 3:$buttons/TextureButton3, 4:$buttons/TextureButton4, 5:$buttons/TextureButton5, 6:$buttons/TextureButton6, 7:$buttons/TextureButton7, 8:$buttons/TextureButton8, 9:$buttons/TextureButton9, 10:$buttons/TextureButton10, 11:$buttons/TextureButton11, 12:$buttons/TextureButton12, 13:$buttons/TextureButton13, 14:$buttons/TextureButton14, 15:$buttons/TextureButton15}
	var totems = [1,2,3,4,5,6,7,8]
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
	for i in [1,2,3,4,5,6,7,8]:
		najechany = najechany or buttons[i].is_hovered()
	if najechany:
		texts.show()
	else:
		texts.hide()
	


func _on_texture_button_mouse_entered(id):
	title.text = descriptions[id].title
	article.text = descriptions[id].description
	cost.text = descriptions[id].cost
