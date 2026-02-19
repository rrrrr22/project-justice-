extends InvItem

func item_name() -> String:
	return "Hello im a key boi"
	
func item_description() -> String:
	return "a useless key, what gives!"

func on_selected(index : int) -> bool:
	JusticeGlobal.main_character.entity_stats.current_hp = JusticeGlobal.main_character.entity_stats.max_hp
	return true
