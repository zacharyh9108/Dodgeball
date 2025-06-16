extends RigidBody2D

func _ready():
	var sprites = [$RedBall, $BlueBall]
	var chosen = sprites.pick_random()

	for sprite in sprites:
		sprite.visible = (sprite == chosen)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
