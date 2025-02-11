class_name ToolCall

var _tool_name:String
var _arguments:Dictionary
var _id:String

func _init(tool_name:String,arguments:Dictionary={},id:String="")->void:
	_tool_name=tool_name
	_arguments=arguments
	_id=id
