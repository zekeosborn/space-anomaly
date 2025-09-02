extends Label

@export var velocity: Vector2 = Vector2(0, 20)
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier


func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)


func _process(delta: float) -> void:
	global_position += velocity * delta
