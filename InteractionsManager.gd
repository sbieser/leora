extends Node

signal startDialogue(dialogue)

#needs reference to the player node
var player = null
var interactive_objects = []
var min_distance = 55

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _init(var player):
#	self.player = player

func setPlayer(var player):
	self.player = player
	self.player.connect("action", self, "_on_Player_action")
	
func addInteractiveObject(var interactiveObject):
	self.interactive_objects.append(interactiveObject)

func _on_Player_action():
	var object = self.findInteractiveObjectNow()
	if object != null && object.has_method("getDialogue"):
		var dialogueText = object.getDialogue(self.player)
		emit_signal("startDialogue", dialogueText)
		pass
		
	pass

func _process(delta):
	#here we will want to check the position of the player against the position of the other interactive objects
	for object in self.interactive_objects:
		var distance = player.position.distance_to(object.position)
		
		if object.has_method("setHighlighted"):
			if distance <= self.min_distance:
				object.setHighlighted(true)
			else:
				object.setHighlighted(false)
	pass

func findInteractiveObjectNow():
	for object in self.interactive_objects:
		var distance = player.position.distance_to(object.position)
		if distance <= 55:
			return object
	return null