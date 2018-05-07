extends Node2D

signal trigger_scene_transition(playerPosition, transitionTo)

func _on_scene_transition_body_entered(body):
	if body.get_name() == "Player":
		print("_on_scene_transition_body_entered::test_level")
		emit_signal("trigger_scene_transition", body.position, "test_level_rs")

