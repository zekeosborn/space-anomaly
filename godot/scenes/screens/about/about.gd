extends Control

@onready var back_button: Button = %BackButton
@onready var zekeosborn_button: Button = %ZekeosbornButton
@onready var heartbeast_button: Button = %HeartbeastButton
@onready var grafxkid_button: Button = %GrafxkidButton
@onready var kenney_button: Button = %KenneyButton
@onready var tallbeard_studios_button: Button = %TallbeardStudiosButton
@onready var kronbits_button: Button = %KronbitsButton

var zekeosborn_link: String = "https://x.com/zekeosborn"
var heartbeast_link: String = "https://heartgamedev.com"
var grafxkid_link: String = "https://grafxkid.itch.io"
var kenney_link: String = "https://kenney.nl"
var tallbeard_studios_link: String = "https://tallbeard.itch.io"
var kronbits_link: String = "https://kronbits.itch.io"


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	zekeosborn_button.pressed.connect(OS.shell_open.bind(zekeosborn_link))
	heartbeast_button.pressed.connect(OS.shell_open.bind(heartbeast_link))
	grafxkid_button.pressed.connect(OS.shell_open.bind(grafxkid_link))
	kenney_button.pressed.connect(OS.shell_open.bind(kenney_link))
	tallbeard_studios_button.pressed.connect(OS.shell_open.bind(tallbeard_studios_link))
	kronbits_button.pressed.connect(OS.shell_open.bind(kronbits_link))


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/main_menu/main_menu.tscn")
