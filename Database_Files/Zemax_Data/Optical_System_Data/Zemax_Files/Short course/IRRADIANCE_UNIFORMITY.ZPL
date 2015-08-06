file_name$ = "C:\detector_uniformity.txt"

CLOSEWINDOW				 # Run macro in quiet mode (without displaying text output window)

dummy = NPRO(1, 2, 0, 0)		 # Extract object type of object #2
object_type$ = $buffer()

dummy = NPRO(1, 2, 1, 0)		 # Extract the comment column of object #2
comment_column$ = $buffer()

OUTPUT  file_name$, APPEND		 # Send the output of PRINT to a file

	dummy = NSDD(1,0,0,0)     	 # Clear all detectors
	NSTR 1,0,0,0,0,1,0,0 		 # Trace rays

	PRINT 
	PRINT object_type$, "     ", comment_column$
	PRINT "First Detector =", NSDD(1,3,-4,1)
	PRINT "Second Detector =", NSDD(1,4,-4,1)
	PRINT "Third Detector =", NSDD(1,5,-4,1)
	PRINT "Fourth Detector =", NSDD(1,6,-4,1)
	PRINT "Fifth Detector =", NSDD(1,7,-4,1)
	PRINT
	PRINT "-------------------------------------------------------------------"

FOR I,1,6,1		 # Update windows 1 to 6 (5 detectors and 1 Layout)
	UPDATE I
NEXT

END


         
