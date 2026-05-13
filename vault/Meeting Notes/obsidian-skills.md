# Obsidian Skills

## Overview

3 סקילי Obsidian שהותקנו ב-`.claude/skills/`. מאפשרים לראובן וצוותו לעבוד עם vault של Obsidian — לכתוב תיעוד מקושר, להגדיר תצוגות database-like, ובעיקר **לאכוף פרוטוקול קריאה/כתיבה לזיכרון ארוך-טווח** של הפרויקט (ה-vault הזה בעצמו). שייך ל: ראובן + כל הצוות (כלי אופקי, חובת שימוש).

## Open Questions

- האם להגדיר hook ב-`.claude/settings.json` שיפעיל `obsidian-vault-workflow` אוטומטית ב-SessionStart וב-UserPromptSubmit?
- האם להוסיף `.base` file לטבלת מעקב על כל ה-topics?

## Session Log

### 2026-05-13 — discovered and adopted [shipped]
- **What was done:** זוהו 3 סקילי Obsidian קיימים תחת `.claude/skills/`, נקראו במלואם, וה-vault הזה (`vault/`) הוקם לפי הפרוטוקול של `obsidian-vault-workflow`.
- **Decisions:** ה-vault יחיה תחת `vault/` בשורש הפרויקט (לפי הקונבנציה של הסקיל). תיקיות שהוגדרו: `Meeting Notes/`, `Brand Guidelines/`. `Content Briefs/` ו-`Publishing Log/` ייווצרו ב-first use.
- **Notes / Caveats:** שלושת הסקילים:
  - `obsidian-vault-workflow` — **חובת שימוש**. מגדיר פרוטוקול: לפני כל משימה לקרוא topic file + Meeting Notes אחרונים; אחרי כל משימה לעדכן Overview + Open Questions + לצרף Session Log entry עם status tag + wikilinks.
  - `obsidian-markdown` — תחביר Obsidian: `[[wikilinks]]`, embeds `![[...]]`, callouts `> [!note]`, properties (frontmatter), tags, callouts, math, mermaid, footnotes.
  - `obsidian-bases` — קבצי `.base` (YAML) שיוצרים תצוגות database (table/cards/list/map) עם filters, formulas, ו-summaries.
- **Related:** [[project-structure]], [[superpowers-skills]]
