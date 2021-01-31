extends Area2D

# [x] apply a velocity
# [x] instantiate a flare
# [x] self-destroy when out of screen

export var velocity = Vector2()
export var max_dist = 250
export var live_laser = true
onready var init_pos = global_position
#const scn_flare = preload("res://scenes/flare.tscn")

func _ready():
	create_flare()

func _process(delta):
	if live_laser:
		if global_position.distance_to(init_pos) > max_dist:
			live_laser = false
			$sprite.hide()
			$anim.play("explodir")
			yield($anim, "animation_finished") #um nó que espera finalizar
			queue_free()
	translate(velocity * delta)

func create_flare():
	#var flare = scn_flare.instance()
	#flare.position = self.position
	#utils.main_node.add_child(flare)
	pass

	


