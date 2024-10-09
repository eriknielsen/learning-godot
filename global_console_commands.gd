extends Node

func _ready() -> void:
	Console.add_command("set_locale", set_locale, 1)

func set_locale(language):
	TranslationServer.set_locale(language)
