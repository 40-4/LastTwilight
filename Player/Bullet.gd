extends Area2D

var speed : float = 250.0

var direction : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(self.global_position + direction)
	self.global_position += direction * speed * delta
	###FIXME: DAMAGE
