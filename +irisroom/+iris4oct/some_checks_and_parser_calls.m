%% look for @blabla.blabla
%{
pattern = '[^\w]@\w+?\.\w+';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

files = struct('name',[],'lines',[]);

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return

%% kick inputParser workaround out of iris_clone
%{
lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m'); %#ok<UNRCH>
files = {};
for ix = 1 : numel(lst)
    flg = irisroom.iris4oct.isPatternInFile(lst{ix},'=\s*inputParser(');
    if flg
        files = [files,lst{ix}];
    end
end

for ix = 1 : numel(files)
    irisroom.iris4oct.parseFile4inputParser_back(files{ix});
end
%}
% return

%% look for char( in stable iris
%{
pattern = '\<char\(';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return

%% look for $0
%{
pattern = '\$0';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return

%% look for cd(
%{
pattern = 'cd\(\)';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return

%% look for char(0)
%{
pattern = 'char\(0\)';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return

%% look for )?
%{
pattern = '\)\?';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
        end
    end
end
%}
% return


%% look for mosw.isa
%{
pattern = 'mosw\.isa';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

nfor = 0;

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern,nfor);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
            for fx = 1 : nfor
                fprintf('\t%4d: %s\n',lines.n(nx)+fx,lines.fwd{nx}{fx});
            end
        end
    end
end
%}
% return


%% look for ismatlab
%{
pattern = 'ismatlab';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

nfor = 2;

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern,nfor);
    if flg
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
            for fx = 1 : nfor
                fprintf('\t%4d: %s\n',lines.n(nx)+fx,lines.fwd{nx}{fx});
            end
            if fx > 0 && nx < length(lines.n)
                fprintf('\t-----\n');
            end
        end
    end
end
%}
% return

%% look for % ##### MOSW
% {
pattern = '% ##### MOSW';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

nfor = 2;
files = {};
nmatches = 0;

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern,nfor);
    if flg
        files = [files,lst{ix}]; %#ok<AGROW>
        nmatches = nmatches + length(lines.n);
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
            for fx = 1 : nfor
                fprintf('\t%4d: %s\n',lines.n(nx)+fx,lines.fwd{nx}{fx});
            end
            if fx > 0 && nx < length(lines.n)
                fprintf('\t-----\n');
            end
        end
    end
end

for ix = 1 : numel(files)
%     irisroom.iris4oct.parseMoswTrue(files{ix});
    irisroom.iris4oct.parseMoswFalse(files{ix});
end
%}

%% look for % >>>>> MOSW
% {
pattern = '% >>>>> MOSW';

lst = irisroom.iris4oct.irisfulldirlist('files',true,'fileExt','.m');

nfor = 2;
files = {};
nmatches = 0;

for ix = 1 : numel(lst)
    [flg, lines] = irisroom.iris4oct.isPatternInFile(lst{ix},pattern,nfor);
    if flg
        files = [files,lst{ix}]; %#ok<AGROW>
        nmatches = nmatches + length(lines.n);
        fprintf('\n[file]: %s\n\t[lines]:\n',lst{ix});
        for nx = 1 : length(lines.n)
            fprintf('\t%4d: %s\n',lines.n(nx),lines.str{nx});
            for fx = 1 : nfor
                fprintf('\t%4d: %s\n',lines.n(nx)+fx,lines.fwd{nx}{fx});
            end
            if fx > 0 && nx < length(lines.n)
                fprintf('\t-----\n');
            end
        end
    end
end

for ix = 1 : numel(files)
    irisroom.iris4oct.parseMoswLine(files{ix});
end
%}
