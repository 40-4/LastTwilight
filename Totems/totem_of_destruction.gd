extends Totem

var bullet = preload("res://Player/bullet.tscn")
var curr_cooldown = 0.0

func _ready():
	super()
	self.longevity = 3
	self.cost = 20
	self.damage = 20
	self.cooldown = 0.3
	self.range = 300

func _physics_process(delta):
	super(delta)
	var targets = []
	for i in get_tree().get_nodes_in_group("Enemies"):
		if i.global_position.distance_to(self.global_position) <= range:
			targets.append(i)
	
	if len(targets) > 0:
		shoot(targets[0])
	curr_cooldown = max(curr_cooldown - delta, 0)

func shoot(target):
	if curr_cooldown == 0.0:
		var i = bullet.instantiate()
		i.boom = true
		i.global_position = self.global_position + Vector2(0, -16)
		i.direction = global_position.direction_to(target.global_position)
		i.damage = damage
		get_tree().get_first_node_in_group("bullets").add_child(i)
		curr_cooldown = cooldown
	
