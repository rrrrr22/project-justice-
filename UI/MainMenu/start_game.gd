extends "res://UI/justice_button.gd"

@export var main_menu : Node

func on_pressed():
	main_menu.queue_free()
	JusticeGlobal.start_game()
