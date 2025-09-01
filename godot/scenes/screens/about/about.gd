extends Control

@onready var back_button: Button = %BackButton
@onready var zekeosborn_button: Button = %ZekeosbornButton
@onready var heartbeast_button: Button = %HeartbeastButton
@onready var grafxkid_button: Button = %GrafxkidButton
@onready var kenney_button: Button = %KenneyButton

var zekeosborn_link: String = "https://x.com/zekeosborn"
var heartbeast_link: String = "https://www.heartgamedev.com/"
var grafxkid_link: String = "https://grafxkid.itch.io/"
var kenney_link: String = "https://www.kenney.nl/"


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	zekeosborn_button.pressed.connect(OS.shell_open.bind(zekeosborn_link))
	heartbeast_button.pressed.connect(OS.shell_open.bind(heartbeast_link))
	grafxkid_button.pressed.connect(OS.shell_open.bind(grafxkid_link))
	kenney_button.pressed.connect(OS.shell_open.bind(kenney_link))


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/main_menu/main_menu.tscn")
