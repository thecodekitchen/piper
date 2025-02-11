extends PipelineGraphNode

var system_editor:CodeEdit
var user_editor:CodeEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	system_editor = $SystemTemplateRow/SystemTemplateEditor
	user_editor = $UserTemplateRow/UserTemplateEditor
	if data.has("value"):
		print(data["value"])
		#if not data["value"] is Array[Dictionary]:
			#push_error("Prompt template is incorrectly typed on load")
			#data["value"] = [
				#ChatMessage.new("system","").to_dict(),
				#ChatMessage.new("user", "").to_dict()
			#]
		var template = data["value"]
		var system_msg = template[0]["_content"][0]["text"]
		var user_msg = template[1]["_content"][0]["text"]
		system_editor.text = system_msg
		user_editor.text = user_msg
	else:
		data["value"] = [
			ChatMessage.new("system","").to_dict(),
			ChatMessage.new("user", "").to_dict()
		]
	
	
	inputs = []
	outputs = [
		Pipeline.DataType.ChatTemplate
	]
	set_slot(0,
		false,0,Color.WHITE,
		true,Pipeline.DataType.ChatTemplate,pipeline.TypeColors["ChatTemplate"]
	)

func system_message_changed()->void:
	var msg = data["value"][0] as Dictionary
	msg["_content"] = [{"text":system_editor.text}]
	set_value(data["value"])
	
func user_message_changed()->void:
	var msg = data["value"][1] as Dictionary
	msg["_content"] = [{"text":user_editor.text}]
	set_value(data["value"])
