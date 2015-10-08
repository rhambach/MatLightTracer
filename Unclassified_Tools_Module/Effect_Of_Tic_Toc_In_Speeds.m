function Effect_Of_Tic_Toc_In_Speeds
% compare the speeds between using tic tocs and not
% COnclusion: When tic statement is added inside a function that is looped
% by a for loop many times, each time it is executed, the clock resets so
% the function with tic statement seems to have smaller execution time than
% theat without, but actually that is not the case.

% The following example shows this effect clearly. Eventhought both
% functions take about 1.5 sec , the time reported by the function with tic
% statement is much lower than 1.5 sec. It is just the time statrting from
% the last call to the function

n = 10;
n2 = 1000000;
disp('With tic toc');
tic
for p2 = 1:n2
PerformLoopFunction_With(n);
end
toc
 
disp('With out tic toc');
tic
for p2 = 1:n2
PerformLoopFunction_WithOut(n);
end
toc
end

function PerformLoopFunction_With(n)
    tic
    total = 0;
    for p = 1:n
        total = total + p^2;
    end
end

function PerformLoopFunction_WithOut(n)
    total = 0;
    for p = 1:n
        total = total + p^2;
    end
end