extends RichTextLabel

var init_text : String
@export var is_focused : bool = false

func _ready() -> void:
	init_text = text
	if is_focused:
		grab_focus()
		call_deferred("grab_focus")
		
func on_pressed():
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("Shoot") && has_focus():
		on_pressed()

func _on_focus_entered() -> void:
	text = "[center][b]<<[b]" + init_text + "[b]>>[b][center]"

func _on_focus_exited() -> void:
	text = init_text
