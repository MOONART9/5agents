# .gitignore Configuration

## Overview

`.gitignore` בשורש הפרויקט מגדיר אילו קבצים Git יתעלם מהם. תפקידו הקריטי ביותר: **למנוע העלאה של `.env`** (סודות/מפתחות) ל-GitHub הציבורי [MOONART9/5agents](https://github.com/MOONART9/5agents). בנוסף מסונן: קבצי OS (Thumbs.db, .DS_Store), editors (.vscode, .idea), logs, ותיקיות תלויות (`__pycache__`, `node_modules`, `.venv`). שייך ל: תשתית כללית.

## Open Questions

- האם להוסיף סינון לקבצי build/output כשיהיו (`dist/`, `build/`)?
- האם להוסיף `.claude/settings.local.json` אם נשתמש בו לפר-מכונה?

## Session Log

### 2026-05-13 — initial setup [shipped]
- **What was done:** נוצר `.gitignore` עם 6 קטגוריות: env/secrets, OS, editors, logs, Python, Node.
- **Decisions:** הוחלט להגן לא רק על `.env` הראשי אלא גם על `.env.local` ו-`.env.*.local` — תבנית סטנדרטית מ-Next.js/Vite. תלויות Python+Node נכללו אף שעדיין אין קוד — מונע "שכחה" עתידית.
- **Notes / Caveats:** `.gitignore` עצמו **כן** נכנס ל-Git (נכון ומכוון). אם בעתיד נרצה להוסיף קבצים שכן יישמרו מתוך תיקיות מסוננות, נשתמש ב-`!path/to/file`.
- **Related:** [[env-configuration]], [[project-structure]]
