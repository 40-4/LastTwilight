extends Node

@export var curve: Curve

#siła fali 
var wave_strenght = 50
#modifier do statów dla potworów
var level = 0
#ilosc rodzajów
var variants = 0
#dict mocy variantów
var variants_strenght = {0:1,1:5,2:3,3:10}

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
	var enemies_left = [] + enemies.duplicate(true)
	
	##LEPIEJ NIE RUSZAĆ !!!!!!!!!!!!!!!!!!!
	
	#spawn 1. części fali
	for i in range(5):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.009))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.009)
		await get_tree().create_timer(5).timeout
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount-enemy.amount*0.946))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount-enemy.amount*0.946)
	await get_tree().create_timer(5).timeout
	for i in range(4):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.009))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.009)
		await get_tree().create_timer(5).timeout
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount-enemy.amount*0.9))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount-enemy.amount*0.9)
	await get_tree().create_timer(5).timeout
	#spawn 2. części fali
	for i in range(6):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.03))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.03)
		await get_tree().create_timer(5).timeout
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount-enemy.amount*0.69))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount-enemy.amount*0.69)
	await get_tree().create_timer(5).timeout
	for i in range(6):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.03))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.03)
		await get_tree().create_timer(5).timeout
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount-enemy.amount*0.48))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount-enemy.amount*0.48)
	await get_tree().create_timer(5).timeout
	for i in range(5):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.03))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.03)
		await get_tree().create_timer(5).timeout
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount-enemy.amount*0.3))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount-enemy.amount*0.3)
	#spawn finału fali
	for i in range(4):
		for enemy in enemies:
			spawn_enemy(enemy.variant, floor(enemy.amount*0.06))
			enemies_left[enemy.variant].amount -= floor(enemy.amount*0.06)
	for enemy in enemies:
		spawn_enemy(enemy.variant, ceil(enemies_left[enemy.variant].amount))
		enemies_left[enemy.variant].amount -= ceil(enemies_left[enemy.variant].amount)


func spawn_enemy(_variant, amount):
	print(amount)
