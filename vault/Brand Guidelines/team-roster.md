# Team Roster — 4 הדמויות

## Overview

הצוות בפרויקט מורכב מ-4 דמויות AI עם תפקידים מובחנים. **ראובן** הוא המנכ"ל שמקבל בקשות מהמשתמש ומנתב; שלושת ה-sub-agents (יעל, יובל, חן) הם מומחי-תחום שראובן מפעיל לפי צורך. ראובן חי בקובץ `CLAUDE.md` בשורש. **יעל** קיימת תחת `.claude/agents/yael.md` עם תיקיית עבודה ב-`yael/`. **יובל** קיים תחת `.claude/agents/yuval.md` עם תיקיית עבודה ב-`yuval/` וסקיל ייעודי `.claude/skills/gpt-image-gen/`. **חן** עדיין לא נוצרה.

## Open Questions

- האם להוסיף דמות חמישית בעתיד (למשל אסטרטג/בודק איכות)?
- מה הסגנון הוויזואלי/קולי של כל דמות? (לא הוגדר עדיין)
- מה מודל המקור של כל sub-agent? (sonnet/opus/haiku — תלוי במשימה)

## Session Log

### 2026-05-13 — yuval agent shipped + yael-yuval handoff defined [shipped]
- **What was done:** יובל הוגדר ב-`.claude/agents/yuval.md` — סטטוס עבר מ"עתידי" ל"קיים". סקיל `gpt-image-gen` נוצר ([[gpt-image-gen-skill]]). יעל עודכנה לזהות מקומות לתמונות ולהשתיל `{{IMAGE_NEEDED}}` placeholders. ראובן עודכן עם שרשרת עבודה מלאה: יעל → רשימת placeholders → יובל לכל אחד → ראובן משלב ב-MD/HTML → גרסה סופית ב-`Output/`.
- **Decisions:** הצוות בנוי **תקשורת אסינכרונית**: יעל לא קוראת ליובל ישירות (אין לה Bash), במקום זה מחזירה רשימה לראובן שמתאם. יתרון: הפרדה נקייה של אחריות, debugging קל יותר, אפשרות לראובן לעצור/לערוך לפני יצירת תמונות.
- **Notes / Caveats:** רק חן נשארה. שני הסוכנים החדשים לא נטענים כ-sub-agents בסשן הזה (נוצרו עתה) — בסשן הבא הם זמינים דרך Agent tool.
- **Related:** [[yuval-agent]], [[yael-agent]], [[gpt-image-gen-skill]], [[claude-md-reuven]]

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
