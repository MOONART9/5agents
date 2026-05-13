# Project Structure

## Overview

מפת-על של פרויקט "צוות סוכנים ליצירת תוכן" (`C:\Users\ARIEL\קלוד\סוכנים\`). הפרויקט מנהל צוות של 4 דמויות AI: ראובן (CLAUDE.md, מנכ"ל) + 3 sub-agents (יעל/יובל/חן) שעתידים להיווצר תחת `.claude/agents/`. כרגע השלד מוכן — תיקיות `.claude/agents/` ו-`.claude/commands/` ריקות, ב-`.claude/skills/` הותקנו 14 סקילים מ-Superpowers ועוד 3 מ-Obsidian. נוצר vault תיעוד תחת `vault/`.

## Open Questions

- האם להגדיר slash-commands ב-`.claude/commands/` (`/brief`, `/research`, `/draft`) כקיצורי-דרך לזרימות נפוצות?
- האם להוסיף test end-to-end של flow מלא (חן → יעל → יובל)?
- האם להוסיף slash-commands ב-`.claude/commands/` (למשל `/brief`, `/research`, `/draft`)?
- האם להגדיר hook ב-settings.json שיפעיל `obsidian-vault-workflow` אוטומטית בכל סשן?

## Session Log

### 2026-05-13 — chen agent shipped, team complete [shipped]
- **What was done:** נוצרה חן ([[chen-agent]]) — sub-agent שלישי ואחרון. נוספה תיקייה `chen/Memory/`. עודכן [[claude-md-reuven]] עם flow מלא של 4 הסוכנים יחד.
- **Decisions:** ה-Open Question ההיסטורי "מתי יוגדרו הסוכנים" — נסגר סופית. ה-Open Questions החדשים שמשתחררים: slash commands ו-end-to-end testing.
- **Notes / Caveats:** עץ הסוכנים יציב. השלב הבא הוא לבדוק שהשרשרת באמת רצה — דורש סשן חדש לטעון את כל הסוכנים כ-Agent calls אמיתיים.
- **Related:** [[chen-agent]], [[team-roster]], [[claude-md-reuven]]

### 2026-05-13 — yael agent + working dirs added [shipped]
- **What was done:** נוצרה הסוכנת הראשונה ([[yael-agent]]); נוספו תיקיות עבודה חדשות בשורש: `yael/`, `Content/`, `Output/`. עודכן `CLAUDE.md` של ראובן.
- **Decisions:** תיקיות עבודה (`Content/`, `Output/`, `yael/`) שמורות בשורש הפרויקט ולא תחת `.claude/` — כי הן data של המשתמש, לא קונפיג של Claude Code.
- **Notes / Caveats:** `.gitkeep` נוסף ל-`Content/`, `Output/`, ו-`yael/reference/` כדי לשמר את המבנה ב-Git.
- **Related:** [[yael-agent]], [[team-roster]], [[claude-md-reuven]]

### 2026-05-13 — vault initialization [shipped]
- **What was done:** מופה כל הפרויקט; נוצרו קבצי תיעוד תחת `vault/Meeting Notes/` ו-`vault/Brand Guidelines/`; נוצרו `_index.md` בשני התיקיות.
- **Decisions:** קבצי תשתית חיצוניים (17 סקילים) קובצו לשני topics קיבוציים ([[superpowers-skills]], [[obsidian-skills]]) ולא קובץ-לכל-סקיל — כדי לשמור על vault סקאני. הצוות (4 דמויות) מתועד כ-Brand Guidelines ולא Meeting Notes כי הוא מגדיר זהות ולא הכרעה זמנית.
- **Notes / Caveats:** `.claude/agents/` ו-`.claude/commands/` עדיין ריקים — יתועדו כשייווצר תוכן.
- **Related:** [[claude-md-reuven]], [[env-configuration]], [[gitignore-config]], [[team-roster]], [[superpowers-skills]], [[obsidian-skills]]
