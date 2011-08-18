#!/bin/bash
AUTH="Haruki:jar90q71"
BASE="http://localhost:3000"

echo $BASE

METHOD=$1
DEST="$BASE$2"
XML=$3

echo $DEST
# make sure args were passed
if [ $# -eq 0 ]; then
        echo "usage: ./`basename $0` HTTP-METHOD DESTINATION_URI [XML]"
        echo "example: ./`basename $0` POST "/accounts" \"<account><name>ed</name><email>ed@ed.com</email></account>\""
		echo $pwd
        exit 1
fi

# execute CURL call
curl -H 'Accept: text/javascript' -H 'Content-Type: application/json' -w '\nHTTP STATUS: %{http_code}\nTIME: %{time_total}\n' \
-X $METHOD \
-d "$XML" \
-u "$AUTH" \
"$DEST" -b $pwd/cookie_for_auth

exit 0