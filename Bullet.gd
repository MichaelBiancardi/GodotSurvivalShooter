extends Area2D

var velocity
var life = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_root().get_node("Main/HUD/Options/EasyCheckBox").is_pressed():
		life = 4
	else:
		life = 2
		
	scale = Vector2(2, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	#print_debug(position)


func _on_Bullet_body_entered(body):
	#print_debug(body.get_name())
	if "Mob" in body.get_name() and self.visible and body.is_visible():
		life -= 1
		
		if life <= 0:
			hide()
		
		body.kill()
		yield(body.get_node("AudioStreamPlayer"), "finished")
		body.queue_free()

func fire_up(player_position):
	velocity = Vector2(0, -1100)
	rotation_degrees = 0
	position = Vector2(player_position.x - 490, player_position.y - 200)
	$AudioStreamPlayer.play()
	
	
func fire_down(player_position):
	velocity = Vector2(0, 1100)
	rotation_degrees = 180
	position = Vector2(player_position.x + 490, player_position.y + 200)
	$AudioStreamPlayer.play()
	
	
func fire_left(player_position):
	velocity = Vector2(-1100, 0)
	rotation_degrees = 270
	position = Vector2(player_position.x - 200, player_position.y + 490)
	$AudioStreamPlayer.play()
	
	
func fire_right(player_position):
	velocity = Vector2(1100, 0)
	rotation_degrees = 90
	position = Vector2(player_position.x + 200, player_position.y - 490)
	$AudioStreamPlayer.play()

