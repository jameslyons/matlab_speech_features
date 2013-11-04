% msf_logfb - log filterbank energies
function mfccs = msf_mfcc(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',      0.025,@(x)gt(x,0));
    addOptional(p,'winstep',     0.01, @(x)gt(x,0));
    addOptional(p,'nfilt',       26,   @(x)ge(x,1));
    addOptional(p,'lowfreq',     0,    @(x)ge(x,0));
    addOptional(p,'highfreq',    fs/2, @(x)ge(x,0));
    addOptional(p,'nfft',        512,  @(x)gt(x,0));
    addOptional(p,'ncep',        13,   @(x)ge(x,1));          
    addOptional(p,'liftercoeff', 22,   @(x)ge(x,0));          
    addOptional(p,'appendenergy',true, @(x)ismember(x,[true,false]));          
    addOptional(p,'preemph',     0,    @(x)ge(x,0));    
    parse(p,varargin{:});
    in = p.Results;
    H = msf_filterbank(in.nfilt, fs, in.lowfreq, in.highfreq, in.nfft);
    pspec = msf_powspec(speech, fs, 'winlen', in.winlen, 'winstep', in.winstep, 'nfft', in.nfft);
    en = sum(pspec,2); % energy in each frame
    feat = dct(log(H*pspec'))';
    mfccs = lifter(feat(:,1:in.ncep), in.liftercoeff);
    if in.appendenergy
        mfccs(:,1) = log10(en);
    end
    
end

function lcep = lifter(cep,L)
    [N,D] = size(cep);
    n = 0:D-1;
    lift = 1 + (L/2)*sin(pi*n/L);
    lcep = cep .* repmat(lift,N,1);
end

