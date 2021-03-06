%% this script is used to simulate and save analysis mask

%% contact mask two region
N = length(pie.dObject);
Nc  = pie.uieRes.get();
Magnification = pie.uieMag.get();
xo_nm = pie.dc_um*Nc/N/Magnification*1000;
lambda_nm= pie.uieLambda.get();
NA = pie.uieNAo.get();
res_nm = 0.61*lambda_nm/NA/2;
dp = round(res_nm/xo_nm/4);

mask = zeros(N);
mask(round(5*N/8)+1-round(N/4):round(5*N/8)+round(N/4),round(5*N/8)+1-round(N/4):round(5*N/8)+round(N/4))=1;
mask(round(5*N/8)+1-round(N/8)-dp:round(5*N/8)+round(N/8)+dp,round(5*N/8)+1-round(N/8)-dp:round(5*N/8)+round(N/8)+dp)=0;
mask(round(5*N/8)+1-round(N/8)+dp:round(5*N/8)+round(N/8)-dp,round(5*N/8)+1-round(N/8)+dp:round(5*N/8)+round(N/8)-dp)=2;
figure(2),imagesc(mask)

%% contact mask 
N = length(pie.dObject);
Nc  = pie.uieRes.get();
Magnification = pie.uieMag.get();
xo_nm = pie.dc_um*Nc/N/Magnification*1000;
lambda_nm= pie.uieLambda.get();
NA = pie.uieNAo.get();
res_nm = 0.61*lambda_nm/NA/2;
dp = round(res_nm/xo_nm/4);

mask = zeros(N);
mask(round(5*N/8)+1-round(N/4):round(5*N/8)+round(N/4),round(5*N/8)+1-round(N/4):round(5*N/8)+round(N/4))=1;
figure(2),imagesc(mask)
%% save probe
save([pie.cAppPath,'/../../data/mask/contact-400nm-2.mat'],'mask');