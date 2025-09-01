class_name MoveInputComponent
extends Node

@export var move_component: MoveComponent
@export var speed: int = 100


func _input(event: InputEvent) -> void:
	var input_axis = Input.get_axis("move_left", "move_right")
	move_component.velocity = Vector2(input_axis * speed, 0)
