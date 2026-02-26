extends Entity

var death_popup : JusticePopup
var death_timer : int = 0
func on_ready() -> void:
	JusticeGlobal.main_character = self
	
func post_update():
	MetSys.set_player_position(global_position)
	if !is_active:
		death_timer += 1
		if death_timer == 160:
			death_popup = Utils.new_popup()
			death_popup.question_at_the_end = true
			death_popup.texts = ["you are dead...", "respawn at last checkpoint?"]
			death_popup.do_pause = true
			death_popup.on_answer_yes.connect(on_answer_yes)
			death_popup.on_answer_no.connect(on_answer_no)

			JusticeUI.add_child(death_popup)
			
func on_answer_yes():
	JusticeGlobal.start_game()

func on_answer_no():
	get_tree().change_scene_to_file("res://Content/StartingScene.tscn")
