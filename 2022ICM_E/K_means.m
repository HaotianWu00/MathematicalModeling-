clc
clear
rng('default')
X= [0.6190 0.5260;
    0.4634 0.7803;
    0.6953 0.5109;
    0.5845 0.5773;
    0.4303 1.0000;
    0.4333 0.8555;
    0.6864 0.5421;
    0.5578 0.4966
    0.4265 0.8965];
    

 [idx, C] = kmeans(X, 2);
 figure
 plot(X(:,1), X(:,2),'.')
 title 'wu'
 figure
 plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',30)
 hold on
 plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',30)
 hold on
 plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)
 legend('Social benefit type', 'Carbon sequestration type', 'Centroids', 'Location', 'NW')
 hold off