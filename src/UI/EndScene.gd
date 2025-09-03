extends Control

@onready var score_label: Label = get_node("ScoreLabel")

func _ready() -> void:
	if score_label:
		score_label.text = "Your score was %s" % PlayerData.get_score()
	else:
		push_warning("ScoreLabel node not found!")
