function res = inrange(x,a,b)
% if a<=x<=b then returns true, else false
% this function is passed as an arg to addOptional from inputParser.

    if (x >= a) && (x <= b)
        res = true;
    else
        s = sprintf('expected input to be %0.4f<=x<=%0.4f, x is %0.4f.\n',a,b,x);
        error(s);
        res = false;
    end
end
