# https://fonts.google.com/specimen/Indie+Flower

extends Node2D

var screenH
var screenW
var level = 1
var score = 0

func _ready():
	var scr = get_viewport_rect().size
	screenW = scr.x
	screenH = scr.y
	randomize()
	z_index = 1

func update_score(points):
	score += points
	$score_label.text = "Score: " + str(score)
