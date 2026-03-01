HL7 to XML to JSON Logic app

<b>Assumptions:</b><br>
This logic app will only work for ADT 01 messages HL7 v2.5 AND NOTHING ELSE!<br>
The work for this should be something created in a short amount of time, not an entire infrastructure for handling messages.<br>
XSLT was mentioned in the SOW so XSLT will be needed<br>
This logic app will ONLY READ a file named test.hl7 from the sftpuser directory (info below)<br>
The output should be formatted as in the example ( readable ) and not a 1-line json string<br>
<br>
<b>Gotchas that should have been considered here but were not:</b><br>
Being that this work cant be done at a candidates place of work it was assumed that the candidate had a "home" development environment<br>
that was all set up for logic apps. This includes an azure account ( needed for the HL7 callback which isnt even used!) as well as<br>
the HL7 v2.5 schema data, which is easily found on a machine at work, yet VERY CHALLENGING to just find online at home.<br>
<br>
All that being said, those obstacles were overcome.<br>
<br>
Design decisions:<br>
<br>
How will this app be invoked? In a production environment, all of those hooks will be pre-determined.<br>
Usually, I would use a http request posting data in the request bu that didnt seem appropriate here.<br>
I chose SFTP for the sake of ease and debugging, which gets triggered by an http request  (THE TRIGGER BUTTON).<br>
<br>
How will the data be transformed?  So there are 15 fields in the output data that need to be moved from hl7.<br>
If it were 5 or a small number, I would just extract the data into variables. However that seemed kind of silly<br>
and given that XSLT was mentioned in the SOW, XSLT it is.<br>
<br>
Given the nature of HL7 data, how will errors be handled?  Given the scope of work, no logging or error framework was mentioned<br>
and creating that seemed out of scope, i chose to create 3 output files:  <br>
<br>
test.json holds the competed json<br>
test.err holds any hard error messages from the decode stage, where it doesnt complete<br>
test.msg holds the "soft" hl7 validation and other errors given by the decoder.<br>
<br>
A future step that could be done, would be to route this data based on error types to appropriate destinations <br>
and some kind of notification.  Again, this was out of scope.<br>
<br>
SFTP info used for this example:<br>
HCAtest.hl7mover.com<br>
sftpuser<br>
Pa$$w0rd<br>
<br>
The XSLT was pretty straight forward:<br>
<br>
<img width="1066" height="460" alt="image" src="https://github.com/user-attachments/assets/cf0f7d18-bca0-46c6-aa77-61447dee8f90" />
