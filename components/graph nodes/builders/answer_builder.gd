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
