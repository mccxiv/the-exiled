tool
extends Node

var _placeholder_worker = preload('res://scenes/units/sawmiller/sawmiller.tscn')
var _placeholder_building = preload('res://scenes/buildings/sawmill/sawmill.tscn')

var Resources = [
	'plank',
	'log',
	'stone',
]

var Buildings = {
	'woodcutters_hut': {
		'building': preload('res://scenes/buildings/woodcutters_hut/woodcutters_hut.tscn'),
		'worker': preload('res://scenes/units/woodcutter/woodcutter.tscn'),
		'construction': {'plank': 2},
		'output': ['log']
	},
	'sawmill': {
		'building': preload('res://scenes/buildings/sawmill/sawmill.tscn'),
		'worker': preload('res://scenes/units/sawmiller/sawmiller.tscn'),
		'construction': {'plank': 3},
		'input': ['log'],
		'output': ['plank']
	},
	'stonecutters_hut': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 2, 'stone': 2},
		'output': ['plank']
	},
	'brickworks': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 3, 'stone': 2},
		'input': ['clay', 'grain'],
		'output': ['brick']
	},
	'clay_pit': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 5, 'stone': 1},
		'input': ['water'],
		'output': ['clay']
	},
	'waterworks': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 3, 'stone': 3},
		'output': ['water']
	},
	'fishermans_hut': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 3, 'stone': 1},
		'output': ['fish']
	},
	'farm': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 4, 'stone': 1},
		'output': ['grain']
	},
	'great_moai': {
		'building': _placeholder_building,
		'worker': _placeholder_worker,
		'construction': {'plank': 25, 'stone': 40}
	}
}
