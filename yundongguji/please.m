function varargout = please(varargin)
% PLEASE MATLAB code for please.fig
%      PLEASE, by itself, creates a new PLEASE or raises the existing
%      singleton*.
%
%      H = PLEASE returns the handle to a new PLEASE or the handle to
%      the existing singleton*.
%
%      PLEASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLEASE.M with the given input arguments.
%
%      PLEASE('Property','Value',...) creates a new PLEASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before please_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to please_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help please

% Last Modified by GUIDE v2.5 27-May-2016 21:10:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @please_OpeningFcn, ...
                   'gui_OutputFcn',  @please_OutputFcn, ...
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


% --- Executes just before please is made visible.
function please_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to please (see VARARGIN)

% Choose default command line output for please
handles.output = hObject;
axes(handles.axes1);
a=imread('please.png');               %载入背景图片并显示
imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes please wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = please_OutputFcn(hObject, eventdata, handles) 
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
h=gcf;                       %打开登陆界面，并关闭当前程序界面
signin;
close(h);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close();