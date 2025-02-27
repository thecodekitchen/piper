extends Node

var pipeline:GraphState
var conversation:Array[ChatMessage]
var sources:Array[Dictionary] = []

var generator_url:String = "http://localhost:8000"
var pipeline_url:String = "http://localhost:8080"
var qdrant_url:String = "http://localhost:6333"
var ollama_url:String = "http://localhost:11434"

var collection_folder:String = "$HOME/collections"
var qdrant_api_key:String
var qdrant_collections:Array[String]
var ollama_models:Array[String]

var selected_collection:String
var selected_pipeline_path:String

var saved_conversations:Dictionary

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

signal updated_messages()
signal updated_conversations()
signal updated_collections()
signal updated_sources()
signal thinking()
signal uploading_collection()

func _ready()->void:
	var file = FileAccess.get_file_as_string("user://user_settings.json")
	var json = JSON.new()
	var err = json.parse(file)
	if err == OK:
		var settings = json.data
		if settings.has("generator_url"):
			generator_url = settings["generator_url"]
		if settings.has("pipeline_url"):
			pipeline_url = settings["pipeline_url"]
		if settings.has("qdrant_url"):
			qdrant_url = settings["qdrant_url"]
		if settings.has("ollama_url"):	
			ollama_url = settings["ollama_url"]
		if settings.has("qdrant_api_key"):
			qdrant_api_key = settings["qdrant_api_key"]
		if settings.has("collection_dir"):
			collection_folder = settings["collection_dir"]
		if settings.has("selected_collection"):
			selected_collection = settings["selected_collection"]

func _exit_tree() -> void:
	var file = FileAccess.open("user://user_settings.json", FileAccess.WRITE)
	var settings = {
		"generator_url": generator_url,
		"pipeline_url": pipeline_url,
		"qdrant_url": qdrant_url,
		"ollama_url": ollama_url,
	}
	if qdrant_api_key:
		settings["qdrant_api_key"] = qdrant_api_key
	if collection_folder:
		settings["collection_dir"] = collection_folder
	if selected_collection:
		settings["selected_collection"] = selected_collection
	file.store_string(JSON.stringify(settings))
	file.close()

func refresh_conversations()->void:
	var dir = DirAccess.open("user://conversations")
	var conversations = []
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		file = file.rstrip(".json")
		conversations.append(file)
	dir.list_dir_end()
	saved_conversations = conversations
	emit_signal("updated_conversations")
	
func save_conversation(title:String)->void:
	var dir = DirAccess.open("user://conversations").get_current_dir()
	var sep = "/"
	if OS.get_name() == "Windows":
		sep = "\\"
	var path = dir + sep + title
	var json_data = JSON.stringify(conversation)
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(json_data)
	file.close()

func load_conversation(path:String)->void:
	var json_string = FileAccess.open(path,FileAccess.READ).get_as_text()
	var json = JSON.new()
	var data = json.parse(json_string)
	if data is Array:
		var messages: Array[ChatMessage] = []
		for message in data:
			if message is Dictionary:
				messages.append(ChatMessage.from_dict(message))
		conversation = messages

func initialize_pipeline_graph()->void:
	if pipeline != null:
		var editor = get_tree().get_first_node_in_group("PipelineGraph")
		#var editor = $"../ColorRect/VBoxContainer/GraphEdit" as PipelineGraphEdit
		editor.clear_connections()
		for child in editor.get_children():
			if child.name != "_connection_layer":
				child.queue_free()
		
		for node in pipeline._nodes as Array[NodeState]:
			var node_type = node._name.rstrip("0123456789")
			var node_path = node_paths[node_type]
			var node_scene = load(node_path) as PackedScene
			var instance = node_scene.instantiate() as PipelineGraphNode
			instance.name = node._name
			instance.position_offset = node._position_offset
			instance.data = node._data
			editor.add_child(instance)
		print("successfully added nodes...")
		for frame in pipeline._frames as Array[FrameState]:
			var frame_instance = PipelineGraphFrame.new()
			frame_instance.name = frame._name
			frame_instance.title = frame._title
			frame_instance.size = frame._size
			frame_instance.position_offset = frame._position_offset
			editor.add_child(frame_instance)
			for node_name in frame._attached:
				editor.attach_graph_element_to_frame(node_name,frame_instance.name)
		print("successfully added frames")
		for conn in pipeline._connections as Array[Connection]:
			editor.connect_node(conn._from,conn._from_port,conn._to,conn._to_port)
		print("successfully connected nodes")
		
func load_pipeline(path:String)->void:
	pipeline = GraphState.from_json_file(path)
