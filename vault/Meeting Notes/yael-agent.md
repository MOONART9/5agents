# Yael Agent — כותבת התוכן

## Overview

יעל היא ה-sub-agent הראשונה שנוצרה בצוות של ראובן (מתוך 3 מתוכננים: יעל, יובל, חן). הסוכנת מוגדרת ב-`.claude/agents/yael.md` עם YAML frontmatter (name=yael, tools=Read/Write/Edit/Glob/Grep) ו-system prompt בעברית. תפקידה: לשכתב מאמרי גלם מ-`Content/` בסגנון הפרויקט, ולשמור Markdown + HTML ב-`Output/`. המקור לסגנון: `yael/style-guide.md` ו-`yael/reference/` — שניהם stubs ריקים בשלב זה, ממתינים למילוי ע"י המשתמשת. סטטוס: **shipped (מוגדרת ופעילה)**.

## Open Questions

- מה יהיו תכני `yael/style-guide.md` ו-`yael/reference/` בפועל? (ממתין למילוי)
- האם הטמפלייט HTML שהוטמע (RTL, גופן עברי, max-width 720px) מתאים לסגנון העיצובי שלך, או שצריך לעדכן אותו?
- האם להוסיף תמיכה גם בקבצי `.txt` ו-`.html` ב-`Content/` או רק `.md`?

## Session Log

### 2026-05-13 — initial creation [shipped]
- **What was done:** נוצרו 5 קבצים: `.claude/agents/yael.md` (סוכן מלא עם 5-step flow), `yael/style-guide.md` (stub), `yael/reference/.gitkeep`, `Content/.gitkeep`, `Output/.gitkeep`. עודכן `CLAUDE.md` של ראובן עם trigger keywords דו-לשוניים, קבצים שייכים, ויכולות/אי-יכולות של יעל.
- **Decisions:**
  - **תיאור הסוכן (description)** נכתב דו-לשוני (עברית + אנגלית) כדי שאוטומציית ההפעלה תזהה את שני סוגי הטריגרים.
  - **HTML template** הוטמע ישירות בסוכן כברירת מחדל (RTL, אסתטיקה נקייה) במקום קובץ נפרד — חוסך readbacks ומשאיר את ההגדרה בכיס היכן שצריך אותה. אם `style-guide.md` יגדיר תבנית אחרת, היא גוברת.
  - **כללי מותר/אסור** נקבעו במפורש בגוף הסוכן (ולא רק ב-frontmatter) — מחזק את ההגנה נגד הוספת CTAs/קישורים של המחבר המקורי.
- **Notes / Caveats:** `style-guide.md` ו-`reference/` ריקים — יעל תפעל במצב "best-effort" ותדווח על כך לראובן עד שיתמלאו. יובל וחן עדיין לא נוצרו (Open Question של [[project-structure]] רק חלקית סגור).
- **Related:** [[team-roster]], [[claude-md-reuven]], [[project-structure]]
