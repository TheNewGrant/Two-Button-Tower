extends KinematicBody2D

signal gotHurt
signal reachedEnd

# Variables for force pressure on the body (speed)
export var LeftSpeed = -500
export var RightSpeed = 500
export var Gravity = 2000
export var DirectionRight = true
# Jump math - Strength, amount
export var JumpPower = -800
export var AllowedJumps = 1
var AvailableJumps = 1
var CanJump = true
# Dash Math
export  var DashStrength = 800
var DashDirection = 800
export var AllowedDashes = 1
var AvailableDashes = 1
var CanDash = true
# Lets me move
var Movement = Vector2()
# Floor Direction detection
export var FLOOR_NORMAL = Vector2(0, -1)


func _ready():
	Movement.x = RightSpeed


func _physics_process(delta):
	Movement.y += Gravity * delta

	if is_on_floor():
		$PlayerAnimations.play("Run")
		CanJump = true
		CanDash = true
		AvailableJumps = AllowedJumps
		AvailableDashes = AllowedDashes

	if AvailableJumps == 0:
		CanJump = false

	if AvailableDashes == 0:
		CanDash = false

	if $RayCast.is_colliding():
		if DirectionRight == true:
			$RayCast.set_cast_to(Vector2(-20, 0))
			DirectionRight = false
			Movement.x = LeftSpeed
			$PlayerAnimations.flip_h = true
		else:
			$RayCast.set_cast_to(Vector2(20, 0))
			DirectionRight = true
			Movement.x = RightSpeed
			$PlayerAnimations.flip_h = false

	if Input.is_action_just_pressed("Jump"):
		if CanJump == true:
			AvailableJumps -= 1
			Movement.y += JumpPower
			$PlayerAnimations.play("Jump")
		else:
			pass
	elif Input.is_action_pressed("Dash"):
		if CanDash == true:
			if DirectionRight == true:
				DashStrength = DashDirection
				$DashTimer.start()
				Movement.x = DashStrength
			else:
				DashStrength = DashDirection * -1
				$DashTimer.start()
				Movement.x = DashStrength
	
	Movement = move_and_slide(Movement, FLOOR_NORMAL)


func _on_DashTimer_timeout():
	if DirectionRight == true:
		Movement.x = RightSpeed
	else:
		Movement.x = LeftSpeed


func _on_Area2D_body_entered(body):
#	print("AreaEntered")
	if body.is_in_group("Spikes"):
#		print("In spike")
		emit_signal("gotHurt")


func _on_Area2D_area_entered(area):
	if area.is_in_group("End"):
#		print("Made it")
		emit_signal("reachedEnd")
