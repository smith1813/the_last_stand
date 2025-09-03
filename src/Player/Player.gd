extends CharacterBody2D

@onready var speed = 50
@onready var max_speed = 450
@onready var bullet_speed = 1500
@onready var fire_rate = 0.2
@onready var hp = 50

var _motion = Vector2.ZERO
var can_fire = true
var bullet = load("res://src/Projectiles/Projectile_1.tscn")

var is_dead = false

signal hp_count(hp)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	if is_dead:
		return
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot") and can_fire:
		shoot(fire_rate)

		 
func _physics_process(_delta: float) -> void:
	if is_dead:
		return
	var _direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		_direction.x -= 1
	if Input.is_action_pressed("right"):
		_direction.x += 1
	if Input.is_action_pressed("up"):
		_direction.y -= 1
	if Input.is_action_pressed("down"):
		_direction.y += 1
	set_velocity(_direction.normalized()*max_speed)
	move_and_slide()
	_motion = velocity

	
func shoot(_fire_rate):
	var bullet_instance_1 = bullet.instantiate()
	var bullet_instance_2 = bullet.instantiate()
	bullet_instance_1.position = $BulletPoint.get_global_position()
	bullet_instance_2.position = $BulletPoint2.get_global_position()
	bullet_instance_1.rotation_degrees = rotation_degrees
	bullet_instance_2.rotation_degrees = rotation_degrees
	bullet_instance_1.apply_impulse(Vector2(bullet_speed,0).rotated(rotation), Vector2())
	bullet_instance_2.apply_impulse(Vector2(bullet_speed,0).rotated(rotation), Vector2())
	get_tree().get_root().add_child(bullet_instance_1)
	get_tree().get_root().add_child(bullet_instance_2)
	can_fire = false
	await get_tree().create_timer(_fire_rate).timeout
	can_fire = true

func _on_body_entered(body: Node) -> void:
	die()

func die() -> void:
	is_dead = true
	$Fire.visible = false
	$AnimationPlayer.play("Die")
	
	await $AnimationPlayer.animation_finished

	var tree = Engine.get_main_loop() as SceneTree
	if tree:
		tree.change_scene_to_file("res://src/Levels/GameOver.tscn")
	
func hit():
	pass
