extends CharacterBody2D


const SPEED = 300.0
const TURN_SPEED = 1.5

var rotation_direction: float = 0
var invincible_duration: float = 1
var invincible_time: float = 0


@onready
var trail_scene = preload("res://trail.tscn")

func _ready():
	create_trail()


func _physics_process(delta):
	rotation += get_turn() * TURN_SPEED * delta
	velocity = Vector2(SPEED, 0).rotated(rotation)
	move_and_slide()
	
	if Input.is_action_just_pressed("ability1"):
		invincible_time = invincible_duration
	
	if invincible_time > 0:
		var s = 1 + sin(invincible_time)
		scale.x = s
		scale.y = s
	
	invincible_time -= delta


func get_turn():
	return Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")


func create_trail():
	var trail = trail_scene.instantiate()
	get_parent().call_deferred("add_child", trail)
	trail.target = self
