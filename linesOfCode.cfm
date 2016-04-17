
<!--- List of directories that need to be scanned --->
<cfset dirList = "../controllers,../layouts,../model,../views">

<cfoutput>
<cfset numdir = 1>
<cfset numfiles = 1>
<cfset numlines = 1>
<cfset totalnumlines = 0>
<cfset totalsize = 0>

<!--- Loop over the list of directories provided above --->
<cfloop list="#dirList#" index="ind" delimiters=",">
	
	<!--- Get all files in the directory and all its subdirectories (via recurse="true") --->
     
	<!--- Loop over all files in a directory --->
    <cfloop query="DirFiles">
		<!--- Only count lines for those valid files - in this case: .cfm, .cfc, .js, .css, .xml --->
		 <cfif DirFiles.name contains ".cfm" or DirFiles.name contains ".cfc" or DirFiles.name contains ".js"
		 	or DirFiles.name contains ".css"  or DirFiles.name contains ".xml">
         	
			<!--- Output file name --->
         	#numfiles#.) #DirFiles.name#
            <cfscript>
            	//try to open the file and read it
				try {
					myfile = FileOpen("#DirFiles.directory#\#DirFiles.name#", "read");
					while (! FileIsEOF(myfile)) { 
						x = FileReadLine(myfile);
		            	//for every line in the file, increment the number of lines counter
						numlines++;
					}
					FileClose(myfile);
				}
				catch (any e) {
					WriteOutput(e.message);
				}
		        WriteOutput("| Lines of code: #numlines# <br>");
				totalsize = totalsize + DirFiles.size;
			 	numfiles++;
            	//add the number of lines in this file to the total number of lines
			 	totalnumlines = numlines + totalnumlines;
				numlines = 1;
			</cfscript>
        </cfif>
    </cfloop>
    <cfset numdir++>
</cfloop>
<br>
<!--- Final Output --->
Number of Directories: #numdir# <br>
Number of Files: #numfiles# <br>
Number of lines of code: #totalnumlines# <br>
Total size: #NumberFormat(totalsize/1024,"00.00")# KB
</cfoutput>

