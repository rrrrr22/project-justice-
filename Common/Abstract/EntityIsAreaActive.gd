class_name EntityIsAreaActive extends Area2D
@export
var entity : Entity
func check():
	if entity.is_active:
		run()
	pass
func run():
	pass
