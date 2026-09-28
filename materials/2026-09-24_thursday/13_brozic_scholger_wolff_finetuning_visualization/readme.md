# School Material Thursday, 24 September 2026


15:30-17:00: Finetuning and visualization (Lucija Brozić, Martina Scholger, Fernanda Wolff)    

#### LLM Labels and Network Representation (Fernanda Wolff)

Useful tools:

- [Ollama](https://ollama.com/)
- [NetworkX](https://networkx.org/en/)
- [Gephi Lite](https://lite.gephi.org/v1.0.2/)

Notebooks:

- `wolff_llm_labels.ipynb`: generates topic labels with an LLM, comparing an OpenAI model against two local Ollama models (Llama and Gemma), and exports the labeled dataset as a CSV.
- `wolff_network.ipynb`: turns that labeled dataset into two networks, one connecting people who corresponded directly, one connecting people through the topics they wrote about, and exports both as GraphML files ready to import into Gephi Lite.
