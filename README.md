HL7 to XML to JSON Logic app

Assumptions: 
This logic app will only work for ADT 01 messages HL7 v2.5 AND NOTHING ELSE!
The work for this should be something created in a short amount of time, not an entire infrastructure for handling messages.
XSLT was mentioned in the SOW so XSLT will be needed
This logic app will ONLY READ a file named test.hl7 from the sftpuser directory (info below)
The output should be formatted as in the example ( readable ) and not a 1-line json string

Gotchas that should have been considered here but were not:
Being that this work cant be done at a candidates place of work it was assumed that the candidate had a "home" development environment
that was all set up for logic apps. This includes an azure account ( needed for the HL7 callback which isnt even used!) as well as
the HL7 v2.5 schema data, which is easily found on a machine at work, yet VERY CHALLENGING to just find online at home.

All that being said, those obstacles were overcome.

Design decisions:

How will this app be invoked? In a production environment, all of those hooks will be pre-determined.
Usually, I would use a http request posting data in the request bu that didnt seem appropriate here.
I chose SFTP for the sake of ease and debugging, which gets triggered by an http request  (THE TRIGGER BUTTON).

How will the data be transformed?  So there are 15 fields in the output data that need to be moved from hl7.
If it were 5 or a small number, I would just extract the data into variables. However that seemed kind of silly
and given that XSLT was mentioned in the SOW, XSLT it is.

Given the nature of HL7 data, how will errors be handled?  Given the scope of work, no logging or error framework was mentioned
and creating that seemed out of scope, i chose to create 3 output files:  

test.json holds the competed json
test.err holds any hard error messages from the decode stage, where it doesnt complete
test.msg holds the "soft" hl7 validation and other errors given by the decoder.

A future step that could be done, would be to route this data based on error types to appropriate destinations 
and some kind of notification.  Again, this was out of scope.

SFTP info used for this example:
HCAtest.hl7mover.com
sftpuser
Pa$$w0rd

The XSLT was pretty straight forward:

<img width="1066" height="460" alt="image" src="https://github.com/user-attachments/assets/cf0f7d18-bca0-46c6-aa77-61447dee8f90" />
