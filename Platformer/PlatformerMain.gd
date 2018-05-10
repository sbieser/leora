extends Node


#onready var tree = preload("res://Tree.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Enemy_hit():
	print("_on_Enemy_hit")

func _on_Enemy_died():
	print("_on_Enemy_died")

#func _on_Player_plant():
#	#pass # replace with function body
#	print("_on_Player_plant")
#	var t = tree.instance()
#	if $Player.facing == 0:
#		#facing right
#		t.position = Vector2($Player.position.x + 40, $Player.position.y)
#	else:
#		#facing left
#		t.position = Vector2($Player.position.x - 40, $Player.position.y)
#
#	#t.position = $Player.position
#	add_child(t)
