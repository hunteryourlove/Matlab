function varargout = yundongguji(varargin)
% YUNDONGGUJI MATLAB code for yundongguji.fig
%      YUNDONGGUJI, by itself, creates a new YUNDONGGUJI or raises the existing
%      singleton*.
%
%      H = YUNDONGGUJI returns the handle to a new YUNDONGGUJI or the handle to
%      the existing singleton*.
%
%      YUNDONGGUJI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YUNDONGGUJI.M with the given input arguments.
%
%      YUNDONGGUJI('Property','Value',...) creates a new YUNDONGGUJI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before yundongguji_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to yundongguji_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help yundongguji

% Last Modified by GUIDE v2.5 15-May-2016 15:04:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @yundongguji_OpeningFcn, ...
                   'gui_OutputFcn',  @yundongguji_OutputFcn, ...
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



% --- Executes just before yundongguji is made visible.
function yundongguji_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to yundongguji (see VARARGIN)

% Choose default command line output for yundongguji
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load('mydata');%载入判断值，判断当前是否为登陆状态
if openflag==1            %如果为1，则为登录状态
else
    h=gcf;
    please;           %打开please.m文件，提示未登录信息 
    close(h);         %关闭当前程序
end
global flag;
flag=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%初始化，提示正在载入图像
axes(handles.axes5);
a=imread('wait.png');
imshow(a);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
axes(handles.axes3);
imshow(a);
axes(handles.axes4);
imshow(a);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% UIWAIT makes yundongguji wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = yundongguji_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global endoftoc;
tic
fullsearch();                                         %调用全搜索函数
toc
thistoc=endoftoc/toc;
set(handles.text8,'String',thistoc); 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global endoftoc;
tic
threesteps();                                        %调用三步搜索函数
toc
thistoc=endoftoc/toc;
set(handles.text8,'String',thistoc); 



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xulie1 xulie2 foldername;                   %定义图像的序列号，为全局变量
global ima imb;                         %定义待处理图像序列变量，为全局变量
global flag;                            %传递全局变量flag的值
flag=1;
xulie1=get(handles.edit1,'String');     %得到GUI界面的参考帧的序列号
xulie2=get(handles.edit2,'String');     %得到GUI界面的当前帧的序列号
axes(handles.axes1);                    %显示参考帧图像
ima=rgb2gray(imread(strcat(foldername,'\',xulie1,'.bmp')));
imshow(ima);
axes(handles.axes2);                    %显示当前帧图像
imb=rgb2gray(imread(strcat(foldername,'\',xulie2,'.bmp')));
imshow(imb);

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
%设置背景色
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
%设置背景色
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%退出程序
openflag=0;
save mydata openflag;
close();


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1



% --- Executes on button press in OpenFolder.
function OpenFolder_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag FileName PathName FilterIndex;%定义flag变量，当输入了图像序列号时，跳出for循环并停止播放。
global foldername;
FileName=0;
[FileName,PathName,FilterIndex]=uigetfile('.avi','选择视频文件');     %打开视频文件，默认后缀为.avi
%返回文件名、路径、索引三个值
if FileName==0
    msgbox('请选择视频文件!');
else
fileName = strcat(PathName,FileName); 
obj = VideoReader(fileName);
     houzhui='.avi';
     clearstr=[];
     foldername=strrep(fileName,houzhui,clearstr);
     %%%%%%%%%%%%%%%%%%%%判断文件夹是否存在
     if exist(foldername)
      rmdir(foldername,'s');
      mkdir(foldername);
     else
      mkdir(foldername);
     end
     %%%%%%%%%%%%%%%%%%%
    axes(handles.axes5);
    fileName = strcat(PathName,'\',FileName);      %定义文件名及路径
    obj = VideoReader(fileName);               % VideoReader函数读取视频文件
    numFrames = obj.NumberOfFrames;            % 读取视频的帧数
      for i = 1 : numFrames
        frame = read(obj,i);          % 读取每一帧
        imshow(frame);                %显示每一帧
        imwrite(frame,strcat(foldername,'\',num2str(i),'.bmp'),'bmp');% 保存每一帧
        set(handles.edit3,'string',num2str(i));
        drawnow;                      %更新axis
      if flag==1                    %如果flag为1，即已选好两帧图像的序列号，跳出循环，停止视频的播放
          break
       else
           continue
       end
     end
end
%%%
 msgbox('序列生成结束！');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag=0;



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


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
