extends Area2D

var max_dist = 170
var live_laser = true
onready var init_pos = global_position
var dir = Vector2() setget set_dir
var vel = -500

func _ready():
	pass
	
func _process(delta):
	translate(dir * vel * delta)
	if live_laser:
		if global_position.distance_to(init_pos) > max_dist:
			live_laser = false
			#collision_particles.emitting = true
			$sprite.visible = false
			queue_free()
	
func set_dir(val):
	dir = val
	rotation = dir.angle()
	

func _on_laser_ship_body_entered(other):
	if other.is_in_group("enemy"):
		other.vida -= 1             
		utils.remote_call("camera", "shake", 1, 0.13)
		queue_free()

func _on_laser_body_entered(body):
	queue_free()
