extends Node

func _on_Timer_timeout():
	get_tree().call_group('ai', 'ai_update')
