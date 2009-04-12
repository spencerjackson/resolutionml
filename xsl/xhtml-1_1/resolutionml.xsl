<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes"
encoding="UTF-8"/>

<xsl:template match="/">
  <html>
    <head> <title> test </title> </head>
    <body>
      <div>
	FORM: <xsl:value-of select="resolution/committee"/>
	ISSUE: <xsl:value-of select="resolution/issue"/>
	SUBMITTED BY: <xsl:value-of select="resolution/submitter"/>
	<xsl:for-each select="resolution/signature">
	  <xsl:value-of select="."/>
	</xsl:for-each>
      </div>
      <xsl:apply-templates select="resolution/preamble"/>
      <xsl:apply-templates select="resolution/body"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="resolution/preamble">
<div>
  <xsl:for-each select="clause">
    <div>
      <xsl:value-of select="phrase"/>
      <xsl:value-of select="text"/>,
    </div>
  </xsl:for-each>
</div>
</xsl:template>

<xsl:template match="resolution/body">
<div>
  <xsl:apply-templates select="clause"/>
</div>
</xsl:template>

<xsl:template match="clause">
<div>
  <xsl:value-of select="phrase"/>
  <xsl:value-of select="text"/>
  <xsl:if test="clause">
    <xsl:apply-templates select="./clause"/>
  </xsl:if>
</div>
</xsl:template>

<xsl:template match="clause/clause">
<div>
  <xsl:value-of select="text"/>
  <xsl:if test="clause">
    <xsl:apply-templates select="clause/clause"/>
  </xsl:if>
</div>
</xsl:template>

</xsl:stylesheet>
