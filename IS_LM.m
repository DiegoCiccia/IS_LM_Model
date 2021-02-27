%% IS-LM Model: Fiscal and Monetary Policy
%% Author: Diego Ciccia

%% Combined Fiscal and Monetary Policy
% The number of parameters in A and Ms must be equal
N=1000;
A=[10, 20];%Autonomous Expenditure
c=0.3; %Marginal Propensity to consume
a=1;b=0.9; %Orthodox Keynesian Estimates
m=0.3; %Money demand income elasticity
Ms=[50, 60]; %Money Supply
P=25; %Price level

StartWith= 0; %Put 0 to begin with fiscal policy, 1 for monetary policy

Arep=repelem(A,2);
Msrep=repelem(Ms,2);
dx=0.3;

if StartWith == 0 %Creates the combinations of Ms e A for each policy environment
    AMs=[Arep(2:end);Msrep(1:end-1)];            
else
    AMs=[Arep(1:end-1);Msrep(2:end)];
end

for k=1:length(AMs)

    Yr_IS=zeros(N,2);
    Yr_LM=zeros(N,2);
    r=10;


    for i=1:N
        Yr_IS(i,1)= (AMs(1,k)/(1 -c))-((a*r)/(1-c));
        Yr_IS(i,2)=r;
        Yr_LM(i,1)= ((1/m)*(AMs(2,k)/P))+((b/m)*r);
        Yr_LM(i,2)=r;
        r=r-0.01;
    end

    plot(Yr_IS(:,1),Yr_IS(:,2), 'r', 'DisplayName', ['IS', num2str(k)])
    hold on
    grid on
    plot(Yr_LM(:,1),Yr_LM(:,2), 'b', 'DisplayName', ['LM', num2str(k)])
    title("The IS-LM Model")
    xlabel("Income")
    ylabel("Interest Rate")

    MatrA=[1, a/(1-c);m, -b];
    MatrBY=[AMs(1,k)/(1-c),a/(1-c) ;AMs(2,k)/P, -b];
    MatrBr=[1, AMs(1,k)/(1-c); m, AMs(2,k)/P];

    Yeq=det(MatrBY)/det(MatrA);
    req=det(MatrBr)/det(MatrA);

    scatter(Yeq,req,'filled','k','HandleVisibility','off' )
    text(Yeq+dx, req, ['E', num2str(n+k-1)])
    plot([Yeq,Yeq],[0, req], '--k','HandleVisibility','off')
    plot([0, Yeq], [req, req], '--k', 'HandleVisibility','off')
    drawnow
    pause(1)
    
    legend
end

