% % % % % % % % % % % % % % % % % % % % % % % %
%------- by Amin Ebrahimi              -------%
%------- website : http://amin347.ir   -------%
%------- github : https://git.io/f4SW5 -------%
%------- Date : 2018-06-20             -------%
% % % % % % % % % % % % % % % % % % % % % % % %


clc;
clear;
close all;


%% Problem Definition

model = LoadData(); %Create Problem Model
CostFunction = @(tour) TourLenth(tour,model);



%% SA Parameter

MaxIt = 20000;     %Maximum Iteration
MaxSubIt = 20;    %Maximum Iteration For Each Temperature
T0 = 100;         %Initial Temperature
alpha = 0.9;     %Temperature Reduction Rate



%% Initialation

sol.Position = CreateRandomSolotion(model);
sol.Cost = CostFunction(sol.Position);          %Create initial Solution

BestSolotion = sol;         %Initialize Best solution
BestCost=zeros(MaxIt,1);    %Initialize Array To Hold Best Cost

T = T0;     %Initialize Temperature



tic
%% SA Main Loop

for it=1 : MaxIt
    
    
    for subIt=1 : MaxSubIt
        newSol.Position = CreateNeighbor(sol.Position); %Create New Solution
        newSol.Cost = CostFunction(newSol.Position);
        
        if newSol.Cost <= sol.Cost %if newsol best than sol
            sol = newSol;
            
        else
            % DELTA = newSol.Cost - sol.Cost
            DELTA = (newSol.Cost - sol.Cost)/sol.Cost;
            P = exp(-DELTA/T);
            if rand <= P
                sol = newSol;
            end
        end
        
        
        if sol.Cost <= BestSolotion.Cost  %Update Best Solotion
            BestSolotion = sol;
        end
        
    end
    
    BestCost(it) = BestSolotion.Cost; %Update Best Cost
    
    T = alpha*T;    %Update Temperature
    disp(['Iteration ' num2str(it) ' Temperature = ' num2str(T) ' And Best Cost Found = ' num2str(BestCost(it))]);
end




%% Result

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');


figure;
PlotSolution( BestSolotion.Position,model )
toc





