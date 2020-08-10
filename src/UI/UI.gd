extends Control

onready var scene_tree: = get_tree()
onready var paused_overlay: ColorRect = get_node("PauseOverlay")
onready var score_label: Label = get_node("ScoreLabel")

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_change",self,"_on_score_update")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value:bool) -> void:
	paused = value
	scene_tree.paused = value
	paused_overlay.visible = value
	
func _on_score_update(_score) -> void:
	score_label.text = "Score %s"%_score
	
