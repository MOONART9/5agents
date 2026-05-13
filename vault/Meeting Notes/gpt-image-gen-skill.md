# gpt-image-gen Skill

## Overview

סקיל מותאם תחת `.claude/skills/gpt-image-gen/` שמהווה מעטפת ל-OpenAI Images API. מקבל `prompt + output_path + size + quality` ושומר PNG. המודל הקבוע: **`gpt-image-2`** (יצא 21.04.2026 — אחרי cutoff Aug 2025 של הזיכרון הפנימי, לא לשנות גם אם משהו נראה לא-מוכר). הסקיל מורכב משני קבצים: `SKILL.md` (תיעוד + 2 תבניות) ו-`run.sh` (סקריפט הרצה עם fallback python/jq). הצרכן העיקרי: [[yuval-agent]]. שייך ל: יובל + כל סוכן עתידי שצריך לייצר תמונה.

## Open Questions

- האם להוסיף תמיכה ב-image editing (לא רק generation) — endpoint נפרד `/v1/images/edits`?
- האם להוסיף retry logic ל-rate limit (429)?
- האם להוסיף parameter ל-`n` (יותר מתמונה אחת בקריאה)?

## Session Log

### 2026-05-13 — PowerShell fallback added + first successful API run [shipped]
- **What was done:** ה-`run.sh` עודכן כך ש-PowerShell יהיה ה-tool המועדף (לפני python ו-jq), כי בסביבת Windows הזה Python הוא MS Store stub ו-jq חסר. הופעלה בהצלחה 5 פעמים על המאמר CRM — כל הקריאות החזירו PNG.
- **Decisions:**
  - **PowerShell המועדף**: `Invoke-RestMethod` + `[Convert]::FromBase64String` + `[IO.File]::WriteAllBytes` — שלשה מובנית שלא דורשת dependencies.
  - **cygpath**: ה-script ממיר נתיב bash ל-Windows לפני העברה ל-PowerShell, כדי שזה יעבוד ב-Git Bash. אם cygpath לא קיים — נשאר עם הנתיב המקורי.
  - **`python_works()` helper**: בדיקה שmenuvalא רק `command -v python` עוברת אלא גם `python -c "print(1)"` באמת רץ. מונע lock על stub של MS Store.
- **Notes / Caveats:**
  - **`gpt-image-2` עובד**: 5/5 קריאות החזירו תמונות תקינות (1.1–2.1 MB כל אחת). אישור חי שהמודל זמין.
  - PowerShell `Invoke-RestMethod` יש לו timeout ברירת מחדל; הוגדר 120s. ייתכן שעבור high quality יהיה צריך להעלות.
- **Related:** [[crm-article-rewrite]], [[yuval-agent]]

### 2026-05-13 — initial creation [shipped]
- **What was done:** נוצרו `.claude/skills/gpt-image-gen/SKILL.md` ו-`run.sh`. הסקיל מתועד עם 2 תבניות (jq/python), טבלת פרמטרים, וטיפול בשגיאות נפוצות.
- **Decisions:**
  - **python קודם, jq fallback**: `run.sh` בודק תחילה `command -v python`, ורק אם אין נופל ל-jq. סיבה: Git Bash על Windows לא מגיע עם jq, אבל python כן זמין דרך Claude Code.
  - **`.env` נטען עם `set -a; . <(grep ...); set +a`**: בטוח יותר מ-`export $(grep ...)` כי לא נופל על ערכים עם רווחים/תווים מיוחדים.
  - **error reporting מפורט**: אם b64_json חסר או יש `error` בתגובה — מדפיס את התגובה המלאה ל-stderr (500 תווים ראשונים). מקל על debug.
  - **size defaults**: `1024x1024` כברירת מחדל. תיעדתי שני גדלים מקצועיים נוספים: `1536x1024` (landscape) ו-`1024x1536` (portrait).
- **Notes / Caveats:**
  - **קריטי**: שם המודל הוא `gpt-image-2`. הזיכרון הפנימי עלול לחשוב שזה DALL-E או gpt-image-1 ולהציע "תיקון" — אסור. המשתמש הדגיש שהמודל אמיתי וזמין מ-21.04.2026.
  - `OUTPUT_PATH` יוצר תיקיות אם הן חסרות (`mkdir -p`).
  - הסקריפט לא מבצע retry על 429 — איטרציה עתידית.
- **Related:** [[yuval-agent]], [[env-configuration]], [[superpowers-skills]], [[obsidian-skills]]
