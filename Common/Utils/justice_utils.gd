class_name Utils

static func new_scene(id : String) -> Node:
	return SceneRegister.game_register[id].scene.instantiate()

static func new_entity(id: String, owner: Entity = null) -> Entity:
	var entity =  SceneRegister.game_register[id].scene.instantiate() as Entity
	entity.entity_owner = owner
	return entity
