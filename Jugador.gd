extends Sprite

var vel = Vector2(99,66)
onready var screensize = get_viewport_rect().size
onready var width = texture.get_width() / 2.0

func _ready():
	set_position(screensize / 2)
	set_process(true)

func _process(delta):
	set_rotation(get_rotation() + PI / 8 * delta)
	var pos = get_position()
	pos += vel * delta
	if pos.x+width >= screensize.x or pos.x-width <= 0:
		vel.x *= -1
		Score.score += 10
	if pos.y+width >= screensize.y or pos.y-width <= 0:
		vel.y *= -1
		Score.score += 10
	set_position(pos)
	Score.update()
