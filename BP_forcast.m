%% 此程序为matlab编程实现的BP神经网络做时间序列预测
% 程序来源于网络，略有修改

%% 清空环境变量
clear
close all
clc
%% 第一步，输入原始时间序列，x为行向量
% x=[31.71428571 27.75555556 30.38333333 30.09090909 32.69512195 30.95945946 27.52631579 25.33333333 29.28571429 32.18421053 29.85483871 28.58227848 32.42105263 30.87654321 30.33333333 25.6025641 29.40506329 28.2375 18.7721519];
x=[11 5	4 7	16 6 5 7 13	6 5	7 12 5 4 6 9 5 5 11	29 21 17 20 27 13 9	10 16 6	5 7 11 5	5	6	12	7	7	10 15	10	9	11	15	10	10	16 26	21	23	36	50	45	45	49 57	43	40	44	52	43	42	45 52	41	39	41	48	35	34	35 42	34	36	43	55	48	54	65 80	70	74	85	101	89	88	90 100	87	88	89	104	89	89	90 106	96	94	99	109	99	96	102];
%% 第二步 构建神经网络输入基本格式

lag=8;% 自回归阶数，代表用前 lag 个数预测后一个数

iinput=x;% x为原始序列（行向量）
n=length(iinput);

%准备输入和输出数据
inputs=zeros(lag,n-lag); % inputs 训练输入
for i=1:n-lag
    inputs(:,i)=iinput(i:i+lag-1)';
end
targets=x(lag+1:end); % targets 训练输出
 
%% 第三步 创建网络相关参数
%创建网络
hiddenLayerSize = 10; %隐藏层神经元个数
net = fitnet(hiddenLayerSize);
 
% 避免过拟合，划分训练，测试和验证数据的比例
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
 
%训练网络
[net,tr] = train(net,inputs,targets);
%% 第四步 根据图表判断拟合好坏
yn=net(inputs);  % yn为神经网络计算后的拟合值
errors=targets-yn;  % 误差
figure, ploterrcorr(errors)  % 绘制误差的自相关图（20lags）
figure, parcorr(errors)  % 绘制偏相关情况
[h,pValue,stat,cValue]= lbqtest(errors); %Ljung－Box Q检验（20lags）
figure,plotresponse(con2seq(targets),con2seq(yn))   %看预测的趋势与原趋势
figure, ploterrhist(errors)  %误差直方图
figure, plotperform(tr)  %误差下降线
 
 
%% 第五步 下面预测往后预测几个时间段
fn=8;  %预测步数为fn
 
f_in=iinput(n-lag+1:end)';
f_out=zeros(1,fn);  %预测输出
% 多步预测时，用下面的循环将网络输出重新输入
for i=1:fn
    f_out(i)=net(f_in);
    f_in=[f_in(2:end);f_out(i)];
end
% 画出预测图
%figure,plot(2003:2022,iinput,'bo-',2022:2025,[iinput(end),f_out],'r-^'); % 例1 的图象


figure,plot(1:n,iinput,'bo-',n:(n+fn),[iinput(end),f_out],'r-^'); % 例2 的图象
