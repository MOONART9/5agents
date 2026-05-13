# Environment Configuration

## Overview

שני קבצים מנהלים משתני סביבה ומפתחות API בפרויקט: **`.env`** (הקובץ המקומי עם הערכים האמיתיים — לא עולה ל-Git) ו-**`.env.example`** (תבנית עם placeholders — כן עולה ל-Git כדי שכל מי שמתחבר לפרויקט ידע אילו מפתחות נדרשים). המשתנים המוגדרים נכון לעכשיו: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `IMAGE_API_KEY` (ליובל), `SEARCH_API_KEY` (לחן), `PROJECT_NAME`, `ENVIRONMENT`. שייך ל: תשתית כללית של ראובן והצוות.

## Open Questions

- אילו ספקים ספציפיים לחן? (Tavily vs Serper vs Perplexity)
- האם להסיר את `IMAGE_API_KEY` מ-`.env.example` עכשיו שיובל עובד עם OpenAI? (משאיר ב-`.env.example` כ-placeholder לחלופה עתידית)
- האם להוסיף משתנים לסוכן חן שעוד לא קיים?

## Session Log

### 2026-05-13 — OPENAI_API_KEY upgraded to mandatory [shipped]
- **What was done:** ההערה ב-`.env.example` עבור `OPENAI_API_KEY` שונתה מ"אופציונלי" ל"חובה — יובל משתמש ב-gpt-image-2 ליצירת תמונות". `IMAGE_API_KEY` הושאר כ-placeholder לחלופה עתידית עם הערה שיובל עובד כרגע עם OpenAI.
- **Decisions:** לא הסרתי את `IMAGE_API_KEY` כדי לא לשבור setups קיימים אם המשתמש כבר מילא ערך. שינוי הערה בלבד.
- **Notes / Caveats:** `.env` עצמו לא הועלה (gitignored). המשתמש צריך להוסיף את ה-key בעצמו לפני שיובל יוכל לפעול.
- **Related:** [[gpt-image-gen-skill]], [[yuval-agent]]

### 2026-05-13 — initial setup [shipped]
- **What was done:** נוצרו `.env` ו-`.env.example` עם placeholders ל-4 מפתחות API + 2 משתנים כלליים. הוספה הגנה ב-`.gitignore`.
- **Decisions:** placeholders ניתנו לפי השיוך הלוגי לסוכנים (IMAGE→יובל, SEARCH→חן) ולא לפי ספקים ספציפיים — להשאיר גמישות. שמות הספקים נכתבו כהערות.
- **Notes / Caveats:** הקובץ `.env` המקומי ריק מערכים — צריך למלא ידנית. אם נוסיף ספק חדש, יש לעדכן את שני הקבצים בו-זמנית.
- **Related:** [[gitignore-config]], [[project-structure]], [[team-roster]]
