class_name YesNoQuestion extends Control

@export var question_text : String
@export var question : RichTextLabel
var is_animating : bool = true
var animation_speed : float = 0.5
var callable_on_yes : Callable
var callable_on_no : Callable

func _ready() -> void:
	position.y += 128

func new_question(question : String, on_yes : Callable, on_no : Callable) -> void:
	create_tween().tween_property(self,"position", Vector2.ZERO,animation_speed).finished.connect(func(): is_animating = false)
	question_text = question
	callable_on_no = on_no
	callable_on_yes = on_yes
	JusticeUI.is_yes_no_question_active = true
# 0 = not answered
# 1 = yes
# -1 = no
func answered_something(answer : int):
	question.text = ""
	is_animating = true
	callable_on_yes.call() if answer == 1 else callable_on_no.call()
	create_tween().tween_property(self,"position", Vector2(0,512),animation_speed).finished.connect(func(): is_animating = false)
	JusticeUI.is_yes_no_question_active = false

func _physics_process(delta: float) -> void:
	if !is_animating:
		if question.text != question_text && Engine.get_physics_frames() % 4 == 0 && !is_animating:
			question.text += question_text[question.text.length()]
		else:
			answer()

func answer():
	if Input.is_action_just_pressed("Shoot"):
		answered_something(1)
	else: if Input.is_action_just_pressed("Jump"):
		answered_something(-1)
