extends Node2D

@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier
@onready var hitbox_component: HitboxComponent = $HitboxComponent


func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(_on_hit_hurtbox)


func _on_hit_hurtbox(hurtbox: HurtboxComponent):
	queue_free()
