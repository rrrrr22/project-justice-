extends Control

@export var selecter : int
@export var outline : TextureRect
@export var inv_grid : GridContainer
@export var item_name_label : RichTextLabel
@export var item_desc_label : RichTextLabel
@export var yes_no_question : YesNoQuestion
var item : InvItem
var tweenAnimation : PropertyTweener
var is_animating : bool = false
var is_yes_no_question_active : bool = false
func _ready() -> void:
	yes_no_question.yes_no_question_with_an_answer.connect(get_answer)

func _physics_process(delta: float) -> void:
	if item  && !is_animating:
		item_name_label.text = item.item_name()
		if item_desc_label.text != item.item_description() && Engine.get_physics_frames() % 4 == 0:
			item_desc_label.text += item.item_description()[item_desc_label.text.length()]

	if is_yes_no_question_active:
		return

	
	if Input.is_action_just_pressed("Inv") && !is_animating:
		item_desc_label.text = ""
		item_name_label.text = ""

		is_animating = true
		if !visible:
			visible = true
			position.y = 512
			tweenAnimation = create_tween().tween_property(self,"position",Vector2(4,4),1).set_trans(Tween.TRANS_CIRC)
			tweenAnimation.finished.connect(func():
				is_animating = false )
		else:
			tweenAnimation = create_tween().tween_property(self,"position",Vector2(4,512),1).set_trans(Tween.TRANS_CIRC)
			tweenAnimation.finished.connect(func():
				is_animating = false
				visible = false )
	if visible:
		get_tree().paused = true
		if inv_grid.get_child(-1) != null:
			if Input.is_action_just_pressed("A"):
				selecter -= 1
			if Input.is_action_just_pressed("D"):
				selecter += 1
			if Input.is_action_just_pressed("S"):
				selecter += inv_grid.columns
			if Input.is_action_just_pressed("W"):
				selecter -= inv_grid.columns
			selecter = clamp(selecter,0,inv_grid.get_child_count() - 1)
			
			if item != inv_grid.get_child(selecter): 
				item = inv_grid.get_child(selecter) as InvItem
				item_desc_label.text = ""
			outline.position = item.position
			
			if Input.is_action_just_pressed("Shoot"):
				if yes_no_question.is_animating && item.yes_no_question_to_select:
					is_yes_no_question_active = true
					yes_no_question.new_question(item.question)
				else:
					if item.on_selected(selecter):
						inv_grid.get_child(selecter).queue_free()
		else:
			selecter = -1
			item_name_label.text = "empty inventory"
		outline.visible = selecter != -1
		
	else:
		get_tree().paused = false

func get_answer(answer : int):
	if answer == 1:
		if item.on_selected(selecter):
			inv_grid.get_child(selecter).queue_free()
	else: if answer == -1:
		item.on_rejected(selecter)
	is_yes_no_question_active = false
	 
