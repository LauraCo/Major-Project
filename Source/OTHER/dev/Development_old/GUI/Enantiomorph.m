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

% Last Modified by GUIDE v2.5 08-Apr-2016 15:49:17

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
handles.alignment = 'shannon';
handles.imageName = '';
handles.imagePath = '';
handles.meanIms = [];
handles.adjSer = [];
handles.finalImg = [];
handles.ent = [];
handles.time = 0;
% Update handles structure
guidata(hObject, handles);

addpath(genpath('/Users/lauracollins/Git/Major-Project/Source/Development/'));

% UIWAIT makes Enantiomorph wait for user response (see UIRESUME)
% uiwait(handles.Main_GUI);


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

pathname = uigetdir();
rmpath(genpath('/Users/lauracollins/Git/Major-Project/Source/Development'));
addpath(pathname);
if isequal(pathname,0)
   disp('User selected Cancel')
elseif exist('/big_scan.pgm', 'file') == 2
   
    message = sprintf('Big scan has already been generated in this folder. \nPlease use "Load existing" button instead.'); 
    uiwait(msgbox(message));
    return;
else
    addpath('/Users/lauracollins/Git/Major-Project/Source/Development/IO');
    pgm2bigPgm(pathname);
    
   % inputImg = strcat(pathname,'/big_scan.pgm');
    
    handles.imagePath = pathname;
      
    handles.imageName = '/big_scan.pgm';
    guidata(hObject, handles);
    
    axes(handles.input_img);
    
    imshow(handles.imageName);
    
    set(handles.clear, 'enable','on')
    set(handles.view, 'enable','on')
    set(handles.run, 'enable','on')
   
    
    info = imfinfo(handles.imageName);
    set(handles.filename, 'String', info.Filename);
    set(handles.modified, 'String', info.FileModDate);
    set(handles.type, 'String', info.Format);
    set(handles.height, 'String', info.Height);
    set(handles.width, 'String', info.Width);
   
    
   addpath(genpath('/Users/lauracollins/Git/Major-Project/Source/Development'));
end



% --- Executes on selection change in alignment_menu.
function alignment_menu_Callback(hObject, eventdata, handles)
% hObject    handle to alignment_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alignment_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alignment_menu

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
function alignment_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alignment_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Shannon';'De-Luca & Termini';'Hybrid'});



% --- Executes on button press in adjSer.
function adjSer_Callback(hObject, eventdata, handles)
% hObject    handle to adjSer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in clear_output.
function clear_output_Callback(hObject, eventdata, handles)
% hObject    handle to clear_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear handles.imageName;
clear handles.imagePath;
clear handles.iterations_box;
clear handles.alignment_menu;
clear handles.meanIms;
clear handles.adjSer;
clear handles.finalImg;
guidata(hObject, handles);

axes(handles.input_img)
axes(handles.output_img)
cla

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(handles.imageName,'')
    message = sprintf('Image has not been loaded.'); 
    uiwait(msgbox(message)); 
    return;
end

if handles.iterations == 0
    message = sprintf('Please enter an iteration amount.'); 
    uiwait(msgbox(message)); 
    return;
end

%http://uk.mathworks.com/matlabcentral/answers/11411-how-to-indicate-that-gui-is-busy-running
%http://uk.mathworks.com/matlabcentral/newsreader/view_thread/58453
set(gcf, 'pointer', 'watch')
drawnow;

[meanIms, adjSer, finalMean, ent, time] = testCongeal(handles.alignment, handles.iterations, handles.imageName, handles.imagePath);

set(gcf, 'pointer', 'arrow')

handles.meanIms = meanIms;
handles.adjSer = adjSer;
handles.ent = ent;
handles.time = time;
guidata(hObject, handles);

handles.finalImg = finalMean;
guidata(hObject, handles);

imshow(handles.finalImg, 'parent', handles.output_img);

set(handles.ttr_box, 'String', handles.time);
set(handles.final_entropy, 'String', handles.ent(handles.iterations));
set(handles.final_txt, 'visible', 'on');

set(handles.entropy_btn, 'enable','on');
set(handles.larger_output, 'enable','on');
set(handles.mean_ims_button, 'enable','on');
set(handles.adj_ser_button, 'enable','on');
set(handles.save_output, 'enable','on');
set(handles.start_new_btn, 'enable','on');





% --- Executes on button press in load_existing.
function load_existing_Callback(hObject, eventdata, handles)
% hObject    handle to load_existing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.pgm','Select pre-compiled pgm file');
if isequal(pathname,0)
   disp('User selected Cancel')
