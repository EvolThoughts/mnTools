function branchtypeprobfigures(controlanalysis,testanalysis)
% Branch type probability figures

mnoptions;

titlefontsize = option.mnfigures.titlefontsize;
labelfontsize = option.mnfigures.labelfontsize;
axesfontsize  = option.mnfigures.axesfontsize;
insetfontsize = option.mnfigures.insetfontsize;

indbluemarkersize  = option.mnfigures.indbluemarkersize;
indgreenmarkersize = option.mnfigures.indgreenmarkersize;
indredmarkersize   = option.mnfigures.indredmarkersize;
bluemarkersize     = option.mnfigures.bluemarkersize;
greenmarkersize    = option.mnfigures.greenmarkersize;
redmarkersize      = option.mnfigures.redmarkersize;
cyanmarkersize     = option.mnfigures.cyanmarkersize;
yellowmarkersize   = option.mnfigures.yellowmarkersize;
magentamarkersize  = option.mnfigures.magentamarkersize;

piecetypes{1} = 'soma';
piecetypes{2} = 'axon';
piecetypes{3} = 'dendrite';
piecetypes{4} = 'apical';

piecetitles{1} = 'Somatic';
piecetitles{2} = 'Axonal';
piecetitles{3} = 'Dendritic';
piecetitles{4} = 'Apical';

versuses{1} = 'diameter';
versuses{2} = 'pathlength';
versuses{3} = 'radialdistance';
versuses{4} = 'branchorder';

versusestitles{1} = 'Diameter';
versusestitles{2} = 'Path Length';
versusestitles{3} = 'Radial Distance';
versusestitles{4} = 'Branch Order';

