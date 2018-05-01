extends StaticBody2D

var stage_1 = preload("res://resources/trees/tree_stage_1.png")
var stage_2 = preload("res://resources/trees/tree_stage_2.png")
var stage_3 = preload("res://resources/trees/tree_stage_3.png")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#pass
	randomize()
	$GrowTimer.wait_time = rand_range(1,3)
	$GrowTimer.start()
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_GrowTimer_timeout():
	print("_on_GrowTimer_timeout")
	#$GrowTimer.wait_time = rand_range(1,3)
	#print(str($Sprite.texture.resource_path))
	#print(str($Sprite.texture.))
	#pass # replace with function body
	if "stage_0" in $Sprite.texture.resource_path:
		$Sprite.texture = stage_1
	elif "stage_1" in $Sprite.texture.resource_path:
		$Sprite.texture = stage_2
	elif "stage_2" in $Sprite.texture.resource_path:
		$Sprite.texture = stage_3
