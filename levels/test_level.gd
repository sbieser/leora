extends Node2D

signal change_scene

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("change_scene")
