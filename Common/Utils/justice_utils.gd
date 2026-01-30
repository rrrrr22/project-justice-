class_name JusticeUtils

# runs animation without restarting it
static func run_animation(animatedSprite : AnimatedSprite2D, animation : StringName):
	if animatedSprite.animation == animation:
		return
	animatedSprite.play(animation)

static func move_towards(value: float, towards: float, amount: float):
	value += amount
	if value > towards:
		value = towards
