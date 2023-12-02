extends Area2D

var speed : float = 250.0
var damage = 5
var direction : Vector2 = Vector2.ZERO
var boom = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(self.global_position + direction)
	self.global_position += direction * speed * delta
	###FIXME: DAMAGE
	if get_overlapping_bodies():
		for ob in get_overlapping_bodies():
			if ob.has_meta("type"):
				if ob.get_meta("type") == "enemy":
					for i in get_tree().get_nodes_in_group("enemies"):
						if global_position.distance_to(i.global_position) <= 50 and boom == true:
							i.damage(damage)
					ob.damage(damage)
				if ob.get_meta("type") != "player":
					queue_free()
			else:
				queue_free()
