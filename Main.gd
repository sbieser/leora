extends Node

onready var pinecone_scene = preload("res://Environment/PineCone.tscn")
onready var tree_scene = preload("res://Environment/Tree.tscn")
onready var interactions_manager_scene = preload("res://InteractionsManager.tscn")

#this will be a container for all the pinecones
onready var pinecone_container = get_node("pinecone_container")

var pinecone_inventory = 0
var screensize
var interactionsManager

func _ready():
	randomize()
	screensize = get_viewport().size
	spawn_pinecones(10)
	self.interactionsManager = interactions_manager_scene.instance()
	self.interactionsManager.setPlayer($Player)
	self.interactionsManager.addInteractiveObject($Grandma)
	self.interactionsManager.connect("startDialogue", self, "showDialogue")
	self.add_child(self.interactionsManager)
	
func showDialogue(var dialogue):
	$DescriptionHUD.setText(dialogue)
	
func spawn_pinecones(num):
	for i in range(num):
		var pinecone = pinecone_scene.instance()
		$pinecone_container.add_child(pinecone)
		pinecone.position = Vector2(rand_range(40, screensize.x-40), rand_range(40, screensize.y-40))

func _process(delta):
	#print("main:_process")
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _on_Player_select():
	
	if pinecone_inventory > 0:
		$DescriptionHUD.setText("You have planted a tree, you are amazing!")
		
		pinecone_inventory = pinecone_inventory - 1
		$Player.setGameStateValue("pinecones_stored", pinecone_inventory)
		$Player.setGameStateValue("pinecones_planted", $Player.getGameStateValue("pinecones_planted") + 1)
		$HUD.update_pinecone_amount(pinecone_inventory)
		var tree = tree_scene.instance()
		$tree_container.add_child(tree)
		tree.position = $Player.position
		
func _on_Player_collected_item(item):
	print(item.get_name())
	if "Pinecone" in item.get_name():
		pinecone_inventory = pinecone_inventory + 1
		$HUD.update_pinecone_amount(pinecone_inventory)
		item.queue_free()
		$Player.setGameStateValue("collected_pinecone", true)
		$Player.setGameStateValue("pinecones_stored", pinecone_inventory)

#This stuff worked, but not sure if it is necessary
#func _Main_trigger_scene_transition(playerPosition, transitionTo):
#	$Player.position.x = 0
#	_change_screen(transitionTo)
#
#func _change_screen(toScreen):
#	print("from:" + get_node(".").get_children()[0].get_name() + " to: " + toScreen)
#	var old_nodes = $LevelPlaceholder.get_children()
#	for node in old_nodes:
#		node.queue_free()
#	$LevelPlaceholder.add_child(load("res://levels/" + toScreen + ".tscn").instance())
#
#	var currentScreen = $LevelPlaceholder.get_node(toScreen)
#
#	print("current screen: " + currentScreen.get_name())
#	currentScreen.connect("trigger_scene_transition", self, "_Main_trigger_scene_transition")
	

func _on_test_level_change_scene():
	print("_on_test_level_change_scene")
	#ok, how do we go about changing the scene now?
	#get_tree().change_scene("res://AnotherMain.tscn")
	get_tree().change_scene("res://Platformer/PlatformerMain.tscn")
	#pass # replace with function body

func _on_DescriptionHUD_descriptionEntered():
	print("_on_DescriptionHUD_descriptionEntered")
	get_tree().paused = true


func _on_DescriptionHUD_descriptionExited():
	print("_on_DescriptionHUD_descriptionExited")
	get_tree().paused = false