extends Node2D

var highlightedTexture = preload("res://resources/grandma_sprite_highlighted.png")
var unhighlightedTexture = preload("res://resources/grandma_sprite.png")
#this is the grandma node, should only just have speaking parts I guess??

var descriptionText = "Who am I? Who are you?";
var pineConeDialogue = "Oh my, you have some pinecones, maybe you can plant a tree like I use to when I was younger. All these trees around here I planted, many years ago. They have aged and they are old, just like me.";
var oneTreePlantedDialogue = "You have planted a tree!"
var manyTreesPlantedDialogue = "You have planted {amount} trees so far, that is amazing."

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#pass in some object to get the current state to figure 
#out what kind of dialogue to send to the screen
func getDialogue(var object):
	if object.name == "Player":
		var game_state = object.getGameState()
		if game_state["collected_pinecone"] == true:
			if game_state["pinecones_stored"] == 0:
				if game_state["pinecones_planted"] == 1:
					return self.oneTreePlantedDialogue
				else:
					
					# Using the 'format' method, replace the 'str' placeholder
					#var actual_string = format_string.format({"str": "Godot"})
					return self.manyTreesPlantedDialogue.format({"amount": str(game_state["pinecones_planted"])}) 
			else:
				return self.pineConeDialogue
	
	#this will be the default text that is returned, grandma will always say this
	return self.descriptionText

func setHighlighted(var highlighted):
	if highlighted == true:
		$Sprite.set_texture(highlightedTexture)
	else:
		$Sprite.set_texture(unhighlightedTexture)
