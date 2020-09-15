extends Node2D

var EnvironmentLibrary = [preload("res://Resources/Environments/Red.tres"), 
		preload("res://Resources/Environments/Orange.tres"), 
		preload("res://Resources/Environments/Yellow.tres"), 
		preload("res://Resources/Environments/Green.tres"), 
		preload("res://Resources/Environments/Blue.tres"), 
		preload("res://Resources/Environments/Purple.tres")]

var levelLibrary = [preload("res://Levels/EasyLevels/Level1/Level1.tscn"), 
		preload("res://Levels/EasyLevels/Level2/Level2.tscn"),
		preload("res://Levels/EasyLevels/Level3/Level3.tscn"),
		preload("res://Levels/EasyLevels/Level4/Level4.tscn"),
		preload("res://Levels/EasyLevels/Level5/Level5.tscn")]

var LoadLevels = preload("res://UI/Menus/Level/LevelSelectHost.tscn")
var LoadSettings = preload("res://UI/Menus/Setting/Settings.tscn")
var loadCharacter = preload("res://Player/Player.tscn")

var InitializeLevels = LoadLevels.instance()
var InitializeSettings = LoadSettings.instance()
var initChar = loadCharacter.instance()
var InitializeSpecificLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	EnvironmentLibrary.shuffle()
	$WorldEnvironment.set_environment(EnvironmentLibrary[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Title_PlayButtonPressed():
	$Title.hide()
	self.add_child(InitializeLevels)
	InitializeLevels.connect("levelStarted", self, "on_Level_Started")
	#print("Worked")


func _on_Title_SettingsButtonPressed():
	$Title.hide()
	self.add_child(InitializeSettings)


func on_Level_Started(levelNumber):
	InitializeSpecificLevel = levelLibrary[levelNumber]
	var newLevel = InitializeSpecificLevel.instance()
	self.add_child(newLevel)
	$PlayerStartPos.add_child(initChar)
	InitializeLevels.hide()
	#print("Done")
	
