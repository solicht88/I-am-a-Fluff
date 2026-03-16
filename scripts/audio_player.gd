extends AudioStreamPlayer

const bgm = preload("res://audio/tomomi_kato-calm-piano-8996.mp3")
const cutscene_bgm = preload("res://audio/tomomi_kato-the-sound-of-light-8863.mp3")


func play_bgm():
	if self.stream == bgm:
		self.stream_paused = false
	else:
		self.stream = bgm
		play()


func play_cutscene_bgm():
	self.stream = cutscene_bgm
	play()


func stop_audio():
	self.stream_paused = true
