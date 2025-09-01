extends Node2D

@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier
@onready var scale_component: ScaleComponent = $ScaleComponent


func _ready() -> void:
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	scale_component.tween_scale()
