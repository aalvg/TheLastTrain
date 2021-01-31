extends KinematicBody2D

var moveSpeed : int = 250

export var vida = 50
var max_vida = 50

var vel = Vector2()
var facingDir = Vector2()

onready var anim = $anim
var anim_atual := ""
var prox_anim := "parada"
var dir_atual := 1.0
var prox_dir := 1.0


var tempo_lanterna = 700 
var maximo_lanterna = tempo_lanterna

const scn_disparo     = preload("res://cenas/arma_player.tscn")
onready var ui = get_node("/root/MainScene/hud/UI")

export var fazer_afastar = false

func _ready ():
	add_to_group("player")

func _physics_process (_delta):
	$canvas/energia_tiro.scale = ceil(tempo_lanterna) / float(maximo_lanterna)
	vel = Vector2()
	ativar_lanterna()
	# inputs
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)

	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)

	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)

	if Input.is_action_pressed("move_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)

	vel = vel.normalized()
	
	if $rotacao/lanterna.enabled == true:
		$rotacao/afastar/Collisionafastar.disabled = false
		tempo_lanterna -= 1
	if tempo_lanterna <= 0:
		$rotacao/lanterna.enabled = false
		$lanterna.playing = true
		$rotacao/afastar/Collisionafastar.disabled = true
		
	move_and_slide(vel * moveSpeed, Vector2.ZERO)
	manage_animations ()
	play_animation ()
	
func manage_animations ():
	
	if vel.x > 0:
		prox_dir = 1
		prox_anim = "lateral"
	elif vel.x < 0:
		prox_dir = -1
		prox_anim = "lateral"
	elif vel.y < 0:
		prox_anim = "indo"
	elif vel.y > 0:
		prox_anim = "voltando"
	else:
		prox_anim = "parada"

		
func play_animation ():
	
	if prox_anim != anim_atual:
		anim_atual = prox_anim
	anim.play(anim_atual)
	
	if prox_dir != dir_atual:
		dir_atual = prox_dir
		$rotacao.scale.x = dir_atual


func take_damage (dmgToTake):
	vida -= dmgToTake
	ui.update_health_bar(vida, max_vida)
	if vida <= 0:
		die()

func die ():
	get_tree().reload_current_scene()

func ativar_lanterna():
	if Input.is_action_just_pressed("fire") and not $rotacao/lanterna.enabled == true:
		if tempo_lanterna >= 1:
			$rotacao/lanterna.enabled = true
			$lanterna.playing = true

	elif Input.is_action_just_pressed("fire") and not $rotacao/lanterna.enabled == false:
		$rotacao/lanterna.enabled = false
		$rotacao/afastar/Collisionafastar.disabled = true
		$lanterna.playing = true
		
func _on_afastar_body_entered(body):
	if body.is_in_group("enemy"):
		fazer_afastar = true

func _on_afastar_body_exited(body):
	if body.is_in_group("enemy"):
		fazer_afastar = false
