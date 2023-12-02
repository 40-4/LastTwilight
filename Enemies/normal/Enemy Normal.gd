extends CharacterBody2D

@export var world : Node

###variables
var target : Vector2 = Vector2.ZERO #FIXME: oblicz domek




var max_hp : float = 20.0
var hp : float

var range: float = 200.0
var attack_range: float = 32.0

var attack_cooldown : float = 0
var attack_cooldown_base : float = 0.5

var speed : float = 100.0


# Called when the node enters the scene tree for the first time.
func _ready():
	max_hp *= 1 #TODO: scaling
	hp = max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	attack_cooldown =  max(attack_cooldown - delta, 0)
	
	target = look_for_targets()
	
	var direction = (target - self.get_global_position()).normalized()
	
	velocity = direction * speed
	
	try_to_attack()
	
	move_and_slide()

func try_to_attack():
	for current_target in %AttackArea.get_overlapping_bodies():
		if current_target != null && current_target.has_meta("type") && (current_target.get_meta("type") == "player" || current_target.get_meta("type") == "house") &&\
				attack_cooldown <= 0:
			attack_cooldown = attack_cooldown_base
			attack(current_target)

func look_for_targets() -> Vector2:
	var targets = get_tree().get_nodes_in_group("Targettable")
	
	var viable_targets = []
	
	var current_target = null
	
	for target in targets:
		if self.get_global_position().distance_to(target.get_global_position()) <= range:
			viable_targets.append(target)
			current_target = target
		
	if len(viable_targets) > 1:
		for target in viable_targets:
			if self.get_global_position().distance_to(target.get_global_position()) < self.get_global_position().distance_to(current_target.get_global_position()):
				current_target = target
		
	if current_target == null:
		return Vector2.ZERO #FIXME:Koordy światła/domku
	else:
		return current_target.get_global_position()

func attack(target):
	#print("I'm currently destroying " + target.name)
	target.deal_damage(5.0)

func damage(amount : float, effect : Array = []):
	hp -= amount
	if hp <= 0:
		queue_free()
