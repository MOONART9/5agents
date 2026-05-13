# CRM Article — Rewrite

## Overview

שכתוב ראשון בפרויקט: מאמר על "מה זה CRM" מ-`Content/מאמר CRM.txt` (15.6KB, עברית, סגנון דיבורי-אישי) → שני קבצים ב-`Output/`: `מאמר CRM.md` ו-`מאמר CRM.html`. בוצע במצב **best-effort** כי `yael/style-guide.md` ו-`yael/reference/` ריקים. מקור המאמר: יועץ CRM ישראלי בעל סטודנטים — הוסרו רכיבי קידום עצמי (CTA לכתיבה אליו, שתילת שם פרטי כ"דוגמת לקוח"); נשמרו אנקדוטות וסיפורים אישיים שאמיתיים לתוכן (סיפור הפיצה בשוהם). מותגים בתוך הסיפור (Make, WhatsApp, Google Drive) נשמרו.

## Open Questions

- האם הסגנון שהופק הוא הסגנון שמונה רוצה? (אין דוגמת yes/no עדיין — צריך feedback)
- האם להסיר גם את אנקדוטת הפיצה (אישית מאוד) או להשאיר?
- האם ל-HTML היא הצליחה לעשות בעיצוב המתאים? (הטמפלייט שיעל משתמשת בו כרגע — RTL, 720px, צבע נחושת בלעלי)

## Session Log

### 2026-05-13 — added 5 images via end-to-end pipeline [shipped]
- **What was done:** הופעלה השרשרת המלאה לראשונה. יעל (ידנית) שתלה 5 `{{IMAGE_NEEDED}}` placeholders ב-MD; יובל (ידנית) ייצר 5 PNG דרך `gpt-image-gen` עם `gpt-image-2`; ראובן העתיק ל-`Output/images/` והחליף ל-`![](images/...)` ב-MD ול-`<figure><img></figure>` ב-HTML.
- **Decisions:**
  - **5 תמונות** למאמר ~1,900 מילים = יחס של ~380 מילים לתמונה. תואם להנחיה של יעל (1/300–500).
  - **כולן `medium` quality, landscape 1536x1024** — לעקביות ולהשגת איזון בין איכות לעלות (סה"כ ~7.5MB).
  - **slugs בלבד באנגלית**: `hero-crm-dashboard`, `crm-tables-connected`, `pizza-anecdote`, `crm-selection-comparison`, `automation-flow`.
  - **HTML**: נוסף `figure.article-image` CSS עם box-shadow עדין ו-border-radius — לאחידות ויזואלית.
  - **`run.sh` עודכן**: PowerShell עכשיו ה-fallback הראשון (לפני python ו-jq). הסיבה — בסביבת Windows שלך, `python` הוא קיצור-דרך של MS Store ולא Python אמיתי, ו-jq לא מותקן. PowerShell עובד מצוין עם Invoke-RestMethod + Convert::FromBase64String.
- **Notes / Caveats:**
  - **המודל `gpt-image-2` עבד**: כל 5 הקריאות הצליחו ללא שגיאות. אישור חי שהמודל זמין ב-API למרות שהזיכרון הפנימי שלי לא הכיר אותו.
  - **`yuval/reference/` עדיין ריק** — יובל עבד ב-best-effort בלבד. הסגנון (flat illustration, פלטה קרם-נחושת) הוא ניחוש שלי שתואם את ה-CSS של ה-HTML.
  - **הסוכנים לא נטענו כ-sub-agents** — שני השלבים (yael, yuval) הופעלו ידנית. בסשן הבא הם יהיו זמינים כ-Agent calls אמיתיים.
- **Related:** [[yael-agent]], [[yuval-agent]], [[gpt-image-gen-skill]], [[claude-md-reuven]]

### 2026-05-13 — first rewrite (CRM article) [shipped]
- **What was done:** ראובן הופעל ידנית בתפקיד יעל (סוכנת yael לא נטענה כי נוצרה אותו סשן — תיטען בסשן הבא). קריאת מקור (147 שורות), שכתוב, שמירת `.md` + `.html` ב-`Output/`. ה-HTML נצפה ב-Launch preview panel מיד לאחר היצירה.
- **Decisions:**
  - **תיקנון מבנה** — חוסר עקביות במקור (כותרות "מה זה CRM?" חוזרות) → היררכיה נקייה: H1 ראשי + 7 H2 ראשיים + H3 משני אחד. הוסרו 3 שורות-כותרת כפולות מפוזרות.
  - **חיתוך CTA** — הוסרה השורה הסופית "ואז תכתבו לי כמה המאמר הזה עזר לכם 🙂" + שתי הופעות של "לתלמידים שלי" → שונה ל"ולאחרים" או הוסר. לפי כלל yael.md, מסירים קישורים/CTAs של המחבר.
  - **הסרת שתילת שם פרטי** — "(כן, הוא קונה מלא, אז בטח הוא גם לקוח שלכם 😅)" עם השם "איתי זרם" — הוסר. סגנון של שתילת זהות אישית = self-promotion, לא מותג בתוך סיפור.
  - **שמירת אנקדוטת הפיצה** — סיפור אישי על שוהם נשאר. הוא ממחיש את הנקודה (שירות גרוע בלי CRM), לא קידום עצמי.
  - **HTML template** — שודרג קלות מהברירת-מחדל של yael.md: הוסף `border-right` בצבע נחושת ל-H2, מחלקת `.brand` לשמות מותגים (Make, WhatsApp, Google Drive), עיצוב Q&A מובחן.
- **Notes / Caveats:**
  - **best-effort**: `style-guide.md` עדיין stub. הסגנון שיעל בחרה — דיבורי-מעט (שמירה על "אשכרה", "ברדק", "פולואפים") + תיקנון תחבירי + פיסוק נקי + ירידה במילים-מילוי. אם הסגנון לא תואם רצון — קל יהיה לחזור עם style-guide מלא.
  - **HTML preview** הוצג למשתמש דרך Launch preview panel.
  - הסוכנת `yael` עצמה לא נטענה כ-sub-agent — תיטען בסשן הבא ואז ה-Agent tool יוכל לקרוא לה ישירות.
- **Related:** [[yael-agent]], [[claude-md-reuven]], [[team-roster]]
