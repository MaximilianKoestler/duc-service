#!/usr/bin/env bash



echo "Content-type: text/html"; echo

cat <<EOF
<!DOCTYPE html>
<head>
  <title>Storage Analyzer</title>
  <meta charset="utf-8" />
  <link rel="stylesheet" type="text/css" href="style.css">
</head>
 <body>
EOF

cat header.htm | sed 's/Snapshot/Log/'
echo "<div style=\"border: 1px solid black; background: white; padding: 10px;\">"
echo "$(bash log.cgi)" | sed 's#Content-type: text/plain##'
echo "</div>"

cat footer.htm

cat <<EOF
  </body>
</html>
EOF