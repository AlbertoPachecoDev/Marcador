# https://fonts.google.com/specimen/Indie+Flower

extends Node2D

var screenH
var screenW
var level = 1
var score = 0
var left = 0
var gamer = 0
var nwait = 0

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
	$wait1.start()
	$wait2.stop()
		
func update_score(id):
	if id == gamer:
		score_replay()
		return
	left += 1
	if 9==left:
		score_replay()
		return

func score_and_reset(points, tie=false):
	score = round((score + points) / 2.0)
	$score_label.text = "Score: " + str(score)
	left = 0
	nwait = 0
	$wait1.stop()
	$wait2.stop()
	$end.pitch_scale = 1.5 if tie else 1.0 # empate
	$end.play()
		
func score_replay():
	var points = Points[left]
	if 0==score: score=points
	score_and_reset(points)

func _on_end_finished():
	$wait1.start()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")

func _on_wait1_timeout():
	$wait2.start()
	print("end-timer1")

func _on_wait2_timeout():
	nwait += 1
	print("end-timer2:", nwait)
	match left:
		9: score_and_reset(100)
		8: if nwait>1: score_and_reset(95, true)
		7: if nwait>2: score_and_reset(90, true)
		6: if nwait>3: score_and_reset(80, true)
		_: if nwait>4: score_and_reset(70, true)
