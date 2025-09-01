extends Enemy

var facing_direction: int = 1


func _ready() -> void:
	super()
	move_component.velocity.x = [-20, 20].pick_random()


func _process(delta: float) -> void:
	_adjust_visuals()


func _adjust_visuals() -> void:
	var move_sign = sign(move_component.velocity.x)
	if move_sign != facing_direction:
		facing_direction = move_sign
		visuals.scale = Vector2(facing_direction, 1)
