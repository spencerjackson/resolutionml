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
	<p>FORM: <xsl:value-of select="resolution/committee"/></p>
	<p>ISSUE: <xsl:value-of select="resolution/issue"/></p>
	<p>SUBMITTED BY: <xsl:value-of select="resolution/submitter"/></p>
	<p>SIGNATORIES:
	<xsl:for-each select="resolution/signature">
	  <xsl:value-of select="."/><xsl:if test="position()!=last()">, </xsl:if>
	</xsl:for-each> </p>
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
      <span style="font-style:italic"><xsl:value-of select="phrase"/></span>
      <xsl:value-of select="text"/>,
    </div>
  </xsl:for-each>
</div>
</xsl:template>

<xsl:template match="resolution/body">
<ol>
  <xsl:for-each select="clause">
    <xsl:call-template name="clause">
      <xsl:with-param name="depth" select="0"/>
    </xsl:call-template>
  </xsl:for-each>
</ol>
</xsl:template>

<xsl:template name="clause">
    <xsl:param name="depth"/>
<li>
  <span style="text-decoration:underline; font-weight:bold"><xsl:value-of select="phrase"/></span>
  <xsl:value-of select="text"/><xsl:if test="not(substring(text, string-length(text)) = ':')"><xsl:text>;</xsl:text></xsl:if>
  <xsl:if test="clause">
    <ol style="list-style-type:lower-alpha">
    <xsl:for-each select="clause">
      <xsl:call-template name="subclause">
	<xsl:with-param name="depth" select="$depth+1"/>
      </xsl:call-template>
    </xsl:for-each>
    </ol>
  </xsl:if>
</li>
</xsl:template>

<xsl:template name="subclause">
<xsl:param name="depth"/>
  <li><xsl:value-of select="text"/><xsl:if test="not(substring(text, string-length(text)) = ':')"><xsl:text>;</xsl:text></xsl:if></li>
  <xsl:if test="clause">
    <ol style="list-style-type:lower-roman">
      <xsl:for-each select="clause">
	<xsl:call-template name="subclause">
	  <xsl:with-param name="depth" select="$depth+1"/>
	</xsl:call-template>
      </xsl:for-each>
    </ol>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
