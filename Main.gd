extends Node2D

onready var sprite = preload("res://Sprite.tscn")

func _ready():
	for i in range(10):
		var s = sprite.instance()
		s.id = i
		s.set_scale(Vector2(0.18, 0.16))
		s.set_texture(Score.Digits[i])
		add_child(s)
