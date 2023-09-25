@echo off

REM PLEASE UPDATE THE FOLLOWING VARIABLES FOR YOUR NEEDS.
set v_domain_name=odoo.abc.com
set openssl_exe=D:\Zend\Apache24\bin\openssl.exe

echo 0. Create Config
(
echo # openssl x509 extfile params
echo extensions = extend
echo [req] # openssl req params
echo prompt = no
echo distinguished_name = dn-param
echo [dn-param] # DN fields
echo C = VN
echo ST = HA NOI
echo O = ASEANSC
echo OU = IT Dept
echo CN = %v_domain_name%
echo emailAddress = lien@abc.com
echo [extend] # openssl extensions
echo subjectKeyIdentifier = hash
echo authorityKeyIdentifier = keyid:always
echo keyUsage = digitalSignature,keyEncipherment
echo extendedKeyUsage=serverAuth,clientAuth
echo [policy] # certificate policy extension data
)>%v_domain_name%.csr.conf

echo 1. Create the Server Private Key
%openssl_exe% genrsa -out %v_domain_name%.key 2048

echo 2. Generate Certificate Signing Request (CSR) Using Server Private Key
%openssl_exe% req -new -newkey rsa:2048 -nodes -keyout %v_domain_name%.key -out %v_domain_name%.csr -config %v_domain_name%.csr.conf

%openssl_exe% x509 -req -days 3650 -sha256 -in %v_domain_name%.csr -signkey %v_domain_name%.key -out %v_domain_name%.crt -extfile %v_domain_name%.csr.conf
