function pspec = msf_powspec(speech,fs,varargin)
    p = inputParser;   
    addOptional(p,'winlen',0.025,@isnumeric);
    addOptional(p,'winstep',0.01,@isnumeric);
    addOptional(p,'nfft',512,@isnumeric);            
    parse(p,varargin{:});
    in = p.Results;
   
    frames = msf_framesig(speech,in.winlen*fs,in.winstep*fs,@(x)hamming(x));
    pspec = 1/in.nfft*abs(fft(frames,in.nfft,2)).^2;
    pspec = pspec(:,1:in.nfft/2);
end
