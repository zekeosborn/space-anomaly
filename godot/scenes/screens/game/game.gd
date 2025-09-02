extends Node2D

@onready var score_label: Label = %ScoreLabel
@onready var game_over_timer: Timer = $GameOverTimer
@onready var ship: Node2D = %Ship


func _ready() -> void:
	Events.score_changed.connect(_on_score_changed)
	ship.tree_exited.connect(game_over_timer.start)
	game_over_timer.timeout.connect(_on_game_over_timer_timeout)
	
	randomize()
	MusicPlayer.menu_bgm.stop()
	MusicPlayer.game_bgm.play()
	Globals.reset_score()


func _on_game_over_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/game_over/game_over.tscn")


func _on_score_changed(score: int) -> void:
	score_label.text = str(score)
