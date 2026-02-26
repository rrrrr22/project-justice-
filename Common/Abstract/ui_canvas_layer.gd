class_name GameUI extends CanvasLayer
var is_yes_no_question_active : bool = false

@export var mc_ui : Container
@export var invetory_screen : PackedScene

func _physics_process(delta: float) -> void:
	if MetSys.get_current_room_id() != "":
		if Input.is_action_just_pressed("Inv") && !JusticePopup.a_popup_is_active:
			get_tree().paused = !get_tree().paused
			add_child(invetory_screen.instantiate())
		mc_ui.visible = true
	else:
		mc_ui.visible = false
	
