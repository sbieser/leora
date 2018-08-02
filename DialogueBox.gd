extends Node2D

var displayed_text

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var label_size = $Control/CenterContainer/Label.rect_size
	print(str(label_size.x) + ":" + str(label_size.y))


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func display_text(var display_text):
	self.displayed_text = display_text
	$Control/CenterContainer/Label.text = self.displayed_text
	var label_size = $Control/CenterContainer/Label.rect_size
	print(str(label_size.x) + ":" + str(label_size.y))	
	
	$Control/CenterContainer/NinePatchRect.rect_size = $Control/CenterContainer/Label.rect_size
	