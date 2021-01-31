extends Node2D

onready var _dialogo_computador = $hud/dialogo_computador

func _ready():
	pass

func _input(event):
	if Input.is_action_pressed("fechar_dialogo"):
		_dialogo_computador.hide()
		$hud/dialogo_escada.hide()
		

func _on_computador_body_entered(body):
	if body.is_in_group("player"):
		$hud/dialogo_escada.show()
		$hud/dialogo_escada/Dialog_Box/NinePatchRect/MarginContainer/Body_Label/anim.play("dialogo")

func _on_computador_body_exited(body):
		if body.is_in_group("player"):
			_dialogo_computador.hide()


func _on_saida_body_entered(body):
	get_tree().change_scene("res://MainScene2.tscn")


func _on_parar_metro_body_entered(body):
	if body.is_in_group("player"):
		$metro/anim.play("metro")
		$parar_metro.queue_free()
