extends Control

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var saving_label: Label = %SavingLabel
@onready var score_label: Label = %ScoreLabel
@onready var restart_button: Button = %RestartButton
@onready var main_menu_button: Button = %MainMenuButton

var hmac = HMAC.new()


func _ready() -> void:
	http_request.request_completed.connect(_on_http_request_completed)
	restart_button.pressed.connect(_on_restart_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	score_label.text = str(Globals.score)
	if Globals.window: _submit_score()


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/game/game.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/main_menu/main_menu.tscn")


func _submit_score() -> void:
	if not Globals.window: return
	if Globals.score == 0: return
	
	saving_label.show()
	
	var api_url = Globals.window.appUrl + "/api/submit-score"
	var json_string = JSON.stringify({
		"address": Globals.window.accountAddress,
		"score": Globals.score
	})
	
	var timestamp = str(int(Time.get_unix_time_from_system() * 1000))
	var signature = hmac.generate(json_string, timestamp)
	var headers = [
		"Content-Type: application/json",
		"x-signature: " + signature,
		"x-timestamp: " + timestamp
	]
	
	http_request.request(
		api_url, 
		headers, 
		HTTPClient.METHOD_POST, 
		json_string
	)


func _on_http_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:
	if response_code == 200 or response_code == 409:
		saving_label.hide()