else
    
    handles.imageName = filename;   
    handles.imagePath = pathname;
    guidata(hObject, handles);
    
    axes(handles.input_img);
    
    imshow(strcat(handles.imagePath,handles.imageName));
    
    set(handles.clear, 'enable','on')
    set(handles.view, 'enable','on')
    set(handles.run, 'enable','on')
    
    info = imfinfo(filename);
    set(handles.filename, 'String', info.Filename);
    set(handles.modified, 'String', info.FileModDate);
    set(handles.type, 'String', info.Format);
    set(handles.height, 'String', info.Height);
    set(handles.width, 'String', info.Width);
    
    file = fopen(filename);
    ln1=fgetl(file);
    ln2=strsplit(fgetl(file));
    
    if numel(ln2) ~= 4
        message = sprintf('The header doesn`t seem to the in the right format. \nAre you sure this is the right image?'); 
        uiwait(msgbox(message));
        return;
    end
    
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear handles.imageName;
guidata(hObject, handles);

axes(handles.input_img) 
cla

set(handles.filename, 'String', '');
    set(handles.modified, 'String', '');
    set(handles.type, 'String', '');
    set(handles.height, 'String', '');
    set(handles.width, 'String', '');

% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure('Name','Input image'); 
imshow(handles.imageName);


%http://uk.mathworks.com/help/matlab/creating_guis/add-code-for-components-in-callbacks.html#f10-1001464
function iterations_box_Callback(hObject, eventdata, handles)
% hObject    handle to iterations_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations_box as text
%        str2double(get(hObject,'String')) returns contents of iterations_box as a double
num = str2double(get(hObject,'String'));

if isnan(num)
    errordlg('You must enter a numeric value','Invalid Input','modal')
  uicontrol(hObject)
  return
elseif num > 100 
  errordlg('You must enter a number less than 100','Invalid Input','modal')
  uicontrol(hObject)
elseif num <= 0
    errordlg('You must enter a number greater than 0','Invalid Input','modal')
    uicontrol(hObject)
else
  display(num);
  handles.iterations=num;
  guidata(hObject, handles);
end
    


% --- Executes during object creation, after setting all properties.
function iterations_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

removeMarker; 


% --- Executes on button press in save_output.
function save_output_Callback(hObject, eventdata, handles)
% hObject    handle to save_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[file,path] = uiputfile(strcat(handles.imagePath,'final_image_',num2str(handles.iterations),'_',handles.alignment),'Save file name');

if isequal(path,0)
   disp('User selected Cancel') 
else 
imwrite(handles.finalImg,strcat(path,file),'pgm'); % Doesn't save in the right format to be fed back in - but doesn't need to be.
end

% --- Executes on button press in mean_ims_button.
function mean_ims_button_Callback(hObject, eventdata, handles)
% hObject    handle to mean_ims_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Name','Mean images per each iteration');
showSer(handles.meanIms,1);
hold on


% --- Executes on button press in adj_ser_button.
function adj_ser_button_Callback(hObject, eventdata, handles)
% hObject    handle to adj_ser_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure('Name','Adjusted input images after last iteration');
showSer(handles.adjSer,1);
hold on


% --- Executes on button press in larger_output.
function larger_output_Callback(hObject, eventdata, handles)
% hObject    handle to larger_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure('Name','Final Mean Image'); 
imshow(handles.finalImg);


% --- Executes on button press in start_new_btn.
function start_new_btn_Callback(hObject, eventdata, handles)
% hObject    handle to start_new_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear handles.imageName;
clear handles.imagePath;
clear handles.time;
clear handles.ent;
clear handles.iterations_box;
clear handles.meanIms;
clear handles.adjSer;
clear handles.finalImg;
guidata(hObject, handles);

axes(handles.input_img) 
cla
axes(handles.output_img) 
cla

set(handles.filename, 'String', '');
set(handles.modified, 'String', '');
set(handles.type, 'String', '');
set(handles.height, 'String', '');
set(handles.width, 'String', '');
set(handles.ttr_box, 'String', '');
set(handles.final_entropy, 'String', '');

set(handles.alignment_menu, 'Value', 1);
set(handles.iterations_box, 'String', '');


% --- Executes on button press in entropy_btn.
function entropy_btn_Callback(hObject, eventdata, handles)
% hObject    handle to entropy_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


figure('Position', [100, 100, 1049, 895]);
set(gcf,'numbertitle','off','name','Decline in Entropy') 

ax = gca;
ax.XLim = [0 handles.iterations];
ax.YLim = [0 1];

x = (1:handles.iterations);

plot(x,handles.ent);

%http://uk.mathworks.com/matlabcentral/answers/97277-how-can-i-apply-data-labels-to-each-point-in-a-scatter-plot-in-matlab-7-0-4-r14sp2
input = handles.ent'; 
label = num2str(input); 
data_label = cellstr(label);

text(x,handles.ent,data_label);

xlabel('Iterations', 'FontSize', 16)
ylabel('Entropy', 'FontSize', 16)
