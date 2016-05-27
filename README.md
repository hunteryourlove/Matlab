# Matlab
#some codes which are written on Matlab
在这里我会把所有在matlab这个编程平台上所学到的，所编写过的代码，上传到这个仓库
<h1>运动估计</h1>
<a href="https://github.com/hunteryourlove/Matlab/tree/master/yundongguji">点击我查看代码</a>
<h5>主文件是yundongguji.m</h5>
* 1.运行该m文件，程序会自动load mydata.mat文件，读取里面的openflag
* 2.如果openflag的值为1，则判定为已登陆状态；若为0，则判定当前为未登录状态
* 3.openflag==1，进入主程序yundongguji.m界面
* 4.openflag==0，自动运行please.m文件，please.m的界面会提示需要登录，选择“登陆”button，跳转到登陆界面
  * 登陆界面=》正确输入账号密码（测试账号：123456789；密码：12345678）登陆到主程序界面
  * 注册界面=》注册账号密码，写入到data.xlsx文件中（作为数据库使用）
