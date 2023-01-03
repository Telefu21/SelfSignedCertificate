@echo off

:: 1) Generate a key file to be used to create the Self signed root certificate (rootCA) 

openssl genrsa -out rootca.key 2048

:: 2) Generate root CA's certificate by using the key file generated at step 1 and the identification and domain data provided in config file (rootCA.conf)

openssl req -x509 -sha256 -days 356 -new -key rootca.key -out rootca.crt -config rootCA.conf

:: 3) Generate a key file to be used to create the Self signed End Entity certificate (selfSignedCrt)

openssl genrsa -out selfsignedcrt.key 2048

:: 4) Create a CSR (Certificate Signing Request) by using the key file generated at step 3 and the identification and domain data provided in config file (selfSignedCrtCsr.conf)

openssl req -new -key selfsignedcrt.key -out selfsignedcrt.csr -config selfSignedCrtCsr.conf

:: 5) Sign the CSR with root CA's private key to Create Self Signed End Entity Certificate 

openssl x509 -req -in selfsignedcrt.csr -CA rootca.crt -CAkey rootca.key -CAcreateserial -out selfsignedcrt.crt -days 365 -sha256 

:: An ".srl" file which contains a serial number will be generated automatically while Root CA signs the certificate(selfSignedCrt.crt). 
:: This serial number is used to uniquely identify a signed certificate and already added to certificate under Serial Number Section.
:: so we can remove this serial number file

del *.srl	

:: Verify the selfsigned Certificate with CA

openssl verify -CAfile rootCA.crt selfSignedCrt.crt

:: To build up more understanding, convert the generated files to human readable text format

openssl rsa  -in rootca.key 		    -text -out rootCAKey.txt
openssl x509 -in rootca.crt 		    -text -out rootCACrt.txt
openssl rsa  -in selfsignedcrt.key 	-text -out selfSignedCrtKey.txt
openssl req  -in selfsignedcrt.csr 	-text -out selfSignedCrtCsr.txt
openssl x509 -in selfsignedcrt.crt 	-text -out selfSignedCrtCrt.txt

:: move all the generated files to specific folders

if not exist CertificateFiles\ (
  mkdir CertificateFiles
)

if not exist TextFiles\ (
  mkdir TextFiles
)

move *.crt CertificateFiles/
move *.csr CertificateFiles/
move *.key CertificateFiles/
move *.txt TextFiles/

pause
