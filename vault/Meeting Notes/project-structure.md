# Project Structure

## Overview

מפת-על של פרויקט "צוות סוכנים ליצירת תוכן" (`C:\Users\ARIEL\קלוד\סוכנים\`). הפרויקט מנהל צוות של 4 דמויות AI: ראובן (CLAUDE.md, מנכ"ל) + 3 sub-agents (יעל/יובל/חן) שעתידים להיווצר תחת `.claude/agents/`. כרגע השלד מוכן — תיקיות `.claude/agents/` ו-`.claude/commands/` ריקות, ב-`.claude/skills/` הותקנו 14 סקילים מ-Superpowers ועוד 3 מ-Obsidian. נוצר vault תיעוד תחת `vault/`.

## Open Questions

- מתי יוגדרו 3 הסוכנים בפועל (`.claude/agents/{yael,yuval,chen}.md`)?
- האם להוסיף slash-commands ב-`.claude/commands/` (למשל `/brief`, `/research`, `/draft`)?
- האם להגדיר hook ב-settings.json שיפעיל `obsidian-vault-workflow` אוטומטית בכל סשן?

## Session Log

### 2026-05-13 — vault initialization [shipped]
- **What was done:** מופה כל הפרויקט; נוצרו קבצי תיעוד תחת `vault/Meeting Notes/` ו-`vault/Brand Guidelines/`; נוצרו `_index.md` בשני התיקיות.
- **Decisions:** קבצי תשתית חיצוניים (17 סקילים) קובצו לשני topics קיבוציים ([[superpowers-skills]], [[obsidian-skills]]) ולא קובץ-לכל-סקיל — כדי לשמור על vault סקאני. הצוות (4 דמויות) מתועד כ-Brand Guidelines ולא Meeting Notes כי הוא מגדיר זהות ולא הכרעה זמנית.
- **Notes / Caveats:** `.claude/agents/` ו-`.claude/commands/` עדיין ריקים — יתועדו כשייווצר תוכן.
- **Related:** [[claude-md-reuven]], [[env-configuration]], [[gitignore-config]], [[team-roster]], [[superpowers-skills]], [[obsidian-skills]]
