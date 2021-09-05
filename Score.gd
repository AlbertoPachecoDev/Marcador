# FONT: https://fonts.google.com/specimen/Indie+Flower

extends Node2D

signal digit_key(digit)

const    NEG = -10
const  Ratio = [0, 20, 40, 60, 70, 80, 85, 90, 95, 100]
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
var screenH
var screenW
var level = 0
var score = 0
var left = 0
var gamer = null
var nwait = 0
var penalty = NEG
var points = 0

func _ready():
	var scr = get_viewport_rect().size
	screenW = scr.x
	screenH = scr.y
	randomize()
	z_index = 1
	reset()
	
func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		return
	if event is InputEventKey:
		if event.is_pressed():
			var key = event.scancode - KEY_0
			if key in range(0,10):
				get_tree().get_root().set_disable_input(true)
				gamer = key
				emit_signal("digit_key", key)
				start()

func start():
	$end.stop()
	$start.stop()
	$wait1.start()
	Engine.time_scale = 1.0

func update_score(id):
	left += 1
	if id==gamer or 9==left:
		score_replay()

func reset():
	level += 1
	left = 0
	nwait = 0
	gamer = null
	penalty = NEG
	$wait1.stop()
	$wait2.stop()
	$start.start()
	get_tree().get_root().set_disable_input(false)
	Engine.time_scale = 0.4 # slow down

func print_score():
	$score_label.text = "Level: "+str(level)+" Wins: "+str(score)+" Points: "+str(points)

func score_and_reset(ratio, tie=false):
	score = round((score + ratio) / 2.0)
	$end.pitch_scale = 1.5 if tie else 1.0 # empate
	$end.play()
	print_score()
		
func score_replay():
	var points = Ratio[left]
	if 0==score: score=points
	score_and_reset(points)

func _on_end_finished():
	reset()
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")

func _on_wait1_timeout():
	$wait2.start()

func _on_wait2_timeout():
	nwait += 1
	match left:
		9: score_and_reset(100)
		8: if nwait>1: score_and_reset(95, true)
		7: if nwait>2: score_and_reset(90, true)
		6: if nwait>3: score_and_reset(80, true)
		_: if nwait>4: score_and_reset(70, true)

func _on_start_timeout():
	$end.play()

func _on_refresh_timeout():
	if gamer:
		points += 20
	else:
		points += penalty
		penalty += NEG
	print_score()
