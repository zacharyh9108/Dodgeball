extends Sprite2D

var skin0 = preload("res://assets/Donatello.png")
var skin1 = preload("res://assets/Angry.png")
var skin2 = preload("res://assets/Ginger.png")
var skin3 = preload("res://assets/IronMan.png")
var skins = [skin0, skin1, skin2, skin3]

func _ready():
	texture = skins[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
