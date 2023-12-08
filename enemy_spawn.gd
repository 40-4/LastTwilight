extends Node

@export var curve: Curve

#siła fali 
var wave_strenght = 1000
#modifier do statów dla potworów
var level = 0
#ilosc rodzajów
var variants = 1
#dict mocy variantów
var variants_strenght = {0:1,1:3,2:3,3:10}

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#tworzymy listę przeciwników na następną falę 
func spawn_wave():
	var enemies_to_spawn = []
	for i in range(variants+1):
		@warning_ignore("integer_division")
		enemies_to_spawn.append({"variant":i, "amount":wave_strenght/(variants+1)/variants_strenght[i]})
	menage_wave(enemies_to_spawn)

#funkcja tworząca prompt o spawn odpowienich przeciwników w interwałach
func menage_wave(enemies):
	var overflow = {0: 0, 1: 0, 2: 0, 3:0}
	##LEPIEJ NIE RUSZAĆ !!!!!!!!!!!!!!!!!!!
	#spawn 1. części fali
	for i in range(54):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.0018)+floor(overflow[enemy.variant]))
			overflow[enemy.variant] -= floor(overflow[enemy.variant])
			overflow[enemy.variant] += enemy.amount*0.0018 - floor(enemy.amount*0.0018)
		await get_tree().create_timer(1).timeout
	#spawn 2. części fali
	print("faza2")
	for i in range(108):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.006)+floor(overflow[enemy.variant]))
			overflow[enemy.variant] -= floor(overflow[enemy.variant])
			overflow[enemy.variant] += enemy.amount*0.006 - floor(enemy.amount*0.006)
		await get_tree().create_timer(1).timeout
	#spawn finału fali
	print("faza3")
	for i in range(18):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.012)+floor(overflow[enemy.variant]))
			overflow[enemy.variant] -= floor(overflow[enemy.variant])
			overflow[enemy.variant] += enemy.amount*0.012 - floor(enemy.amount*0.012)
		await get_tree().create_timer(1).timeout
	
	level += 1
	wave_strenght += 10000
	spawn_wave()
	
#respi przeciwników na okręgu
func spawn_enemy(variant, amount):
	var center = Vector2(0,0)
	var radius = 145*32
	var step = 2*PI / amount
	var angle = 2*PI * randf()
	for i in range(amount):
		var direction = Vector2(cos(angle), sin(angle))
		var pos = center + direction * radius
		var enemy_scene
		if variant == 0:
			enemy_scene = load("res://Enemies/normal/enemy_normal.tscn")
		elif variant == 1:
			enemy_scene = load("res://Enemies/normal/enemy_fuzzy.tscn")
		elif variant == 2:
			pass
		elif variant == 3:
			pass
			
		var enemy = enemy_scene.instantiate()
		enemy.position = pos
		self.add_child(enemy)
		
		angle +=step
		
