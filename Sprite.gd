# https://openclipart.org/download/277205/7SegmentNumbers.svg

extends Sprite

var vel
var spin
var id = 0
var bouncex = false
var bouncey = false
onready var screensize = get_viewport_rect().size
onready var  width = int(texture.get_width()  * get_scale().x / 2)
onready var height = int(texture.get_height() * get_scale().y / 2)

func _ready():
	$efectox.interpolate_property(self, 'scale:x',
		null, 0.15, 2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$efectoy.interpolate_property(self, 'scale:y',
		null, 0.15, 2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$efecto_final.interpolate_property(self, 'modulate:a',
		null, 0, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	vel = Vector2(rand_range(150,240),rand_range(25,150)).rotated(rand_range(0.4, PI/2))
	spin = rand_range(-PI, PI)
	set_position(Vector2(rand_range(150,screensize.x-150), 100))
	set_process(true)

func _process(delta):
	set_rotation(get_rotation() + spin * delta)
	var pos = get_position()
	pos += vel * delta
	if pos.x+width >= screensize.x or pos.x-width <= 0:
		vel.x *= -1
		$efectox.start()
		if not $bounce.playing: $bounce.play()
		if not bouncex:
			bouncex = true
			if bouncey: $efecto_final.start()	
	if pos.y+height >= screensize.y or pos.y-height <= 0:
		vel.y *= -1
		$efectoy.start()
		if not $bounce.playing: $bounce.play()
		if not bouncey:
			bouncey = true
			if bouncex: $efecto_final.start()
	set_position(pos)

func _on_efecto_final_tween_completed(_object, _key):
	if bouncex and bouncey:
		$out.play()
		Score.update_score(id)

func _on_out_finished():
	queue_free()
