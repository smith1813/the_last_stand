extends Node

@onready var timer = get_node("Timer")
@onready var	spawnable_scene = preload("res://src/Enemies/Enemy_1.tscn")
@onready var	spawnable_scene_2 = preload("res://src/Enemies/Enemy_2.tscn")
@onready var	spawnable_scene_3 = preload("res://src/Enemies/Enemy_3.tscn")
@onready var	player
@onready var has_boss = false

@onready var current_score = 0
@onready var current_spawn = 0
@export var max_spawnable = 10
@export var respawn_time = 0.5
@export var spawn_distance = 500
var position = Vector2.ZERO

func _process(_delta):
	if current_score > 100:
		max_spawnable = 15
		respawn_time = 0.4
	if current_score > 200:
		max_spawnable = 20
		respawn_time = 0.3
	if current_score > 300:
		max_spawnable = 25
		respawn_time = 0.2
	if current_score > 400:
		spawn_distance = 450	
	if current_score > 500:
		spawn_distance = 400
		
func _ready() -> void:
	player = get_parent().get_node("Player")
	timer.set_wait_time(respawn_time)
	timer.start()	

func spawn(ship_type:int)-> void:
	if current_spawn >= max_spawnable:
		return
	#calculate distances	
	randomize()
	var angle = randf_range(0,2*PI)
	var new_position = Vector2(cos(angle),sin(angle))*spawn_distance
	var player_position = player.get_global_position()
	#spawn
	var spawnable_scene_instance
	match ship_type:
		0,1,2,3,4:
			#print("instance 1")
			spawnable_scene_instance = spawnable_scene.instantiate()
		5,6,7,8:
			#print("instance 2")
			spawnable_scene_instance = spawnable_scene_2.instantiate()
		9:
			#print("instance 3")
			spawnable_scene_instance = spawnable_scene_3.instantiate()
			has_boss = true
			
	spawnable_scene_instance.set_position(player_position + new_position)
	get_parent().add_child(spawnable_scene_instance)
	# update
	current_spawn += 1
	
func _on_Enemy_1_dead() -> void:
	#print("dead!")
	current_spawn = max(0, current_spawn -1)

func _on_Enemy_2_dead() -> void:
	#print("dead!")
	current_spawn = max(0, current_spawn -1)

func _on_Enemy_3_dead() -> void:
	#print("dead!")
	current_spawn = max(0, current_spawn -1)
	has_boss = false
	
func _on_timeout() -> void:
	var ship_type
	randomize()
	if has_boss:
		ship_type = randi()%9
	else:
		ship_type = randi()%10
	spawn(ship_type)


func _on_PlayerData_score_change(score) -> void:
	current_score = score
