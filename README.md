# Digital Certificates

Public key certificate, also known as a digital certificate or identity certificate, is an software document used to prove the validity of a public key. The certificate includes information about the public key, information about the identity of its owner (called the subject), and the digital signature of an entity that has verified the certificate's contents (called the issuer). If the signature is valid, and the software examining the certificate trusts the issuer, then it can use that key to communicate securely with the certificate's subject.
 
 ![image](https://user-images.githubusercontent.com/101481631/204348593-7d68954e-dd8a-453e-8394-8418f9839dca.png)
                            The roles of root certificate, intermediate certificate and end-entity certificate as in the chain of trust.
 
Good example for understanding the Trust Chain and certificate Creation is self-signed certificates.
 
## Self-Signed Certificates
A self-signed certificate is not signed by a public or private certificate authority. Instead, it is signed by the creator’s own personal or root CA certificate.
Here is what we do to request paid certificate from a well-known Certificate Authority like DigiCert or Verisign.
 
 ![image](https://user-images.githubusercontent.com/101481631/204348469-d7a97f95-834b-4570-97a1-7a5aaffd0645.png)

1.	Create a certificate signing request (CSR) with a private key. A CSR contains details about location, organization, and FQDN (Fully Qualified Domain Name).
2.	Send the CSR to the trusted CA authority.
3.	The CA authority will send you the certificate signed by their root certificate authority and private key.
4.	You can then validate and use the certificate with your applications.
But for a self-signed certificate, here is what we do.
 
 ![image](https://user-images.githubusercontent.com/101481631/204347053-b8c4f001-1d23-4605-bc98-606890bcc66d.png)

1.	Create our own root CA certificate & CA private key (We act as a CA on our own)
2.	Create a server private key to generate CSR
3.	Create an certificate with CSR using our root CA and CA private key.
4.	Install the CA certificate in the browser, Device (ECU etc) or Operating system to avoid unauthorized access or communication.
 
Creating Self Signed Certificate (without Intermediate Certificate - Just Root Certificate Authority and End Entity):
 
1) Generate a public and private key pair to be used to create the Self signed root Certificate Authority (root CA).
 
2) Generate root CA's certificate by using the keys generated at step 1 and by providing the identification and domain data (for CA). 
 
3) Generate a public and private key pair  to be used to create the End Entity's Certificate Signing Request (CSR).
 
4) Generate a CSR for End Identity by using the keys generated at step 3 and by providing the identification and domain data (for End Entity).
 
5) Generate an End Entity Certificate by adding the identification and domain data of both CA (issuer) and End Entity (subject ) and End Entity's public key and signature which is created with root CA's private key. 
 
Note: A serial number will be generated automatically while Root CA signs the End Entity certificate.  This serial number is used to uniquely identify a signed certificate and added to End Entity certificate under Serial Number Section. 
 
## Self Signed Certificate Generation Example

A batch script to execute all given steps with openSsl is given in code section.
 
OpenSSL is a software library for using crypto algorithms, protocols and secure communications.
 
You can download the latest version of openssl from:

https://www.openssl.org/source/
 
Set the identification and domain data in .conf files (if needed?) and double click SelfSignedCertGenerate.bat file. You can trace the chain of trust by inspecting the generated .txt files.

  
###  Example Certificate file content (Base 64 Ascii Encoded) generated with openssl

![image](https://user-images.githubusercontent.com/101481631/204363293-baf43f15-01f9-4a09-932f-5923549513b3.png)
 
### Human readable form of Digital Certificate Example
 
![image](https://user-images.githubusercontent.com/101481631/204362819-400aff8c-2a7e-4bc8-9510-0ca11468d7ad.png)

