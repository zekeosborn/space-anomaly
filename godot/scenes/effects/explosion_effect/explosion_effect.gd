extends AnimatedSprite2D

@onready var explosion_audio: VariablePitchAudioStreamPlayer = $ExplosionAudio


func _ready() -> void:
	animation_finished.connect(hide)
	explosion_audio.finished.connect(queue_free)
