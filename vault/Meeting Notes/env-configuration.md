# Environment Configuration

## Overview

שני קבצים מנהלים משתני סביבה ומפתחות API בפרויקט: **`.env`** (הקובץ המקומי עם הערכים האמיתיים — לא עולה ל-Git) ו-**`.env.example`** (תבנית עם placeholders — כן עולה ל-Git כדי שכל מי שמתחבר לפרויקט ידע אילו מפתחות נדרשים). המשתנים המוגדרים נכון לעכשיו: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `IMAGE_API_KEY` (ליובל), `SEARCH_API_KEY` (לחן), `PROJECT_NAME`, `ENVIRONMENT`. שייך ל: תשתית כללית של ראובן והצוות.

## Open Questions

- אילו ספקים ספציפיים נשתמש בפועל? (Replicate vs DALL-E ליובל; Tavily vs Serper לחן)
- האם להוסיף משתנים לסוכן מסוים שעוד לא קיים?

## Session Log

### 2026-05-13 — initial setup [shipped]
- **What was done:** נוצרו `.env` ו-`.env.example` עם placeholders ל-4 מפתחות API + 2 משתנים כלליים. הוספה הגנה ב-`.gitignore`.
- **Decisions:** placeholders ניתנו לפי השיוך הלוגי לסוכנים (IMAGE→יובל, SEARCH→חן) ולא לפי ספקים ספציפיים — להשאיר גמישות. שמות הספקים נכתבו כהערות.
- **Notes / Caveats:** הקובץ `.env` המקומי ריק מערכים — צריך למלא ידנית. אם נוסיף ספק חדש, יש לעדכן את שני הקבצים בו-זמנית.
- **Related:** [[gitignore-config]], [[project-structure]], [[team-roster]]
