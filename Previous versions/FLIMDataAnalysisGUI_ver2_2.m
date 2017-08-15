function varargout = FLIMDataAnalysisGUI_ver2_2(varargin)
% FLIMDATAANALYSISGUI_VER2_2 MATLAB code for FLIMDataAnalysisGUI_ver2_2.fig
%      FLIMDATAANALYSISGUI_VER2_2, by itself, creates a new FLIMDATAANALYSISGUI_VER2_2 or raises the existing
%      singleton*.
%
%      H = FLIMDATAANALYSISGUI_VER2_2 returns the handle to a new FLIMDATAANALYSISGUI_VER2_2 or the handle to
%      the existing singleton*.
%
%      FLIMDATAANALYSISGUI_VER2_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLIMDATAANALYSISGUI_VER2_2.M with the given input arguments.
%
%      FLIMDATAANALYSISGUI_VER2_2('Property','Value',...) creates a new FLIMDATAANALYSISGUI_VER2_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FLIMDataAnalysisGUI_ver2_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FLIMDataAnalysisGUI_ver2_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FLIMDataAnalysisGUI_ver2_2

% Last Modified by GUIDE v2.5 19-Feb-2013 18:55:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FLIMDataAnalysisGUI_ver2_2_OpeningFcn, ...
    'gui_OutputFcn',  @FLIMDataAnalysisGUI_ver2_2_OutputFcn, ...
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

% --- Executes just before FLIMDataAnalysisGUI_ver2_2 is made visible.
function FLIMDataAnalysisGUI_ver2_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FLIMDataAnalysisGUI_ver2_2 (see VARARGIN)

% Choose default command line output for FLIMDataAnalysisGUI_ver2_2
handles.output = hObject;

%Initialize handles
handles.NumOfImages = 0;
handles.image_struct = [];

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using FLIMDataAnalysisGUI_ver2_2.
if strcmp(get(hObject,'Visible'),'off')
    
end


% UIWAIT makes FLIMDataAnalysisGUI_ver2_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FLIMDataAnalysisGUI_ver2_2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {});


%% Push buttons for open/close images

% Push button to open Image(s)
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name pathname filterindex] = uigetfile2('*.sdt','MultiSelect','on');


if iscell(name) | name~=0
    if iscell(name)
        filename = name;
    else
        filename = cell(1,1);
        filename{1} = name;
    end
    
    %     %Current slider value
    %     slider_value = get(handles.slider1,'Value');
    %Number of newly loaded images
    NumOfNewImages = length(filename);
    %Number of previously opened images
    NumOfPrevImages = handles.NumOfImages;
    %Total number of loaded images
    NumOfImages = NumOfNewImages+NumOfPrevImages;
    
    %Image structure that contains all the information about the newly
    %opened images
    image_struct = cell(NumOfNewImages,1);
    
    %Two photon image block
    block=1; %1:2pf, 2:SHG
    
    axes(handles.axes1);
    for i = 1:NumOfNewImages
        %load sdt file
        sdt = bh_readsetup([pathname filename{i}]);
        ch = bh_getdatablock(sdt,block);
        img = uint8(squeeze(sum(ch,1)));
        flim = double(ch);
        disp(['progress ' num2str(i) ' out of ' num2str(NumOfImages)])
        
        image_handle = imagesc(img);
        axis image;    colorbar;    set(gca,'FontSize',15);
        hold on;
        set(image_handle,'Visible','off');
        
        %Update image structure
        image_struct{i}.filename = filename{i};
        image_struct{i}.pathname = pathname;
        %image plot handle
        image_struct{i}.image_handle = image_handle;
        %x,y coordinates of pixels selected for analysis
        image_struct{i}.selected_pixel = [];
        %Handles for plot showing selected pixels
        image_struct{i}.selected_pixel_handle = [];
        %FLIM Data
        image_struct{i}.flim = flim;
        %Fluorescence decay data extracted from selected pixels
        image_struct{i}.decay = zeros(size(flim,1),1);
        %Handles for fluorescence decay data plot
        image_struct{i}.decay_handle = [];
    end
    
    %show the first image newly opened
    set(image_struct{1}.image_handle,'Visible','on');
    
    %Show filename
    names = get(handles.popupmenu1,'String');
    set(handles.popupmenu1,'String',[names,filename]);
    set(handles.popupmenu1,'Value',NumOfPrevImages+1);
    
    %update the handles
    %image select slider
    set(handles.slider1,'Min',1);
    set(handles.slider1,'Max',max(NumOfImages,2));
    set(handles.slider1,'Value',NumOfPrevImages+1);
    set(handles.slider1,'SliderStep',[1,1]/(max(NumOfImages,2)-1))
    if NumOfImages>1
        set(handles.slider1,'Visible','on');
    end
    
    %image structure
    handles.image_struct = [handles.image_struct;image_struct];
    %Total Number of images loaded
    handles.NumOfImages = NumOfImages;
    
    handles.previous_value = NumOfPrevImages+1;
    guidata(hObject,handles);
