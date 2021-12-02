# acme_docker
Docker file to issue a certificate from letsencrypt using the web-root of another container.

## environment variables
| variable name | values      | description                                           |
|---------------|-------------|-------------------------------------------------------|
|LE_DOMAINS     | string list | list of domains to include in the certificate         |
|LE_EMAIL       | string      | email used for acount creation                        |
|LE_ISNOTEST    | 1 for true  | set to 1 to issue a production certificate            |
|LE_EXPAND      | 1 for true  | see --expand in letsencrypt                           |
|LE_PFX         | 1 for true  | set to 1 to convert certificat to pfx after issueing  |
|PFX_PW         | string      | password to use for pfx file                          |
