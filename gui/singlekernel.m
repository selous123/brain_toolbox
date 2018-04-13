function varargout = singlekernel(varargin)
%SINGLEKERNEL MATLAB code file for singlekernel.fig
%      SINGLEKERNEL, by itself, creates a new SINGLEKERNEL or raises the existing
%      singleton*.
%
%      H = SINGLEKERNEL returns the handle to a new SINGLEKERNEL or the handle to
%      the existing singleton*.
%
%      SINGLEKERNEL('Property','Value',...) creates a new SINGLEKERNEL using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to singlekernel_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SINGLEKERNEL('CALLBACK') and SINGLEKERNEL('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SINGLEKERNEL.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help singlekernel

% Last Modified by GUIDE v2.5 13-Apr-2018 10:34:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @singlekernel_OpeningFcn, ...
                   'gui_OutputFcn',  @singlekernel_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before singlekernel is made visible.
function singlekernel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for singlekernel
handles.output = hObject;
handles.configure = struct();
handles.fe_method_para = '';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes singlekernel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = singlekernel_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
configure = struct();

%configure root directory
root_dir = get(handles.rootdir_edit,'String');
if root_dir
    configure.root_dir = root_dir;
else
    errordlg('please input the data root directory!!');
    return ;
end

%configure data format
data_formats = cellstr(get(handles.dataformat_popupmenu,'String'));
data_format = data_formats{get(handles.dataformat_popupmenu,'Value')};
configure.data_format = data_format;

%configure sparsity for threshold data
threshold = get(handles.threshold_radiobutton,'Value');
configure.threshold = threshold;
if configure.threshold
    configure.sparsity = str2double(get(handles.sparsity_edit,'String'));
end

%configure feature extraction method and parameters.
contents = cellstr(get(handles.feaextraction_popupmenu,'String'));
fe_method_selected = contents{get(handles.feaextraction_popupmenu,'Value')};
configure.feaextraction_method = fe_method_selected;

configure.feaextraction_parameters = handles.fe_method_para; 

%configure kernel method
kernel_methods = cellstr(get(handles.kernel_popupmenu,'String'));
kernel_method_selected = kernel_methods{get(hObject,'Value')};
configure.kernel_method = kernel_method_selected;

%configure k-fold
k_folds = {'five','ten','loo'};
k_folds_index = ([get(handles.fivefold_radiobutton,'Value'),...
    get(handles.tenfold_radiobutton,'Value'),...
    get(handles.loo_radiobutton,'Value')]==1);
if sum(k_folds_index) == 0
    errordlg('please choose the k-folds!!');
    return;
end
configure.k_fold = k_folds{k_folds_index};

%configure parameter C
configure.C = str2double(get(handles.parameterC_edit,'String'));

%choose result metrics
metrics = [0,0,0,0];
if get(handles.acc_checkbox,'Value')
    metrics(1) = 1;
end
if get(handles.roc_checkbox,'Value')
    metrics(2) = 1;
end
if get(handles.pr_checkbox,'Value')
    metrics(3) = 1;
end
if get(handles.auc_checkbox,'Value')
    metrics(4) = 1;
end
configure.metrics = metrics;
if sum(metrics)==0
    errordlg('choose at least one metircs');
    return;
end

addpath('../model');
[pred_labels,pred_probs,true_labels] = main_single_kernel(configure);
result(pred_labels,pred_probs,true_labels,metrics);

% --- Executes on button press in exit_pushbutton.
function exit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in fivefold_radiobutton.
function fivefold_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to fivefold_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fivefold_radiobutton
set(handles.tenfold_radiobutton,'Value',0);
set(handles.loo_radiobutton,'Value',0);
handles.ksplits = 'five';
guidata(hObject,handles);

% --- Executes on button press in tenfold_radiobutton.
function tenfold_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to tenfold_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tenfold_radiobutton
set(handles.fivefold_radiobutton,'Value',0);
set(handles.loo_radiobutton,'Value',0);
handles.ksplits = 'ten';
guidata(hObject,handles);


% --- Executes on button press in loo_radiobutton.
function loo_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to loo_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of loo_radiobutton
set(handles.tenfold_radiobutton,'Value',0);
set(handles.fivefold_radiobutton,'Value',0);
handles.ksplits = 'loo';
guidata(hObject,handles);


% --- Executes on button press in acc_checkbox.
function acc_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to acc_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of acc_checkbox

% --- Executes on button press in pr_checkbox.
function pr_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to pr_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pr_checkbox


% --- Executes on button press in auc_checkbox.
function auc_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to auc_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auc_checkbox


% --- Executes on button press in roc_checkbox.
function roc_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to roc_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of roc_checkbox


% --- Executes on button press in parameter_pushbutton.
function parameter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('parameters');
contents = cellstr(get(handles.feaextraction_popupmenu,'String'));
fe_method_selected = contents{get(handles.feaextraction_popupmenu,'Value')};

if strcmp(fe_method_selected,'Discriminative Subnetwork')
    handles.fe_method_para = disc_para();
elseif strcmp(fe_method_selected,'Ordinal Patterns')
end

guidata(hObject,handles);

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
%contents:
%5×1 cell array
%     'NULL'
%     'Connection'
%     'Clustering Coefficient'
%     'Discriminative Subnetwork'
%     'Ordinal Patterns '


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


% --- Executes on button press in rootdir_pushbutton.
function rootdir_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rootdir_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
%handles    structure with handles and user data (see GUIDATA)
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
hObject.Visible = 'off';


% --- Executes during object creation, after setting all properties.
function sparsity_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sparsity_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.Visible = 'off';



function parameterC_edit_Callback(hObject, eventdata, handles)
% hObject    handle to parameterC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of parameterC_edit as text
%        str2double(get(hObject,'String')) returns contents of parameterC_edit as a double


% --- Executes during object creation, after setting all properties.
function parameterC_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameterC_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
