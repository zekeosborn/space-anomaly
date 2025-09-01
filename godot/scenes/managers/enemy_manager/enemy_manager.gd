extends Node

@export var pepe_enemy_scene: PackedScene
@export var jar_enemy_scene: PackedScene
@export var scre_enemy_scene: PackedScene
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var pepe_enemy_timer: Timer = $PepeEnemyTimer
@onready var jar_enemy_timer: Timer = $JarEnemyTimer
@onready var scre_enemy_timer: Timer = $ScreEnemyTimer

var margin = 12
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var entities_layer: Node2D


func _ready() -> void:
	pepe_enemy_timer.timeout.connect(_spawn_enemy.bind(pepe_enemy_scene, pepe_enemy_timer, 2))
	jar_enemy_timer.timeout.connect(_spawn_enemy.bind(jar_enemy_scene, jar_enemy_timer, 5))
	scre_enemy_timer.timeout.connect(_spawn_enemy.bind(scre_enemy_scene, scre_enemy_timer, 10))
	Events.score_changed.connect(_on_score_changed)
	entities_layer = get_tree().get_first_node_in_group("entities_layer")


func _on_score_changed(new_score: int):
	if new_score > 50:
		jar_enemy_timer.process_mode = Node.PROCESS_MODE_INHERIT
	if new_score > 250:
		scre_enemy_timer.process_mode = Node.PROCESS_MODE_INHERIT


func _spawn_enemy(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	var spawn_location = Vector2(randf_range(margin, screen_width - margin), -16)
	spawner_component.scene = enemy_scene
	spawner_component.spawn(spawn_location, entities_layer)
	var spawn_rate = time_offset / (1.0 + log(Globals.score + 1) * 0.1)
	timer.start(spawn_rate + randf_range(0.25, 0.5))
