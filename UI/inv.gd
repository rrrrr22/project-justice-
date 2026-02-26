class_name Inventory extends Control
const animation_speed : float = 0.7
@export var selecter : int
@export var outline : TextureRect
@export var inv_grid : GridContainer
@export var item_name_label : RichTextLabel
@export var item_desc_label : RichTextLabel
var yes_no_question : YesNoQuestion
var item : InvItem
var tweenAnimation : PropertyTweener
var is_animating : bool = false
var is_yes_no_question_active : bool = false
var is_finished_animating_opening : bool = false
var is_finished_animating_closing : bool = false

func post_animation_tick():
	
	if item:
		item_name_label.text = item.item_name()
		if item_desc_label.text != item.item_description() && Engine.get_physics_frames() % 4 == 0:
			item_desc_label.text += item.item_description()[item_desc_label.text.length()]

	if JusticeUI.is_yes_no_question_active:
		return
	
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
			if JusticeUI.yes_no_question.is_animating && item.yes_no_question_to_select:
				is_yes_no_question_active = true
				JusticeUI.yes_no_question.new_question(item.question,
				func():
					get_answer(1)
				,func():
					get_answer(-1)
				)
			else:
				if item.on_selected(selecter):
					inv_grid.get_child(selecter).queue_free()
	else:
		selecter = -1
		item_name_label.text = "empty inventory"
	outline.visible = selecter != -1 

	
func get_answer(answer : int):
	if answer == 1:
		if item.on_selected(selecter):
			inv_grid.get_child(selecter).queue_free()
	else: if answer == -1:
		item.on_rejected(selecter)
	is_yes_no_question_active = false
	 
