
function test
fig = figure;
ax1 = axes;
% gr = surf(ax1,peaks);
gr = pcolor(ax1,peaks);
hold on;
maxZ = max(max(peaks));
arrowHandle = quiver3(ax1, 0,0,maxZ,0,0,0,0,'color','w','LineWidth',1.0 ) ;
% gr = surf(ax1,ones(100,100));
view(ax1,2)
hold on
set(gr,'ButtonDownFcn',{@bd,1,ax1,arrowHandle})
axis([ax1],'tight')


% ---------------------------
function bd(h,evd,n,ax,arrowHandle)
initialCoord = get(ax,'CurrentPoint');
initialX = initialCoord(1,1);
initialY = initialCoord(1,2);
set(arrowHandle,'XData',initialX,'YData',initialY,'UData',0,'VData',0);
% delete(arrowHandle);
% arrowHandle = quiver(ax, initialX,initialY,0,0,0,'color','w' ) ;
disp('down')

fig = ancestor(h,'figure');

% get the values and store them in the figure's appdata
props.WindowButtonMotionFcn = get(fig,'WindowButtonMotionFcn');
props.WindowButtonUpFcn = get(fig,'WindowButtonUpFcn');

setappdata(fig,'TestGuiCallbacks',props);


set(fig,'WindowButtonMotionFcn',{@wbm,n,ax,arrowHandle,initialX,initialY})
set(fig,'WindowButtonUpFcn',{@wbu,ax,arrowHandle,initialX,initialY})


% ---------------------------
function wbm(h,evd,n,ax,arrowHandle,initialX,initialY)
    
currentCoord = get(ax,'CurrentPoint');
currentX = currentCoord(1,1);
currentY = currentCoord(1,2);
UData = currentX - initialX;
VData = currentY - initialY;
updateArrow(arrowHandle,UData,VData);

disp(['motion: patch ' num2str(n)])

% ---------------------------
function wbu(h,evd,ax,arrowHandle,initialX,initialY)
currentCoord = get(ax,'CurrentPoint');
currentX = currentCoord(1,1);
currentY = currentCoord(1,2);
UData = currentX - initialX;
VData = currentY - initialY;
updateArrow(arrowHandle,UData,VData);

disp('up')

fig = ancestor(h,'figure');

props = getappdata(fig,'TestGuiCallbacks');
set(fig,props);
setappdata(fig,'TestGuiCallbacks',[]);

function updateArrow(arrowHandle,UData,VData)
    set(arrowHandle,'UData',UData,'VData',VData);
%     arrowHandle = quiver(axesHandle, x(1),y(1),x(2)-x(1),y(2)-y(1),0 ) ;   
%     axis([axesHandle],[0 1 0 1])



