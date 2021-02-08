FROM traefik:v2.3

# Being explicit to share what is realy needed.
COPY config/tls.yml /etc/traefik/

# NOTE: our Traefik configuration expects these names

COPY assets/proxy.pem /certs/
COPY assets/proxy-key.pem /certs/
