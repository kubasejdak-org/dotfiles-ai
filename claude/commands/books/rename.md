# Rename eBooks and PDFs

Adjust filenames of eBooks and PDFs in current directory using books-manager subagent to match my desired convention and
group them into book directories (one for each title). Do not categorize them. Use filesystem MCP if needed.

Follow the process below:

1. Make a backup of current directory called `<directory_name>_backup`
2. Launch subagent
3. Once agent are finished, remove all temporary files that were created in the process
4. Confirm that `before.txt` and `after.txt` files created by books-manager agent are identical in terms of SHA256 sums
   count and their values. Filename will obviously be different.
5. If those files differ then it means that some books were lost in the process and you need to at least list what is
   missing.
