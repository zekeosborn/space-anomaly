class_name Enemy
extends Node2D

@export var score: int = 5
@onready var hit_audio: VariablePitchAudioStreamPlayer = $HitAudio
@onready var visuals: Node2D = $Visuals
@onready var stats_component: StatsComponent = $StatsComponent
@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent


func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hurtbox_component.hurt.connect(_on_hurt)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	stats_component.no_health.connect(_on_no_health)


func _on_hurt(hitbox: HitboxComponent) -> void:
	scale_component.tween_scale()
	flash_component.flash()
	shake_component.tween_shake()
	hit_audio.play_with_variance()


func _on_no_health() -> void:
	Globals.add_score(score)
