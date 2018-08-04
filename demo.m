clear
load ('ionosphere.mat');

x1=mapminmax(x1',0,1);
x2=mapminmax(x2',0,1);

data=x1';
data2=x2';
[M,N]=size(data);
g=2;c=1;d=1;gamma=0.1;
tic
indices=crossvalind('Kfold',data(1:M,N),5);
for k=1:5
    test = (indices == k);
    train = ~test;
    train_data=data(train,:);
    train_data2=data2(train,:);
    train_target=y(train,:);
    test_data=data(test,:);
    test_data2=data2(test,:);
    test_target=y(test,:);

    model=rpsvm2v(train_data,train_data2,train_target,'rbf',c,c,d,g,gamma);
    accuracy(k)=predict_rpsvm2v(model,test_data,test_data2,test_target);
    clear model;
end
accuracy21=mean(accuracy);
fprintf('rpsvm2v %.4f\n',mean(accuracy21));
toc
