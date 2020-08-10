extends Control

onready var score_label: Label = get_node("ScoreLabel")

func _ready() -> void:
	score_label.text = "Your score was %s"%PlayerData.get_score()
