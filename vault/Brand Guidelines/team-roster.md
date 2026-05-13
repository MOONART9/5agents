# Team Roster — 4 הדמויות

## Overview

הצוות בפרויקט מורכב מ-4 דמויות AI עם תפקידים מובחנים. **ראובן** הוא המנכ"ל שמקבל בקשות מהמשתמש ומנתב; שלושת ה-sub-agents (יעל, יובל, חן) הם מומחי-תחום שראובן מפעיל לפי צורך. ראובן חי בקובץ `CLAUDE.md` בשורש. **יעל** קיימת תחת `.claude/agents/yael.md` עם תיקיית עבודה ב-`yael/`. **יובל** ו-**חן** עדיין לא נוצרו.

## Open Questions

- האם להוסיף דמות חמישית בעתיד (למשל אסטרטג/בודק איכות)?
- מה הסגנון הוויזואלי/קולי של כל דמות? (לא הוגדר עדיין)
- מה מודל המקור של כל sub-agent? (sonnet/opus/haiku — תלוי במשימה)

## Session Log

### 2026-05-13 — yael agent shipped [shipped]
- **What was done:** יעל הוגדרה בפועל ב-`.claude/agents/yael.md` — סטטוס שלה עבר מ"עתידי" ל"קיים". CLAUDE.md של ראובן עודכן בהתאם (trigger keywords, יודעת/לא יודעת).
- **Decisions:** יעל קיבלה תיקיית עבודה משלה (`yael/`) שמופרדת מ-`.claude/agents/` — כי תוכן הסגנון (style-guide + reference) הוא תוכן-תוכן ולא הגדרת-סוכן. עיקרון: `.claude/agents/<x>.md` מגדיר את ה-*איך*, התיקייה `<x>/` מכילה את ה-*מה*.
- **Notes / Caveats:** יובל וחן עדיין לא נוצרו — Overview עודכן בהתאם.
- **Related:** [[yael-agent]], [[claude-md-reuven]], [[project-structure]]

### 2026-05-13 — initial roster [shipped]
- **What was done:** הוגדרו 4 הדמויות והשיוך שלהן לקבצים ולתחומי אחריות.
- **Decisions:**
  - **ראובן** (מנכ"ל) → `CLAUDE.md` בשורש. מקבל בקשות, מבין כוונה, מנתב.
  - **יעל** (כותבת תוכן) → עתידית: `.claude/agents/yael.md`. אחראית: ניסוח, סגנון, עריכה.
  - **יובל** (מעצב תמונות) → עתידית: `.claude/agents/yuval.md`. אחראית: ויזואל, יצירת תמונות. משתמש ב-`IMAGE_API_KEY`.
  - **חן** (חוקרת) → עתידית: `.claude/agents/chen.md`. אחראית: מחקר, בדיקת עובדות. משתמשת ב-`SEARCH_API_KEY`.
- **Notes / Caveats:** השמות בעברית נבחרו במכוון. אין עדיין הוראות פרסונה מפורטות לכל דמות — רק תפקיד.
- **Related:** [[claude-md-reuven]], [[env-configuration]], [[project-structure]]
