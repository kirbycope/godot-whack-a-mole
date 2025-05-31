extends Node3D

var high_score := 0
var score := 0

@onready var animation_player_0: AnimationPlayer = $WhackAMoleMachine/Chipmunk/AnimationPlayer
@onready var animation_player_1: AnimationPlayer = $WhackAMoleMachine/Chipmunk_001/AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $WhackAMoleMachine/Chipmunk_002/AnimationPlayer
@onready var animation_player_3: AnimationPlayer = $WhackAMoleMachine/Chipmunk_003/AnimationPlayer
@onready var animation_player_4: AnimationPlayer = $WhackAMoleMachine/Chipmunk_004/AnimationPlayer
@onready var lose_reaction: AudioStreamPlayer = $LoseReaction
@onready var reation_theme: AudioStreamPlayer = $ReactionTheme
@onready var start_ui: Control = $Camera3D/StartUI
@onready var game_timer: Timer = $GameTimer
@onready var spawn_timer: Timer = $SpawnTimer
@onready var win_reaction: AudioStreamPlayer = $WinReaction


func start() -> void:
	start_ui.hide()
	if not reation_theme.playing:
		reation_theme.play()
	game_timer.start()
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	# Get a list of availible chipmunks
	var availible_chipmunks = []
	if animation_player_0.current_animation != "action":
		availible_chipmunks.append(0)
	if animation_player_1.current_animation != "action":
		availible_chipmunks.append(1)
	if animation_player_2.current_animation != "action":
		availible_chipmunks.append(2)
	if animation_player_3.current_animation != "action":
		availible_chipmunks.append(3)
	if animation_player_4.current_animation != "action":
		availible_chipmunks.append(4)
	
	var random_number = randi_range(0, 5)
	if random_number == 0:
		animation_player_0.play("action")
	elif random_number == 1:
		animation_player_1.play("action")
	elif random_number == 2:
		animation_player_2.play("action")
	elif random_number == 3:
		animation_player_3.play("action")
	elif random_number == 4:
		animation_player_4.play("action")
	spawn_timer.start()


func _on_start_button_pressed() -> void:
	start()


func _on_timer_timeout() -> void:
	start_ui.show()
	reation_theme.stop()
	if score == 0:
		if not lose_reaction.playing:
			lose_reaction.play()
	else:
		if not win_reaction.playing:
			win_reaction.play()
	spawn_timer.stop()
	animation_player_0.play("RESET")
	animation_player_1.play("RESET")
	animation_player_2.play("RESET")
	animation_player_3.play("RESET")
	animation_player_4.play("RESET")
