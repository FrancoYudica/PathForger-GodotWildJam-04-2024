extends Node

var audio_player_count: int = 50
var _audio_players: Array[AudioStreamPlayer]

var _menu_stream_player: AudioStreamPlayer
var _play_stream_player: AudioStreamPlayer

var _path_node_reached_streams: Array[AudioStream] = [
	preload("res://art/sfx/node_reached_0/path_node_reached_0.wav"),
	preload("res://art/sfx/node_reached_0/path_node_reached_1.wav"),
	preload("res://art/sfx/node_reached_0/path_node_reached_2.wav"),
	preload("res://art/sfx/node_reached_0/path_node_reached_3.wav")
]

var _throw_hook_stream: AudioStream = preload("res://art/sfx/throw_hook_0.wav")

func _ready():
	_menu_stream_player = AudioStreamPlayer.new()
	_menu_stream_player.stream = preload("res://art/music/menu_music.mp3")
	_menu_stream_player.bus = "MUSIC"
	add_child(_menu_stream_player)
	
	_play_stream_player = AudioStreamPlayer.new()
	_play_stream_player.stream = preload("res://art/music/play_music.mp3")
	_play_stream_player.bus = "MUSIC"
	add_child(_play_stream_player)
	
	for i in range(audio_player_count):
		var stream_player = AudioStreamPlayer.new()
		stream_player.bus = "SFX"
		_audio_players.append(stream_player)
		add_child(stream_player)

func play_menu_music():
	_menu_stream_player.play()
	create_tween().tween_property(_menu_stream_player, "volume_db", 0, 0.3)
	
	if _play_stream_player.playing:
		create_tween().tween_property(_play_stream_player, "volume_db", -80, 0.5)

func play_playing_music():
	_play_stream_player.play()
	create_tween().tween_property(_play_stream_player, "volume_db", 0, 0.3)
	
	if _menu_stream_player.playing:
		create_tween().tween_property(_menu_stream_player, "volume_db", -80, 0.5)

func play_path_node_reached():
	var stream = _path_node_reached_streams.pick_random()
	var player: AudioStreamPlayer = _get_free_player()
	player.stream = stream
	player.pitch_scale = randf_range(0.50, 1.75)
	player.play()
	
func play_throw_hook():
	var player: AudioStreamPlayer = _get_free_player()
	player.stream = _throw_hook_stream
	player.pitch_scale = randf_range(0.70, 1.25)
	player.volume_db = -20
	player.play()

func _get_free_player():
	for player in _audio_players:
		if not player.playing:
			player.volume_db = 0
			return player
	
