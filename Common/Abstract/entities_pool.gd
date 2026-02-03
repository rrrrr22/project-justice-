class_name EntitiesPool extends Node

func clear():
	for child in get_children():
		var entity = child as Entity
		entity.kill()
		
func add_entity(entity: Node):
	if entity is Entity:
		add_child(entity)
