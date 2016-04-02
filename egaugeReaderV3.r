Text before the script is ignored and can be used for comments, tags, etc

REBOL [
    Title: 		"eGauge Reader" 
    Date: 		11-March-2016
    File:		%egaugereaderV2.r
    Author:		"Mike O'Connor"
    Version:	1.0
    
    Purpose: {
		Reads web page (in this case XML output from the Main Panel eGuage
		Parses web page data
		Writes those data values to individual text files 
		Text files will be read by a ChucK program (PowerReader.ck) and formatted into
			OSC messages
    }

    REBOL and program usage tips: {
    
    	Get REBOL from www.rebol.com
    	Life is easier if a copy of the REBOL binary and rebol.r files
    		are copied into your path (like /usr/local/bin on a Mac)
    		so that launching REBOL files can happen from any folder location
    	
    	Run this program from the command line -- stop it with ctl-C
    	

    }

    History: [
        1.0 [29-Feb-2016 "Created this example" "Mike"]
        	[23-March-2016 "Successfully read into OSC messages"  "Mike"]
        	[1-April-2016 "Updated comments for public sharing"  "Mike"]
    ]

] 

;	The program runs in an infinite loop but that is not required.
;	If you prefer, run it in one-shot mode by commenting out this line, which
;	starts the loop and the matching closing bracket at the end of the loop.  That 
;	is the way that I create test data for Wekinator

forever [

	
;	Read the web page and dump it into a block called XML1.  Again note that 
; 	this program can read/parse any web page, not just a page that produces XML. 
;	This URL is operational.  Do me a favor and avoid super long test runs
; 	against my power-monitoring system.   
	
	XML1: read http://egauge25464.egaug.es/56A7C/cgi-bin/egauge?inst&tot
	
;	Uncomment these two lines if you would like to display the block of web page data
;	to the screen or write it to a text file.  File writing convention - file name is
; 	preceded by the percent sign.
	
		;		print XML1
		;		write	%XML1.txt XML1

;	This is the parsing and file-writing part of the loop.  Each parse command stands by
;	itself, they do not need to be ordered sequentially like this.  The command reads
;	the block (in this case the previously-read XML1) THRU some string and then copies
;	from that point TO some other string into a block (first time that is MainGrid).  The
;	goal is to find a string that defines the beginning of what you would like to extract
;	and another string that defines the end.  XML makes this easier, but it is not 
;	required.  

;	The PRINT command is just there for debugging.  The WRITE command is 
; 	producing the text file output and completes this bite out of the web page

;	Note how I solve the problem of repeated instances of the beginning string in
;	the XML file by repeating the THRU argument to step through the XML data.  This
;	same strategy can be used to step to a unique position in any web page and the
; 	strings can be varied - they only happen to repeat in this example

	parse XML1 [thru </v><i> thru "-" copy MainGrid to </i>]
		;		print MainGrid
				write %MainGrid.txt MainGrid
	parse/all XML1 [ thru </v><i> thru </v><i> thru "-" copy Interruptable to </i>]	
		;		print Interruptable	
				write %Interruptable.txt Interruptable
	parse/all XML1 [ thru </v><i> thru </v><i> thru </v><i> copy HouseSol to </i>]	
		;		print HouseSol
				write %HouseSol.txt HouseSol
	parse/all XML1 [ thru </v><i> thru </v><i> thru </v><i> thru </v><i> copy GarageSol to </i>]	
		;		print GarageSol
				write %GarageSol.txt GarageSol
	parse/all XML1 [ thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> copy GarageUse to </i>]	
		;		print GarageUse
				write %GarageUse.txt GarageUse
	parse/all XML1 [ thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> copy TotalUse to "."]	
		;		print TotalUse
				write %TotalUse.txt TotalUse
	parse/all XML1 [ thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> thru </v><i> copy TotalGen to "."]	
		;		print TotalGen
				write %TotalGen.txt TotalGen

;	Here is a line to print the variables out on the screen for debugging, and for
;	comparison with the next program in the chain which is going to read those files
;	and produce OSC messages based on them
		
		print [MainGrid Interruptable HouseSol GarageSol GarageUse TotalUse TotalGen]
		
;	Vary the wait to change the timing of the strobe -- this version
;	hits the web page once every 5 seconds

	wait 5		

]
