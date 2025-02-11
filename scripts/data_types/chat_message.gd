class_name ChatMessage

var _role: String
var _content: Array
var _name: String
var _meta: Dictionary

func _init(role: String, text: String, name: String = "", meta: Dictionary = {}) -> void:
	_role = role
	_content = [{"text": text}]
	_name = name
	_meta = meta

func to_dict() -> Dictionary:
	return {
	   "_role": _role,
	   "_content": _content,
	   "_name": _name,
	   "_meta": _meta
	}

static func from_dict(d:Dictionary)->ChatMessage:
	if d.has("_role")&&d.has("_content")&&d.has("_name")&&d.has("_meta"):
		return ChatMessage.new(d["_role"],d["_content"],d["_name"],d["_meta"])
	return null
