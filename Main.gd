extends Node2D

onready var sprite = preload("res://Sprite.tscn")

func _ready():
	for i in range(10):
		var s = sprite.instance()
		s.id = i
		s.set_texture(Score.Digits[i])
		add_child(s)
