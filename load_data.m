function varargout = load_data(varargin)
% LOAD_DATA MATLAB code for load_data.fig
%      LOAD_DATA, by itself, creates a new LOAD_DATA or raises the existing
%      singleton*.
%
%      H = LOAD_DATA returns the handle to a new LOAD_DATA or the handle to
%      the existing singleton*.
%
%      LOAD_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOAD_DATA.M with the given input arguments.
%
%      LOAD_DATA('Property','Value',...) creates a new LOAD_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before load_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to load_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help load_data

% Last Modified by GUIDE v2.5 22-Mar-2018 10:14:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @load_data_OpeningFcn, ...
                   'gui_OutputFcn',  @load_data_OutputFcn, ...
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


% --- Executes just before load_data is made visible.
function load_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to load_data (see VARARGIN)

% Choose default command line output for load_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes load_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = load_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nordir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to nordir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nordir_edit as text
%        str2double(get(hObject,'String')) returns contents of nordir_edit as a double


% --- Executes during object creation, after setting all properties.
function nordir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nordir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function normal_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
       {'*.mat','MAT-files (*.mat)';}, ...
        'Pick a file');
set(handles.nordir_edit,'string',[pathname,filename]);




function patdir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to patdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of patdir_edit as text
%        str2double(get(hObject,'String')) returns contents of patdir_edit as a double


% --- Executes during object creation, after setting all properties.
function patdir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to patdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function patient_dir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
       {'*.mat','MAT-files (*.mat)';}, ...
        'Pick a file');
set(handles.patdir_edit,'string',[pathname,filename]);


% --- Executes on button press in run button.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('algorithm');
fileA = get(handles.nordir_edit,'String'); 
fileB = get(handles.patdir_edit,'String');
parameters = handles.parameters;
[~,~,ACC] = ConnectionClassification(fileA,fileB,str2double(parameters{2}));
warndlg(num2str(ACC));
result(ACC);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in classifymethod_popupmenu.
function classifymethod_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to classifymethod_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns classifymethod_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from classifymethod_popupmenu


% --- Executes during object creation, after setting all properties.
function classifymethod_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to classifymethod_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function parameter_button_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('parameters');

%get parameters
output = conn_para();

%get the classfy method
classifymethod = get(handles.classifymethod_popupmenu,'String');
pos = get(handles.classifymethod_popupmenu,'Value');
classifymethod_para = classifymethod{pos};

for i = 1:size(output,2):2
    classifymethod_para = strcat(classifymethod_para,';',output{i},',',output{i+1});
end
get(handles.reminder_text,'String');
set(handles.reminder_text,'String',classifymethod_para);
%net_sparcity = output{2};

%store the parameters
%pass value
handles.classifymethod = classifymethod{pos};
handles.parameters = output;
guidata(hObject,handles);





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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in fivefold_button.
function fivefold_button_Callback(hObject, eventdata, handles)
% hObject    handle to fivefold_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fivefold_button
set(handles.tenfold_button,'Value',0);
set(handles.loo_button,'Value',0);

% --- Executes on button press in tenfold_button.
function tenfold_button_Callback(hObject, eventdata, handles)
% hObject    handle to tenfold_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tenfold_button
set(handles.fivefold_button,'Value',0);
set(handles.loo_button,'Value',0);

% --- Executes on button press in loo_button.
function loo_button_Callback(hObject, eventdata, handles)
% hObject    handle to loo_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loo_button
set(handles.tenfold_button,'Value',0);
set(handles.fivefold_button,'Value',0);


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
