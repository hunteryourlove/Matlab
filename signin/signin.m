function varargout = signin(varargin)
% SIGNIN MATLAB code for signin.fig
%      SIGNIN, by itself, creates a new SIGNIN or raises the existing
%      singleton*.
%
%      H = SIGNIN returns the handle to a new SIGNIN or the handle to
%      the existing singleton*.
%
%      SIGNIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNIN.M with the given input arguments.
%
%      SIGNIN('Property','Value',...) creates a new SIGNIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signin

% Last Modified by GUIDE v2.5 14-May-2016 23:15:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signin_OpeningFcn, ...
                   'gui_OutputFcn',  @signin_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before signin is made visible.
function signin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signin (see VARARGIN)

% Choose default command line output for signin
%定义全局变量%
%userdatabase：读取excel中的用户名/密码；user_matrix_in：num2str(alldata)后的用户名/密码
%user_matrix_sp_in=[um1,pm1]：即user_matrix_in经过行列变换合并后的结果，string化的两列alldata
%pin_in：c1=rand*10000;pin_in=num2str(b,'%.0f');并赋值给edit4中的验证码
%username1 password1 pin1：flag作用，即作为状态表明是否注册成功
%变量设置规则：为区分全局变量，signin中的全局变量会在signup的变量基础上加上“_in”
global pin_in username1 password1 pin1 userdatabase user_matrix_sp_in;
username1=0; password1=0; pin1=0;
set(handles.edit6,'visible','off');      %设置为不可见
set(handles.edit5,'visible','off');
handles.output = hObject;
axes(handles.axes1);
a=imread('banner.png');                   %设置背景
imshow(a);
axes(handles.axes2);
b=imread('user.jpg');
imshow(b);
c1=rand*10000;pin_in=num2str(c1,'%.0f'); 
set(handles.edit4,'string',pin_in);  
% Update handles structure
%for循环，遍历alldata，即用户名和密码
%excel中只有A、B两列，A代表用户名，B代表密码
%为了只使用一个for循环，将alldata的length*2，这样就能遍历完所有数据
%简单的a=num2str(alldata),比如a(1,1)，出来的只是一个字符串，如3，无法得到一个完整的用户名/密码
%转换为user_matrix_in{i}的形式，可以解决上述问题
%详细解释参考signup.m对应段的代码
userdatabase=xlsread('data.xlsx','sheet1');                  
for i=1:(length(userdatabase)*2)                            
    user_matrix_in{i}=num2str(userdatabase(i));                                                                                     
    k=length(user_matrix_in);                                    
    um=user_matrix_in(1:k/2);
    pm=user_matrix_in((k/2+1):k);
    um1=um(:);
    pm1=pm(:);
    user_matrix_sp_in=[um1,pm1];             
end
guidata(hObject, handles);

% UIWAIT makes signin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns togglebutton2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from togglebutton2


% --- Executes on button press in pushbutton3.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pin_in username1 password1 pin1 user_matrix_sp_in;      %引用全局变量
username=get(handles.edit1,'string');              %获取edit1输入框的用户名string值
password=get(handles.edit2,'string');              %获取edit2输入框的密码string值
[m,n]=size(user_matrix_sp_in);

%%%%%%%%%%%%%%%%%%%%验证码判断
pin2=get(handles.edit4,'string');
if pin2~=pin_in
    set(handles.edit4,'string','错误！');    %判断是否输入正确
    pause(0.5);
    set(handles.edit4,'string','');
    judge_pin_in=0;
else
    judge_pin_in=1;
    set(handles.edit5,'visible','on');
    set(handles.edit5,'string','正确');
end

%%%%%%%%%%%%%%%%%%%%
%利用for循环遍历矩阵中的用户信息，判断是否存在
for ii=1:1:m                                        
    if (strcmp(username,user_matrix_sp_in(ii,1))==1)
        username1=1;
    else
        if ii<=m
            continue;
        else
            username1=0;
            set(handles.edit1,'string','用户名不存在！');       %弹出用户名不存在
            pause(0.2);
            set(handles.edit1,'string','');set(handles.edit2,'string','');
        end
    end
end
%判断密码是否正确
for jj=1:1:m
    if (strcmp(password,user_matrix_sp_in(jj,2))==1)
        password1=1;
    else
        if jj<=m
            continue;
        else
            password1=0;
            set(handles.edit2,'string','密码错误！');         %弹出密码错误
            pause(0.2);
            set(handles.edit1,'string','');set(handles.edit2,'string','');
        end
    end
end
if judge_pin_in==1
    pin1=1;
else
    pin1=0;
    set(handles.edit3,'string','验证码错误！');%弹出验证码错误
    pause(0.2);
    set(handles.edit3,'string','');
end
a1=(username1==1);b1=(password1==1);c1=(pin1==1);
if a1&b1&c1
    openflag=1;
    set(handles.edit6,'string','成功登陆')            %弹出重新来一次
    save mydata openflag;
    h=gcf;yundongguji;pause(0.2);close(h);
else
    set(handles.edit6,'visible','on');
    if a1==0
    set(handles.edit6,'string','账号不存在！')            %弹出重新来一次
    elseif b1==0
        set(handles.edit6,'string','密码错误！')        %弹出重新来一次
    elseif c1==0
        set(handles.edit6,'string','验证码错误！')        %弹出重新来一次
    end
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf;                           %跳转到注册界面，延迟0.2秒后，关闭当前程序界面
signup;pause(0.2);
close(h);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global judge_pin_in pin_in;                 %传递得到验证码是否输入正确的判断值
pin2=get(handles.edit4,'string');
if pin2~=pin_in
    set(handles.edit4,'string','错误！');    %判断是否输入正确
    pause(0.5);
    set(handles.edit4,'string','');
    judge_pin_in=0;
else
    judge_pin_in=1;
    set(handles.edit5,'visible','on');
    set(handles.edit5,'string','正确');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=gcf;signup;pause(0.2);close(h);
