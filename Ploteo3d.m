%% Ploteo 3D
x=xyz_Gil.Data(:,1);
y=xyz_Gil.Data(:,2);
z=xyz_Gil.Data(:,3);

figure();
subplot(1,2,1);plot3(x,y,z); title('RoboGil')

x=xyz_Mod.Data(:,1);
y=xyz_Mod.Data(:,2);
z=xyz_Mod.Data(:,3);
subplot(1,2,2);plot3(x,y,z); title('RoboModelo')
