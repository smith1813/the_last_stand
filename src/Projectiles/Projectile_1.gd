extends RigidBody2D

export var projectile_dmg = 1


func _ready() -> void:
	$AnimationPlayer.play("normal")
	
func get_dmg() -> int:
	return projectile_dmg

func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered(_body: Node) -> void:
	_body.hit(projectile_dmg)
	#TODO revisar este error
	get_node(".").sleeping = true
	$AnimationPlayer.play("explode")
	$AudioStreamPlayer2D.play()
	yield($AnimationPlayer,"animation_finished")
	queue_free()
