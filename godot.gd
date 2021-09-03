extends Sprite

var vel
var spin
onready var screensize = get_viewport_rect().size
onready var width = texture.get_width() / 2

func _ready():
	$efectox.interpolate_property(self, 'scale:x',
		null, 0.8, 2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$efectoy.interpolate_property(self, 'scale:y',
		null, 0.8, 2, Tween.TRANS_QUAD, Tween.EASE_OUT)
	vel = Vector2(rand_range(70,220),0).rotated(rand_range(0.4, PI/2))
	spin = rand_range(-PI, PI)
	set_position(Vector2(rand_range(150,screensize.x-150), 100))
	set_process(true)

func _process(delta):
	set_rotation(get_rotation() + spin * delta)
	var pos = get_position()
	pos += vel * delta
	if pos.x+width >= screensize.x or pos.x-width <= 0:
		vel.x *= -1
		Score.update_score(10)
		$efectox.start()
		if not $bounce.playing: $bounce.play()
	if pos.y+width >= screensize.y or pos.y-width <= 0:
		vel.y *= -1
		Score.update_score(10)
		$efectoy.start()
		if not $bounce.playing: $bounce.play()
	set_position(pos)

#func _on_efecto_tween_completed(object, key):
#	add new tween + interpolate
