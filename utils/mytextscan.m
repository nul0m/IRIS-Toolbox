function data = mytextscan(fid,varargin)

if ismatlab
    data = textscan(fid,varargin{:});
else
    if isnumeric(varargin{2}) && (varargin{2} == -1)
        varargin(2) = [];
    end
    bix = 2 + isnumeric(varargin{2});
    hlx = bix + find(strcmpi(varargin(bix:2:end),'headerlines'))*2 - 2;
    numHL = 0;
    if ~isempty(hlx)
        numHL = varargin{hlx+1};
        varargin(hlx:hlx+1) = [];
    end
    numHC = 0;
    hcx = bix + find(strcmpi(varargin(bix:2:end),'headercolumns'))*2 - 2;
    if ~isempty(hcx)
        numHC = varargin{hcx+1};
        varargin(hcx:hcx+1) = [];
    end
    cox = bix + find(strcmpi(varargin(bix:2:end),'collectoutput'))*2 - 2;
    data = textscan(fid,varargin{:});
    if numHC > 0
        if varargin{cox+1}
            data = {data{1}(1+numHL:end,1+numHC:end)};
        else
            data = data(1+numHL:end,1+numHC:end);
        end
    end
end

end