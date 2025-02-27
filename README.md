# Piper
An agentic pipeline editor in Godot!
## What It Does
Piper is a visual, node-based editor for the Haystack agentic pipeline framework in Python.

The goal for this tool is to allow drag and drop assembly of agentic pipelines and the APIs exposing them by visually connecting inputs and outputs.

This results in visually appealing, yet functional representations of the pipeline APIs assembled this way that can be modified without touching any code.

Piper also operates as a chat interface for chat-based RAG pipelines, providing an out-of-the-box example pipeline configuration (the starter_pack.json file at the project root) that can be loaded from the pipeline editor scene.

Currently, only a core set of Haystack components are built out for use in the editor, but more will be added as availability allows since I am currently the sole developer.
## Backend
The backend this application depends on currently requires a local Linux environment with NVIDIA GPU capability. Supporting CPU-powered implementations was deemed unwise since response times for the services involved would likely be unusable in most scenarios. Work is underway to support remote deployments so that the front end can operate more freely across platforms, but right now only local stacks are supported.

For instructions on how to deploy the backend, visit the [Piper Builder](https://github.com/thecodekitchen/piper-builder) repo.