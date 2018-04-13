function varargout = disc_para(varargin)
% DISC_PARA MATLAB code for disc_para.fig
%      DISC_PARA, by itself, creates a new DISC_PARA or raises the existing
%      singleton*.
%
%      H = DISC_PARA returns the handle to a new DISC_PARA or the handle to
%      the existing singleton*.
%
%      DISC_PARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISC_PARA.M with the given input arguments.
%
%      DISC_PARA('Property','Value',...) creates a new DISC_PARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before disc_para_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to disc_para_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help disc_para

% Last Modified by GUIDE v2.5 13-Apr-2018 15:37:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @disc_para_OpeningFcn, ...
                   'gui_OutputFcn',  @disc_para_OutputFcn, ...
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


% --- Executes just before disc_para is made visible.
function disc_para_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to disc_para (see VARARGIN)

% Choose default command line output for disc_para
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes disc_para wait for user response (see UIRESUME)
uiwait(handles.disc_para);


% --- Outputs from this function are returned to the command line.
function varargout = disc_para_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
output.min_support_pos = str2double(get(handles.minsupppos_edit,'String'));
output.min_support_neg = str2double(get(handles.minsuppneg_edit,'String'));
output.size_req = [str2double(get(handles.minsize_edit,'String'))... 
    str2double(get(handles.maxsize_edit,'String'))];
output.num_positive_subgraph = str2double(get(handles.numsubgpos_edit,'String'));
output.num_negative_subgraph = str2double(get(handles.numsubgneg_edit,'String'));

varargout{1} = output;
delete(handles.disc_para);


function minsupppos_edit_Callback(hObject, eventdata, handles)
% hObject    handle to minsupppos_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minsupppos_edit as text
%        str2double(get(hObject,'String')) returns contents of minsupppos_edit as a double


% --- Executes during object creation, after setting all properties.
function minsupppos_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minsupppos_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minsuppneg_edit_Callback(hObject, eventdata, handles)
% hObject    handle to minsuppneg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minsuppneg_edit as text
%        str2double(get(hObject,'String')) returns contents of minsuppneg_edit as a double


% --- Executes during object creation, after setting all properties.
function minsuppneg_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minsuppneg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minsize_edit_Callback(hObject, eventdata, handles)
% hObject    handle to minsize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minsize_edit as text
%        str2double(get(hObject,'String')) returns contents of minsize_edit as a double


% --- Executes during object creation, after setting all properties.
function minsize_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minsize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxsize_edit_Callback(hObject, eventdata, handles)
% hObject    handle to maxsize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxsize_edit as text
%        str2double(get(hObject,'String')) returns contents of maxsize_edit as a double


% --- Executes during object creation, after setting all properties.
function maxsize_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxsize_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numsubgpos_edit_Callback(hObject, eventdata, handles)
% hObject    handle to numsubgpos_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numsubgpos_edit as text
%        str2double(get(hObject,'String')) returns contents of numsubgpos_edit as a double


% --- Executes during object creation, after setting all properties.
function numsubgpos_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numsubgpos_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numsubgneg_edit_Callback(hObject, eventdata, handles)
% hObject    handle to numsubgneg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numsubgneg_edit as text
%        str2double(get(hObject,'String')) returns contents of numsubgneg_edit as a double


% --- Executes during object creation, after setting all properties.
function numsubgneg_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numsubgneg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in confirm_pushbutton.
function confirm_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to confirm_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
min_support_pos = get(handles.minsupppos_edit,'String');
min_support_neg = get(handles.minsuppneg_edit,'String');
min_size_req = get(handles.minsize_edit,'String');
max_size_req = get(handles.maxsize_edit,'String');
num_positive_subgraph = get(handles.numsubgpos_edit,'String');
num_negative_subgraph = get(handles.numsubgneg_edit,'String');
if isempty(min_support_neg)||isempty(min_support_pos)||...
        isempty(min_size_req)||isempty(max_size_req)||...
        isempty(num_negative_subgraph)||isempty(num_positive_subgraph)
    errordlg('input NULL is illegal!!!');
else
    uiresume(handles.disc_para);
end
