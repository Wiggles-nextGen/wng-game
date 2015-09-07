###########################
#  This file is part of
#    Wiggles nextGen
#
#  Licensed under GPLv2
#    
###########################


extends Node

var target = null
var targetFunction
var promiseClass = load("res://scripts/promise.gd")
var promise


func _ready():
	pass

func then(node, funct):
	target = node
	targetFunction = funct
	promise = promiseClass.new()
	return promise

func hasPromise():
	return (target != null)

func fullfill(data):
	OS.delay_msec(5) #just in case then() haven't been called yet
	if(target != null && target.has_method(targetFunction)):
		target.call(targetFunction,data)
		if(promise.hasPromise()):
			promise.fullfill(data)