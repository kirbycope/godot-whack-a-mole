extends Node3D

var high_score := 0
var score := 0

@onready var animation_player_0: AnimationPlayer = $Chipmunk/AnimationPlayer
@onready var animation_player_1: AnimationPlayer = $Chipmunk_001/AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $Chipmunk_002/AnimationPlayer
@onready var animation_player_3: AnimationPlayer = $Chipmunk_003/AnimationPlayer
@onready var animation_player_4: AnimationPlayer = $Chipmunk_004/AnimationPlayer
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
		$"../Camera3D/HighScoreUI".show()
	else:
		$"../Camera3D/StartUI".show()


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
	# Pick a chipmunk
	var random_number = randi_range(0, 5)
	# Play that chipmunk's "action" animation
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
