# Yuval Agent — מעצב התמונות

## Overview

יובל הוא ה-sub-agent השני שנוצר בצוות של ראובן (אחרי יעל). מוגדר ב-`.claude/agents/yuval.md` עם כלים `Read, Write, Bash, Glob` — Bash דרוש כדי לקרוא לסקיל `gpt-image-gen`. ה-flow שלו: סריקת `yuval/reference/` (אם לא ריקה) → חילוץ סגנון/פלטה/קומפוזיציה → ניסוח prompt באנגלית → קריאה לסקיל `gpt-image-gen` → שמירת PNG + sibling `.txt` עם ה-prompt ב-`yuval/outputs/`. המטרה העליונה: **עקביות ויזואלית בין כל התמונות שיוצאות מהפרויקט**. שייך ל: ראובן + שרשרת עבודה משולבת עם [[yael-agent]].

## Open Questions

- מה יהיה ב-`yuval/reference/` בפועל? (תיקייה ריקה כרגע; יובל יעבוד ב-best-effort עם סגנון מינימליסטי-נקי)
- האם בחירת המודל `gpt-image-2` נכונה לסגנון של מונה? צריך לעשות test run ראשון אחרי שיהיו references.
- האם להגדיר OUTPUT format נוסף (webp) לחיסכון בגודל?

## Session Log

### 2026-05-13 — initial creation [shipped]
- **What was done:** נוצרו: `.claude/agents/yuval.md` (סוכן מלא, 6-step flow + slug rules + prompt template), `.claude/skills/gpt-image-gen/SKILL.md` ו-`run.sh` (מעטפת ל-OpenAI Images API עם `gpt-image-2`), `yuval/reference/.gitkeep`, `yuval/outputs/.gitkeep`. עודכן [[claude-md-reuven]] עם section תהליך-עבודה מלא Yael→Yuval→Reuven.
- **Decisions:**
  - **מודל קבוע**: `gpt-image-2` בלבד. הסקיל מתעד מפורשות **לא** להציע אלטרנטיבות גם אם נראה שגיאה — המודל יצא 21.04.2026, אחרי cutoff של הזיכרון הפנימי. שגיאות 400 על model = לבדוק key/parameters לא לשנות model.
  - **prompts באנגלית**: יובל מתרגם תיאורים עבריים לאנגלית לפני שליחה ל-API, גם אם הבקשה הגיעה בעברית — תוצאות איכותיות יותר.
  - **sibling .txt**: כל PNG מלווה ב-.txt עם ה-prompt המדויק. מאפשר איטרציה — אם תוצאה לא מוצלחת, אפשר לערוך את ה-.txt ולהריץ שוב.
  - **slug באנגלית בלבד**: גם אם הבקשה בעברית — שמות קבצים תמיד באנגלית lowercase-hyphenated, עד 40 תווים. מונע בעיות path בכל OS.
  - **fallback python/jq**: `run.sh` בודק תחילה python (נפוץ יותר), נופל ל-jq, ומפסיק אם אף אחד לא קיים. בחירה: python קודם כי Claude Code מגיע עם python בסביבה.
- **Notes / Caveats:**
  - `yuval/reference/` ריק — מצב best-effort עד שיתמלא.
  - הסוכן לא נטען כ-sub-agent בסשן הנוכחי (נוצר זה עתה) — יעלה בסשן הבא.
  - `gpt-image-gen` קורא `OPENAI_API_KEY` מ-`.env`. אם המפתח חסר/ריק, הסקיל יחזיר ERROR ויובל ידווח לראובן בלי לנסות שוב.
- **Related:** [[yael-agent]], [[gpt-image-gen-skill]], [[claude-md-reuven]], [[team-roster]], [[env-configuration]]
