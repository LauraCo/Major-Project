function varargout = Enantiomorph(varargin)
% ENANTIOMORPH MATLAB code for Enantiomorph.fig
%      ENANTIOMORPH, by itself, creates a new ENANTIOMORPH or raises the existing
%      singleton*.
%
%      H = ENANTIOMORPH returns the handle to a new ENANTIOMORPH or the handle to
%      the existing singleton*.
%
%      ENANTIOMORPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENANTIOMORPH.M with the given input arguments.
%
%      ENANTIOMORPH('Property','Value',...) creates a new ENANTIOMORPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Enantiomorph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Enantiomorph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Enantiomorph

% Last Modified by GUIDE v2.5 24-Mar-2016 16:20:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Enantiomorph_OpeningFcn, ...
                   'gui_OutputFcn',  @Enantiomorph_OutputFcn, ...
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


% --- Executes just before Enantiomorph is made visible.
function Enantiomorph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Enantiomorph (see VARARGIN)

% Choose default command line output for Enantiomorph
handles.output = hObject;
handles.iterations = 0;
handles.alignment = '';
handles.imageName = '';
handles.imagePath = '';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Enantiomorph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Enantiomorph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in generate.
function generate_Callback(hObject, eventdata, handles)
% hObject    handle to generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%[filename, pathname] = uigetfile('*.pgm;*.pbm;', 'Select an image file', 'MultiSelect', 'on');
pathname = uigetdir();
if isequal(pathname,0)
   disp('User selected Cancel')
else
    addpath('/Users/lauracollins/Git/Major-Project/Source/Development/IO');
    pgm2bigPgm(pathname);
    
    inputImg = strcat(pathname,'/big_scan.pgm');
    
    handles.imagePath = pathname;
    
    imshow(inputImg);
    handles.alignment = inputImg;
    guidata(hObject, handles);
    
    set(handles.clear, 'enable','on')
    set(handles.view, 'enable','on')
   
    
    info = imfinfo(strcat(pathname,'/big_scan.pgm'));
    set(handles.imageMeta, 'String', struct2cell(imageinfo(info)));
end


% --- Executes on selection change in alignment.
function alignment_Callback(hObject, eventdata, handles)
% hObject    handle to alignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alignment contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alignment

contents = get(hObject,'Value');
handles = guidata(hObject);  % Update!
switch contents 
    case 1
        metric = 'shannon';
    case 2
        metric = 'deLuca';
    case 3
        metric = 'hybrid';
    otherwise
end

handles.alignment = metric;
guidata(hObject, handles);





% --- Executes during object creation, after setting all properties.
function alignment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alignment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Shannon';'De-Luca & Termini';'Hybrid'});



% --- Executes on button press in save_output.
function save_output_Callback(hObject, eventdata, handles)
% hObject    handle to save_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clear_output.
function clear_output_Callback(hObject, eventdata, handles)
% hObject    handle to clear_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath(genpath('/Users/lauracollins/Git/Major-Project/Source/Development/'));
testCongeal(handles.alignment, handles.iterations, handles.imageName);

imshow(strcat(handles.imagePath,'final_mean.pgm'));



% --- Executes on button press in load_existing.
function load_existing_Callback(hObject, eventdata, handles)
% hObject    handle to load_existing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.pgm','Select pre-compiled pgm file');
if isequal(pathname,0)
   disp('User selected Cancel')
else
    imshow(filename);
    handles.imageName = filename;
    handles.imagePath = pathname;
    guidata(hObject, handles);
    set(handles.clear, 'enable','on')
    set(handles.view, 'enable','on')
    
    info = imfinfo(filename);
    set(handles.filename, 'String', info.Filename);
    set(handles.modified, 'String', info.FileModDate);
    set(handles.type, 'String', info.Format);
    set(handles.height, 'String', info.Height);
    set(handles.width, 'String', info.Width);
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla

% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fh = figure();

%Print axes 2 in here


%http://uk.mathworks.com/help/matlab/creating_guis/add-code-for-components-in-callbacks.html#f10-1001464
function iterations_Callback(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations as text
%        str2double(get(hObject,'String')) returns contents of iterations as a double
num = str2double(get(hObject,'String'));

if isnan(num)
    errordlg('You must enter a numeric value','Invalid Input','modal')
  uicontrol(hObject)
  return
else
  display(num);
  handles.iterations=num;
  guidata(hObject, handles);
end
    


% --- Executes during object creation, after setting all properties.
function iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
