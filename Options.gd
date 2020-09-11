extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$EasyCheckBox.pressed = true
	$HardCheckBox.pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	$EasyCheckBox.show()
	$HardCheckBox.show()
	$DifficultyLabel.show()
	
	
func hide():
	$EasyCheckBox.hide()
	$HardCheckBox.hide()
	$DifficultyLabel.hide()

