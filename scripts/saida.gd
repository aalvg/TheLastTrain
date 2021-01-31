extends Area2D

func _on_saida_body_entered(_body):
	get_tree().change_scene("res://MainScene1.tscn")
