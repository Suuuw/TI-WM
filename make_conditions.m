clear

rootdir = 'D:\TIWM2022\Processing';

% rootdir = 'F:\experiments\DVF\onset_behavioral';
% rootdir = 'F:\fmri(language_inhibition)\fmri\analysis\inhibition\pilot_data';
ffxdir = 'ffx\M1';
onsetsfile = 'ffx\onsets\onset';
% onsetsfile = 'onsets_behavioral/onsets_n21';
% onsetsfile = 'behavioural/onsets/onsets_allsub_fMRI_WordMVPA_pilot3';

scan_no = {...
     '31',...  
%    , '01','02','03','04','06','08','09','10','22','25','35','36','37','38','39','40'...
       };
        
session_no = {...
         'session1','session2','session3','session4','session5','session6','session7','session8', ...    
        };

nsub = size((scan_no),2);
nsess = size((session_no),2);

if ~exist(fullfile(rootdir,ffxdir,'conditions_files'),'dir')
    mkdir(fullfile(rootdir,ffxdir,'conditions_files'))
end

onsetsfilename = [onsetsfile,'.mat'];
load(fullfile(rootdir,onsetsfilename));

for sub = 1:nsub
%     for sess = 1
    for sess = 1:nsess
        names = {'BACK1','BACK3','errors'};
        durations = cell(1,size(names,2));
        onsets = cell(1,size(names,2));
%         mods = {'competition','selection'};
% these four modulators are treated in parallel.

%         erroritems=eval(['error_',scan_no{sub}]);
        erroritems=eval(['ACC_',scan_no{sub}]);
          onsets_sub=eval(['onset_',scan_no{sub}]);


%                 onsets{1,1} = onsets_sub(session == sess);
%                 durations{1,1} = 0; 
                
                for i=1:2
                    onsets{1,i} = onsets_sub(session == sess & condition == i & erroritems == 1);
                    durations{1,i} = 1;
                end
                
                onsets{1,3} = onsets_sub(session == sess & erroritems == 0);
                durations{1,3} = 1;                

                
%             condfilename = ['conditions_',scan_no{sub},'_task_',num2str(sess),'.mat'];
            condfilename = ['conditions_',scan_no{sub},'_',session_no{sess},'.mat'];
            condfilename = fullfile(rootdir,ffxdir,'conditions_files',condfilename);
            save(condfilename,'names','onsets','durations');
%             save(condfilename,'names','onsets','durations','pmod');
        end
        fprintf('Done: %s\n',scan_no{sub})
   
end

