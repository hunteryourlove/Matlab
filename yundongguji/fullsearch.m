%初始化handles句柄
handles.output = hObject;
guidata(hObject, handles);
global ima imb endoftoc;                %以全局变量的形式传递当前帧、参考帧图像
ima1=ima;                        %读取第一帧
imb1=imb;                        %读取第二帧

deltam=7;                          %定义搜索范围
ima1=double(ima1);                 %转换精度，防止后续数据运算时溢出
imb1=double(imb1);
[rows cols] = size(ima1);    %得到参考帧的分辨率

imb2=zeros(rows+2*deltam,cols+2*deltam);  %向两边扩充
imb2(deltam+1:deltam+rows,deltam+1:deltam+cols)=ima1;
for i=1:deltam
    imb2(i,deltam+1:deltam+cols)=imb2(deltam+1,deltam+1:deltam+cols);
    imb2(rows+deltam+i,deltam+1:deltam+cols)=imb2(deltam+rows,deltam+1:deltam+cols);
end
for j=1:deltam
    imb2(1:rows+2*deltam,j)=imb2(1:rows+2*deltam,deltam+1);
    imb2(1:rows+2*deltam,cols+deltam+j)=imb2(1:rows+2*deltam,deltam+cols);
end

%全局搜索算法实现
 blocksize=16;                  %匹配的块大小为16
 rowblocks =rows/blocksize;
 colblocks =cols/blocksize;
 A=66666666666666666666;         %为了找到最小的均方误差，A用于设定一个很大的初值
 Emn=0;
 No_x=ones(blocksize,blocksize);            %No_x，No_y用于存放匹配块的块号，即运动矢量
 No_y=ones(blocksize,blocksize);
 diff=zeros(rows,cols);             %这幅图像的大小为256*256，diff用于存放像素差值
 tic
                for x=0:(rowblocks-1)         %x表示行中第几个子块
                    row=x*blocksize;
                   for y=0:(colblocks-1)         %y表示列中第几个子块
                       col=y*blocksize;
                                 for p=-deltam:deltam         %搜索范围：-7~7
                                    for q=-deltam:deltam      %（p，q）表示在x，y对应子块在前一帧中所的搜索位置
                                        Emn=0;
                                        Emn=sum(sum((imb1(row+1:row+blocksize,col+1:col+blocksize)-imb2(row+deltam+p+1:row+deltam+p+blocksize,col+deltam+q+1:col+deltam+q+blocksize)).^2))/(blocksize^2); 
                                        if Emn<A
                                                    A=Emn;
                                                    No_x(x+1,y+1)=p;
                                                    No_y(x+1,y+1)=q;
                                            end   
                                    end
                                end
                                 A=66666666666666666666;
                                for mx=1:blocksize
                                    for ny=1:blocksize
                                        diff(row+mx,col+ny)=imb1(row+mx,col+ny)-imb2(row+mx+deltam+No_x(x+1,y+1),col+ny+deltam+No_y(x+1,y+1));
                                    end
                                end
                                        
                   end
                       
                end
toc
endoftoc=toc;
set(handles.text3,'String',toc);         %gui界面显示算法运行时间


%%绘图            
                     
                         for x=0:(rowblocks-1)             %x表示行中第几个子块
                             row=x*blocksize;
                             for y=0:(colblocks-1)         %y表示列中第几个子块
                                 col=y*blocksize;
                                 %求出恢复出来的图像imb3，即参考图像+预测误差
                                 imb3(row+1:row+blocksize,col+1:col+blocksize)=imb2(row+deltam+No_x(x+1,y+1)+1:row+deltam+No_x(x+1,y+1)+blocksize,col+deltam+No_y(x+1,y+1)+1:col+deltam+No_y(x+1,y+1)+blocksize)+diff(row+1:row+blocksize,col+1:col+blocksize);
                             end
                         end
                         imb3=ima1+diff;
                         axes(handles.axes4);%使恢复帧显示在gui界面
                         imshow(imb3,[]);
                         
FSpsnr = imgPSNR(imb1, imb3, 255);       %峰值信噪比计算
set(handles.text7,'String',FSpsnr);        %将结果输出到前端  
axes(handles.axes3);%初始化头部背景
quiver(1:16,1:16,No_y,No_x);
 grid on;
                   

        