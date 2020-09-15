extends Control

signal PlayButtonPressed
signal SettingsButtonPressed


var levelSelect = preload("res://UI/Menus/Level/LevelSelectHost.tscn")
var settingsChange = preload("res://UI/Menus/Setting/Settings.tscn")



func _on_Play_pressed():
	emit_signal("PlayButtonPressed")


func _on_Settings_pressed():
	emit_signal("SettingsButtonPressed")
