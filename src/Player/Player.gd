extends KinematicBody2D

onready var speed = 50
onready var max_speed = 400
onready var bullet_speed = 1500
onready var fire_rate = 0.2
onready var hp = 50

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
	if Input.is_action_pressed("left"):
		_motion.x -= speed
		_motion.x = max(_motion.x,-max_speed)
	if Input.is_action_pressed("right"):
		_motion.x += speed
		_motion.x = min(_motion.x,max_speed)
	if Input.is_action_pressed("up"):
		_motion.y -= speed
		_motion.y = max(_motion.y,-max_speed)
	if Input.is_action_pressed("down"):
		_motion.y += speed
		_motion.y = min(_motion.y,max_speed)
	_motion = move_and_slide(_motion)

	
func shoot(_fire_rate):
	var bullet_instance_1 = bullet.instance()
	var bullet_instance_2 = bullet.instance()
	bullet_instance_1.position = $BulletPoint.get_global_position()
	bullet_instance_2.position = $BulletPoint2.get_global_position()
	bullet_instance_1.rotation_degrees = rotation_degrees
	bullet_instance_2.rotation_degrees = rotation_degrees
	bullet_instance_1.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	bullet_instance_2.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().add_child(bullet_instance_1)
	get_tree().get_root().add_child(bullet_instance_2)
	can_fire = false
	yield(get_tree().create_timer(_fire_rate), "timeout")
	can_fire = true

func _on_body_entered(body: Node) -> void:
	die()

func die() -> void:
	is_dead = true
	$Fire.visible = false
	$AnimationPlayer.play("Die")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://src/Levels/GameOver.tscn")
	queue_free()
	
func hit():
	pass