end

% Push Button to close image
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected = get(handles.slider1,'Value');
NumOfImages = handles.NumOfImages;
image_struct = handles.image_struct;
switch NumOfImages
    case 0
        
    case 1
        axes(handles.axes1);
        cla;
        axes(handles.axes2);
        cla;
        image_struct = [];
        NumOfImages = 0;
        
        %update filename
        set(handles.popupmenu1,'String',{})
        %update count
        set(handles.text4,'String',num2str(0));
        
    otherwise
        %delete what's related to the current image shown on the axes
        axes(handles.axes1)
        delete(image_struct{selected}.image_handle);
        delete(image_struct{selected}.selected_pixel_handle);
        axes(handles.axes2)
        delete(image_struct{selected}.decay_handle);
        
        image_struct(selected) = [];
        
        %update filename popupmenu entry
        names = get(handles.popupmenu1,'String');
        names(selected) = [];
        set(handles.popupmenu1,'String',name);
        
        NumOfImages = NumOfImages-1;
        
        %next image automatically shown
        selected = min(selected,NumOfImages);
        
        axes(handles.axes1)
        set(image_struct{selected}.image_handle,'Visible','on');
        set(image_struct{selected}.selected_pixel_handle,'Visible','on');
            
        axes(handles.axes2);
        set(image_struct{selected}.decay_handle,'Visible','on');
           
        %update filename
        set(handles.popupmenu1,'Value',selected);
        
        %update photon counts
        set(handles.text4,'String',num2str(sum(image_struct{selected}.decay)))

end

% update image select slider
set(handles.slider1,'Min',1);
set(handles.slider1,'Max',max(NumOfImages,2));
set(handles.slider1,'Value',max(NumOfImages,1));
set(handles.slider1,'SliderStep',[1,1]/(max(NumOfImages,2)-1))
if NumOfImages>1
    set(handles.slider1,'Visible','on');
else
    set(handles.slider1,'Visible','off');
end

%update handles

%image structure
handles.image_struct = image_struct;
%Total Number of images loaded
handles.NumOfImages = NumOfImages;

handles.previous_value = selected;

guidata(hObject,handles);


%% Push Buttons for Pixel Selection

% Push button to select/deselect pixel
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%currently selected image
selected = get(handles.slider1,'Value');
selected_pixel = handles.image_struct{selected}.selected_pixel;
selected_pixel_handle = handles.image_struct{selected}.selected_pixel_handle;
flim = handles.image_struct{selected}.flim;
decay = handles.image_struct{selected}.decay;

%time axis
dt = str2double(get(handles.edit1,'String'));
time = (1:length(decay))*dt;

if isempty(selected_pixel)
    xx = []; yy= [];
else
    xx = selected_pixel(:,1);
    yy = selected_pixel(:,2);
end

button=1;
decay_handle = 0;

