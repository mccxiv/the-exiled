extends Node

func _ready():
	timeout('_tick', 0.1)

func _tick():
	get_tree().call_group('ai', 'ai_update')

func timeout(callback: String, time: float):
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = time
	timer.connect("timeout", self, callback)
	timer.start()
	pass
