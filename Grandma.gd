extends Node2D

var highlightedTexture = preload("res://resources/grandma_sprite_highlighted.png")
var unhighlightedTexture = preload("res://resources/grandma_sprite.png")
#this is the grandma node, should only just have speaking parts I guess??

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func setHighlighted(var highlighted):
	if highlighted == true:
		$Sprite.set_texture(highlightedTexture)
	else:
		$Sprite.set_texture(unhighlightedTexture)