while button==1
    [x,y,button]=ginput(1);
    x = round(x); y = round(y);
    %whether or not pixel already has been selected
    reclick = find(xx == x & yy == y);
    
    axes(handles.axes1);
    if isempty(reclick) && button==1;
        h = plot(x,y,'ks','MarkerFaceColor','k','MarkerSize',5); %mark the point
        selected_pixel_handle = [selected_pixel_handle;h];
        xx=[xx;x];yy=[yy;y];
        decay = decay + flim(:,y,x);
        axes(handles.axes2);
        if decay_handle ~= 0
            delete(decay_handle);
        end
        decay_handle = semilogy(time,decay,'.');
        hold on;
        %update total photon counts
        set(handles.text4,'String',num2str(sum(decay)))
    elseif button==1;
        xx(reclick) = []; yy(reclick) = [];
        delete(selected_pixel_handle(reclick));
        selected_pixel_handle(reclick) = [];
        decay = decay - flim(:,y,x);
        axes(handles.axes2);
        if decay_handle ~= 0
            delete(decay_handle);
        end
        decay_handle = semilogy(time,decay,'.');
        hold on;
        %update total photon counts
        set(handles.text4,'String',num2str(sum(decay)))
    end
    
end
selected_pixel = [xx,yy];

%update handles
handles.image_struct{selected}.selected_pixel = selected_pixel;
handles.image_struct{selected}.selected_pixel_handle = selected_pixel_handle;
handles.image_struct{selected}.decay = decay;
handles.image_struct{selected}.decay_handle = decay_handle;

guidata(hObject,handles);

% Push Button to deselect all pixels
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%currently selected image
selected = get(handles.slider1,'Value');
selected_pixel_handle = handles.image_struct{selected}.selected_pixel_handle;
decay = handles.image_struct{selected}.decay;
decay_handle = handles.image_struct{selected}.decay_handle;
flim = handles.image_struct{selected}.flim;

%time axis
dt = str2double(get(handles.edit1,'String'));
time = (1:length(decay))*dt;

%initialize selected pixel and decay
delete(selected_pixel_handle);
handles.image_struct{selected}.selected_pixel = [];
handles.image_struct{selected}.selected_pixel_handle = [];
handles.image_struct{selected}.decay = zeros(size(flim,1),1);

axes(handles.axes2);
if decay_handle ~= 0
    delete(decay_handle);
end
decay_handle = semilogy(time,decay,'.');
handles.image_struct{selected}.decay_handle = decay_handle;

%update total photon counts
set(handles.text4,'String',num2str(0))

guidata(hObject,handles);




%% Image Selection
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject,'Value');
value = round(value);
set(hObject,'Value',value);

previous_value = handles.previous_value;

axes(handles.axes1);
set(handles.image_struct{previous_value}.image_handle,'Visible','off');
set(handles.image_struct{previous_value}.selected_pixel_handle,'Visible','off');
set(handles.image_struct{value}.image_handle,'Visible','on');
set(handles.image_struct{value}.selected_pixel_handle,'Visible','on');

axes(handles.axes2);
set(handles.image_struct{previous_value}.decay_handle,'Visible','off');
set(handles.image_struct{value}.decay_handle,'Visible','on');

%Show filename
set(handles.popupmenu1,'Value',value);

%update total photon counts
set(handles.text4,'String',num2str(sum(handles.image_struct{value}.decay)))

%update slider previous value
handles.previous_value = value;

guidata(hObject,handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

value = get(hObject,'Value');
set(handles.slider1,'Value',value);

previous_value = handles.previous_value;

axes(handles.axes1);
set(handles.image_struct{previous_value}.image_handle,'Visible','off');
set(handles.image_struct{previous_value}.selected_pixel_handle,'Visible','off');
set(handles.image_struct{value}.image_handle,'Visible','on');
set(handles.image_struct{value}.selected_pixel_handle,'Visible','on');

axes(handles.axes2);
set(handles.image_struct{previous_value}.decay_handle,'Visible','off');
set(handles.image_struct{value}.decay_handle,'Visible','on');

%update total photon counts
set(handles.text4,'String',num2str(sum(handles.image_struct{value}.decay)))

%update slider previous value
handles.previous_value = value;

guidata(hObject,handles);




%%


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String',num2str(0))



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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end