cat $1 | grep -i "^[a-z]" | cut -c-30 | sort | uniq -c | sort -nr | head -20
