% LightSourceDefinitionDialog
harmonicFieldSource = getappdata(0,'HarmonicFieldSource');
[ U_xyTot,xlinTot,ylinTot] = getSpatialProfile( harmonicFieldSource );
figure;surf(xlinTot,ylinTot,U_xyTot)
shading interp