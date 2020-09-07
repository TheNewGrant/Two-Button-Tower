extends Node2D

var EnvironmentLibrary = [preload("res://Resources/Environments/Red.tres"), 
		preload("res://Resources/Environments/Orange.tres"), 
		preload("res://Resources/Environments/Yellow.tres"), 
		preload("res://Resources/Environments/Green.tres"), 
		preload("res://Resources/Environments/Blue.tres"), 
		preload("res://Resources/Environments/Purple.tres")]



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	EnvironmentLibrary.shuffle()
	$WorldEnvironment.set_environment(EnvironmentLibrary[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
