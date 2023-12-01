extends CharacterBody2D

###Variables



###Debug Variables
var direction : Vector2 = Vector2.ZERO
var speed : float = 150.0 #TODO: Acceleration
var dash_speed : float = 450.0
var dash_duration : float = 0.3
var dash_direction : Vector2 = Vector2.ZERO
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
	#setting temps variables
	var current_speed : float = 0 
	#checking dashes:
	if Input.is_action_just_pressed("move_dash"):
		dash()
	#checking if player is dashing ect.
	if is_dashing == 0:
		#getting_movement
		current_speed = speed
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
		print(direction)
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
