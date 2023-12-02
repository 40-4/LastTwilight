extends CharacterBody2D

###Variables



###Debug Variables
var direction : Vector2 = Vector2.ZERO
var speed : float = 250.0 #TODO: Acceleration
var dash_speed : float = 500.0
var dash_duration : float = 0.5
var dash_direction : Vector2 = Vector2.ZERO
var is_dashing : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var current_speed : float = 0 
	#checking if player is dashing ect.
	if is_dashing > 0:
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
	pass
