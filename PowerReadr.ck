// ChucK program -- PowerReadr.ck

// Purpose:

// This program reads text files created by a Rebol program (in my case egaugeReader.r, 
// which has parsed the XML output of an energy monitoring system - but any text files
// with text integers in them will work).

// This program strobes those text files and reformats the numbers into
// OSC messages which are then passed along to a downstream program that groks OSC
// messages (like OSCulator or Wekinator)

// This particular program also downscales the data from the text files by taking 
// their square-roots.  Not needed in most applications.

// ChucK and program usage tips:

//		Get ChucK from http://chuck.cs.princeton.edu/
//		Life is easier if a copy of the ChucK binary is copied into your path
//		(like /usr/local/bin on a Mac) so that launching ChucK files can happen
//		from any folder location

//		Run this program from the command line -- stop it with ctl-C.  Do NOT
//		run it with miniAudicle.app -- I have no idea what will happen if you do.


// History:

//		29-Feb-2016 - created the program - Mike O'Connor - www.haven2.com
//		23-Mar-2016 - successfully created OSC messages - Mike
//		 1-Apr-2016 - updated comments for public sharing - Mike

// Main Program:

// FILE IO SETUP -- run once

	// instantiate the fileIO gizmo and name it "fio"
	
		FileIO fio;

	// establish (integer) variables to read text-file data into
	
		int MainGrid_val;
		int GarageSol_val;
		int GarageUse_val;
		int HouseSol_val;
		int Interruptable_val;
		int TotalGen_val;
		int TotalUse_val;
		
	// establish the scaled-down (and converted-to-float) variables	
	
		float MainGrid_float ;
		float Interruptable_float ;
		float HouseSol_float ;
		float GarageSol_float ;
		float GarageUse_float ;
		float TotalUse_float ;   
		float TotalGen_float ;

	// set up string files to read from REBOL parsing program (substitute your own path
	// to get to these)

		"/Applications/Rebol/MainGrid.txt"  	=> string MainGrid;
		"/Applications/Rebol/GarageSol.txt" 	=> string GarageSol;
		"/Applications/Rebol/GarageUse.txt" 	=> string GarageUse;
		"/Applications/Rebol/HouseSol.txt" 		=> string HouseSol;
		"/Applications/Rebol/Interruptable.txt" => string Interruptable;
		"/Applications/Rebol/TotalGen.txt" 		=> string TotalGen;
		"/Applications/Rebol/TotalUse.txt" 		=> string TotalUse;

// OSC-SEND SETUP - run once

	// establish (string) host name and (integer) port variables
		"localhost" => string hostname;
		6449 => int port;

	// establish xmit - the container to hold the various parts of the OSC packet
		OscOut xmit;

	// aim the transmitter at the destination set above
		xmit.dest( hostname, port );


// MAIN LOOP - runs infinite time - interrupt with ctl-C

	while( true )
	{
		
	// Read the files and capture their values	
		// open the MainGrid file
			fio.open( MainGrid, FileIO.READ );	
		// get the value from the file
			fio => MainGrid_val;
	 
		// open the Interruptable file
			fio.open( Interruptable, FileIO.READ );	
		// get the value from the file
			fio => Interruptable_val;
		
		// open the HouseSol file
			fio.open( HouseSol, FileIO.READ );	
		// get the value from the file
			fio => HouseSol_val;   
	 
		// open the GarageSol file
			fio.open( GarageSol, FileIO.READ );	
		// get the value from the file
			fio => GarageSol_val;
 
		// open the GarageUse file
			fio.open( GarageUse, FileIO.READ );	
		// get the value from the file
			fio => GarageUse_val;
	   
		// open the TotalUse file
			fio.open( TotalUse, FileIO.READ );	
		// get the value from the file
			fio => TotalUse_val;
	
		// open the TotalGen file
			fio.open( TotalGen, FileIO.READ );	
		// get the value from the file
			fio => TotalGen_val;
			
	// Take the square root to downscale/flatten values coming from the upstream
	// program (and exclude negative values) -- probably not needed in your case.  
	// Here is a version of the line if without all the conversion.  This will
	// just convert the recently-read string value into the float value...
	
 	// 		MainGrid_val => MainGrid_float ;
	

	
		if( MainGrid_val >0)
			{ Math.sqrt( MainGrid_val ) 		=> MainGrid_float 		;   }
		if( Interruptable_val >0)
			{ Math.sqrt( Interruptable_val ) 	=> Interruptable_float 	;   }
		if( HouseSol_val >0)
			{ Math.sqrt( HouseSol_val ) 		=> HouseSol_float 		;   }
		if( GarageSol_val >0)
			{ Math.sqrt( GarageSol_val ) 		=> GarageSol_float 		;   }
		if( GarageUse_val >0)
			{ Math.sqrt( GarageUse_val ) 		=> GarageUse_float 		;   }
		if( TotalUse_val >0)
			{ Math.sqrt( TotalUse_val ) 		=> TotalUse_float 		;   }
		if( TotalGen_val >0)
			{ Math.sqrt( TotalGen_val ) 		=> TotalGen_float 		;   }
	   
	// start building the OSC message - use an OSC compliant name space 
	
		xmit.start( "/power/readr" );
	
	// add the data to the OSC packet
	
		MainGrid_float 					=> xmit.add;
		Interruptable_float 			=> xmit.add;
		HouseSol_float 					=> xmit.add;
		GarageSol_float 				=> xmit.add;
		GarageUse_float 				=> xmit.add;
		TotalUse_float 					=> xmit.add;   
		TotalGen_float 					=> xmit.add;
					
		
	// send the packet 
	
		xmit.send();
		
	// print values to the console for debugging	
	
		<<< "watts", MainGrid_val, Interruptable_val, HouseSol_val, GarageSol_val, GarageUse_val, TotalUse_val, TotalGen_val   >>>;
		<<< "scaled", MainGrid_float, Interruptable_float, HouseSol_float, GarageSol_float, GarageUse_float, TotalUse_float, TotalGen_float   >>>;

	// wait 5 seconds at the end of the loop -- same interval as the REBOL program,
	// so there's no reason to pound any faster on the files
	
		5::second => now;
			
	// end the loop
	
	}




