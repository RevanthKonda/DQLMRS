clc, clear all;
close all;

trials = 1;
eps = 50;
time_steps = 800;

rewards_end = zeros(eps,trials);
dtheta_trial = zeros(eps*time_steps,trials); 


for jjj = 1:trials 

lower_limit = 0;
upper_limit = 50;
n = 15;

k = 1.2;
d = 30;
r = k*d;
delta_t = 0.009;
e = 0.1;

s = rng;

dalpha = (sqrt(1 + e*d^2) - 1)/e;
ralpha = (sqrt(1 + e*r^2) - 1)/e;

positionx = zeros(n,time_steps);
positiony = zeros(n,time_steps);
velocityx = zeros(n,time_steps);
velocityy = zeros(n,time_steps);
velocity = zeros(n,time_steps);
connectivity = zeros(time_steps,1);

pcom = zeros(time_steps,2);

action_list = {[420 0];[640 200];[200 200];[420 400]};
act = zeros(n,2);
act_index = zeros(n,1);

action_1 = [420,200];

num_rbf = 2;

theta = rand(num_rbf*4,15);
rewards = zeros(n,1);
states_prev = zeros(n,2);
states_current = zeros(n,2);

rewards_total = zeros(eps*time_steps,1);
rewards_agent = zeros(eps*time_steps,n);
action_selection = zeros(eps*time_steps,n);

dummy = 0;
dtheta = zeros(eps*time_steps,1); 

 
for j = 1:eps
    
    p = Initialize(n,upper_limit,lower_limit);
    q = Initialize(n,1,0);
    u = zeros(n,2);
    states_current(1:n,:) = 0;
    states_prev(1:n,:) = 0;
        
    prob = rem(j,4);
    
    if prob == 1
        choice = 1;
    elseif prob == 2
        choice = 2;        
    elseif prob == 3
        choice = 3;
    elseif prob == 0
        choice = 4;
    end


    for i = 1:time_steps

        dummy = dummy + 1;
        
        theta_init = theta;

        
        positionx(:,i) = p(:,1);
        positiony(:,i) = p(:,2);
        velocityx(:,i) = q(:,1);
        velocityy(:,i) = q(:,2);

        [A,A1] = adjacency(p,n,r);
        connections = neighbours(A,n);
        connectivity(i,1) = rank(A)/n;
        
        do = 30;
        ro = [];
        po = [];
        
        num_obstacles = length(ro);
        for number = 1:num_obstacles

            [poso(:,:,number), ~ ,B(:,number)] = oadjacency(p,q,po(number,:),n,r,ro(number));

        end
        
        w = 1;
        rp = [15];
        
        if choice == 1
            
            pp = [700-i,200];
            qp = [-w,0];
            
        elseif choice == 4
            
            pp = [420, -100+i];
            qp = [0,w];
            
        elseif choice == 3
            
            pp = [420, 600-i];
            qp = [0,-w];
            
        elseif choice == 2
            
            pp = [i, 200];
            qp = [w,0];     
            
        end  
                

        num_predators = length(rp);
        for number = 1:num_predators

            [posp(:,:,number), ~ ,Bp(:,number),Bpse(:,number),dan(:,number),direction(:,:,number)] = padjacency2(p,q,pp(number,:),qp(number,:),n,r,rp(number),connections);

        end

        
        states_prev = get_states_test(n,direction);
        pcom(i,:) = [mean(p(:,1)),mean(p(:,2))];
        
                
         if isequal(states_current,zeros(15,2)) ~= 1
            states_prev = states_current; 
         end
        
        
         if isequal(states_prev,zeros(15,2)) == 1
             
             for jj = 1:n
             act(jj,:) = action_1;
             end
             
         else
            
            [act,act_index,~] = action_choice(action_list,n,states_prev,theta);

         end
            

      %if (j == eps - 1) || (j == eps) || (j == eps - 2) || (j == eps - 3)
      %if (j == 1) || (j == 2) || (j == eps - 1) || (j == eps)
