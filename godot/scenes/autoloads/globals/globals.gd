extends Node

var window: JavaScriptObject

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


func watch_connection(
	on_connect: Callable,
	on_disconnect: Callable,
	on_bypass: Callable
) -> void:
	if window:
		if window.accountAddress != null:
			on_connect.call()
		else:
			on_disconnect.call()
	else:
		on_bypass.call()


func login() -> void:
	if window: window.login()


func logout() -> void:
	if window: window.logout()


func add_score(amount: int) -> void:
	score += amount


func reset_score() -> void:
	score = 0
