function foopsilogical = foopsitological(x)

% foopsilogical = foopsitological(x,badtraces, I)
% FOOPSITOLOTICAL: apply thresholds (for goodtraces,2.5*SD; for badtraces, 
% 0.7) to foopsi traces and convert foopsi to 0 (below threshold, inactive)
% and 1 (above threshold active)
% foopsilogical = foopsitological(x,badtraces)
% where
% x is foopsitraces
% badtraces is the vector contains cell IDs with noise
% See also: TRACETOLOGICAL

% 2012 by Jae-eun K. Miller

[ncell len] = size(x);
threshold=input('threshold is: ');
% if ~exist('I','var'), I=struct; end
% if ~isfield(I,'treshold'), I.threshold=input('threshold is: ');end
% if ~isfield(I,'badcutoff'), I.badcutoff=input('badcutoff is: ');end
% if ~isfield(I,'options'), I.options=input('choose options btw lowco or lhco: ');end

% switch I.options
%     case {'lowco'}
        for i = 1:ncell
            for j = 1:len
                if (x(i,j) >= threshold)
                    x(i,j) = 1;
                else
                    x(i,j) = 0;
                end
            end
        end
        
%     case{'lhco'} % I need to open bradtraces
%         goodtraces = setxor(badtraces,1:ncell); % find only goodtraces
%         for i = badtraces
%             for j = 1:len
%                 if (x(i,j) >= I.badcutoff)
%                     x(i,j) = 1;
%                 else
%                     x(i,j) = 0;
%                 end
%             end
%         end
%         for i = goodtraces
%             for j = 1:len
%                 if (x(i,j) >= I.threshold)
%                     x(i,j) = 1;
%                 else
%                     x(i,j) = 0;
%                 end
%             end
%         end
% end
foopsilogical = x;
save('foopsilogical','foopsilogical')
   
