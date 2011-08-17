curl -H 'Content-Type: application/json' \
     -H 'Accept: text/javascript' \
     -X POST 'http://localhost:3000/login/renew' \
	 -d '{ 'token': 'o2OFrPFmFRQBC8HyQF48' }' -c pwd/cookie_for_auth
exit 0