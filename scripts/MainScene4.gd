extends Node2D

onready var _dialogo_amarelo = $hud/dialogo_amarelo
onready var _dialogo_azul = $hud/dialogo_azul
onready var recarregar_pilhas = false

func _ready():
	#_on_ficar_na_luz_body_entered(KinematicBody2D)
	#_on_ficar_na_luz_body_exited(KinematicBody2D)
	pass

func _process(delta):
	if recarregar_pilhas == true:
		$Player.tempo_lanterna += 1
		if $Player.tempo_lanterna <= 699: $recarga.playing = true
		$recarga.stream_paused = false
		if $Player.tempo_lanterna >= 700:
			recarregar_pilhas = false
			if recarregar_pilhas == false: $recarga.stream_paused = true

func _input(event):
	if Input.is_action_pressed("fechar_dialogo"):
		_dialogo_amarelo.hide()
		_dialogo_azul.hide()
		

func _on_abrir_azul_body_entered(_body):
	if _body.is_in_group("player"):
		_dialogo_azul.show()
		$hud/dialogo_azul/Dialog_Box/NinePatchRect/MarginContainer/Body_Label/anim.play("dialogo")


func _on_abrir_azul_body_exited(_body):
	_dialogo_azul.hide()


func _on_abrir_amarelo_body_entered(_body):
	if _body.is_in_group("player"):
		_dialogo_amarelo.show()
		$hud/dialogo_amarelo/Dialog_Box/NinePatchRect/MarginContainer/Body_Label/anim.play("dialogo")

func _on_abrir_amarelo_body_exited(_body):
	_dialogo_amarelo.hide()


func _on_ficar_na_luz_body_entered(body):
	if body.is_in_group("player"):
		if $Enemy: $Enemy.moveSpeed = 0
		if $Enemy2: $Enemy2.moveSpeed = 0
		recarregar_pilhas = true


func _on_ficar_na_luz_body_exited(body):
	if body.is_in_group("player"):
		if $Enemy: $Enemy.moveSpeed = 200
		if $Enemy2: $Enemy2.moveSpeed = 200
		recarregar_pilhas = false
		$recarga.stream_paused = true


func _on_saida_body_entered(body):
	get_tree().change_scene("res://cenas/menu.tscn")
