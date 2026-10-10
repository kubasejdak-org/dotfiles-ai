---
name: ebookpoint-daily-promo
description: Retrieve ebookpoint.pl daily ebook promotion
---

# Ebookpoint Daily Promotion

Run `scripts/ebookpoint-get-promo` from this skill's directory each time the promotion is requested. Resolve the script
path relative to this skill, not the current working directory. It requires only the system `python3` (standard
library, no dependencies).

On success, stdout contains `Title - Author(s)`. Use it to return a concise response identifying today's promoted ebook.
Include only information returned by the script.

If the command fails, report that today's promotion could not be retrieved.
