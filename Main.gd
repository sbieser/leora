extends Node

onready var pinecone_scene = preload("res://Environment/PineCone.tscn")
onready var tree_scene = preload("res://Environment/Tree.tscn")

#this will be a container for all the pinecones
onready var pinecone_container = get_node("pinecone_container")

var pinecone_inventory = 0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var screensize

func _ready():
	randomize()
	screensize = get_viewport().size
	spawn_pinecones(10)
	
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
	print("_on_Player_select")
	if pinecone_inventory > 0:
		pinecone_inventory = pinecone_inventory - 1
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
