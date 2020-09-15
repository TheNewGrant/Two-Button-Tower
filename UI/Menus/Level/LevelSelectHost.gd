extends Control


signal levelStarted()

export var levelNumber = 0
var fakeLevel = 1
export var minLevel = 0
export var maxLevel = 4

var levelTextBase = "LV%s"
var levelText = levelTextBase % str(fakeLevel)

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	emit_signal("levelStarted", levelNumber)


func _on_UpArrow_pressed():
	if levelNumber < maxLevel:
		levelNumber += 1
		fakeLevel += 1
	else: 
		pass
	levelText = levelTextBase % str(fakeLevel)
	$Margin/VBox/Button.set_text(levelText)


func _on_DownArrow_pressed():
	if levelNumber > minLevel:
		levelNumber -= 1
		fakeLevel -= 1
	else:
		pass
	levelText = levelTextBase % str(fakeLevel)
	$Margin/VBox/Button.set_text(levelText)
