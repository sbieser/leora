extends CanvasLayer

signal descriptionEntered
signal descriptionExited

var inputListen = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$Control.hide()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if inputListen:
		var action = Input.is_action_just_released("ui_accept")	# enter
		if action:
			#print("DescriptionHUD::_process::ui_accept")
			inputListen = false
			$Control.hide()
			emit_signal("descriptionExited")
			
func setText(var text):
	$Control.show()
	emit_signal("descriptionEntered")
	$Control/CenterContainer/Label.text = text
	$InputDelayTimer.start()

func _on_InputDelayTimer_timeout():
	inputListen = true
