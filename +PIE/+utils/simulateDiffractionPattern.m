function [sqrtInt,Em,measurements] = simulateDiffractionPattern(probe,object,...
    segs,modeNumber,N,propagator,Rpix,H,preShift,do_um,lambda_um)
%% simulate diffracted patterns
Em = zeros(N,N,modeNumber);
for m= 1:modeNumber
    reconBox = object(Rpix(m,1)+[1:N],Rpix(m,2)+[1:N],m);
    if size(Rpix,2)==3
        probe(:,:,m) = PIE.utils.Propagate(probe(:,:,m),'angular spectrum',do_um(m),lambda_um(m),Rpix(m,3));
    end
    exitWave = reconBox.*probe(:,:,m);
    Em(:,:,m) = PIE.utils.postPropagate (exitWave,propagator,H{m},preShift);
    sqrtInt = single(abs(Em));
    measurements = sqrtInt.^2;
end
measurements = sum(measurements,3);
sqrtInt = sqrt(measurements);

% segment
if ~isempty(segs)
    img = zeros(length(segs{1}));
    out=zeros(1,length(segs));
    for k=1:length(segs)
        seg = logical(segs{k});
        out(k) = sum(measurements(seg));
        img = img + segs{k}*out(k);
    end
    measurements=img;
    sqrtInt = sqrt(measurements);
end