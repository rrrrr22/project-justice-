class_name Utils

static func new_scene(id : String) -> Node:
	return SceneRegister.game_register[id].scene.instantiate()

static func new_entity(id: String, owner: Entity = null) -> Entity:
	var entity =  SceneRegister.game_register[id].scene.instantiate() as Entity
	entity.entity_owner = owner
	return entity

static func emit_sound(sound : AudioStream, emitter: AudioStreamPlayer2D, base_pitch = 1, pitch_difference : float = 0):
	if emitter:
		emitter.stream = sound
		emitter.pitch_scale = randf_range(base_pitch - pitch_difference / 2, base_pitch + pitch_difference / 2)
		emitter.play()
