class_name JusticePopup extends Control

signal on_answer_no()
signal on_answer_yes()

@export var text_label : RichTextLabel
@export var yes_no_label : RichTextLabel
@export var yes_no_panel : PanelContainer
var question_at_the_end : bool
var texts : Array[String]
var current_text_index : int
var do_pause : bool = false
static var a_popup_is_active : bool = false

func _ready() -> void:
	a_popup_is_active = true
	if !get_tree().paused && do_pause:
		get_tree().paused = true 

func _physics_process(delta: float) -> void:
	
	if text_label.text != texts[current_text_index] && Engine.get_physics_frames() % 4 == 0:
		text_label.text += texts[current_text_index][text_label.text.length()]
	if question_at_the_end && text_label.text == texts[current_text_index] && current_text_index == texts.size() - 1:
		yes_no_panel.visible = true

func _unhandled_key_input(event: InputEvent) -> void:
	
	if text_label.text != texts[current_text_index] && event.is_action_pressed("Shoot"):
		text_label.text += texts[current_text_index][text_label.text.length()]
		return
		
	if current_text_index != texts.size() - 1 && Input.is_action_just_pressed_by_event("Shoot",event):
		current_text_index += 1
		text_label.text = ""
	else: if !question_at_the_end:
		queue_free()
	
	if text_label.text == texts[current_text_index] && event.is_action_pressed("Yes"):
		on_answer_yes.emit()
		queue_free()
		a_popup_is_active = false
		if do_pause:
			get_tree().paused = false
	if text_label.text == texts[current_text_index] && event.is_action_pressed("No"):
		on_answer_no.emit()
		queue_free()
		a_popup_is_active = false
		if do_pause:
			get_tree().paused = false
