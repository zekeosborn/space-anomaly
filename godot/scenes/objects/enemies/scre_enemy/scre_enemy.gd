extends Enemy

@onready var projectile_marker: Marker2D = $ProjectileMarker
@onready var states: Node = $States
@onready var move_down_state: TimedStateComponent = %MoveDownState
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var move_side_component: MoveComponent = %MoveSideComponent
@onready var fire_state: StateComponent = %FireState
@onready var projectile_spawner: SpawnerComponent = %ProjectileSpawner
@onready var pause_state: TimedStateComponent = %PauseState

var entities_layer: Node2D
var facing_direction: int = 1


func _ready() -> void:
	super()
	entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
	for state in states.get_children():
		(state as StateComponent).disable()
	
	move_side_component.velocity.x = [-20, 20].pick_random()
	
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(_fire_projectile)
	fire_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_down_state.enable)
	
	move_down_state.enable()


func _process(delta: float) -> void:
	_adjust_visuals()


func _adjust_visuals() -> void:
	var move_sign = sign(move_side_component.velocity.x)
	if move_sign != facing_direction:
		facing_direction = move_sign
		visuals.scale = Vector2(facing_direction, 1)


func _fire_projectile():
	fire_state.enable()
	scale_component.tween_scale()
	projectile_spawner.spawn(projectile_marker.global_position, entities_layer)
	fire_state.disable()
	fire_state.state_finished.emit()
