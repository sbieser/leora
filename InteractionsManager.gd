extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#needs reference to the player node
var player = null
var interactive_objects = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _init(var player):
#	self.player = player

func setPlayer(var player):
	#print("InteractionManager::setPlayer")
	
	self.player = player
	self.player.connect("select", self, "_on_Player_select")
	self.player.connect("action", self, "_on_Player_action")
	
func addInteractiveObject(var interactiveObject):
	self.interactive_objects.append(interactiveObject)

func _on_Player_select():
	print("InteractionsManager._on_Player_select")
	pass

func _on_Player_action():
	print("InteractionsManager._on_Player_action")
	pass

func _process(delta):
	#here we will want to check the position of the player against the position of the other interactive objects
	for object in self.interactive_objects:
		var distance = player.position.distance_to(object.position)
		
		if object.name == "Grandma":
			if distance <= 60:
				object.setHighlighted(true)
			else:
				object.setHighlighted(false)
	pass
