extends Node2D

onready var _dialogo_computador = $hud/dialogo_porta
onready var _dialogo_acordar = $hud/dialogo_acordar

func _ready():
	pass

func _input(event):
	if Input.is_action_pressed("fechar_dialogo"):
		_dialogo_computador.hide()
		_dialogo_acordar.hide()
		

func _on_computador_body_entered(body):
	if body.is_in_group("player"):
		_dialogo_computador.show()
		$hud/dialogo_porta/Dialog_Box/NinePatchRect/MarginContainer/Body_Label/anim.play("dialogo")

func _on_computador_body_exited(body):
		if body.is_in_group("player"):
			_dialogo_computador.hide()
