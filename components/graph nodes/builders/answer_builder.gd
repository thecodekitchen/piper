extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["import"] = "haystack.components.builders.answer_builder.AnswerBuilder"
	inputs = [
		Pipeline.DataType.PlainString,
		Pipeline.DataType.ChatMessageList,
		Pipeline.DataType.DocumentList
	]
	outputs = [
		Pipeline.DataType.GeneratedAnswerList
	]
	slot(0,Pipeline.DataType.PlainString,Pipeline.DataType.GeneratedAnswerList)
	slot(1,Pipeline.DataType.ChatMessageList)
	slot(2,Pipeline.DataType.DocumentList)
	data["component_name"]="answer_builder"
	data["receivers"] = [
		"answer_builder.query",
		"answer_builder.replies",
		"answer_builder.documents"
	]
	data["senders"] = [
		"answer_builder.answers"
	]
	if not data.has("api_variables"):
		data["api_variables"] = {}
	
func handle_param_assignment(port:int,param_data)->void:
	if param_data.has("name"):
		var param = param_data["name"]
		match port:
			0:
				data["api_variables"]["query"] = param
			1:
				data["api_variables"]["replies"] = param
			2:
				data["api_variables"]["documents"] = param
