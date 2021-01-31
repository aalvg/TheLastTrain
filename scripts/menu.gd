extends Node


func _on_iniciar_pressed():
	get_tree().change_scene("res://MainScene.tscn")


func _on_sair_pressed():
	get_tree().quit()
