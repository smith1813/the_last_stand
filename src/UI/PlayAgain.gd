extends Button

func _on_button_up() -> void:
	PlayerData.score = 0
	get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")
