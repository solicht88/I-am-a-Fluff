extends AudioStreamPlayer

const title = preload("res://audio/tomomi_kato-holy-night-11014.mp3")
const bgm = preload("res://audio/tomomi_kato-calm-piano-8996.mp3")
const cutscene_bgm = preload("res://audio/tomomi_kato-the-sound-of-light-8863.mp3")
const ending_bgm = preload("res://audio/tomomi_kato-elegy-455234.mp3")


func play_title_bgm():
	self.stream = title
	play()

func play_bgm():
	if self.stream == bgm:
		self.stream_paused = false
	else:
		self.stream = bgm
		play()


func play_cutscene_bgm():
	self.stream = cutscene_bgm
	play()


func play_ending_bgm():
	self.stream = ending_bgm
	play()


func stop_audio():
	self.stream_paused = true
