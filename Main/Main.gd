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

var currentLevel = 0

var InitializeLevels = LoadLevels.instance()
var InitializeSettings = LoadSettings.instance()
var initChar = loadCharacter.instance()
var InitializeSpecificLevel = levelLibrary[0]

var newLevel = InitializeSpecificLevel.instance()


func _ready():
	randomize()
	EnvironmentLibrary.shuffle()
	$WorldEnvironment.set_environment(EnvironmentLibrary[1])


func _on_Title_PlayButtonPressed():
	$Title.hide()
	self.add_child(InitializeLevels)
	InitializeLevels.connect("levelStarted", self, "on_Level_Started")


func _on_Title_SettingsButtonPressed():
	$Title.hide()
	self.add_child(InitializeSettings)


func on_Level_Started(levelNumber):
	currentLevel = levelNumber
	InitializeSpecificLevel = levelLibrary[levelNumber]
	newLevel = InitializeSpecificLevel.instance()
	self.add_child(newLevel)
	$PlayerStartPos.add_child(initChar)
	initChar.connect("gotHurt", self, "on_Char_Hurt")
	initChar.connect("reachedEnd", self, "on_Char_Finished")
	InitializeLevels.hide()


func on_Char_Hurt():
#	print($PlayerStartPos.get_position())
	initChar.set_global_position($PlayerStartPos.get_position())


func on_Char_Finished():
	self.remove_child(newLevel)
	#newLevel.queue_free()
	initChar.set_global_position($PlayerStartPos.get_position())
	InitializeSpecificLevel = levelLibrary[currentLevel + 1]
	currentLevel += 1
	newLevel = InitializeSpecificLevel.instance()
	self.add_child(newLevel)
