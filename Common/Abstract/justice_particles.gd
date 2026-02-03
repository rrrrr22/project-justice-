class_name JusticeParticles extends CPUParticles2D

func _ready() -> void:
	emitting = true
	reparent(self.get_tree().current_scene)

func _on_finished() -> void:
	queue_free()
