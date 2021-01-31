extends EnemyBase

export var vida = 1 setget set_vida

export var moveSpeed : int = 200
var xpToGive : int = 30

var dano: int = 1
var taxa_ataque : float = 1.0
var distancia_ataque : int = 80
var distancia_minima : int = 400
var pode_seguir :int = 58 #se a distancia for menor que isso vai ativar o afastar
var afastar = false
var dir = 500 #afastar
var vel = Vector2(1,0) #afastar

var dir_atual := 1.0
var prox_dir := 1.0


onready var timer = $Timer
onready var player = get_node("/root/MainScene/Player")

func _ready ():
	add_to_group("enemy")
	timer.wait_time = taxa_ataque
	timer.start()

func _physics_process (_delta):
	direcao_sprite()
	var dist = position.distance_to(player.position)
	
	if dist > distancia_ataque and dist < distancia_minima:
		var vel = (player.position - position).normalized()
		if vel.x >= 0.1:
			prox_dir = -1
		elif vel.x >= -0.1:
			prox_dir = 1
		
		move_and_slide(vel * moveSpeed)


	if player.fazer_afastar == true:
		translate(vel * dir * _delta)
		moveSpeed = 0
	else:
		moveSpeed = 200
		
func _on_Timer_timeout():
	
	if position.distance_to(player.position) <= distancia_ataque:
		player.take_damage(dano)


func set_vida(new_value):
	if is_queued_for_deletion(): return
	if new_value < vida: 
		vida = new_value
	
	if vida <= 0:
		#utils.search_node("tex_score").score += score_value
		queue_free()


func direcao_sprite():
	if prox_dir != dir_atual:
		dir_atual = prox_dir
		$rotacao.scale.x = dir_atual
	
