###########################
#
#
#
#
#
###########################


extends Node

var uiCtrl
var mapCtrl

var debugNode
var worldNode
var uiNode

var version = {}

var versionStr
var commitStr = "f39e57abcfbc627a3d6ae847f7f8773ab6eb734a" #TODO: change


func _ready():
	uiCtrl = get_node("/root/uiController")
	mapCtrl = get_node("/root/mapController")

###
# Setup envirment
###
func setUp(debug, world, ui):
	debugNode = debug
	worldNode = world
	uiNode = ui
	uiCtrl.call("setUp",debugNode,uiNode)
	mapCtrl.call("setUp",worldNode)

###
# Utils to get/show the Version
###
func getVersionAsStr():
	if(!versionStr):
		var file = File.new()
		file.open("res://version.json",file.READ)
		var tmp = file.get_as_text()
		file.close()
		version.parse_json(tmp)
		versionStr = "v" + str(version["major"]) +"."+ str(version["minor"]) +"."+ str(version["patch"]) +"."+ str(version["status"])
	return versionStr
func getCommitAsStr():
	return commitStr

func setVersionAndCommit(VersionLabel, CommitLabel):
	setVersion(VersionLabel)
	setCommit(CommitLabel)
func setVersion(VersionLabel):
	VersionLabel.set_text(getVersionAsStr())
func setCommit(CommitLabel):
	CommitLabel.set_text(getCommitAsStr())