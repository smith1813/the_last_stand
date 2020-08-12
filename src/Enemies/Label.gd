extends Label

func _on_Enemy_1_hp_count(hp) -> void:
	get_node(".").text = "HP: %s"%hp
