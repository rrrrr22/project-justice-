extends Label


func _physics_process(delta: float) -> void:
	if JusticeGlobal.main_character:
		text = str(JusticeGlobal.main_character.entity_stats.current_hp) + "/" + str(JusticeGlobal.main_character.entity_stats.max_hp) 
		
