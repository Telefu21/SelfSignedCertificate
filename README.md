# SelfSignedCertificate
General Information about Digital Certificates and Example Self Signed Certificate Generation 

Public key certificate, also known as a digital certificate or identity certificate, is an software document used to prove the validity of a public key. The certificate includes information about the public key, information about the identity of its owner (called the subject), and the digital signature of an entity that has verified the certificate's contents (called the issuer). If the signature is valid, and the software examining the certificate trusts the issuer, then it can use that key to communicate securely with the certificate's subject.
 
 ![image](https://user-images.githubusercontent.com/101481631/204348593-7d68954e-dd8a-453e-8394-8418f9839dca.png)

                            The roles of root certificate, intermediate certificate and end-entity certificate as in the chain of trust.
 
Good example for understanding the Trust Chain and certificate Creation is self-signed certificates.
 
Self-Signed Certificates
A self-signed certificate is not signed by a public or private certificate authority. Instead, it is signed by the creator’s own personal or root CA certificate.
Here is what we do to request paid certificate from a well-known Certificate Authority like DigiCert, Verisign or comodo.
 
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
 
Below is a batch script to execute all given steps with openSsl :
 
OpenSSL is a software library for using crypto algorithms, protocols and secure communications.
 
You can download the latest version of openssl from here.
 
Set the identification and domain data in .conf files (if needed?) and double click SelfSignedCertGenerate.bat file. You can trace the chain of trust by inspecting the generated .txt files.
-
 
 
------------------------------ Example Certificate file content (Base 64 Ascii Encoded) generated with openssl ------------------------------------------------
 
-----BEGIN CERTIFICATE-----
MIIEIzCCAwsCFAjQDPeZ40T3wV9uaVdzr4LibGHYMA0GCSqGSIb3DQEBCwUAMIHU
MQswCQYDVQQGEwJVSzEQMA4GA1UECAwHQ0FTdGF0ZTETMBEGA1UEBwwKQ0FMb2Nh
dGlvbjEXMBUGA1UECgwOQ0FPcmdhbmlzYXRpb24xHzAdBgNVBAsMFkNBIE9yZ2Fu
aXNhdGlvbmFsIFVuaXQxHTAbBgkqhkiG9w0BCQEWDkNBZW1haWxBZGRyZXNzMUUw
QwYDVQQDDDxDQSBGdWxseSBRdWFsaWZpZWQgRG9tYWluIE5hbWUgKElQIEFkZHJl
c3MsRG9tYWluIE5hbWUgZXRjLikwHhcNMjIxMTE3MTQzOTAwWhcNMjMxMTE3MTQz
OTAwWjCBxjELMAkGA1UEBhMCVUsxDjAMBgNVBAgMBVN0YXRlMREwDwYDVQQHDAhM
b2NhdGlvbjEVMBMGA1UECgwMT3JnYW5pc2F0aW9uMRwwGgYDVQQLDBNPcmdhbmlz
YXRpb25hbCBVbml0MRswGQYJKoZIhvcNAQkBFgxlbWFpbEFkZHJlc3MxQjBABgNV
BAMMOUZ1bGx5IFF1YWxpZmllZCBEb21haW4gTmFtZSAoSVAgQWRkcmVzcyxEb21h
aW4gTmFtZSBldGMuKTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMj3
0I6M96N+jBKbS6R3MXOP0iImk3oPDMNXI5VhSPi7ggIuxpTVPGULw4LN/1S9PKHQ
xt0NKMTwmSNPEVwaQlTLTdj5VF+rbAFK9GkhJ4BJdMYoEydfytAXZ08nkQFGPUZ0
/ZRU5wS465GUIANCUBn/WchrnLFtjEwdmFArzQG9gpgot1N36YfHAdvy5crxkofZ
fEMYGjbmF2vytJUKuJJeXZPOKt0Se4SEVZ/bIF7JlzCIhLQA+vukrunN7I0tg8HH
NX6a7M5CrZYnPJF9zkt6gctef4D+6zW2R2cfPrxXxQqkZxzwCJHa2oPxhxd/wKWn
y47sptl8eYuMGErCISkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEASJRv8ZFTqdKK
Vmf2ODeWNcHz+iR4esW+s3GbAxtYy27vJW3WuhAggWo6ZZTEwXGJ6vnXUUnQf2yr
FDkuIifE+ghpUrR+Z8/EZ8LxhwbQOYJwT9nNi+bPLo/BtujYiAoGqXaIzIcyOsHK
OAYxiHGUDtCRy8R87od6+oV2qMAg1QL6Mlq/sJ5VBsZR7WOyqh8KMrnmVT0xM6Qs
1/pVSzoKU/R9wEcugCjOhm3GsrzWCtoPg5c3zlJrcop/bQ07xoBiVQDJO7n/9dd7
EF6vba6mQsH+fYOzEg96guMws2diMCFrUP4asP/Vb7SE1wB6cTilYW6bi+f3ZRTV
UamKsfFVxw==
-----END CERTIFICATE-----
 
----------------------------------------------------  Human readable form of Digital Certificate Example ---------------------------------------------------------------
 
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number:
            65:b1:3e:fa:4a:31:26:94:2a:b1:05:1d:50:c3:62:7c:c5:fa:08:d5
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = UK, ST = CAState, L = CALocation, O = CAOrganisation, OU = CA Organisational Unit, emailAddress = CAemailAddress, CN = "CA Fully Qualified Domain Name (IP Address,Domain Name etc.)"
        Validity
            Not Before: Nov 17 14:18:11 2022 GMT
            Not After : Nov 17 14:18:11 2023 GMT
        Subject: C = UK, ST = State, L = Location, O = Organisation, OU = Organisational Unit, emailAddress = emailAddress, CN = "Fully Qualified Domain Name (IP Address,Domain Name etc.)"
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:d9:79:5b:91:e8:34:72:75:86:1b:65:82:c8:34:
                    06:06:19:38:82:44:f3:87:1b:45:fa:db:aa:7c:09:
                    e9:41:0b:1e:99:29:41:a5:99:3c:a8:5f:28:fa:4a:
                    a9:49:87:40:66:8e:c3:5b:0a:7e:7b:0f:9b:a1:11:
                    42:d1:cb:d5:b9:ed:70:ef:f1:a1:6a:6b:a9:6a:a8:
                    da:d9:0c:9f:d5:48:8c:9b:00:ba:ea:b5:c9:f6:21:
                    d4:45:f9:52:81:68:a6:b5:27:e5:b7:7c:89:09:84:
                    1f:95:0e:bf:79:c0:9c:d8:f0:68:65:17:17:d8:1c:
                    b4:e9:63:0e:6a:1a:a5:80:0d:60:23:15:19:54:cb:
                    62:12:49:47:a1:28:28:d9:14:70:20:1e:c4:65:74:
                    6b:8f:0d:dd:d7:94:07:d7:1a:d5:58:28:7e:b6:ae:
                    8a:f4:99:c5:d4:3f:c7:9b:13:83:6a:ff:f4:ec:d9:
                    dd:c9:fc:b4:95:68:bf:e8:5b:24:3e:b6:ef:65:b7:
                    dd:3b:d8:0a:80:ae:84:b5:7d:da:76:3c:d4:e2:6f:
                    4c:d2:c2:0e:9f:9a:ee:45:3c:53:9a:58:96:ae:69:
                    78:3d:33:99:e7:22:50:7c:26:73:16:9c:f9:f7:86:
                    40:cd:e8:56:6e:60:8e:93:64:b2:41:24:25:b0:be:
                    ff:93
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         86:43:59:01:d9:31:d4:5c:80:80:47:46:7a:27:8e:ed:13:86:
         d0:d6:6a:9f:b5:f6:a3:15:74:8d:2f:49:1f:0c:58:0d:e2:0c:
         b5:fc:ec:15:cf:2d:a9:95:1e:35:8d:f5:3c:8a:5e:b3:0c:d9:
         4c:f7:81:a6:98:cf:51:fc:13:39:26:74:e1:e9:be:2c:ea:40:
         e4:22:cb:6b:e5:21:9c:da:04:16:be:b1:c8:13:d1:77:35:f4:
         62:9e:6c:40:3b:80:03:45:d1:5d:88:ac:2b:8b:c8:8c:e3:f1:
         23:37:88:44:e4:5a:57:f5:24:4f:90:f0:c0:3c:18:c0:a6:13:
         12:61:c6:e3:a6:54:3d:cc:25:c4:c1:b3:b1:d4:9d:e3:b7:5f:
         fb:96:48:f6:ab:d9:a0:2d:b6:e3:61:42:42:ca:d8:33:81:26:
         04:a1:b7:d3:d6:26:74:bf:66:45:3d:9a:42:99:f0:e0:43:20:
         f4:a0:f0:32:fa:b5:01:da:01:6d:e1:05:92:2e:cb:bc:a1:95:
         f8:45:46:27:7a:00:fa:97:75:a2:3c:1e:10:93:1e:b3:11:80:
         20:06:31:12:e2:ce:61:2e:02:92:a9:05:21:3a:f2:d2:5d:9b:
         c5:b2:66:ce:0c:0c:3b:96:33:e3:28:ee:6c:9b:2d:13:85:e5:
         8f:59:25:a8
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
