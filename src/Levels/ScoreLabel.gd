extends Label

func _ready() -> void:
	get_node(".").text= "Score: 0"

func _on_PlayerData_score_change(_score) -> void:
	get_node(".").text= "Score:\t %s"%_score
