extends CharacterBody2D

###Variables

var light : int = 1

var max_hp : int = 3
var hp : int

var damage



###Debug Variables
@export var time_slowdown_curve : Curve

var direction : Vector2 = Vector2.ZERO
var speed : float = 150.0 #TODO: Acceleration
var dash_speed : float = 450.0
var dash_duration : float = 0.3
var dash_direction : Vector2 = Vector2.ZERO
var dash_cooldown : float = 0
var dash_cooldown_base : float = 2.0
var is_dashing : float = 0

###Onready variables
@onready var pivot_book = $Pivot
@onready var book = $Pivot/Book
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.skew = (lerp(skew, direction.x * 10, 1-pow(0.5, delta)))
	pivot_book.look_at(get_global_mouse_position())
	book.rotation = pivot_book.rotation * -1


func _physics_process(delta):
	dash_cooldown = max(dash_cooldown - delta, 0)
	#setting temps variables
	var current_speed : float = 0 
	#checking dashes:
	if Input.is_action_just_pressed("move_dash") and dash_cooldown == 0:
		dash()
	#checking if player is dashing ect.
	if is_dashing == 0:
		#getting_movement
		current_speed = speed
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	#handling dashes
	else:
		current_speed = dash_speed
		is_dashing = max(is_dashing - delta, 0) #odejmujemy deltę i jak będzie mniej to się setuje na 0
		direction = dash_direction
		
		
	
	#movement
	velocity = direction * current_speed #TODO: Speed Scale potem
	move_and_slide()
	


func dash():
	dash_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	is_dashing = dash_duration
	dash_cooldown = dash_cooldown_base + dash_duration
