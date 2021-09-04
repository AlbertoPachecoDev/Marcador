# https://fonts.google.com/specimen/Indie+Flower

extends Node2D

var screenH
var screenW
var level = 1
var score = 0

const Digits = [
	 preload("res://images/0.png"),
	 preload("res://images/1.png"),
	 preload("res://images/2.png"),
	 preload("res://images/3.png"),
	 preload("res://images/4.png"),
	 preload("res://images/5.png"),
	 preload("res://images/6.png"),
	 preload("res://images/7.png"),
	 preload("res://images/8.png"),
	 preload("res://images/9.png"),
]

func _ready():
	var scr = get_viewport_rect().size
	screenW = scr.x
	screenH = scr.y
	randomize()
	z_index = 1
#	for fn in DigitFiles:
#		var pack = load(fn)
#		Digits.append(pack)
		
func update_score(points):
	score += points
	$score_label.text = "Score: " + str(score)
