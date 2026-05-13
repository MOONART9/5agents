# skill-creator Skill

## Overview

הסקיל הרשמי של Anthropic ליצירת ועריכת סקילים, הותקן ב-`.claude/skills/skill-creator/` מהמאגר [anthropics/skills](https://github.com/anthropics/skills/tree/main/skills/skill-creator). כולל: `SKILL.md`, `agents/` (סוכני עזר ליצירת סקילים), `references/` (best practices), `scripts/` (eval + run-loop בפייתון), ו-`assets/`. מאפשר לראובן וצוותו ליצור סקילים חדשים, לערוך קיימים, ולהריץ evals על איכות הסקיל. שייך ל: ראובן + כל הצוות (כלי מטא).

## Open Questions

- האם להפעיל אותו ליצירת סקיל ייעודי לכל sub-agent (יעל/יובל/חן)?
- האם להריץ את `run_eval.py` על הסקילים שכבר הותקנו ב-`.claude/skills/` כדי לבדוק איכות?
- ה-scripts הם Python — האם Python מותקן בסביבת המשתמש? (לבדוק אם נרצה להריץ evals)

## Session Log

### 2026-05-13 — manual install [shipped]
- **What was done:** sparse-clone של `anthropics/skills` (רק `skills/skill-creator/`), העתקה ל-`.claude/skills/skill-creator/`, commit `dd91d5e`, push ל-origin/main.
- **Decisions:** התקנה ידנית בלבד — ה-CLI `claude` לא קיים ב-PATH של המשתמש (לא ב-bash ולא ב-PowerShell). כל 3 הפקודות `claude plugin install ...` שהתבקשו נכשלו ב-`command not found`. בחירה ב-sparse-checkout כדי לא להוריד את כל המאגר של anthropics/skills (גדול).
- **Notes / Caveats:** ה-`--scope project` שהתבקש לא רלוונטי בהתקנה ידנית — הסקיל יושב פיזית תחת `.claude/skills/` של הפרויקט, כלומר scope הוא ממילא project (לא user). אימות `claude plugin list` לא בוצע (אין CLI).
- **Related:** [[superpowers-skills]], [[obsidian-skills]], [[project-structure]]
