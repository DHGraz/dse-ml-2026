# Presentation: Text Embeddings

## Interaktive Slideshow starten

Die live ausführbare Präsentation benötigt einen laufenden Jupyter-Kernel. Im Projektverzeichnis PowerShell öffnen und die klassische Notebook-Oberfläche starten:

```powershell
& "C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\.venv\Scripts\python.exe" `
  -m jupyter nbclassic `
  --notebook-dir="C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\slideset"
```

Im Browser `presentation_embeddings.ipynb` öffnen. Über **View → Cell Toolbar → Slideshow** die Zelltypen festlegen und anschließend das RISE-Symbol (**Enter/Exit RISE Slideshow**) verwenden. Zellen können während der Präsentation mit `Shift+Enter` ausgeführt werden.

## Statischer HTML-Export

Dieser Export benötigt keinen laufenden Kernel. Für eine Präsentation mit den aktuellen gespeicherten Outputs:

```powershell
cd "C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\slideset"

& "C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\.venv\Scripts\python.exe" `
  -m jupyter nbconvert presentation_embeddings.ipynb `
  --to slides `
  --output presentation_embeddings_slides
```

Die Datei `presentation_embeddings_slides.slides.html` anschließend im Browser öffnen.

Mit `--execute` werden die Notebook-Zellen vor dem Export erneut ausgeführt:

```powershell
& "C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\.venv\Scripts\python.exe" `
  -m jupyter nbconvert presentation_embeddings.ipynb `
  --to slides `
  --execute `
  --ExecutePreprocessor.timeout=600 `
  --output presentation_embeddings_slides
```

## PDF exportieren

### PDF aus der Slideshow drucken

Die zuverlässigste Variante für das Folienlayout ist der Browser:

1. Die interaktive Slideshow oder die HTML-Datei öffnen.
2. `Strg+P` drücken.
3. Als Drucker **Als PDF speichern** auswählen.
4. Hintergrundgrafiken aktivieren, falls die Folien Gestaltungselemente enthalten.

### PDF mit nbconvert erzeugen

Für einen direkten Export als PDF kann LaTeX erforderlich sein:

```powershell
& "C:\Users\mjantscher\PycharmProjects\clariah_summer_school\dse-ml-2026\materials\2026-09-22_tuesday\05_jantscher_embeddings\.venv\Scripts\python.exe" `
  -m jupyter nbconvert presentation_embeddings.ipynb `
  --to pdf `
  --output presentation_embeddings
```

Der direkte PDF-Export erzeugt ein Notebook-PDF und übernimmt das Reveal.js-Folienlayout nicht immer vollständig. Für das Präsentationslayout daher bevorzugt die Browser-Druckfunktion verwenden.
 