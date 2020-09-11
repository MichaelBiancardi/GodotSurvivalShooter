extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

onready var player = get_tree().get_root().get_node("Main").get_node("Player")

var player_pos
var velocity
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("moved", self, "handle_player_moved")
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	handle_player_moved()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	player_pos = player.position
	
	position += velocity * delta
	
	if velocity.x > 0 and position.x > player_pos.x:
		velocity.x = 0
		
		if player.position.y > position.y:
			move_down()
		elif player.position.y < position.y:
			move_up()
		
	if velocity.x < 0 and position.x < player_pos.x:
		velocity.x = 0
		
		if player.position.y > position.y:
			move_down()
		elif player.position.y < position.y:
			move_up()
		
	if velocity.y > 0 and position.y > player_pos.y:
		velocity.y = 0
		
		if player_pos.x > position.x:
			move_right()
		elif player_pos.x < position.x:
			move_left()
		
	if velocity.y < 0 and position.y < player_pos.y:
		velocity.y = 0
		
		if player_pos.x > position.x:
			move_right()
		elif player_pos.x < position.x:
			move_left()


func handle_player_moved():
	var new_pos = player.position
		
	#Check if orientation is different from before
	if player_pos:
		if (new_pos.x < position.x and player_pos.x < position.x) or (new_pos.x > position.x and player_pos.x > position.x):
			if (new_pos.y < position.y and player_pos.y < position.y) or (new_pos.y > position.y and player_pos.y > position.y):
				player_pos = new_pos
				pass
	
	player_pos = new_pos
	velocity = Vector2()
	
	if (abs(player_pos.x - position.x) > 5) and (abs(player_pos.y - position.y) > 5):
		if rng.randi_range(0, 1) == 0:
			if player_pos.x > position.x:
				move_right()
			elif player_pos.x < position.x:
				move_left()
		else:
			if player.position.y > position.y:
				move_down()
			elif player.position.y < position.y:
				move_up()
	elif abs(player_pos.x - position.x) > 5:
		if player_pos.x > position.x:
			move_right()
		elif player_pos.x < position.x:
			move_left()
	elif abs(player_pos.y - position.y) > 5:
		if player.position.y > position.y:
			move_down()
		elif player.position.y < position.y:
			move_up()
	else:
		velocity.x = 0
		velocity.y = 0

func _on_Mob_body_entered(body):
	if "Bullet" in body.get_name():
		hide()
		#self.queue_free()
		
func kill():
	if self.is_visible():
		$AudioStreamPlayer.play()
		hide()
		
func move_right():
	velocity.x = 100
	$AnimatedSprite.animation = "right"

func move_left():
	velocity.x = -100
	$AnimatedSprite.animation = "left"
		
func move_down():
	velocity.y = 100
	$AnimatedSprite.animation = "down"
	
func move_up():
	velocity.y = -100
	$AnimatedSprite.animation = "up"
