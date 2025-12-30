# Markdown & Obsidian Complete Reference

## Basic Markdown Syntax

### Text Formatting
````markdown
*italic* or _italic_
**bold** or __bold__
***bold and italic***
~~strikethrough~~
==highlight== (Obsidian)
`inline code`
````

### Headings
````markdown
# H1 - Main title
## H2 - Section
### H3 - Subsection
#### H4 - Sub-subsection
##### H5 - Minor heading
###### H6 - Smallest heading
````

### Lists

**Unordered:**
````markdown
- Item 1
- Item 2
  - Nested item
  - Another nested
- Item 3
````

**Ordered:**
````markdown
1. First item
2. Second item
   1. Nested numbered
   2. Another nested
3. Third item
````

**Task Lists:**
````markdown
- [ ] Unchecked task
- [x] Completed task
- [>] Forwarded (Obsidian)
- [<] Scheduled (Obsidian)
- [-] Cancelled (Obsidian)
````

### Links and Images

**External Links:**
````markdown
[Link text](https://example.com)
[Link with title](https://example.com "Hover title")
<https://auto-link.com>
````

**Internal Links (Obsidian):**
````markdown
[[Note name]]
[[Note name|Display text]]
[[Note name#Heading]]
[[Note name#^block-id]]
````

**Images:**
````markdown
![Alt text](image.png)
![Alt text](image.png "Image title")
![[image.png]] (Obsidian)
![[image.png|200]] (Resize in Obsidian)
````

### Code

**Inline code:**
````markdown
Use `code` for inline code
````

**Code blocks:**
````markdown
```python
def hello():
    print("Hello, world!")
```
````

### Tables
````markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |

Alignment:
| Left | Center | Right |
|:-----|:------:|------:|
| L    |   C    |     R |
````

### Blockquotes
````markdown
> Single quote

>> Nested quote

> Multi-line
> quote here
````

## Obsidian-Specific Features

### Callouts
````markdown
> [!note]
> This is a note callout

> [!info]
> This is an info callout

> [!tip]
> This is a tip callout

> [!warning]
> This is a warning callout

> [!danger]
> This is a danger callout

> [!question]
> This is a question callout

> [!success]
> This is a success callout

> [!example]
> This is an example callout

> [!quote]
> This is a quote callout

Modifiers:
> [!note]+ 
> Expanded by default

> [!note]-
> Collapsed by default
````

### Embedding
````markdown
![[Other note]]               # Embed entire note
![[Other note#Section]]       # Embed section
![[Other note#^block-id]]     # Embed block
![[image.png]]                # Embed image
![[document.pdf]]             # Embed PDF
````

### Tags
````markdown
#simple-tag
#nested/tag/structure
#CamelCaseTag
````

### Frontmatter (YAML)
````markdown
---
title: My Note
date: 2024-12-28
tags: [tag1, tag2, tag3]
author: Your Name
status: draft
aliases: [Alternative Name, Another Name]
---
````

### Block References
````markdown
This is a paragraph ^block-id

Reference it: ![[Note#^block-id]]
````

### Comments
````markdown
%% This comment won't appear in preview %%

%%
Multi-line
comment
%%
````

## Obsidian Workflow Examples

### Daily Note Template
````markdown
---
date: {{date}}
tags: [daily-note]
---

# {{date:YYYY-MM-DD}}

## Tasks
- [ ] 

## Notes


## Meetings


## Tomorrow
- [ ] 

## Journal
````

### Project Template
````markdown
---
title: {{title}}
created: {{date}}
status: active
tags: [project]
---

# {{title}}

## Overview


## Goals
- 

## Tasks
- [ ] 

## Resources
- [[]]

## Timeline


## Notes
````

### Meeting Notes Template
````markdown
---
date: {{date}}
attendees: []
tags: [meeting]
---

# Meeting: {{title}}

**Date:** {{date}}
**Attendees:** 

## Agenda
1. 

## Discussion


## Action Items
- [ ] 

## Decisions


## Next Meeting
````

## Dataview Examples (Plugin)

### List all tasks
````dataview
TASK
FROM #project
WHERE !completed
````

### Table of notes
````dataview
TABLE file.mtime as "Last Modified", status
FROM #project
SORT file.mtime DESC
````

### List by tag
````dataview
LIST
FROM #meeting
WHERE date >= date(today) - dur(7 days)
SORT date DESC
````

### Count notes
````dataview
TABLE length(file.inlinks) as "Backlinks"
FROM ""
SORT length(file.inlinks) DESC
LIMIT 10
````

## Mermaid Diagram Examples

### Flowchart
````mermaid
graph TD
    A[Start] --> B{Is it working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug]
    D --> B
    C --> E[End]
````

### Sequence Diagram
````mermaid
sequenceDiagram
    participant User
    participant System
    User->>System: Request
    System->>System: Process
    System->>User: Response
````

### Gantt Chart
````mermaid
gantt
    title Project Timeline
    dateFormat YYYY-MM-DD
    section Planning
    Research: 2024-01-01, 7d
    Design: 2024-01-08, 5d
    section Development
    Development: 2024-01-15, 14d
    Testing: 2024-01-29, 7d
````

## Best Practices

### Note-Taking

1. **Atomic Notes** - One idea per note
2. **Descriptive Titles** - Clear, searchable names
3. **Link Generously** - Connect related ideas
4. **Use Tags Sparingly** - Too many = useless
5. **Regular Review** - Update and connect notes

### Organization

1. **PARA Method**
   - Projects: Active, deadline-driven
   - Areas: Ongoing responsibilities
   - Resources: Reference material
   - Archives: Completed items

2. **Zettelkasten**
   - Fleeting notes → Literature notes → Permanent notes
   - Link notes together
   - Use unique IDs

3. **Johnny Decimal System**
   - 10-19 Administration
   - 20-29 Finance
   - 30-39 Projects
   - etc.

### Linking Strategy

- **Bottom-up**: Create notes, link as you go
- **Top-down**: Create structure notes (MOCs)
- **Hub notes**: Central notes that link to related topics
- **Use backlinks**: See what links to current note

## Keyboard Shortcuts Quick Reference

| Action | Shortcut |
|--------|----------|
| Quick switcher | `Ctrl/Cmd + O` |
| Command palette | `Ctrl/Cmd + P` |
| Search in file | `Ctrl/Cmd + F` |
| Search all files | `Ctrl/Cmd + Shift + F` |
| Toggle edit/preview | `Ctrl/Cmd + E` |
| Insert link | `Ctrl/Cmd + K` |
| Bold | `Ctrl/Cmd + B` |
| Italic | `Ctrl/Cmd + I` |
| Graph view | `Ctrl/Cmd + G` |
| Navigate back | `Ctrl/Cmd + Alt + ←` |
| Navigate forward | `Ctrl/Cmd + Alt + →` |
| Toggle checkbox | `Ctrl/Cmd + Enter` |

