extends Node2D

onready var _dialogo_azul = $hud/dialogo_azul

func _input(event):
	if Input.is_action_pressed("fechar_dialogo"):
		_dialogo_azul.hide()
		
func _on_saida_body_entered(body):
	get_tree().change_scene("res://MainScene4.tscn")


func _on_dialogar_body_entered(body):
	_dialogo_azul.show()
