extends Node3D

signal on_kill

func _ready() -> void:
	$AnimationPlayer.play("bash_shield")

func initialize(level:int, player_position):
	position.z -= 1.5

func _on_area_3d_body_entered(body: Node3D) -> void:
	body.queue_free()
	on_kill.emit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
