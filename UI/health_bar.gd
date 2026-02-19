extends TextureProgressBar


func _physics_process(delta: float) -> void:
	if JusticeGlobal.main_character:
		value = JusticeGlobal.main_character.entity_stats.current_hp
		max_value = JusticeGlobal.main_character.entity_stats.max_hp
