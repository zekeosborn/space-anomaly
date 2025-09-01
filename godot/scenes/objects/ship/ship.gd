extends Node2D

@export var disable_control: bool = false
@onready var laser_audio: VariablePitchAudioStreamPlayer = $LaserAudio
@onready var ship_animated_sprite: AnimatedSprite2D = %ShipAnimatedSprite
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var move_component: MoveComponent = $MoveComponent
@onready var move_input_component: MoveInputComponent = $MoveInputComponent
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var left_muzzle: Marker2D = %LeftMuzzle
@onready var right_muzzle: Marker2D = %RightMuzzle
@onready var laser_spawner: SpawnerComponent = %LaserSpawner
@onready var fire_timer: Timer = %FireTimer

var entities_layer: Node2D
var firing: bool = false


func _ready() -> void:
	fire_timer.timeout.connect(_on_fire_timeout)
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	if disable_control: move_input_component.speed = 0


func _process(delta: float) -> void:
	_animate_ship()


func _input(event: InputEvent) -> void:
	if disable_control: return
	if event.is_action_pressed("fire"):
		_fire_lasers()
		firing = true
	elif event.is_action_released("fire"):
		firing = false


func _on_fire_timeout() -> void:
	if firing: _fire_lasers()


func _animate_ship() -> void:
	if move_component.velocity.x < 0:
		ship_animated_sprite.play("tilt_left")
		flame_animated_sprite.play("tilt_left")
	elif move_component.velocity.x > 0:
		ship_animated_sprite.play("tilt_right")
		flame_animated_sprite.play("tilt_right")
	else:
		ship_animated_sprite.play("center")
		flame_animated_sprite.play("center")


func _fire_lasers() -> void:
	if fire_timer.is_stopped():
		laser_audio.play_with_variance()
		laser_spawner.spawn(left_muzzle.global_position, entities_layer)
		laser_spawner.spawn(right_muzzle.global_position, entities_layer)
		scale_component.tween_scale()
		fire_timer.start()
