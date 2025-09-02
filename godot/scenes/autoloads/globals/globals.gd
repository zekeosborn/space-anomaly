extends Node

var window: JavaScriptObject = null
var account_address: Variant = null

var _score: int = 0
var score: int:
	get:
		return _score
	set(value):
		_score = value
		Events.score_changed.emit(_score)

var high_score: int = 0


func _ready() -> void:
	window = JavaScriptBridge.get_interface("window")


func watch_connection(on_connect: Callable, on_disconnect: Callable) -> void:
	if not window: return
	var new_address = window.accountAddress
	if new_address != account_address:
		account_address = new_address
		if account_address:
			on_connect.call()
		else:
			on_disconnect.call()


func reset_connection() -> void:
	account_address = null


func login() -> void:
	if window: window.login()


func logout() -> void:
	if window: window.logout()


func add_score(amount: int) -> void:
	score += amount


func reset_score() -> void:
	score = 0
