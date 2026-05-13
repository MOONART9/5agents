# Superpowers Skills

## Overview

14 סקילים שהותקנו ידנית מהמאגר [obra/superpowers](https://github.com/obra/superpowers) ב-2026-05-13, יושבים תחת `.claude/skills/`. נותנים לראובן וצוותו יכולות-על לתכנון, ביצוע, debugging, code review, ו-TDD. כל סקיל הוא תיקייה עם `SKILL.md` (לפעמים גם scripts/קבצי עזר). הותקן ידנית (clone + cp) כי `/plugin` של Claude Code לא זמין במחשב. שייך ל: ראובן + כל הצוות (כלי אופקי).

## Open Questions

- אילו מ-14 הסקילים באמת רלוונטיים לעבודת תוכן (לעומת קוד)? יכול להיות שחלקם מיותרים לפרויקט הזה.
- האם לעדכן את הסקילים תקופתית מ-upstream?

## Session Log

### 2026-05-13 — initial install [shipped]
- **What was done:** clone של `obra/superpowers`, העתקת `skills/*` ל-`.claude/skills/`, commit (`cebabb4`), push ל-origin/main.
- **Decisions:** הותקנו רק `skills/` (לא היו `commands/` או `agents/` ב-upstream). קבצים קיימים ב-`.claude/` לא נדרסו (`-n` flag ב-cp).
- **Notes / Caveats:** הרשימה המלאה של 14 הסקילים:
  - `brainstorming` — שיטה לסיעור מוחות מובנה
  - `dispatching-parallel-agents` — שיגור sub-agents במקביל
  - `executing-plans` — ביצוע מסודר של תוכניות
  - `finishing-a-development-branch` — סגירת branch בצורה נקייה
  - `receiving-code-review` — קבלת ביקורת קוד
  - `requesting-code-review` — בקשת ביקורת קוד (כולל code-reviewer agent prompt)
  - `subagent-driven-development` — פיתוח מונחה sub-agents
  - `systematic-debugging` — debugging שיטתי (root cause, defense-in-depth)
  - `test-driven-development` — TDD + testing anti-patterns
  - `using-git-worktrees` — עבודה עם worktrees מקבילים
  - `using-superpowers` — מטא-סקיל על איך להשתמש בערכה
  - `verification-before-completion` — אימות לפני הכרזה על "סיום"
  - `writing-plans` — כתיבת תוכניות איכותיות
  - `writing-skills` — כתיבת סקילים חדשים (מטא)
- **Related:** [[project-structure]], [[obsidian-skills]]
