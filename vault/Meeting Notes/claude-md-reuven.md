# CLAUDE.md — ראובן (מנכ"ל הצוות)

## Overview

`CLAUDE.md` בשורש הפרויקט הוא ה"מוח" של **ראובן**, מנכ"ל הצוות. זהו קובץ ההקשר שנטען אוטומטית בכל סשן של Claude Code בפרויקט הזה — הוא מגדיר את הזהות של ראובן, את הצוות שתחתיו (יעל/יובל/חן), ואת מבנה התיקיות תחת `.claude/`. כרגע הוא במצב **ראשוני** — בלי הוראות ניתוב מפורטות. שייך ל: ראובן.

## Open Questions

- להוסיף ל-CLAUDE.md הוראות ניתוב ברורות (מתי להפעיל איזה sub-agent)?
- האם להפנות מ-CLAUDE.md אל ה-vault (`vault/`) כקריאת חובה?

## Session Log

### 2026-05-13 — added chen block + full chen→yael→yuval workflow [shipped]
- **What was done:** הוסף בלוק חן (מ"עתידי" ל"קיים") עם trigger keywords ושיוך קבצים. הוסף section "מחקר → תוכן → תמונות" שמתאר את ה-flow המלא של 4 הסוכנים: חן מביאה מקור → ראובן מחליט אם להמשיך → יעל כותבת + placeholders → יובל יוצר תמונות → ראובן משלב. הוסף `chen/` לעץ התיקיות.
- **Decisions:** ראובן הוא **התאמן היחיד**. אף sub-agent לא קורא ישירות לאחר — הכל עובר דרכי. יתרון: שליטה, debug, ויכולת לעצור באמצע.
- **Notes / Caveats:** ה-flow המלא טרם נבדק end-to-end (חן → יעל → יובל). הסבב הבא — סשן חדש עם בקשה אמיתית מהמשתמש.
- **Related:** [[chen-agent]], [[yael-agent]], [[yuval-agent]]

### 2026-05-13 — added yael→yuval workflow + yuval agent block [shipped]
- **What was done:** הוסף section "תהליכי עבודה" עם flow מלא של מאמר+תמונות (7 שלבים). הוחלף בלוק יובל מ"עתידי" ל"קיים" עם trigger keywords ושיוך קבצים. שודרג section "מבנה התיקיות" — הסבר על `.claude/`, תיקיות עבודה בשורש (`Content/`, `Output/`, `yael/`, `yuval/`, `vault/`).
- **Decisions:** ה-workflow מתאר תהליך אסינכרוני: יעל מסמנת placeholders → ראובן מקבל רשימה → ראובן מפעיל את יובל פעם אחת לכל placeholder → ראובן משלב (כולל copy מ-`yuval/outputs/` ל-`Output/images/`). זה מבטיח self-contained Output ו-debug-ability.
- **Notes / Caveats:** כשהמשתמש יבקש מאמר עם תמונות — צריך להריץ end-to-end test ולוודא שהשרשרת באמת עובדת. סשן הבא ייטען את הסוכנים החדשים אוטומטית.
- **Related:** [[yael-agent]], [[yuval-agent]], [[gpt-image-gen-skill]]

### 2026-05-13 — initial creation [shipped]
- **What was done:** נכתב הקובץ בעברית עם 5 חלקים: הצגה עצמית, תיאור פרויקט, רשימת צוות, מבנה תיקיות, הערת המשך.
- **Decisions:** בוצע בגוף ראשון ("אני ראובן…") כדי לחזק את הפרסונה. בכוונה לא נוספו הוראות ניתוב — נשמר לסבב הבא.
- **Notes / Caveats:** הצוות (יעל/יובל/חן) מוזכר אבל לא קיים עדיין כקבצים תחת `.claude/agents/`.
- **Related:** [[team-roster]], [[project-structure]]
