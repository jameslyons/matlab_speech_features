%% msf_delta - Delta Feature calculation
%
%   function delta = msf_delta(feat, N)
%
% * |feat| - a matrix with each row being the feature vector extracted from a frame
% * |N| - for each frame, calculate delta features based on preceding and following N frames
%
% Example usage:
%
%   d_mfcc = msf_delta(mfcc, 2);
%   dd_mfcc = msf_delta(d_mfcc, 2);
%
function delta = msf_delta(feat, N)
    delta_filter = (N:-1:-1*N);
    denom = sumsqr(delta_filter);
    delta = zeros(size(feat));
    for feat_dim = 1:size(feat, 2)
        tmp = filter(delta_filter, denom, [ones(N,1); feat(:,feat_dim); ones(N,1)]);
        delta(:,feat_dim) = tmp(2*N+1:size(tmp));
    end
end
