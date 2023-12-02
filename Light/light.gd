extends Marker2D

@onready var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if global_position.distance_to(Player.global_position) <= 15:
		Player.light += 1
		self.queue_free()
	
