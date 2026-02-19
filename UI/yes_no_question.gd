class_name YesNoQuestion extends Control

@export var question_text : String
@export var question : RichTextLabel
var is_animating : bool = true
signal yes_no_question_with_an_answer(answer : int)

func _ready() -> void:
	position.y += 128

func new_question(question : String) -> void:
	create_tween().tween_property(self,"position", Vector2.ZERO,1).finished.connect(func(): is_animating = false)
	question_text = question
# 0 = not answered
# 1 = yes
# -1 = no
func answered_something(answer : int):
	question.text = ""
	is_animating = true
	create_tween().tween_property(self,"position", Vector2(0,128),1).finished.connect(func(): yes_no_question_with_an_answer.emit(answer))
	
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
