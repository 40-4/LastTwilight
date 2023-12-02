extends Area2D
class_name Totem

var player : Node



var longevity : float = 120
var active = true
var life : float
# Called when the node enters the scene tree for the first time.
func _ready():
	life = longevity * 1 #FIXME: SKALA SKILLI


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	life = max(life - delta, 0)
	
	if life == 0:
		set_active(false)
	


func set_active(state : bool):
	if state:
		active = false
		#ZMIANA spriteu.
	else:
		active = true
		life = longevity * 1 #FIXME SKALA
		#odbierz graczowi koszt, zmiana sprite'u
