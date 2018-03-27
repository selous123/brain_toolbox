function varargout = conn_para(varargin)
% CONN_PARA MATLAB code for conn_para.fig
%      CONN_PARA, by itself, creates a new CONN_PARA or raises the existing
%      singleton*.
%
%      H = CONN_PARA returns the handle to a new CONN_PARA or the handle to
%      the existing singleton*.
%
%      CONN_PARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONN_PARA.M with the given input arguments.
%
%      CONN_PARA('Property','Value',...) creates a new CONN_PARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before conn_para_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to conn_para_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help conn_para

% Last Modified by GUIDE v2.5 20-Mar-2018 13:50:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @conn_para_OpeningFcn, ...
                   'gui_OutputFcn',  @conn_para_OutputFcn, ...
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


% --- Executes just before conn_para is made visible.
function conn_para_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to conn_para (see VARARGIN)

% Choose default command line output for conn_para
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes conn_para wait for user response (see UIRESUME)
uiwait(handles.conn_para);


% --- Outputs from this function are returned to the command line.
function varargout = conn_para_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
output{1} = 'sparsity';
output{2} = get(handles.net_sparsity_edit,'string');
varargout{1} = output;
delete(handles.conn_para);



function net_sparsity_edit_Callback(hObject, eventdata, handles)
% hObject    handle to net_sparsity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of net_sparsity_edit as text
%        str2double(get(hObject,'String')) returns contents of net_sparsity_edit as a double


% --- Executes during object creation, after setting all properties.
function net_sparsity_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to net_sparsity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in confirm_button.
function confirm_button_Callback(hObject, eventdata, handles)
% hObject    handle to confirm_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = get(handles.net_sparsity_edit,'String');
if isempty(a)
    warndlg('input NULL is illegal!!!');
else
    uiresume(handles.conn_para);
end
