# https://fonts.google.com/specimen/Indie+Flower

extends Node2D

var screenH
var screenW
var level = 1
var score = 0
var left = 0
var gamer = 0

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

const Points = [0, 20, 40, 60, 70, 80, 85, 90, 95, 100]

func _ready():
	var scr = get_viewport_rect().size
	screenW = scr.x
	screenH = scr.y
	randomize()
	gamer = 5
	z_index = 1
		
func update_score(id):
	if id == gamer: score_replay()
	left += 1
	if 9==left: score_replay()
		
func score_replay():
	var points = Points[left]
	if 0==score: score=points 
	score = round((score + points) / 2.0)
	$score_label.text = "Score: " + str(score)
	$end.play()

func _on_end_finished():
	left = 0
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")
