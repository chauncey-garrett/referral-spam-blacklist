#!/bin/bash
#
# Generate an Nginx blacklist.conf from several master blacklist.txt files
#
# Chauncey Garrett
# http://chauncey.io
# @chauncey_io
#

dest="../blacklist.conf"
src="./blacklist.txt"
tmp="./blacklist.tmp"

blacklists=(
	"./blacklist-piwik.txt"
	"./blacklist-private.txt"
)

# generate master blacklist
for list in "${blacklists[@]}"
do
	cat "$list" >> "$src"
done

# ensure blacklist is sorted and only contains unique values
sort "$src" | uniq > "$tmp"

#
# Generate blacklist.conf
#

# add the beginning
cat << EOF > "$dest"
# /etc/nginx/blacklist.conf
#
# Usage
#
# Add the following to /etc/nginx/nginx.conf inside 'http { ... }':
#
#     include blacklist.conf;
#
# Add the following to /etc/nginx/site-available/your-site.conf inside 'server { ... }':
#
#     if($bad_referer) {
#         return 444;
#     }
#

#
# Map referral spam
#

map \$http_referer \$bad_referer {
    default 0;

    # referral spam TLDs
EOF

# insert each spammer to block
while read line
do
	echo "    \"~*$line\" 1;" >> "$dest"
done < "$tmp"

# close the map block
cat << EOF >> "$dest"
}

EOF

rm "$tmp"
rm "$src"

