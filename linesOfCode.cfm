
<cfset dirList = "test,test2">

<cfoutput>
<cfset numdir = 1>
<cfset numfiles = 1>
<cfset numlines = 1>
<cfset totalnumlines = 0>
<cfset totalsize = 0>
<cfloop list="#dirList#" index="ind" delimiters=",">
	
	<cfdirectory directory="C:\ColdFusion9\wwwroot\#ind#" name="DirFiles" action="list" recurse="true">
     
    <cfloop query="DirFiles">
		 <cfif DirFiles.name contains ".cfm" or DirFiles.name contains ".cfc" or DirFiles.name contains ".js"
		 	or DirFiles.name contains ".css"  or DirFiles.name contains ".xml">
         	#numfiles#.) #DirFiles.name#
            <cfscript>
				try {
					myfile = FileOpen("#DirFiles.directory#\#DirFiles.name#", "read");
					while (! FileIsEOF(myfile)) { 
						x = FileReadLine(myfile);
						numlines++;
					}
					FileClose(myfile);
				}
				catch (any e) {
					dumpVar(e.message);
				}
		        WriteOutput("| Lines of code: #numlines# <br>");
			 	numfiles++;
			 	totalnumlines = numlines + totalnumlines;
				totalsize = totalsize + DirFiles.size;
				numlines = 1;
			</cfscript>
        </cfif>
    </cfloop>
    <cfset numdir++>
</cfloop>
<br>
Number of Directories: #numdir# <br>
Number of Files: #numfiles# <br>
Number of lines of code: #totalnumlines# <br>
Total size: #NumberFormat(totalsize/1024,"00.00")# KB
</cfoutput>

