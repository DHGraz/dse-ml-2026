<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">

    <!-- ==========
     Title:   Hugo Schuchardt Letters – CSV Export
     Author:  Martina Scholger
     Date:    2026-09-20
     Version: updated version
     Description: Transforms the letter collection from the Hugo Schuchardt Archive (https://gams.uni-graz.at/hsa) into a CSV file for further analysis (topic modeling).
                  Processes only "original" letters, the resulting CSV contains one row per paragraph. Opener, closer, editorial notes, and abbreviations are excluded. 
     ========== -->
       
    <!--  Definition of the output method and whitespace regulation for the element p -->
    
    <xsl:output method="text" encoding="UTF-8" indent="no"></xsl:output>
    <xsl:strip-space elements="p"/>
    
    <!-- Read collection -->
    
    <xsl:variable name="letters" select="collection('hsa_letters/?select=*.xml')"/>
    
    
    <!-- Main transformation: Creates a csv header and then one row per paragraph (tei:p). -->
    
    <xsl:template match="/">
        
        <!-- CSV header -->
        <xsl:text>"source_file","pid","sender_id","sender","receiver_id","receiver","date","text","language","keywords","word_count"</xsl:text>
        
        <!-- Process TEI documents containing an original letter. -->
        <xsl:for-each select="$letters//tei:TEI[.//tei:div[@type='letter'][@subtype='original']]">
            
            <!-- Sort results by the numeric part of the source file name (PID). -->
            <xsl:sort select="xs:integer(replace((.//tei:idno[@type='PID'])[1],'.*letter\.(\d+).*', '$1'))" data-type="number"/>
            
            <!-- Create variable for the letter's identifier -->
            <xsl:variable name="pid" select=".//tei:div[@type='letter']/@xml:id"/>
            
            
            <!-- For each letter iterate each paragraph and provide the corresponding metadata -->
            <xsl:for-each select=".//tei:div[@type='letter'][@subtype='original']/tei:p">
                
                <xsl:text>&#10;</xsl:text>
                
                <!-- col 1: source file -->
                <xsl:value-of select="//tei:idno[@type='PID']/concat(substring-after(., ':'), '.xml')"/>
                <xsl:text>,</xsl:text>
                
                <!-- col 2: letter pid and paragraph index -->
                <xsl:value-of select="$pid"/>
                <xsl:text>-</xsl:text>
                <xsl:number format="1" />
                <xsl:text>,"</xsl:text>
                
                <!-- col 3: sender ID -->
                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:persName/@corresp"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 4: sender surname -->
                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:surname"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 5: receiver ID -->
                <xsl:value-of select="//tei:correspAction[@type='received']//tei:persName/@corresp"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 6: receiver surname -->
                <xsl:value-of select="//tei:correspAction[@type='received']//tei:surname"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 7: date -->
                <xsl:value-of select="//tei:correspAction[@type='sent']//tei:date"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 8: creates a variable 'raw-text' that takes the text of each paragraph, but excludes note and expan elements as these are editorial supplements. -->
                <xsl:variable name="raw-text" 
                    select="normalize-space(
                    string-join(
                    .//text()[not(ancestor::tei:note or ancestor::tei:expan)],
                    ''
                    )
                    )"/>
                <xsl:variable name="clean-text" 
                    select="replace($raw-text, '&quot;', '')"/>
                <xsl:value-of select="$clean-text"/>
                <xsl:text>","</xsl:text>
                
                <!-- col 9: language codes, separated by semicolons -->
                <xsl:for-each select="//tei:langUsage/tei:language">
                    <xsl:value-of select="@ident"/><xsl:if test="not(last())"><xsl:text>;</xsl:text></xsl:if>
                </xsl:for-each>
                <xsl:text>","</xsl:text>
                
                <!-- col 10: keywords, spearated by semicolons -->
                <xsl:for-each select="//tei:keywords">
                    <xsl:value-of select="string-join(tei:term/tei:term, ';')"/>
                </xsl:for-each>
                <xsl:text>","</xsl:text>
                
                <!-- col 11: rough estimate of whitespace count -->
                <xsl:value-of select="count(tokenize($clean-text, '\s+'))"/>
                <xsl:text>"</xsl:text>
            </xsl:for-each>
        </xsl:for-each>    
    </xsl:template>
   
</xsl:stylesheet>