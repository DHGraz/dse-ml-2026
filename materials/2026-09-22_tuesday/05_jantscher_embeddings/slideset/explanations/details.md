# PCA Explanations
The PCA output shows that the first two components explain:
PC1 = 10.59\%, \qquad PC2 = 6.57%
Together, they explain only: 17.16% of the variation in the original 384-dimensional embeddings. Therefore, the plot is useful for inspection, but it is only a partial view of the semantic structure.

### What the closest pair shows

The closest pair is:

- `u54`: government restrictions, restaurants, taxes, and action by ministers;
- `u56`: ministers, a bill, rural communities, companies, and government support.

They are not about exactly the same subject, but both use similar parliamentary language:

- government action;
- ministers and bills;
- financial measures;
- answering questions;
- institutional decision-making.

PCA places them almost at the same coordinates:

```text
u54: (0.2831, -0.0121)
u56: (0.2836, -0.0136)
```

This suggests that the embedding captures a shared semantic and rhetorical context, such as parliamentary debate about government measures, even when the specific subject differs.

### What the farthest pair shows

The farthest pair is:

- `u36`: parliamentary procedure, rushing a bill through committees, and voting;
- `u26`: the health system, hospitals, doctors, waiting lists, and Covid-19.

Their coordinates are:

```text
u36: ( 0.4878, 0.0448)
u26: (-0.4719, 0.3266)
```

The largest difference is along PC1. In this dataset, PC1 appears to distinguish something like:

```text
parliamentary procedure and legislative administration
                    ↔
health and substantive public-policy discussion
```

This is an interpretation of the observed examples, not the formal meaning of PC1. PCA does not know the labels “procedure” or “health.” PC1 is simply a weighted combination of all 384 embedding dimensions.

### What the component extremes suggest

The extremes provide a more useful interpretation.

At the negative end of PC1, the examples are strongly related to healthcare:

- health-system problems;
- hospitals;
- waiting lists;
- healthcare professionals;
- Covid-19.

At the positive end of PC1, the examples are more procedural:

- bills;
- ministers;
- committees;
- council meetings;
- parliamentary deadlines.

This gives reasonable evidence that PC1 is partly associated with a **health-policy versus parliamentary-procedure gradient**.

PC2 shows a different pattern:

- low PC2 includes iceland, agriculture, gardening, electricity costs, and refugees;
- high PC2 includes hospitals, health-system funding, medical staff, and Covid-19.

A possible interpretation is that PC2 separates different substantive policy areas, especially health-related debate from other social, agricultural, or international issues. However, the pattern is less clean than for PC1.

### What the plot itself means

The plot shows a broad cloud rather than clearly separated clusters. That is expected:

- PCA is linear;
- it emphasizes the largest global directions of variation;
- it does not explicitly search for topic-shaped groups;
- only 17.16% of the total variation is visible.

The dense group on the right corresponds broadly to utterances with parliamentary and procedural language. The points on the left contain more substantive policy discussions, especially healthcare. But the overlap shows that these are gradual semantic differences rather than perfectly separated topics.

Also, the closest and farthest pairs were calculated **in the two-dimensional PCA projection**, not in the original 384-dimensional space. PCA may make two documents look close after discarding dimensions that distinguish them, so these examples should be treated as exploratory evidence.

The strongest teaching point is:

> PCA does not produce “topic 1” and “topic 2.” It produces orthogonal directions of maximum variation. We inspect the texts at the extremes of those directions to infer what kinds of language may be associated with them.

The long utterances also deserve a caveat: the Sentence Transformer may truncate inputs beyond its maximum token length, and the machine-translated or noisy language in this ParlaMint sample can affect the embedding geometry.

---

# UMAP Explanations
The UMAP output shows a clearer local structure than the PCA output. The plot contains several compact neighborhoods rather than one mostly continuous cloud.

### Closest pair

The closest pair is:

- `u52`
- `u55`

Both discuss the same parliamentary bill, calculated remuneration, tax rules, ministers, and government consultations.

Their coordinates are almost identical:

```text
u52: (7.9073, 3.7606)
u55: (7.9183, 3.7478)
```

This is a strong example of UMAP preserving a local semantic neighborhood. The model recognizes that these utterances are part of the same specific debate, even though the translated wording is noisy.

The nearby `u51` utterance also discusses the same bill and appears in the same upper-right neighborhood. This suggests that UMAP has grouped a coherent parliamentary discussion.

### Farthest pair

The farthest pair is:

- `u57`: financial rules, companies, payment deferrals, and tax calculations;
- `u28`: healthcare staffing, doctors, nurses, and health-system planning.

This reflects a broad thematic difference between economic legislation and healthcare policy.

However, the farthest-pair result should be treated cautiously. UMAP is designed mainly to preserve local neighborhoods. Distance between two far-away points in the two-dimensional map does not necessarily represent a precise global semantic distance.

### Local neighborhoods

Several groups are interpretable:

- The lower-left area contains utterances about healthcare, Covid, hospitals, nurses, and medical education.
- The upper-right area contains a very tight group about a particular bill, tax calculations, ministers, and payment rules.
- The right-hand area contains agriculture, industrial production, factories, rural communities, and environmental concerns.
- The lower-middle and lower-left areas contain further healthcare and public-service discussions.

This is exactly the type of structure UMAP is useful for revealing: smaller semantic neighborhoods that may later become topic clusters.

---

# UMAP versus PCA

PCA showed broad directions of variation. Its output suggested a general contrast between procedural parliamentary language and substantive health-policy discussion.

UMAP creates a more locally organized map:

```text
PCA  → broad global gradients
UMAP → compact local semantic neighborhoods
```

For example, PCA placed several health utterances toward one side of the plot, but UMAP separates healthcare subgroups more clearly and creates a tight financial-legislation neighborhood around `u51`, `u52`, and `u55`.

### Important interpretation

The UMAP axes themselves do not have meanings like:

```text
UMAP 1 = healthcare
UMAP 2 = finance
```

UMAP can rotate, flip, or rearrange its coordinate system in another run. The important information is:

- which points are close;
- which points form local neighborhoods;
- whether the texts in those neighborhoods appear semantically related.

The output also reflects parliamentary session structure. The close financial utterances have nearby IDs and appear to be consecutive contributions in the same debate. Their proximity may therefore reflect both topic similarity and shared conversational context.

The warning about `n_jobs` is harmless: setting `random_state=42` forces UMAP to use one job so that the result is reproducible.