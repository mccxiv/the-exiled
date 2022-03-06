extends Camera

var movement_speed = 25

func _process (delta: float) -> void:
	_move_camera(delta)
	
func _move_camera(delta: float) -> void:
	var velocity = Vector3()
	if Input.is_action_pressed("ui_left"):
		velocity -= self.transform.basis.x
	if Input.is_action_pressed("ui_right"):
		velocity += self.transform.basis.x
	if Input.is_action_pressed("ui_up"):
		velocity += self.transform.basis.y
	if Input.is_action_pressed("ui_down"):
		velocity -= self.transform.basis.y
	self.translation += velocity * delta * movement_speed
