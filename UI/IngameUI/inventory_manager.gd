class_name InventoryManager extends Control


var item : InvItem
@export var item_name : RichTextLabel
@export var item_desc: RichTextLabel
@export var inv_grid : GridContainer
@export var outline : TextureRect
@export var inventory_item : PackedScene
static var selecter : int = 0
var popup_instance : JusticePopup

func _ready() -> void:
	for item in PersistentGlobal.current_items:
		var i = inventory_item.instantiate() as InvItem
		i.instance = item
		i.texture = item.texture
		inv_grid.add_child(i)

func _physics_process(delta: float) -> void:
	
	if !get_tree().paused:
		queue_free()
		return
		
	if item:
		outline.visible = true
		item_name.text = item.instance.item_name
		if item_desc.text != item.instance.item_desc && Engine.get_physics_frames() % 4 == 0:
			item_desc.text += item.instance.item_desc[item_desc.text.length()]

func _unhandled_key_input(event: InputEvent) -> void:
	if JusticePopup.a_popup_is_active:
		return
	
	if inv_grid.get_child_count() > 0 && inv_grid.get_child(-1) != null:
		if event.is_action_pressed("A"):
			selecter -= 1
		if event.is_action_pressed("D"):
			selecter += 1
		if event.is_action_pressed("S"):
			selecter += inv_grid.columns
		if event.is_action_pressed("W"):
			selecter -= inv_grid.columns
		selecter = clamp(selecter,0,inv_grid.get_child_count() - 1)
		
		if item != inv_grid.get_child(selecter): 
			item = inv_grid.get_child(selecter) as InvItem
			item_desc.text = ""
		outline.position = item.position + item.size
	else:
		item_name.text = ""
		item_desc.text = "no item selected"
		
	if Input.is_action_just_pressed_by_event("Shoot",event):
		popup_instance = SceneRegister.game_register["justice_popup"].scene.instantiate() as JusticePopup
		popup_instance.on_answer_yes.connect(consume_item)
		popup_instance.texts = item.instance.item_popup_texts
		popup_instance.question_at_the_end = true
		add_child(popup_instance)

func consume_item():
	PersistentGlobal.remove_item(item.instance)
	item.queue_free()
