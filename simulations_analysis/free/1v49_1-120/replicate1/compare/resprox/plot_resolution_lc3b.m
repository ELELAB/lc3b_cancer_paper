%%
clc;
clear all;

% [dummy1,modelno,resol_a14, dummy2]=textread(sprintf('a14/a14_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_rsff1, dummy2]=textread(sprintf('rsff1/rsff1_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_rsff2, dummy2]=textread(sprintf('rsff2/rsff2_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_charmm22star, dummy2]=textread(sprintf('charmm22star/charmm22star_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_charmm27, dummy2]=textread(sprintf('charmm27/charmm27_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_charmm36, dummy2]=textread(sprintf('charmm36/charmm36_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% 
% [dummy1,modelno,resol_amber99star_ildn, dummy2]=textread(sprintf('amber99star-ildn/amber99star-ildn_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_amber99star_ildn_q, dummy2]=textread(sprintf('amber99star-ildn-q/amber99star-ildn-q_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% [dummy1,modelno,resol_amber99star_nmr, dummy2]=textread(sprintf('amber99star-nmr/amber99star-nmr_resol.txt'),'%s %s %f %s',101,'headerlines',1);
% 
% [dummy1,modelno,resol_amber99sb_disp, dummy2]=textread(sprintf('amber99sb-disp/amber99sb-disp_resol.txt'),'%s %s %f %s',101,'headerlines',1);


[dummy1,modelno,resol_a14, dummy2]=textread(sprintf('a14/a14_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_rsff1, dummy2]=textread(sprintf('rsff1/rsff1_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_rsff2, dummy2]=textread(sprintf('rsff2/rsff2_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_charmm22star, dummy2]=textread(sprintf('charmm22star/charmm22star_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_charmm27, dummy2]=textread(sprintf('charmm27/charmm27_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_charmm36, dummy2]=textread(sprintf('charmm36/charmm36_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);

[dummy1,modelno,resol_amber99star_ildn, dummy2]=textread(sprintf('amber99star-ildn/amber99star-ildn_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_amber99star_ildn_q, dummy2]=textread(sprintf('amber99star-ildn-q/amber99star-ildn-q_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);
[dummy1,modelno,resol_amber99star_nmr, dummy2]=textread(sprintf('amber99star-nmr/amber99star-nmr_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);

[dummy1,modelno,resol_amber99sb_disp, dummy2]=textread(sprintf('amber99sb-disp/amber99sb-disp_resol_noCNter.txt'),'%s %s %f %s',101,'headerlines',1);


clear dummy* modelno


%%
% resol_a14=nonzeros(resol_a14);
% resol_rsff1=nonzeros(resol_rsff1);
% resol_rsff2=nonzeros(resol_rsff2);
% resol_charmm22star=nonzeros(resol_charmm22star);
% resol_charmm27=nonzeros(resol_charmm27);
% resol_charmm36=nonzeros(resol_charmm36);
% resol_amber99star_nmr=nonzeros(resol_amber99star_nmr);
% resol_amber99star_ildn=nonzeros(resol_amber99star_ildn);
% resol_amber99star_ildn_q=nonzeros(resol_amber99star_ildn_q);
% resol_amber99sb_disp=nonzeros(resol_amber99sb_disp);

resol_a14(find(resol_a14==0)) = NaN;
resol_rsff1(find(resol_rsff1==0)) = NaN;
resol_rsff2(find(resol_rsff2==0)) = NaN;
resol_charmm22star(find(resol_charmm22star==0)) = NaN;
resol_charmm27(find(resol_charmm27==0)) = NaN;
resol_charmm36(find(resol_charmm36==0)) = NaN;
resol_amber99star_nmr(find(resol_amber99star_nmr==0)) = NaN;
resol_amber99star_ildn(find(resol_amber99star_ildn==0)) = NaN;
resol_amber99star_ildn_q(find(resol_amber99star_ildn_q==0)) = NaN;
resol_amber99sb_disp(find(resol_amber99sb_disp==0)) = NaN;

%% plot
figure(1)
boxplot([resol_a14,resol_rsff1,resol_rsff2,resol_charmm22star,resol_charmm27,resol_charmm36,resol_amber99star_nmr,resol_amber99star_ildn,resol_amber99star_ildn_q,resol_amber99sb_disp],'Notch','off');%,...
%     'Labels',{'a14','rsff1','rsff2','charmm22*','charmm27','charmm36','amber99*-nmr','amber99*-ildn','amber99*-ildn-q','amber99sb-disp'})


% plot(repmat(1,100,1), resol_a14([1:93 95:101]),'g','LineWidth',15)
% hold on
% plot(repmat(2,101,1),resol_rsff1,'m','LineWidth',15)
% hold on
% plot(repmat(3,101,1),resol_rsff2,'y','LineWidth',15)
% hold on
% plot(repmat(4,101,1),resol_charmm22star,'r','LineWidth',15)
% hold on
% plot(repmat(5,101,1),resol_charmm27,'c','LineWidth',15)
% hold on
% plot(repmat(6,101,1),resol_charmm36,'k','LineWidth',15)
% hold on
% plot(repmat(7,101,1),resol_amber99star_nmr,'b','LineWidth',15)
% hold on
% plot(repmat(8,101,1),resol_amber99star_ildn,'g','LineWidth',15)
% hold on
% plot(repmat(9,101,1),resol_amber99star_ildn_q,'color',[0.3 0.3 0.3],'LineWidth',15)
% hold on
% plot(repmat(9,101,1),resol_amber99sb_disp,'color',[0.5 0.5 0.5],'LineWidth',15)

xlim([0 11]);
ylim([0 5]);
   

% Create x/y labels
% xlabel('\bf{\fontsize{18} Force Field}');
ylabel('\bf{\fontsize{18} R (Angstrom)}');


set(gca,'XTick',[0 1 2 3 4 5 6 7 8 9 10 11]);
set(gca,'YTick',[0 1 2 3 4 5]);
set(gca,'XTickLabel',{' ', 'a14','rsff1','rsff2','charmm22*','charmm27','charmm36','amber99*nmr','amber99* ildn','amber99*ildn-q','amber99sb-disp',' '},...
    'FontSize',12,'XTickLabelRotation',45);

set(gca,'YTickLabel',[0 1 2 3 4 5],'FontSize',12);

title('Prediction of resolution values for the different ensemble of LC3B (7-116) conformations created by different force fields')


%%
line([0 11],[1.5 1.5],'Color','r','LineWidth', 1,'LineStyle',':','LineWidth',2);

% saveas(figure(1),['resol_ff_allres_matlab_NaN' '.fig']);
% saveas(figure(1),['resol_ff_allres_matlab_NaN' '.tif']);

saveas(figure(1),['resol_ff_noCNter_matlab_NaN' '.fig']);
saveas(figure(1),['resol_ff_noCNter_matlab_NaN' '.tif']);

