extends Control

@onready var menu_container: CenterContainer = $MenuContainer
@onready var log_in_container: CenterContainer = $LogInContainer
@onready var play_button: Button = %PlayButton
@onready var leaderboard_button: Button = %LeaderboardButton
@onready var about_button: Button = %AboutButton
@onready var log_in_button: Button = %LogInButton
@onready var log_out_button: Button = %LogOutButton

var leaderboard_link: String = "https://monad-games-id-site.vercel.app/leaderboard?page=1&gameId=248&sortBy=scores"


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	leaderboard_button.pressed.connect(OS.shell_open.bind(leaderboard_link))
	about_button.pressed.connect(_on_about_button_pressed)
	log_in_button.pressed.connect(Globals.login)
	log_out_button.pressed.connect(Globals.logout)


func _process(delta: float) -> void:
	Globals.watch_connection(_show_menu, _show_login, _show_menu)


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/game/game.tscn")


func _on_about_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/about/about.tscn")


func _show_menu():
	log_in_container.hide()
	menu_container.show()


func _show_login():
	menu_container.hide()
	log_in_container.show()
