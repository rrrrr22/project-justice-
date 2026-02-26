extends Node

@export var current_items : Array[Item]

func remove_item(item : Item):
	item.on_consumed()
	current_items.erase(item)

func add_item(item : Item):
	item.on_added()
	current_items.append(item)
