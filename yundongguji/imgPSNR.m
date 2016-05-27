function psnr = imgPSNR(imgP, imgComp, n)

[row col] = size(imgP);   %读取图像大小

Err = 0;                  %err先置零，方便之后的for循环计算

for i = 1:row
    for j = 1:col
        Err = Err + (imgP(i,j) - imgComp(i,j))^2;  %求恢复帧与当前帧的square误差值
    end
end
mse = Err / (row*col);     %计算得出均方误差值（n*n）

psnr = 10*log10(n*n/mse);  %利用pnsr的计算公式，得出峰值信噪比的值