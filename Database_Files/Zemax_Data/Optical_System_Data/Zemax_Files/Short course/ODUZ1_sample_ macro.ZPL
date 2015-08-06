
nom_thick_3 = THIC(3)	 # store the nomimal value for surface #3 thickness
A$ = "For thickness of surface #3 = "

	FOR I, 0, 10, 1 	 # for I going from 0 to 10 in steps of 1
		SURP 3, 3, nom_thick_3 + I	 # set the surface #3 thickness to be nominal + I     
		PRINT A$, THIC(3), ", the MF value is ", MFCN()
	NEXT

SURP 3, 3, nom_thick_3 	 # restore the nominal thickness
END
