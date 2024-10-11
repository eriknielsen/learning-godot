extends Node

func _ready() -> void:
	# Localization
	Console.add_command("set_locale", set_locale, 1)
	# Player
	Console.add_command("add_weapon", add_weapon, 1)

#region Localization
func set_locale(language):
	TranslationServer.set_locale(language)
#endregion // Localization

#region Player
func add_weapon(name):
	print("mjau")
	var path = "res://items/%s.tres" % name
	var loaded = load(path)
	get_node("/root/main/Player").add_weapon(loaded)
#endregion // Player
