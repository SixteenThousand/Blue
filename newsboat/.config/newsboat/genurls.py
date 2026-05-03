import re

# Read the markdown file, get urls, ansd get tags from markdown headings
md = open("urls.md", "r", encoding="utf-8")

feed_data = dict()
current_tags = []
tag_rg = re.compile("^(#+) (.*)")
for line in md:
    m = tag_rg.fullmatch(line.strip())
    if m is None:
        # Note re.match only looks for matches at the start of a string
        if re.match("https://|file://|http://", line):
            feed_data[line.strip()] = current_tags[:]
        continue
    tag_level = len(m.group(1))
    new_tag = m.group(2)
    if tag_level == 1:
        current_tags = [new_tag]
    elif tag_level == len(current_tags) + 1:
        current_tags.append(new_tag)
    elif tag_level > len(current_tags) + 1:
        raise Exception("Could not make tags map: urls.md has bad formatting (nothing written to urls")
    else:
        current_tags[tag_level-1] = new_tag

md.close()

# Write result to actual newsboat config file
config = open("urls", "w", encoding="utf-8")

for feed_url in feed_data:
    config.write("\n" + feed_url)
    for tag in feed_data[feed_url]:
        config.write(f' "{tag}"')

config.close()
