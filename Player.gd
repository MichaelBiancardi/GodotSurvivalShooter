extends Area2D

signal hit
signal moved

export var speed = 400
var screen_size

var velocity
var prev_pos

const Bullet = preload("res://Bullet.tscn")

var bullets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not self.visible:
		return
	
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.scale = Vector2(2, 2)
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.scale = Vector2(2, 2)
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.scale = Vector2(2.3, 2.3)
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.scale = Vector2(2.3, 2.3)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		#emit_signal("moved")
	else:
		$AnimatedSprite.stop()
		
	prev_pos = position
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if abs(prev_pos.x - position.x) > 5 or abs(prev_pos.y - position.y) > 5:
		if velocity.length() == 0:
			emit_signal("moved")
	
	if Input.is_action_just_pressed("ui_accept"):
		var instance = Bullet.instance()
		instance.position = position
		
		if $AnimatedSprite.animation == "up":
			instance.fire_up(position)
		elif $AnimatedSprite.animation == "down":
			instance.fire_down(position)
		elif $AnimatedSprite.animation == "left":
			instance.fire_left(position)
		elif $AnimatedSprite.animation == "right":
			instance.fire_right(position)
			
		bullets.push_back(instance)
		get_tree().get_root().get_node("Main").add_child(instance)
		
		
	var new_list = []
	for bullet in bullets:
		if bullet.life <= 0:
			bullet.queue_free()
		else:
			if bullet.position.x <= screen_size.x and bullet.position.x >= 0:
				if bullet.position.y <= screen_size.y and bullet.position.y >= 0:
					new_list.push_back(bullet)
				
	bullets = new_list

func _on_Player_body_entered(body):
	if "Mob" in body.get_name() and body.is_visible():
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
		$AudioStreamPlayer.play()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_area_entered(area):
	if "Mob" in area.get_name() and area.is_visible():
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
