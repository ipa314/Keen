load('pointlist4.mat')
pointlist(intersect(intersect(find(pointlist(:,1)==0.62),find(pointlist(:,2)==0.65)),find(pointlist(:,3)==9)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.71),find(pointlist(:,2)==0.65)),find(pointlist(:,3)==0)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.73),find(pointlist(:,2)==0.78)),find(pointlist(:,3)==3.5)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.76),find(pointlist(:,2)==0.76)),find(pointlist(:,3)==2)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.79),find(pointlist(:,2)==0.74)),find(pointlist(:,3)==2)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.1),find(pointlist(:,2)==0.74)),find(pointlist(:,3)==0)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.7),find(pointlist(:,2)==0.64)),find(pointlist(:,3)==8)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.81),find(pointlist(:,2)==0.74)),find(pointlist(:,3)==3.5)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.71),find(pointlist(:,2)==0.86)),find(pointlist(:,3)==3.5)),:)=[];
pointlist(intersect(intersect(find(pointlist(:,1)==0.7),find(pointlist(:,2)==0.87)),find(pointlist(:,3)==4)),:)=[];

pointlist(157,:)=[];
pointlist(157,:)=[];
pointlist(698,:)=[];
pointlist(1102,:)=[];


scatter3(pointlist(:,1),pointlist(:,2),pointlist(:,3))


%plot(alphaShape(pointlist(:,1),pointlist(:,2),pointlist(:,3)))
figure()
h=plot(alphaShape(pointlist(:,1),pointlist(:,2),pointlist(:,3)));
h.EdgeAlpha=0.2;
xlim([0 1.2])
ylim([0 1.2])
daspect([1 1 12])
xlabel('$x_1$','fontsize',16,'interpreter','latex')
ylabel('$x_2$','fontsize',16,'interpreter','latex')
zlabel('$x_3$','fontsize',16,'interpreter','latex')
view(35,15)
grid on

%% convexification of the stability region
[k1 k2]=convhull(pointlist)
surf(pointlist(k1,1),pointlist(k1,2),pointlist(k1,3))

figure()
hh=trisurf(k1,pointlist(:,1),pointlist(:,2),pointlist(:,3),'FaceColor','cyan');
hh.EdgeAlpha=0.1;
axis equal
daspect([1 1 12])
xlim([0 1.2])
ylim([0 1.2])


%% Boundary of the stabiliry region

x=pointlist(:,1)
y=pointlist(:,2)
z=pointlist(:,3)
k = boundary(pointlist)
figure()
trisurf(k,x,y,z,'Facecolor','red','FaceAlpha',0.1)
xlim([0 1.2])
ylim([0 1.2])
daspect([1 1 12])
xlabel('$x_1$','fontsize',16,'interpreter','latex')
ylabel('$x_2$','fontsize',16,'interpreter','latex')
zlabel('$x_3$','fontsize',16,'interpreter','latex')
view(35,15)
grid on