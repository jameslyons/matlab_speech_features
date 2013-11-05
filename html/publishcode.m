opts.codeToEvaluate = 'fs=16000;speech=randn(1,100);';
opts.showCode = false;
addpath ..
publish('msf_lsf.m',opts);
publish('msf_lpc.m',opts);
publish('msf_ssc.m',opts);
publish('msf_mfcc.m',opts);
publish('msf_powspec.m',opts);
publish('msf_rc.m',opts);
publish('inrange.m',opts);
publish('msf_framesig.m',opts);
publish('msf_lpcc.m',opts);
publish('msf_filterbank.m',opts);
publish('msf_logfb.m',opts);
publish('msf_lar.m',opts);
