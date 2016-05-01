function varargout = removeMarker(varargin)
% REMOVEMARKER MATLAB code for removeMarker.fig
%      REMOVEMARKER, by itself, creates a new REMOVEMARKER or raises the existing
%      singleton*.
%
%      H = REMOVEMARKER returns the handle to a new REMOVEMARKER or the handle to
%      the existing singleton*.
%
%      REMOVEMARKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOVEMARKER.M with the given input arguments.
%
%      REMOVEMARKER('Property','Value',...) creates a new REMOVEMARKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before removeMarker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to removeMarker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help removeMarker

% Last Modified by GUIDE v2.5 28-Mar-2016 15:54:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @removeMarker_OpeningFcn, ...
                   'gui_OutputFcn',  @removeMarker_OutputFcn, ...
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


% --- Executes just before removeMarker is made visible.
function removeMarker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to removeMarker (see VARARGIN)
addpath(genpath('/Users/lauracollins/Git/Major-Project/Source/Development/'));
% Choose default command line output for removeMarker
handles.output = hObject;
handles.imageName = '';
handles.imagePath = '';
handles.finalImg = [];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes removeMarker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = removeMarker_OutputFcn(hObject, eventdata, handles) 
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

[filename, pathname] = uigetfile('*.pgm','Select pre-compiled pgm file');
if isequal(pathname,0)
   disp('User selected Cancel')
else
    
    handles.imageName = filename;   
    handles.imagePath = pathname;
    guidata(hObject, handles);

    axes(handles.inputImg);
    %imshow(handles.imageName);
    
    %handles.finalImg = removeMarker(strcat(handles.imagePath,handles.imageName));
    
    image = imread(strcat(handles.imagePath,handles.imageName));

    %http://uk.mathworks.com/matlabcentral/answers/102219-how-do-i-make-a-figure-full-screen-programmatically-in-matlab
    %figure('units','normalized','outerposition',[0 0 1 1]);
    
    imshow(image);
    title('Input image');
    
    message = sprintf('Draw the area to be removed. \n Release the mouse once you have finished drawing.');
    
    uiwait(msgbox(message));
    areaDrawn = imfreehand();
    
    mask = areaDrawn.createMask();
    
    finalImage = image;
    
    darkestPoint = min(image(:));
    
    finalImage(mask) = darkestPoint; %set the mask to the darkest point found in the mask
    
    handles.finalImg = finalImage;
    guidata(hObject, handles);
    
    axes(handles.outputImg);
    imshow(handles.finalImg);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%http://uk.mathworks.com/help/matlab/ref/uiputfile.html

[file,path] = uiputfile(strcat(handles.imagePath,handles.imageName),'Save file name');

[imHeight,imWidth, dim] = size(handles.finalImg);

output = fopen(strcat(path,file), 'w');

fprintf(output,'P5\n');
fprintf(output,'%d %d\n',imWidth,imHeight);
fprintf(output,'255\n');
fwrite(output,handles.finalImg.','uchar'); %Need to transpose the array, as fwrite writes by columns
fclose(output);

%imwrite(handles.finalImg, strcat(path,file), 'pgm');
