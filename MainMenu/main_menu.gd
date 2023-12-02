extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameManager.last_score == null:
		$CongratsPanel.hide()
	else:
		$CongratsPanel/Label.text = "Congrats!!!\n
You have survived through " + GameManager.time_to_word_string(GameManager.last_score) + " of the night.\n
(That's a great score!!!)\n
It sure was your Last Twilight."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
