extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ReturnButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_message(text, time):
	$Message.text = text
	$Message.show()
	$MessageTimer.wait_time = time
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over", 2)
	yield($MessageTimer, "timeout")
	
	$Message.text = "Survival Shooter"
	$Message.show()
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	$OptionsButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	$OptionsButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_Options_pressed():
	$StartButton.hide()
	$OptionsButton.hide()
	$Options.show()
	$ReturnButton.show()
	$ScoreLabel.hide()
	$Message.hide()


func _on_ReturnButton_pressed():
	$StartButton.show()
	$OptionsButton.show()
	$Options.hide()
	$ReturnButton.hide()
	$ScoreLabel.show()
	$Message.show()