for piecetype = 2:4
    
    if nargin == 1
        goahead = true;
    else
        if isfield(testanalysis,piecetypes{piecetype})
            goahead = true;
        else
            goahead = false;
        end
    end
    
    if isfield(controlanalysis,piecetypes{piecetype}) && goahead
        
        currentpiecetype = piecetypes{piecetype};
        currentpiecetitle = piecetitles{piecetype};
        eval(['controltype = controlanalysis.' currentpiecetype ';']);
        if nargin > 1
            eval(['testtype = testanalysis.' currentpiecetype ';']);
        end
        
        for versus = 1:4
            
            currentversus = versuses{versus};
            currentversustitle = versusestitles{versus};
            
            eval(['x1 = [controltype.' currentversus '.' currentversus ']'';']);
            if ~strcmp('branchorder',currentversus)
                eval(['b1 = [controltype.' currentversus '.numberbifurcatingbranches.mean]'';']);
                eval(['t1 = [controltype.' currentversus '.numberterminatingbranches.mean]'';']);
            else
                eval(['b1 = [controltype.' currentversus '.numberbifurcations.mean]'';']);
                eval(['t1 = [controltype.' currentversus '.numberterminations.mean]'';']);
            end
            n1 = b1 + t1;
            b1param = glmfit(x1,[b1 n1],'binomial','link','logit');
            t1param = glmfit(x1,[t1 n1],'binomial','link','logit');
            b1fit = glmval(b1param,x1,'logit','size',n1);
            t1fit = glmval(t1param,x1,'logit','size',n1);
            if nargin == 2
                eval(['x2 = [testtype.' currentversus '.' currentversus ']'';']);
                if ~strcmp('branchorder',currentversus)
                    eval(['b2 = [testtype.' currentversus '.numberbifurcatingbranches.mean]'';']);
                    eval(['t2 = [testtype.' currentversus '.numberterminatingbranches.mean]'';']);
                else
                    eval(['b2 = [testtype.' currentversus '.numberbifurcations.mean]'';']);
                    eval(['t2 = [testtype.' currentversus '.numberterminations.mean]'';']);
                end
                n2 = b2 + t2;
                b2param = glmfit(x2,[b2 n2],'binomial','link','logit');
                t2param = glmfit(x2,[t2 n2],'binomial','link','logit');
                b2fit = glmval(b2param,x2,'logit','size',n2);
                t2fit = glmval(t2param,x2,'logit','size',n2);
            end
            figure;
            
            subplot(2,1,1);
            legendhandle1 = gca;
            hold on;
            ylabel('Number of Segments','FontSize',labelfontsize,'FontWeight','b');
            if nargin == 1
                plot(x1,n1,'b','LineWidth',2);
                plot(x1,b1,'sg','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',indgreenmarkersize);
                plot(x1,t1,'dr','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',indredmarkersize);
            else
                plot(x1,n1,'b','LineWidth',2);
                plot(x1,b1,'sg','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',greenmarkersize);
                plot(x1,t1,'dr','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',redmarkersize);
                plot(x2,n2,'c','LineWidth',1.5);
                plot(x2,b2,'sy','MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',yellowmarkersize);
                plot(x2,t2,'dm','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',magentamarkersize);
            end
            set(gca,'FontSize',axesfontsize);
            hold off;
            
            subplot(2,1,2);
            legendhandle2 = gca;
            hold on;
            ylabel('Branch Type Prob','FontSize',labelfontsize,'FontWeight','b');
            xlabel(currentversustitle,'FontSize',labelfontsize,'FontWeight','b');
            if nargin == 1
                plot(x1,b1./n1,'sg','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',indgreenmarkersize);
                plot(x1,b1fit./n1,'-g','LineWidth',2);
                plot(x1,t1./n1,'dr','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',indredmarkersize);
                plot(x1,t1fit./n1,'-r','LineWidth',2);
            else
                plot(x1,b1./n1,'sg','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',greenmarkersize);
                plot(x1,b1fit./n1,'-g','LineWidth',2);
                plot(x1,t1./n1,'dr','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',redmarkersize);
                plot(x1,t1fit./n1,'-r','LineWidth',2);
                plot(x2,b2./n2,'sy','MarkerEdgeColor','y','MarkerFaceColor','y','MarkerSize',yellowmarkersize);
                plot(x2,b2fit./n2,'-y','LineWidth',1.5);
                plot(x2,t2./n2,'dm','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',magentamarkersize);
                plot(x2,t2fit./n2,'-m','LineWidth',1.5);
            end
            set(gca,'FontSize',axesfontsize);
            hold off;
            
            currentdirectory = cd;
            %subplotspace('vertical',-15);
            
            if nargin == 1
                [ignore,h]=suplabel([controlanalysis.inputfilename ' -- ' currentpiecetitle ' Branch Type Probability vs ' currentversustitle]  ,'t');
                set(h,'FontSize',titlefontsize);
                legend(legendhandle1,[controlanalysis.inputfilename ' Total'],[controlanalysis.inputfilename ' Bifs'],[controlanalysis.inputfilename ' Terms'],'Location','NorthEast');
                legend(legendhandle2,[controlanalysis.inputfilename ' Bif Prob'],[controlanalysis.inputfilename ' Logit Fit'],[controlanalysis.inputfilename ' Term Prob'],[controlanalysis.inputfilename ' Logit Fit'],'Location','NorthEast');
                cd(controlanalysis.datapathname);
                if exist(piecetypes{piecetype},'dir') ~= 7
                    mkdir(piecetypes{piecetype});
                end
                cd(piecetypes{piecetype});
                if exist('figures','dir') ~= 7
                    mkdir('figures');
                end
                cd('figures');
                filename = sprintf('%s_%s_04_Type_Prob_vs_%s',controlanalysis.inputfilename,currentpiecetype,currentversus);
            else
                [ignore,h]=suplabel([controlanalysis.inputfilename ' vs ' testanalysis.inputfilename ' -- ' currentpiecetitle ' Branch Type Probability vs ' currentversustitle]  ,'t');
                set(h,'FontSize',titlefontsize);
                legend(legendhandle1,[controlanalysis.inputfilename ' Total'],[controlanalysis.inputfilename ' Bifs'],[controlanalysis.inputfilename ' Terms'],[testanalysis.inputfilename ' Total'],[testanalysis.inputfilename ' Bifs'],[testanalysis.inputfilename ' Terms'],'Location','NorthEast');
                legend(legendhandle2,[controlanalysis.inputfilename ' Bif Prob'],[controlanalysis.inputfilename ' Logit Fit'],[controlanalysis.inputfilename ' Term Prob'],[controlanalysis.inputfilename ' Logit Fit'],[testanalysis.inputfilename ' Bif Prob'],[testanalysis.inputfilename ' Logit Fit'],[testanalysis.inputfilename ' Term Prob'],[testanalysis.inputfilename ' Logit Fit'],'Location','NorthEast');
                cd(testanalysis.datapathname);
                cd ..
                if exist(sprintf('%s_%s_comparison',controlanalysis.inputfilename,testanalysis.inputfilename),'dir') ~= 7;
                    mkdir(sprintf('%s_%s_comparison',controlanalysis.inputfilename,testanalysis.inputfilename));
                end
                cd(sprintf('%s_%s_comparison',controlanalysis.inputfilename,testanalysis.inputfilename));
                if exist(piecetypes{piecetype},'dir') ~= 7
                    mkdir(piecetypes{piecetype});
                end
                cd(piecetypes{piecetype});
                filename = sprintf('%s_%s_%s_04_Type_Prob_vs_%s',controlanalysis.inputfilename,testanalysis.inputfilename,currentpiecetype,currentversus);
            end
            
            print('-djpeg',filename);
            if strcmp(option.mnfigures.matfig,'y')
                saveas(gcf,filename,'fig');
            end
            
            cd(currentdirectory);
            
        end
    end
end
