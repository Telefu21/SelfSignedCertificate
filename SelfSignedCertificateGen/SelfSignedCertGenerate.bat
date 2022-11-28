@echo off

:: 1) Generate a key file to be used to create the Self signed root certificate (rootCA) 

openssl genrsa -out rootCA.key 2048

:: 2) Generate root CA's certificate by using the key file generated at step 1 and the identification and domain data provided in config file (rootCA.conf)

openssl req -x509 -sha256 -days 356 -new -key rootCA.key -out rootCA.crt -config rootCA.conf

:: 3) Generate a key file to be used to create the Self signed End Entity certificate (selfSignedCrt)

openssl genrsa -out selfSignedCrt.key 2048

:: 4) Create a CSR (Certificate Signing Request) by using the key file generated at step 3 and the identification and domain data provided in config file (selfSignedCrtCsr.conf)

openssl req -new -key selfSignedCrt.key -out selfSignedCrt.csr -config selfSignedCrtCsr.conf

:: 5) Sign the CSR with root CA's private key to Create Self Signed End Entity Certificate 

openssl x509 -req -in selfSignedCrt.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out selfSignedCrt.crt -days 365 -sha256 

:: An ".srl" file which contains a serial number will be generated automatically while Root CA signs the certificate(selfSignedCrt.crt). 
:: This serial number is used to uniquely identify a signed certificate and already added to certificate under Serial Number Section.
:: so we can remove this serial number file

del *.srl	

:: move all the generated files to a specific folder

if not exist GeneratedFiles\ (
  mkdir GeneratedFiles
)

mv *.crt GeneratedFiles/
mv *.csr GeneratedFiles/
mv *.key GeneratedFiles/

:: To build up more understanding, convert the generated files to human readable text format

cd GeneratedFiles

openssl rsa  -in rootCA.key 		-text -out rootCAKey.txt
openssl x509 -in rootCA.crt 		-text -out rootCACrt.txt
openssl rsa  -in selfSignedCrt.key 	-text -out selfSignedCrtKey.txt
openssl req  -in selfSignedCrt.csr 	-text -out selfSignedCrtCsr.txt
openssl x509 -in selfSignedCrt.crt 	-text -out selfSignedCrtCrt.txt

pause