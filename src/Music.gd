extends Node

## vars ##########################################################

# @onready var late_night_radio = preload("res://addons/core/dj/assets/songs/Late Night Radio.mp3")

# @onready var field_stars = preload("res://addons/core/dj/assets/songs/sulosounds/field-stars-ambient-loop.wav")

## ready ##########################################################

func _ready():
	if not Engine.is_editor_hint():
		pass
		# SoundManager.set_default_music_bus("Music")
		# # deferring to give Sounds._ready a chance to set its buses
		# # dodging a SoundManager warning about using the Master bus
		# SoundManager.set_music_volume.call_deferred(0.3)

## resume menu song ##########################################################

func switch_to_pause_music():
	# TODO crossfade
	pause_game_song()
	resume_menu_song()

func switch_to_game_music():
	# TODO crossfade
	pause_menu_song()
	resume_game_song()

func resume_menu_song():
	pass
	# SoundManager.play_music(late_night_radio, 2.0)

func pause_menu_song():
	pass
	# var playing_songs = SoundManager.get_currently_playing_music()
	# if not playing_songs.is_empty():
	# 	SoundManager.stop_music()

func resume_game_song():
	pass
	# SoundManager.play_music(field_stars, 2.0)

func pause_game_song():
	pass
	# var playing_songs = SoundManager.get_currently_playing_music()
	# if not playing_songs.is_empty():
	# 	SoundManager.stop_music()
