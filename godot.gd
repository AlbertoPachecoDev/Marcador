extends Sprite

var vel
var spin
onready var screensize = get_viewport_rect().size
onready var width = texture.get_width() / 2.0

func _ready():
	vel = Vector2(rand_range(70,200),0).rotated(rand_range(0.4, PI/2))
	spin = rand_range(-PI, PI)
	set_position(screensize / 2)
	set_process(true)

func _process(delta):
	set_rotation(get_rotation() + spin * delta)
	var pos = get_position()
	pos += vel * delta
	if pos.x+width >= screensize.x or pos.x-width <= 0:
		vel.x *= -1
		Score.score += 10
		if not $bounce.playing: $bounce.play()
	if pos.y+width >= screensize.y or pos.y-width <= 0:
		vel.y *= -1
		Score.score += 10
		if not $bounce.playing: $bounce.play()
	set_position(pos)
	Score.update()
