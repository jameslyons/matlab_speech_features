% msf_logfb - log filterbank energies
function feat = msf_logfb(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',  0.025,@isnumeric);
    addOptional(p,'winstep', 0.01, @isnumeric);
    addOptional(p,'nfilt',   26,   @isnumeric);
    addOptional(p,'lowfreq', 0,    @isnumeric);
    addOptional(p,'highfreq',fs/2, @isnumeric);
    addOptional(p,'nfft',    512,  @isnumeric);            
    addOptional(p,'preemph',     0,    @(x)ge(x,0));    
    parse(p,varargin{:});
    in = p.Results;
    H = msf_filterbank(in.nfilt,fs,in.lowfreq,in.highfreq,in.nfft);
    pspec = msf_powspec(speech,fs,'winlen',in.winlen,'winstep',in.winstep,'nfft',in.nfft);
    feat = log(pspec*H');
end
