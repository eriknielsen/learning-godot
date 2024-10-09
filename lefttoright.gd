extends Node3D

@export var mob_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UserInterface/DeathBackground.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and $UserInterface/DeathBackground.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()
		

func spawn_enemy():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("level/SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_mob_timer_timeout() -> void:
	spawn_enemy()

func _on_player_death() -> void:
	game_over()

func game_over():
	$MobTimer.stop()
	$UserInterface/DeathBackground.show()
	var to_destroy = get_tree().get_nodes_in_group("destroyed_on_game_over")
	for d in to_destroy:
		d.queue_free()
