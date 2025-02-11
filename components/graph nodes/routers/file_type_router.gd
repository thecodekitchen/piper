extends PipelineGraphNode

var run_node:PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.PathList]
	outputs = [
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
		Pipeline.DataType.PathList,
	]
	data["import"] = "haystack.components.routers.file_type_router.FileTypeRouter"
	data["component_name"] = "file_type_router"
	data["receivers"] = ["file_type_router.sources"]
	data["mime_types"] = [
		"text/plain",
		"text/csv",
		"text/markdown",
		"text/html",
		"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
		"application/pdf",
		"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
	]
	data["senders"] = [
		"file_type_router.text/plain",
		"file_type_router.text/csv",
		"file_type_router.text/markdown",
		"file_type_router.text/html",
		"file_type_router.application/vnd.openxmlformats-officedocument.wordprocessingml.document",
		"file_type_router.application/pdf",
		"file_type_router.application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" 
	]
	slot(0,Pipeline.DataType.PathList,Pipeline.DataType.PathList)
	slot(1,Pipeline.DataType.None,Pipeline.DataType.PathList)
	slot(2,Pipeline.DataType.None,Pipeline.DataType.PathList)
	slot(3,Pipeline.DataType.None,Pipeline.DataType.PathList)
	slot(4,Pipeline.DataType.None,Pipeline.DataType.PathList)
	slot(5,Pipeline.DataType.None,Pipeline.DataType.PathList)
	slot(6,Pipeline.DataType.None,Pipeline.DataType.PathList)
	
	
