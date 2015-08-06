

 # This macro will set the surface # 4 thickness from 4 to 5 in increments of 0.1, 
 # update the open analysis windows and print the surface #6 radius of curvature. 

FOR i, 4, 5, 0.1  # i goes from 4 to 5 in steps of 0.1

	SURP 4, 3, i 	 #set the surface #4 thickness (code 3) to i
	UPDATE All	 #Update all open analysis windows
	x=1/CURV(6)	 #Store surface #6 radius(1/curvature) in numeric variable x
	A$="      Radius of curvature = " #Place the label in the string variable A$ 
	Print "Thickness = ", i, A$, x

		 #Dummy loop to slow down the macro excecution
		FOR k,1,1E7,1
		NEXT		 #Close the k loop

NEXT			 #Close the i loop

END