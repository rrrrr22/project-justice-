class_name InvItem extends TextureRect

@export var yes_no_question_to_select : bool
@export var question : String

func item_name() -> String:
	return ""

func item_description() -> String:
	return ""

#return true to consume
func on_selected(index : int) -> bool:
	return true
	
func on_rejected(index : int):
	pass
