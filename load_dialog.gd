extends FileDialog
# Called when the node enters the scene tree for the first time.
var node_paths = {
	"APIParam": "res://components/graph nodes/api/API Param.tscn",
	"Response": "res://components/graph nodes/api/Response.tscn",
	"Route": "res://components/graph nodes/api/Route.tscn",
	"ChatPromptBuilderInit": "res://components/graph nodes/builders/chat_prompt_builder_init.tscn",
	"ChatPromptBuilderRun": "res://components/graph nodes/builders/chat_prompt_builder_run.tscn",
	"AnswerBuilder": "res://components/graph nodes/builders/AnswerBuilder.tscn",
	"FileTypeRouter": "res://components/graph nodes/routers/FileTypeRouter.tscn",
	"DocumentCleaner": "res://components/graph nodes/preprocessors/DocumentCleaner.tscn",
	"DocumentSplitter": "res://components/graph nodes/preprocessors/DocumentSplitter.tscn",
	"DocumentJoiner": "res://components/graph nodes/joiners/DocumentJoiner.tscn",
	"DocumentWriterInit": "res://components/graph nodes/writers/document_writer_init.tscn",
	"DocumentWriterRun": "res://components/graph nodes/writers/document_writer_run.tscn",
	"CsvToDocument": "res://components/graph nodes/converters/CSVToDocument.tscn",
	"DocxToDocument": "res://components/graph nodes/converters/DOCXToDocument.tscn",
	"HtmlToDocument": "res://components/graph nodes/converters/HTMLToDocument.tscn",
	"MarkdownToDocument": "res://components/graph nodes/converters/MarkdownToDocument.tscn",
	"PyPdfToDocument": "res://components/graph nodes/converters/PyPDFToDocument.tscn",
	"TextFileToDocument": "res://components/graph nodes/converters/TextFileToDocument.tscn",
	"XlsxToDocument": "res://components/graph nodes/converters/XLSXToDocument.tscn",
	"Args": "res://components/graph nodes/complex values/Args.tscn",
	"PromptTemplate": "res://components/graph nodes/complex values/PromptTemplate.tscn",
	"StringList": "res://components/graph nodes/complex values/StringList.tscn",
	"OllamaTextEmbedderInit": "res://components/graph nodes/embedders/ollama_text_embedder_init.tscn",
	"OllamaTextEmbedderRun": "res://components/graph nodes/embedders/ollama_text_embedder_run.tscn",
	"OllamaDocumentEmbedderInit": "res://components/graph nodes/embedders/ollama_document_embedder_init.tscn",
	"OllamaDocumentEmbedderRun": "res://components/graph nodes/embedders/ollama_document_embedder_run.tscn",
	"OllamaChatGeneratorInit":"res://components/graph nodes/generators/ollama_chat_generator_init.tscn",
	"OllamaChatGeneratorRun":"res://components/graph nodes/generators/ollama_chat_generator_run.tscn",
	"QdrantEmbeddingRetrieverInit":"res://components/graph nodes/retrievers/qdrant_embedding_retriever_init.tscn",
	"QdrantEmbeddingRetrieverRun":"res://components/graph nodes/retrievers/qdrant_embedding_retriever_run.tscn",
	"QdrantDocumentStore": "res://components/graph nodes/doc stores/QdrantDocumentStore.tscn",
	"ApiKey": "res://components/graph nodes/scalar values/api_key.tscn",
	"Bool": "res://components/graph nodes/scalar values/bool.tscn",
	"Integer": "res://components/graph nodes/scalar values/Integer.tscn",
	"Model": "res://components/graph nodes/scalar values/model.tscn",
	"String": "res://components/graph nodes/scalar values/string.tscn",
	"Url": "res://components/graph nodes/scalar values/url.tscn"
}


func _ready() -> void:
	filters = ["*.json; JSON Files"]
	file_selected.connect(load_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_scene(path:String)->void:
	var graph_data = GraphState.from_json_file(path)
	if graph_data != null:
		var editor = $"../ColorRect/VBoxContainer/GraphEdit" as PipelineGraphEdit
		editor.clear_connections()
		for child in editor.get_children():
			if child.name != "_connection_layer":
				child.queue_free()
		
		for node in graph_data._nodes as Array[NodeState]:
			var node_type = node._name.rstrip("0123456789")
			var node_path = node_paths[node_type]
			var node_scene = load(node_path) as PackedScene
			var instance = node_scene.instantiate() as PipelineGraphNode
			instance.name = node._name
			instance.position_offset = node._position_offset
			instance.data = node._data
			editor.add_child(instance)
		print("successfully added nodes...")
		for frame in graph_data._frames as Array[FrameState]:
			var frame_instance = PipelineGraphFrame.new()
			frame_instance.name = frame._name
			frame_instance.title = frame._title
			frame_instance.size = frame._size
			frame_instance.position_offset = frame._position_offset
			editor.add_child(frame_instance)
			for node_name in frame._attached:
				editor.attach_graph_element_to_frame(node_name,frame_instance.name)
		print("successfully added frames")
		for conn in graph_data._connections as Array[Connection]:
			editor.connect_node(conn._from,conn._from_port,conn._to,conn._to_port)
		print("successfully connected nodes")
		#print("Connections:")
		#for conn in graph_data._connections as Array[Connection]:
			#print("from ",conn._from," port ",conn._from_port," to ",conn._to, " port ", conn._to_port)
		#print("Nodes:")
		#for node in graph_data._nodes as Array[NodeState]:
			#print(node._name)
			#print(node._position_offset)
		#print("Frames:")
		#for frame in graph_data._frames as Array[FrameState]:
			#print(frame._attached)
			#print(frame._position_offset)
