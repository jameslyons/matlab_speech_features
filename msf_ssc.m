% msf_logfb - log filterbank energies
function feat = msf_ssc(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',  0.025,@isnumeric);
    addOptional(p,'winstep', 0.01, @isnumeric);
    addOptional(p,'nfilt',   26,   @isnumeric);
    addOptional(p,'lowfreq', 0,    @isnumeric);
    addOptional(p,'highfreq',fs/2, @isnumeric);
    addOptional(p,'nfft',    512,  @isnumeric);            
    parse(p,varargin{:});
    in = p.Results;
    H = msf_filterbank(in.nfilt,fs,in.lowfreq,in.highfreq,in.nfft);
    pspec = msf_powspec(speech,fs,'winlen',in.winlen,'winstep',in.winstep,'nfft',in.nfft);
    R = repmat(linspace(0,fs/2,in.nfft/2),size(pspec,1),1);
    feat = ((R.*pspec)*H')./ (pspec*H');
end
