classdef ObjectHandle < handle
    % This class is used to define a pointer to any data either in GUI or
    % outside GUI.
    % Example usage :
    % myPtr = ObjectHandle;
    % myPtr.Object acts like a pointer. That is if it is changed in any
    % function, it is maintained even outside the changing function.
    
   properties
      Object=[];
   end
 
   methods
      function obj=ObjectHandle(myObject)
         obj.Object=myObject;
      end
   end
end

