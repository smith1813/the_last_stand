extends KinematicBody2D

export var hp = 10
var inmune = false

export var speed = 250
onready var player = get_parent().get_node("Player")
onready var spawner = get_parent().get_node("EnemySpawner")


signal dead()

signal hp_count(hp)

func _ready() -> void:
	connect("dead",spawner,"_on_Enemy_3_dead")
	connect("dead",PlayerData,"_on_Enemy_3_dead")
	$AnimationPlayer.play("idle")
	emit_signal("hp_count",hp)
		
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
		yield($AnimationPlayer,"animation_finished")
		inmune = false
		
func die():

	speed = 0
	$Sprite/AnimatedSprite.visible = false
	$Sprite/AnimatedSprite2.visible = false
	$AnimationPlayer.play("die")
	$AudioStreamPlayer2D.play()
	yield($AnimationPlayer,"animation_finished")
	emit_signal("dead")
	queue_free()


