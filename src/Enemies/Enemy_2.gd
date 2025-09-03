extends CharacterBody2D

@export var hp = 1
var inmune = false

#export var speed = 900
@export var speed = 500

@onready var player = get_parent().get_node("Player")
@onready var spawner = get_parent().get_node("EnemySpawner")


signal dead()

signal hp_count(hp)

func _ready() -> void:
	connect("dead", Callable(spawner, "_on_Enemy_2_dead"))
	connect("dead", Callable(PlayerData, "_on_Enemy_2_dead"))
	$AnimationPlayer.play("idle")
	emit_signal("hp_count",hp)
	speed = max(randf(),0.8)*speed
		
func _physics_process(delta):
	if player!= null:
		var dir = (player.get_global_position() - get_node(".").global_position).normalized()
		get_node(".").look_at(player.get_global_position())
		move_and_collide(dir * speed * delta)	

func hit(dmg)->void:
	if !inmune:
		inmune = true
		hp -= dmg
		emit_signal("hp_count",hp)
		if hp <= 0:
			die()
			return
		$AnimationPlayer.play("hit")
		await $AnimationPlayer.animation_finished
		inmune = false
		
func die():
	emit_signal("dead")
	speed = 0
	$Sprite2D/AnimatedSprite2D.visible = false
	$Sprite2D/AnimatedSprite2.visible = false
	$AnimationPlayer.play("die")
	$AudioStreamPlayer2D.play()
	await $AnimationPlayer.animation_finished
	queue_free()


