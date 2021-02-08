init:
	brew install cfssl
	brew install cfssljson

uninstall:
	brew uninstall cfssl
	brew uninstall cfssljson

ca_name := traefik
server_name := proxy
cert_dest := traefik/assets/
setup-ca:
	@echo "INFO :: Creating CA and certificates in '$(cert_dest)'"
	@mkdir -p $(cert_dest)

	# Create CA
	cd $(cert_dest) && cfssl print-defaults csr | cfssl gencert -initca - | cfssljson -bare $(ca_name)-ca
	# Create certificate to be used by the server locally
	cd $(cert_dest) && echo '{}' | cfssl gencert -ca=../$(ca_name)-ca.pem -ca-key=../$(ca_name)-ca-key.pem -config=../cfssl.json -hostname="$(server_name).local.$(ca_name),localhost,127.0.0.1" - | cfssljson -bare $(server_name)

test:
	traefik/test/test.sh
