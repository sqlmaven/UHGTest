<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- IMPORTANT: output XML, not text -->
  <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

  <!-- Helper: YYYYMMDD -> YYYY-MM-DD -->
  <xsl:template name="fmt-date-yyyymmdd">
    <xsl:param name="d" />
    <xsl:choose>
      <xsl:when test="string-length($d) &gt;= 8">
        <xsl:value-of select="concat(substring($d,1,4),'-',substring($d,5,2),'-',substring($d,7,2))" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$d" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/">

    <!-- MSH -->
    <xsl:variable name="mshType" select="string(//*[local-name()='MSH.9_MessageType']/*[local-name()='CM_MSG.0_MessageType'])"/>
    <xsl:variable name="mshTrig" select="string(//*[local-name()='MSH.9_MessageType']/*[local-name()='CM_MSG.1_TriggerEvent'])"/>
    <xsl:variable name="mshCtrl" select="string(//*[local-name()='MSH.10_MessageControlId'])"/>
    <xsl:variable name="mshVer"  select="string(//*[local-name()='MSH.12_VersionId']/*[local-name()='VID_0_VersionId'])"/>

    <!-- PID -->
    <xsl:variable name="patientId" select="string(//*[local-name()='PID_3_PatientIdentifierList']/*[local-name()='CX_0_IdNumber'])"/>
    <xsl:variable name="lastName"  select="string(//*[local-name()='PID_5_PatientName']/*[local-name()='XPN_0_FamilyName']/*[local-name()='XPN_0_0_Surname'])"/>
    <xsl:variable name="firstName" select="string(//*[local-name()='PID_5_PatientName']/*[local-name()='XPN_1_GivenName'])"/>
    <xsl:variable name="dobRaw"    select="string(//*[local-name()='PID_7_DateTimeOfBirth']/*[local-name()='TS_0_Time'])"/>
    <xsl:variable name="gender"    select="string(//*[local-name()='PID_8_AdministrativeSex'])"/>
    <xsl:variable name="phone"     select="string(//*[local-name()='PID_13_PhoneNumberHome']/*[local-name()='XTN_0_TelephoneNumber'])"/>

    <!-- PV1 -->
    <xsl:variable name="patientClass" select="string(//*[local-name()='PV1_2_PatientClass'])"/>
    <xsl:variable name="locPoc"  select="string(//*[local-name()='PV1_3_AssignedPatientLocation']/*[local-name()='PL_0_PointOfCare'])"/>
    <xsl:variable name="locRoom" select="string(//*[local-name()='PV1_3_AssignedPatientLocation']/*[local-name()='PL_1_Room'])"/>
    <xsl:variable name="locBed"  select="string(//*[local-name()='PV1_3_AssignedPatientLocation']/*[local-name()='PL_2_Bed'])"/>
    <xsl:variable name="docId"    select="string(//*[local-name()='PV1_7_AttendingDoctor']/*[local-name()='XCN_0_IdNumber'])"/>
    <xsl:variable name="docLast"  select="string(//*[local-name()='PV1_7_AttendingDoctor']/*[local-name()='XCN_1_FamilyName']/*[local-name()='XCN_1_0_Surname'])"/>
    <xsl:variable name="docFirst" select="string(//*[local-name()='PV1_7_AttendingDoctor']/*[local-name()='XCN_2_GivenName'])"/>

    <xsl:variable name="dobFmt">
      <xsl:call-template name="fmt-date-yyyymmdd">
        <xsl:with-param name="d" select="normalize-space($dobRaw)"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Output schema as XML -->
    <root>
      <messageHeader>
        <messageType>
          <xsl:value-of select="concat($mshType,'^',$mshTrig)"/>
        </messageType>
        <messageControlId><xsl:value-of select="$mshCtrl"/></messageControlId>
        <hl7Version><xsl:value-of select="$mshVer"/></hl7Version>
      </messageHeader>

      <patient>
        <patientId><xsl:value-of select="$patientId"/></patientId>
        <firstName><xsl:value-of select="$firstName"/></firstName>
        <lastName><xsl:value-of select="$lastName"/></lastName>
        <dateOfBirth><xsl:value-of select="$dobFmt"/></dateOfBirth>
        <gender><xsl:value-of select="$gender"/></gender>
        <phoneNumber><xsl:value-of select="$phone"/></phoneNumber>
      </patient>

      <visit>
        <patientClass><xsl:value-of select="$patientClass"/></patientClass>
        <location><xsl:value-of select="concat($locPoc,'-',$locRoom,'-',$locBed)"/></location>
        <attendingDoctor>
          <doctorId><xsl:value-of select="$docId"/></doctorId>
          <firstName><xsl:value-of select="$docFirst"/></firstName>
          <lastName><xsl:value-of select="$docLast"/></lastName>
        </attendingDoctor>
      </visit>

      <status>Decoded to HL7 XML Successfully</status>
    </root>

  </xsl:template>
</xsl:stylesheet>