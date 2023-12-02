extends Node

var last_score = null

func end_game(time):
	last_score = time
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")

func time_to_word_string(time):
	var minutes = floor(time / 60)
	var seconds = int(time) % 60
	
	#return ( str(minutes) + ":" + ("0" if seconds < 10 else "") + str(seconds) )
	return str(minutes) + " minute" + ("s" if minutes != 1 else "") + " and " + str(seconds) + " second" + ("s" if seconds != 1 else "")

func time_to_string(time):
	var minus = ""
	
	if time < 0:
		time = -time
		minus = "-"
	
	var minutes = floor(time / 60)
	var seconds = int(time) % 60
	
	return ( minus + str(minutes) + ":" + ("0" if seconds < 10 else "") + str(seconds) )
	#return minutes + " minute" + ("s" if minutes != 1 else "") + " and " + seconds + " second" + ("s" if seconds != 1 else "")
