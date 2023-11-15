% goal is hamming code for M=4; so N=15 & K=11
%% data-word
Din = randi([0,1],1,11)
%%  H is parity matrix and G is generator-matrix
[H,G] = hammgen(4);
%%  create code-word
Tx = mod(Din * G,2)
%% insert error
Rx = mod(Tx+[0 0 0 0 0 0 0 0 0 0 0 1 0 0 0],2)    % error in 12th bit
%% in Receiver
S = mod(Rx*H',2);
t = [ eye(15) ; zeros(1,15) ];   % table of syndrome
syndrome = bin2dec( dec2base(S,2)' )+1;
if  find(bi2de(H') ==bi2de(S)) <=15
    x = find(bi2de(H') ==bi2de(S));
else
    x=16;
end
correspond_Syndrm_t = t(x , :)
%% syndrome decoder
CorRx = mod(Rx+correspond_Syndrm_t ,2)
Dout = CorRx(: , 5:end)
%%  field
CorRx = de2bi([0:(2^11)-1]',11);
cb= de2bi([0:(2^15)-1]',15);    %%%%%%%%    or dec2bin((...))-'0'
FildC = mod(CorRx*G,2);
%%  min distance
md = FildC(2:end, : )*ones(15,1);       %suggesting use func. <SUM()>
disp(['Dmin is : ',num2str(min(md))])