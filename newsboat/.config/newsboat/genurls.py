import re

# Read the markdown file, get urls, ansd get tags from markdown headings
md = open("urls.md", "r", encoding="utf-8")

feed_data = dict()
current_tags = []
for line in md:
    if line.startswith("# "):
        current_tags = [line[2:].strip()]
    elif line.startswith("##"):
        current_tags.append(line.partition(" ")[2].strip())
    # Note re.match only looks for matches at the start of a string
    elif re.match("https://|file://|http://", line):
        feed_data[line.strip()] = current_tags[:]

md.close()

# Write result to actual newsboat config file
config = open("urls", "w", encoding="utf-8")

for feed_url in feed_data:
    config.write("\n" + feed_url)
    for tag in feed_data[feed_url]:
        config.write(f' "{tag}"')

config.close()
