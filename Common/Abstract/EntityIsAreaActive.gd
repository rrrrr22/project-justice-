class_name EntityIsAreaActive extends Area2D
@export
var entity : Entity
func _physics_process(delta: float) -> void:
	if entity.is_active:
		run()
func run():
	pass
