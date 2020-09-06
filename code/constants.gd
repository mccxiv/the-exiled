tool
extends Node

var Buildings = {
	'woodcutters_hut': {
		'building': preload('res://entities/buildings/woodcutters_hut/woodcutters_hut.tscn'),
		'worker': preload('res://entities/units/woodcutter/woodcutter.tscn'),
		'construction': {'plank': 2}
	},
	'sawmill': {
		'building': preload('res://entities/buildings/sawmill/sawmill.tscn'),
		'worker': preload('res://entities/units/sawmiller/sawmiller.tscn'),
		'construction': {'plank': 3}
	}
}
