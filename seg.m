clear;
close all;
clc;

img=imread('finger.png');
%img = rgb2gray(img);
imgn=img>128;

s=uint8(1-imgn);

[m, n]=size(s);
tmp=zeros(m,n);     %标记图像
label=1;
queue_head=1;       %队列头
queue_tail=1;       %队列尾
neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %和当前像素坐标相加得到八个邻域坐标

for i=2:m-1
    for j=2:n-1
        if s(i,j)==1 && tmp(i,j) ==0           
            tmp(i,j)=label;
            q{queue_tail}=[i j];        %用元组模拟队列，当前坐标入列
            queue_tail=queue_tail+1;
            while queue_head~=queue_tail
                pix=q{queue_head};                
                for k=1:8               %8邻域搜索
                    pix1=pix+neighbour(k,:);
                    if pix1(1)>=2 && pix1(1)<=m-1 && pix1(2) >=2 &&pix1(2)<=n-1
                        if s(pix1(1),pix1(2)) == 1 && tmp(pix1(1),pix1(2)) ==0  %如果当前像素邻域像素为1并且标记图像的这个邻域像素没有被标记，那么标记
                        tmp(pix1(1),pix1(2))=label;
                        q{queue_tail}=[pix1(1) pix1(2)];
                       queue_tail=queue_tail+1;
                        end 
                    end              
                end
                queue_head=queue_head+1;
            end
            
            clear q;                %清空队列，为新的标记做准备
            label=label+1;
            queue_head=1;
            queue_tail=1;            
        end
    
    end
end
imwrite(mat2gray(tmp),'test.png');