%       if (j == 1) || (j == 2)
%       %if (j == 1)
% 
%         
%            frame = figure(1);
%             figure(1);
%             obstacle(po,ro);
%             for number = 1:num_obstacles
% 
%                 connect(p,poso(:,:,number),B(:,number),n);
% 
%             end 
%             obstacle(pp,rp);
%             for number = 1:num_predators
% 
%                 connect(p,posp(:,:,number),Bp(:,number),n);
% 
%             end
%             gplot(A1,p,'b');
%             hold on;
%             if isequal(states_prev,zeros(15,2))~= 1
% 
%             plot(action_list{1}(1),action_list{1}(2),'o','MarkerEdgeColor','b','MarkerFaceColor','b');
%             hold on;
%             plot(action_list{2}(1),action_list{2}(2),'o','MarkerEdgeColor','b','MarkerFaceColor','b');
%             hold on;
%             plot(action_list{3}(1),action_list{3}(2),'o','MarkerEdgeColor','b','MarkerFaceColor','b');
%             hold on;
%             plot(action_list{4}(1),action_list{4}(2),'o','MarkerEdgeColor','b','MarkerFaceColor','b');
%             hold on; 
%             
%             end
%             plot(p(:,1),p(:,2),'>','MarkerEdgeColor','m','MarkerFaceColor','m');
%             hold on;
%             circle(p,n,r+30);
%             hold on;
%             plot(mean(p(:,1)),mean(p(:,2)),'*','MarkerEdgeColor','g','MarkerFaceColor','g');
%             hold off;
%             title(j);
%             xlim([-50,750]);
%             ylim([-100,650]);
%             drawnow;
%         
%        end

        u = input_QRL(n,e,do-2,ralpha,dalpha,p,q,act,po,ro,pp,qp,rp,do,A,connections);
        
        p0 = p;
        q0 = q;

        q = q0 + u*delta_t;
        p = p0 + q*delta_t + (u*delta_t^2)/2;
        
        
        [A,A1] = adjacency(p,n,r);
        connections = neighbours(A,n);
        connectivity(i,1) = rank(A)/n;
        
        
        for number = 1:num_predators

            [~, ~ ,~,Bpse(:,number),dan(:,number),direction(:,:,number)] = padjacency2(p,q,pp(number,:),qp(number,:),n,r,rp(number),connections);

        end
        
        states_current = get_states_test(n,direction);
        

        rewards = getrewards2(connections,n,dan);
        
       if isequal(states_prev,zeros(15,2)) ~= 1
           
            states_current = states_prev;  
            [~,~,max_value] = action_choice(action_list,n,states_current,theta);    
            theta = update_theta(theta,states_prev,rewards,act_index,max_value,connections,num_rbf);
                        
       end
        
        rewards_total(dummy,1) = sum(rewards);
        rewards_agent(dummy,:) = rewards;
        
        action_selection(dummy,:) = act_index;  
        dtheta(dummy,1) = mean(abs(theta - theta_init),'all');

        
    end
    
    rewards_end(j,jjj) = sum(rewards);

end

dtheta_trail(:,jjj) = dtheta;

end

% figure(2);
% for i = 1:n    
%     plot(rewards_agent(:,i));
%     hold on;   
% end
% title('Rewards of Each Agent');
% xlabel('Iterations');
% ylabel('Reward');
% grid on;
% 
figure(3);
plot(sum(action_selection'),'LineWidth', 1.25);
title('Action Selection of all Agent');
xlabel('iterations');
ylabel('Action Selection');
xlim([1,eps*time_steps]);
ylim([0 70]);
grid on;

figure(4);
for i = 1:trials
plot(rewards_end(:,i),'LineWidth', 1.25);
hold on;
end
title('Total Rewards');
xlabel('Episodes');
ylabel('Total Reward');
xlim([0, eps]);
grid on;
 
figure(5);
plot(dtheta,'LineWidth', 1.25);
hold on;
title('DeltaTheta');
xlabel('Iterations');
ylabel('DeltaTheta');
xlim([1,eps*time_steps]);
grid on;