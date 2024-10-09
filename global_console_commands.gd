#class_name GlobalConsoleCommands

extends Node

#var player: Node3D

func _ready() -> void:
	# Localization
	Console.add_command("set_locale", set_locale, 1)
	# Player
	Console.add_command("add_weapon", add_weapon, 1)
	print(get_tree().root.get_tree())
func set_locale(language):
	TranslationServer.set_locale(language)

func add_weapon(name):
	print("mjau")
	var path = "res://items/%s.tres" % name
	var loaded = load(path)
	get_node("/root/Node3D/Player").add_weapon(loaded)
