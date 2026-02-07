extends Entity

func on_ready() -> void:
	JusticeGlobal.set_player(self)
	JusticeGlobal.main_character = self

func post_update():
	MetSys.set_player_position(global_position)
