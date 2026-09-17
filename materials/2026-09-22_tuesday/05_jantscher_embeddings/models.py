from bertopic.backend import BaseEmbedder
from sentence_transformers import SentenceTransformer
from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer


class TfIdfEmbedder(BaseEmbedder):
    def __init__(self, vocabulary: list[str] | None = None, *args, **kwargs):
        super().__init__()
        self.embedding_model: TfidfVectorizer = TfidfVectorizer(*args, **kwargs)
        self.vocabulary = vocabulary
        if vocabulary is not None:
            self.embedding_model.fit(self.vocabulary)

    def embed(self, documents, verbose=True):
        if self.vocabulary is None:
            print("Call 'fit_transform'...")
            return self.embedding_model.fit_transform(documents)
        print("Call 'transform' only...")
        return self.embedding_model.transform(documents)


class CountVectorizerEmbedder(BaseEmbedder):
    def __init__(self, vocabulary: list[str] | None = None, *args, **kwargs):
        super().__init__()
        self.embedding_model: CountVectorizer = CountVectorizer(*args, **kwargs)
        self.vocabulary = vocabulary
        if vocabulary is not None:
            self.embedding_model.fit(self.vocabulary)

    def embed(self, documents, verbose=True):
        if self.vocabulary is None:
            print("Call 'fit_transform'...")
            return self.embedding_model.fit_transform(documents)
        print("Call 'transform' only...")
        return self.embedding_model.transform(documents)


class SentenceTransformerSmall(BaseEmbedder):
    def __init__(self):
        super().__init__()
        self.embedding_model = SentenceTransformer("all-minilm-l6-v2")

    def embed(self, documents, verbose=True):
        embeddings = self.embedding_model.encode(documents, show_progress_bar=verbose)
        return embeddings


class SentenceTransformerLarge(BaseEmbedder):
    def __init__(self):
        super().__init__()
        self.embedding_model = SentenceTransformer("paraphrase-multilingual-MiniLM-L12-v2")

    def embed(self, documents, verbose=True):
        embeddings = self.embedding_model.encode(documents, show_progress_bar=verbose)
        return embeddings
