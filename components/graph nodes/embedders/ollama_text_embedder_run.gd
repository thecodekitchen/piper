extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs=[
		Pipeline.DataType.PlainString
	]
	outputs=[
		Pipeline.DataType.Embedding,
		Pipeline.DataType.MetaDict
	]
	slot(0,Pipeline.DataType.PlainString, Pipeline.DataType.Embedding)
	slot(1,Pipeline.DataType.None,Pipeline.DataType.MetaDict)
	data["receivers"] = ["text_embedder.text"]
	data["senders"] = ["text_embedder.embedding", "text_embedder.meta"]
