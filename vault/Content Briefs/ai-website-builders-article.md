# AI Website Builders Article — Chen+Yael+Yuval Pipeline

## Overview

המאמר השני שעבר את הצוות, והראשון שעבר את **השרשרת המלאה**: חן (מחקר) → יעל (כתיבה+placeholders) → יובל (4 תמונות) → ראובן (שילוב). נושא: השוואה בין Lovable, Bolt.new ו-v0 של Vercel לבניית אתרים ב-AI ב-2026. מקור: Till Freitag (2026-02-24, מקור עצמאי איכותי). תוצר: `Output/2026-05-13-ai-website-builders.{md,html}` + 4 תמונות ב-`Output/images/`. בקהל-יעד: מונה (מעצבת/מפתחת אתרים) — שכבר משתמשת ב-Lovable, אז המאמר רלוונטי מאוד.

## Open Questions

- האם הסגנון של יעל (דיבורי-מעט, נקי) מתאים לקול של מונה כשהיא תפרסם זאת לקהל? צריך feedback.
- האם 4 תמונות לכ-1,300 מילים זה הקצב הנכון, או שצריך פחות/יותר?
- ה-`yuval/reference/` עדיין ריק — סגנון התמונות עקבי בין המאמרים אבל לא בהכרח הסגנון של מונה.

## Session Log

### 2026-05-13 — first full pipeline run (chen→yael→yuval) [shipped]
- **What was done:** הופעלה השרשרת המלאה לראשונה:
  1. **חן**: בדקה זיכרון (ריק); 2 שאילתות WebSearch; WebFetch על 2 מקורות; בחרה את [Till Freitag](https://till-freitag.com/en/blog/lovable-vs-bolt-vs-v0-en); שמרה ב-`Content/2026-05-13-ai-website-builders-comparison.md` עם frontmatter; תיעדה ב-`chen/Memory/searches.md`.
  2. **יעל**: שכתבה לעברית בעברית-דיבורית-מקצועית; תרגמה טבלאות; הוסיפה 4 `{{IMAGE_NEEDED}}` placeholders + רשימת placeholders מסומכרת בסוף הקובץ.
  3. **יובל**: 4 קריאות ל-`gpt-image-gen` (כל אחת `medium` quality, 1536x1024 landscape); כולן הצליחו; כל PNG עם sibling `.txt`.
  4. **ראובן**: cp ל-`Output/images/`; החליף 4 placeholders ל-`![](images/...)`; יצר HTML עם CSS משופר (טבלאות עם רקע נחושת-עדין, blockquote בולט, figures עם box-shadow).
- **Decisions:**
  - **Till Freitag נבחר על Lovable's own guide** — עצמאי, פחות מוטה. עיקרון: עדיף ⭐⭐⭐⭐⭐ עצמאי על ⭐⭐⭐ content-marketing.
  - **Emergent.sh נכשל** — JS-rendered page. WebFetch החזיר רק metadata. אם זה נושא חוזר — שווה לחקור fallback (browser MCP?).
  - **4 placeholders ל-~1,300 מילים** = 325 מילים/תמונה, בתוך הטווח של יעל (300–500).
  - **קהל יעד**: מונה ספציפית. הטון "דיבורי-מקצועי" עם "את" (לא "אתם") כי מונה היא אחת. המותגים נשארים באנגלית (Lovable, Bolt, v0, Next.js, Vite).
  - **CSS table חדש**: רקע נחושת-עדין ל-th, border-bottom עדין. ראוי שמונה (מעצבת) תאשר טעם.
- **Notes / Caveats:**
  - **שני המאמרים בפרויקט** עכשיו: זה ([[ai-website-builders-article]]) ו-[[crm-article-rewrite]]. שניהם עברו flow ידני (סוכנים לא נטענו כי נוצרו בסשן הזה).
  - **בסשן הבא** — הסוכנים ייטענו אוטומטית ויובל נוכל לקרוא להם דרך Agent tool עם `subagent_type=chen` / `yael` / `yuval`. ה-end-to-end test האמיתי יקרה אז.
  - **searches.md** קיבל את ה-entry הראשון בפועל. ה-flow של בדיקת זיכרון עבד (Grep מצא שאין רישומים).
- **Related:** [[chen-agent]], [[yael-agent]], [[yuval-agent]], [[claude-md-reuven]], [[crm-article-rewrite]]
