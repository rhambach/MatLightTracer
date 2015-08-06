classdef ObjectHandle < handle
   properties
      Object=[];
   end
 
   methods
      function obj=ObjectHandle(myObject)
         obj.Object=myObject;
      end
   end
end

