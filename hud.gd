extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
signal leaderboard
signal character

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Avoid the Phantoms!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$LeaderboardButton.show()
	$StartButton.show()
	$OptionButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
func update_attempt(attempt):
	$AttemptLabel.text = str(attempt)
	
func _on_leaderboard_button_pressed():
	$LeaderboardButton.hide()
	leaderboard.emit()

func _on_option_button_item_selected(index):
	pass
