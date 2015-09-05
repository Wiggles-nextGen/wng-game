###########################
#
#
#
#
#
###########################


extends Node

var version = {}

var versionStr
var commitStr = "f39e57abcfbc627a3d6ae847f7f8773ab6eb734a" #TODO: change


func _ready():
	pass

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