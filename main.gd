extends Node

@export var mob_scene: PackedScene
var score
@export var music_tracks = [preload("res://assets/audio/MovieTickets.mp3"), 
							preload("res://assets/audio/VendettaPreppies.mp3"),
							preload("res://assets/audio/Wildstyle.mp3")]

func _ready():
	pass

func game_end() -> void:
	$ScoreTimer.stop()
	$BallTimer.stop()
	$HUD.show_game_over()
	$Music.stop()

func new_game():
	get_tree().call_group("balls", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Be Prepared")
	
	if randi() % 5 == 0:
		$SoundEffect.play()
	
	if music_tracks.size() > 0:
		$Music.stream = music_tracks.pick_random()
		$Music.stream.loop = true
		$Music.play()

func _on_ball_timer_timeout() -> void:
	var ball = mob_scene.instantiate()

	var ball_spawn_location = $BallPath/BallSpawnLocation
	ball_spawn_location.progress_ratio = randf()
	ball.position = ball_spawn_location.position

	# Set the mob's direction perpendicular to the path direction
	var direction = ball_spawn_location.rotation + PI / 2

	direction += randf_range(-PI / 4, PI / 4)
	ball.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	ball.linear_velocity = velocity.rotated(direction)

	add_child(ball)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	
	if score % 100 == 0:
		$SoundEffect2.play()

func _on_start_timer_timeout() -> void:
	$BallTimer.start()
	$ScoreTimer.start()
