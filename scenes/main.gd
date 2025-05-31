extends Node3D

@onready var high_score_ui: Control = $Camera3D/HighScoreUI
@onready var leaderboard_ui: LeaderboardUI = $Camera3D/LeaderboardUI
@onready var player_name: LineEdit = $Camera3D/HighScoreUI/Panel/Name
@onready var start_ui: Control = $Camera3D/StartUI
@onready var whack_a_mole: Node3D = $WhackAMoleMachine


func start() -> void:
	high_score_ui.hide()
	leaderboard_ui.hide()
	start_ui.hide()
	whack_a_mole.start()


## New High Score > 'Back' button
func _on_back_button_pressed() -> void:
	high_score_ui.hide()
	start_ui.show()


## Start > 'Quit' button
func _on_quit_button_pressed() -> void:
	get_tree().quit()


## Start > 'Scores' button
func _on_scores_button_pressed() -> void:
	leaderboard_ui.visible = !leaderboard_ui.visible


## Start > 'Start' button
func _on_start_button_pressed() -> void:
	start()


## New High Score > 'Submit' button
func _on_submit_button_pressed() -> void:
	var nickname := player_name.text
	if len(name) > 0:
		await Leaderboards.post_guest_score(leaderboard_ui.leaderboard_id, whack_a_mole.high_score, nickname)
		await leaderboard_ui.refresh_scores()
		high_score_ui.hide()
		leaderboard_ui.show()
		start_ui.show()
