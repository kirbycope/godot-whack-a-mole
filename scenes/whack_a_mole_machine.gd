extends Node3D

var high_score := 0
var last_spawned := -1
var score := 0

@onready var animation_player_0: AnimationPlayer = $Chipmunk/AnimationPlayer
@onready var animation_player_1: AnimationPlayer = $Chipmunk_001/AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $Chipmunk_002/AnimationPlayer
@onready var animation_player_3: AnimationPlayer = $Chipmunk_003/AnimationPlayer
@onready var animation_player_4: AnimationPlayer = $Chipmunk_004/AnimationPlayer
@onready var animation_players: Array[AnimationPlayer] = [animation_player_0, animation_player_1, animation_player_2, animation_player_3, animation_player_4]
@onready var bonus_tickets_label: Label3D = $Atari/BonusTickets
@onready var high_score_label: Label3D = $Atari/HighScore
@onready var hit: AudioStreamPlayer = $Hit
@onready var game_timer: Timer = $GameTimer
@onready var lose_reaction: AudioStreamPlayer = $LoseReaction
@onready var reaction_theme: AudioStreamPlayer = $ReactionTheme
@onready var miss: AudioStreamPlayer = $Miss
@onready var spawn_timer: Timer = $SpawnTimer
@onready var win_reaction: AudioStreamPlayer = $WinReaction
@onready var your_score: Label3D = $Atari/YourScore


func start() -> void:
	score = 0
	your_score.text = str(score)
	if not reaction_theme.playing:
		reaction_theme.play()
	game_timer.start()
	spawn_timer.start()


func _on_area_3d_0_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if animation_player_0.current_animation == "action":
			score += 1
			your_score.text = str(score)
			animation_player_0.play("RESET")
			hit.play()


func _on_area_3d_1_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if animation_player_1.current_animation == "action":
			score += 1
			your_score.text = str(score)
			animation_player_1.play("RESET")
			hit.play()


func _on_area_3d_2_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if animation_player_2.current_animation == "action":
			score += 1
			your_score.text = str(score)
			animation_player_2.play("RESET")
			hit.play()


func _on_area_3d_3_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if animation_player_3.current_animation == "action":
			score += 1
			your_score.text = str(score)
			animation_player_3.play("RESET")
			hit.play()


func _on_area_3d_4_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if animation_player_4.current_animation == "action":
			score += 1
			your_score.text = str(score)
			animation_player_4.play("RESET")
			hit.play()


func _on_game_timer_timeout() -> void:
	reaction_theme.stop()
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
	if score > high_score:
		high_score = score
		high_score_label.text = str(high_score)
		$"../Camera3D/HighScoreUI/Panel/Score".text = str(high_score)
		$"../Camera3D/HighScoreUI".show()
	else:
		$"../Camera3D/StartUI".show()


func _on_spawn_timer_timeout() -> void:
	var random_number: int
	# Avoid spawning in the same hole twice in a row
	while true:
		random_number = randi_range(0, animation_players.size() - 1)
		if random_number != last_spawned:
			break
	# Play the spawn animation for the randomly selected chipmunk
	
	animation_players[random_number].play("action")
	last_spawned = random_number

	# Calculate how much time is left (0.0 to 1.0, where 1.0 = full time remaining)
	var time_remaining_ratio = game_timer.time_left / game_timer.wait_time

	# Base timing gets faster as time runs out
	# Starts at ~1.5 seconds, gets as fast as ~0.3 seconds
	var base_time = lerp(0.3, 1.5, time_remaining_ratio)

	# Add some variation (±30%)
	spawn_timer.wait_time = randf_range(base_time * 0.7, base_time * 1.3)
	spawn_timer.start()
