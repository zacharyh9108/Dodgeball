extends Area2D

@export var speed = 400 # Speed (pixels/sec)
var screen_size # Size of the game window
signal hit

func _ready():
	hide()
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# Only move if there's input
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "move"
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation = "move"
			$AnimatedSprite2D.flip_h = false
		if not $WoodSound.playing:
			$WoodSound.play()
	else:
		$AnimatedSprite2D.animation = "idle"

		if $WoodSound.playing:
			$WoodSound.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(_body: Node2D) -> void:
	hide()
	$DeathSound.play()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
