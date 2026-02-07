extends AudioStreamPlayer2D

@export
var entity : Entity

func _physics_process(delta: float) -> void:

	if !is_instance_valid(entity) && !playing:
		queue_free()
		
		
