function varargout = loadmodel(varargin)
% LOADMODEL MATLAB code for loadmodel.fig
%      LOADMODEL, by itself, creates a new LOADMODEL or raises the existing
%      singleton*.
%
%      H = LOADMODEL returns the handle to a new LOADMODEL or the handle to
%      the existing singleton*.
%
%      LOADMODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOADMODEL.M with the given input arguments.
%
%      LOADMODEL('Property','Value',...) creates a new LOADMODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before loadmodel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to loadmodel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help loadmodel

% Last Modified by GUIDE v2.5 13-Apr-2018 17:18:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @loadmodel_OpeningFcn, ...
                   'gui_OutputFcn',  @loadmodel_OutputFcn, ...
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


% --- Executes just before loadmodel is made visible.
function loadmodel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to loadmodel (see VARARGIN)

% Choose default command line output for loadmodel
handles.output = hObject;
handles.output1 = struct();
handles.fe_method_para = '';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes loadmodel wait for user response (see UIRESUME)
uiwait(handles.loadmodel);


% --- Outputs from this function are returned to the command line.
function varargout = loadmodel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%isempty(fieldnames(handles.output1))
%if ~isempty(fieldnames(handles.output1))
varargout{1} = handles.output1;
delete(handles.loadmodel);
%end
%

function rootdir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rootdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rootdir_edit as text
%        str2double(get(hObject,'String')) returns contents of rootdir_edit as a double


% --- Executes during object creation, after setting all properties.
function rootdir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rootdir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dataformat_popupmenu.
function dataformat_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to dataformat_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dataformat_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dataformat_popupmenu


% --- Executes during object creation, after setting all properties.
function dataformat_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataformat_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in feaextraction_popupmenu.
function feaextraction_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to feaextraction_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns feaextraction_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from feaextraction_popupmenu
contents = cellstr(get(hObject,'String'));
fe_method_selected = contents{get(hObject,'Value')};

if strcmp(fe_method_selected,'NULL')
    handles.kernel_popupmenu.String = 'Graph Kernel';
else
    handles.kernel_popupmenu.String = 'linear|gaussian|poly';
end

if strcmp(fe_method_selected,'Discriminative Subnetwork')
    handles.parameter_pushbutton.Enable = 'on';
elseif strcmp(fe_method_selected,'Ordinal Patterns')
    handles.parameter_pushbutton.Enable = 'off';
else
     handles.parameter_pushbutton.Enable = 'off';
end

handles.fe_method = fe_method_selected;
%handles.fe_paramaters = 
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function feaextraction_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feaextraction_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in parameter_pushbutton.
function parameter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in kernel_popupmenu.
function kernel_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to kernel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kernel_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kernel_popupmenu


% --- Executes during object creation, after setting all properties.
function kernel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in confirm_pushbutton.
function confirm_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to confirm_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%root directory
handles.output1.root_dir = get(handles.rootdir_edit,'String');
if isempty(handles.output1.root_dir)
    errordlg('root directory NULL is illegal!!!');
    return;
end
%data format
data_formats = cellstr(get(handles.dataformat_popupmenu,'String'));
data_format = data_formats{get(handles.dataformat_popupmenu,'Value')};
handles.output1.data_format= data_format;

%threshold
threshold = get(handles.threshold_radiobutton,'Value');
handles.output1.threshold = threshold;
if handles.output1.threshold
    handles.output1.sparsity = str2double(get(handles.sparsity_edit,'String'));
else
    handles.output1.sparsity = '';
end

%feature extraction method
contents = cellstr(get(handles.feaextraction_popupmenu,'String'));
fe_method_selected = contents{get(handles.feaextraction_popupmenu,'Value')};
handles.output1.fe_method = fe_method_selected;
handles.output1.fe_method_parameter = handles.fe_method_para; 

%kernel method
kernel_methods = cellstr(get(handles.kernel_popupmenu,'String'));
kernel_method_selected = kernel_methods{get(hObject,'Value')};
handles.output1.kernel_method = kernel_method_selected;

guidata(hObject,handles);

uiresume(handles.loadmodel);


% --- Executes on button press in cancel_pushbutton.
function cancel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.loadmodel);

% --- Executes on button press in rootdir_pushbutton.
function rootdir_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rootdir_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname, filterindex] = uigetfile( ...
       {'*.mat','MAT-files (*.mat)';}, ...
        'Pick a file');
%dname = uigetdir('../data');

if pathname~=0
    set(handles.rootdir_edit,'string',[pathname,filename]);
end

% --- Executes on button press in threshold_radiobutton.
function threshold_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of threshold_radiobutton
if get(hObject,'Value')==true
    handles.sparsity_text.Visible = 'on';
    handles.sparsity_edit.Visible = 'on';   
else
    handles.sparsity_text.Visible = 'off';
    handles.sparsity_edit.Visible = 'off';
end


function sparsity_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sparsity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sparsity_edit as text
%        str2double(get(hObject,'String')) returns contents of sparsity_edit as a double


% --- Executes during object creation, after setting all properties.
function sparsity_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sparsity_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
