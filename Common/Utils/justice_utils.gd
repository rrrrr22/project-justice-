class_name Utils

static func new_scene(id : String) -> Node:
	return SceneRegister.game_register[id].scene.instantiate()

static func new_entity(id: String, owner: Entity = null) -> Entity:
	var entity =  SceneRegister.game_register[id].scene.instantiate() as Entity
	entity.entity_owner = owner
	return entity

static func emit_sound(sound : AudioStream, emitter: AudioStreamPlayer2D, pitch_difference : float = 0, base_pitch = null):
	if emitter:
		emitter.stream = sound
		if base_pitch != null:
			emitter.pitch_scale = clampf(randf_range(base_pitch - pitch_difference / 2, base_pitch + pitch_difference / 2),0.1,10)
		else:
			emitter.pitch_scale = clampf(randf_range(emitter.pitch_scale - pitch_difference / 2, emitter.pitch_scale + pitch_difference / 2),0.1,10)
		emitter.play()
