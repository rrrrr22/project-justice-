extends EntityIsAreaActive

var has_a_yes_no_question : bool = false

func _ready() -> void:
	yes_no_question.yes_no_question_with_an_answer.connect(get_answer)


func on_interact():
	var section = get_tree().current_scene
	if section is Section:
		section.yes_no_prompt.new_question("Found a Key... take it?")

func get_answer(answer : int):
	if answer == 1:
		if item.on_selected(selecter):
			inv_grid.get_child(selecter).queue_free()
	else: if answer == -1:
		item.on_rejected(selecter)
	is_yes_no_question_active = false
