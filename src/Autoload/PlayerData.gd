extends Node

@onready var score:int = 0: get = get_score, set = set_score
@onready var lifes = 3

signal score_change(score)


func _ready() -> void:
	emit_signal("score_change", score)
	
func _on_Enemy_1_dead():
	score += 1
	emit_signal("score_change", score)
	
func _on_Enemy_2_dead():
	score += 2
	emit_signal("score_change", score)
	
func _on_Enemy_3_dead():
	score += 10
	emit_signal("score_change", score)

func set_score(new_score) -> void:
	score = new_score
	emit_signal("score_change", new_score)
	
func get_score() -> int:
	return score
