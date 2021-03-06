

function varargout = FLIMDataAnalysisGUI_ver8_3(varargin)
% FLIMDATAANALYSISGUI_VER8_3 MATLAB code for FLIMDataAnalysisGUI_ver8_3.fig
%      FLIMDATAANALYSISGUI_VER8_3, by itself, creates a new FLIMDATAANALYSISGUI_VER8_3 or raises the existing
%      singleton*.
%
%      H = FLIMDATAANALYSISGUI_VER8_3 returns the handle to a new FLIMDATAANALYSISGUI_VER8_3 or the handle to
%      the existing singleton*.6
%   
%      FLIMDATAANALYSISGUI_VER8_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLIMDATAANALYSISGUI_VER8_3.M with the given input ar5guments.
%
%      FLIMDATAANALYSISGUI_VER8_3('Property','Value',...) creates a new FLIMDATAANALYSISGUI_VER8_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FLIMDataAnalysisGUI_ver8_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FLIMDataAnalysisGUI_ver  5_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES5

% Edit the above text to modify the response to help FLIMDataAnalysisGUI_ver8_3

% Last Modified by GUIDE v2.5 12-Apr-2017 12:24:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FLIMDataAnalysisGUI_ver8_3_OpeningFcn, ...
    'gui_OutputFcn',  @FLIMDataAnalysisGUI_ver8_3_OutputFcn, ...
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

% --- Executes just before FLIMDataAnalysisGUI_ver8_3 is made visible.
function FLIMDataAnalysisGUI_ver8_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FLIMDataAnalysisGUI_ver8_3 (see VARARGIN)

% Choose default command line output for FLIMDataAnalysisGUI_ver8_3
handles.output = hObject;

%Initialize handles
handles.NumOfImages = 0;
handles.image_struct = [];
% handles.previous_value = 1;
handles.NumOfSavedDecays = 0;
handles.saved_decay = [];

addpath bh;

fitsetting = zeros(5,3);
fitsetting(1,1) = 0;
fitsetting(1,2) = 1;
fitsetting(3,2) = 1;
fitsetting(5,2) = 1;
fitsetting(:,3) = [-15;0.95;2;0.01;0.01];
fitsetting(:,4) = [15;1;4;1;1];

set(handles.FitSetting_table,'Data',fitsetting);

set(handles.FitSetting_table,'RowName',...
    {'shift';'A';'tau1';'f';'tau2'},'ColumnName',...
    {'Fit';'Fix';'Min';'Max'});

set(handles.Image_axes,'XTick',[],'YTick',[]);


% Update handles structure
guidata(hObject, handles);


% This sets up the initial plot - only do when we are invisible
% so window can get raised using FLIMDataAnalysisGUI_ver8_3.
if strcmp(get(hObject,'Visible'),'off')
    
end

% UIWAIT makes FLIMDataAnalysisGUI_ver8_3 wait for user response (see UIRESUME)
% uiwait(handles.MainGui);


% --- Outputs from this function are returned to the command line.
function varargout = FLIMDataAnalysisGUI_ver8_3_OutputFcn(hObject, eventdata, handles)
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
drawnow; pause(0.05);
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.MainGui)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.MainGui,'Name') '?'],...
    ['Close ' get(handles.MainGui,'Name') '...'],...
    'Yes','No','Yes');
drawnow; pause(0.05);
if strcmp(selection,'No')
    return;
end

delete(handles.MainGui)


% --- Executes during object creation, after setting all properties.
function Filename_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', 'Open Images');
set(hObject, 'Value', 1);
set(hObject, 'Max', 100);
set(hObject, 'Min', 1);

guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function FileName_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileName_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'Value', 1);
set(hObject, 'Max', 1000);
set(hObject, 'Min', 1);

guidata(hObject,handles)


%% Push buttons for open/close images

% Push button to open Image(s)
% --- Executes on button press in OpenImage_pushbutton.
function OpenImage_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figname = 'ImportImagesGUI_v03';

eval([figname,'(''MainGui'',handles.MainGui)']);

guidata(hObject,handles);



% Pushbutton to close image
% --- Executes on button press in CloseImage_pushbutton.
function CloseImage_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseImage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected = get(handles.FileName_listbox,'Value');
NumOfImages = handles.NumOfImages;
image_struct = handles.image_struct;
switch NumOfImages
    case 0
        
    case length(selected)
        for ind = 1:length(selected)
            i = selected(ind);
            set(handles.MainGui,'CurrentAxes',handles.Image_axes)
            if ishandle(image_struct{i}.image_handle)
                delete(image_struct{i}.image_handle);
            end
            if ishandle(image_struct{i}.selected_pixel_handle)
                delete(image_struct{i}.selected_pixel_handle);
            end
            
            set(handles.MainGui,'CurrentAxes',handles.Decay_axes)
            if ishandle(image_struct{i}.decay_handle)
                delete(image_struct{i}.decay_handle);
            end  
        end
        
            image_struct = [];
            NumOfImages = 0;
            
            %update filename
            set(handles.Filename_popupmenu,'String',{'Open Images'})
            set(handles.FileName_listbox,'String',{' '})
            %update count
            set(handles.TotalCount_text,'String',num2str(0));
            
            %Disable decay save
            set(handles.SaveDecay_pushbutton,'Enable','off')
            
            Switch_pushbuttons(handles,'off','image')

    otherwise
        for ind = 1:length(selected)
            i = selected(ind);
            %delete what's related to the current image shown on the axes
            set(handles.MainGui,'CurrentAxes',handles.Image_axes)
            if ishandle(image_struct{i}.image_handle)
                delete(image_struct{i}.image_handle);
            end
            if ishandle(image_struct{i}.selected_pixel_handle)
                delete(image_struct{i}.selected_pixel_handle);
            end
            
            set(handles.MainGui,'CurrentAxes',handles.Decay_axes)
            if ishandle(image_struct{i}.decay_handle)
                delete(image_struct{i}.decay_handle);
            end
            
        end
        
        image_struct(selected) = [];
        
        %update filename popupmenu entry
        set(handles.Filename_popupmenu,'Value',1);
        set(handles.FileName_listbox,'Value',1);
        names = get(handles.Filename_popupmenu,'String');
        names(selected) = [];
        set(handles.Filename_popupmenu,'String',names);
        set(handles.FileName_listbox,'String',names);
        
        NumOfImages = NumOfImages-length(selected);
        
        %next image automatically shown
        selected = min(selected(end),NumOfImages);
        
        set(handles.MainGui,'CurrentAxes',handles.Image_axes)
        set(image_struct{selected}.image_handle,'Visible','on');
        set(image_struct{selected}.selected_pixel_handle,'Visible','on');
        
        set(handles.MainGui,'CurrentAxes',handles.Decay_axes);
        set(image_struct{selected}.decay_handle,'Visible','on');
        
        %update filename
        set(handles.Filename_popupmenu,'Value',selected);
        set(handles.FileName_listbox,'Value',selected);
        
        %update photon counts
        set(handles.TotalCount_text,'String',num2str(sum(image_struct{selected}.decay)))
        
end

% update image select slider
set(handles.ImageSelection_slider,'Min',1);
set(handles.ImageSelection_slider,'Max',max(NumOfImages,2));
set(handles.ImageSelection_slider,'Value',max(NumOfImages,1));
set(handles.ImageSelection_slider,'SliderStep',[1,1]/(max(NumOfImages,2)-1))
if NumOfImages>1
    set(handles.ImageSelection_slider,'Visible','on');
else
    set(handles.ImageSelection_slider,'Visible','off');
end

% update image select popupmenu
set(handles.Filename_popupmenu,'Min',1);
set(handles.Filename_popupmenu,'Max',max(NumOfImages,2));
set(handles.Filename_popupmenu,'Value',max(NumOfImages,1));

set(handles.FileName_listbox,'Value',max(NumOfImages,1));


%update handles

%image structure
handles.image_struct = image_struct;
%Total Number of images loaded
handles.NumOfImages = NumOfImages;

handles.previous_value = selected;

guidata(hObject,handles);


% --- Executes on button press in MakeMovie_pushbutton.
function MakeMovie_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MakeMovie_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath saveastiff_4.4

filtered=0;

showM1 = get(handles.ShowM1_togglebutton,'Value');
showM2 = get(handles.ShowM2_togglebutton,'Value');

selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;
Nframe = length(selected);

% %Example batch filename
eg_fname = image_struct{selected(1)}.filename;
eg_fname = eg_fname(1:(findstr(eg_fname,'_c')-1));

% %Example number of frame
% namelist = get(handles.FileName_listbox,'String');
% TF = strncmp(namelist,eg_fname,namelen);
% eg_Nframe = sum(TF)+(sum(TF)==0)*10;

% %Example repeat time
% ind = findstr(eg_fname,'repeat');
% tempind = findstr(eg_fname,'sec');
% tempind = tempind(tempind>ind);
% if isempty(tempind) == 0 
%     ind2 = tempind(1);
% else
%     ind2 =[];
% end
% if (isempty(ind) && isempty(ind2)) == 0 
%     eg_repeat = eg_fname((ind+6):(ind2-1));
% else
%     eg_repeat = 15;
% end

ind = findstr(eg_fname,'x_');
ind2 = findstr(eg_fname,'_');
ind2 = max(ind2(ind2<ind));
eg_zm = eg_fname(ind2+1:ind-1);



prompt = {'Frame rate (frames/sec)','Magnification (e.g. 60)','Zoom Factor','Extension (e.g. avi, tif)'};
dlg_title = 'Movie Maker';
num_lines = 1;
def = {'8','40',eg_zm,'avi'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

framerate = str2num(answer{1});
mag = str2num(answer{2});
zm = str2num(answer{3});
ext = answer{4};
if zm<0 | zm>32
    errordlg('Zoom Factor must be between 1 and 32')
end

% field of view is 440um for 1x zoom, 40x objective
pixsize = 440*40/mag/zm/size(image_struct{selected(1)}.image,1);

%choose save directory
[filename,pathname] = uiputfile3([eg_fname,'.',ext],'Save movie file as','mode','analysis');
drawnow; pause(0.05);
if filename == 0 
    return;
end

imagetime = zeros(Nframe,1);
image = cell(Nframe,1);
% figure the order of increasing time
timevec = zeros(Nframe,6);
for i = 1:Nframe
    timevec(i,:) = timesdt(image_struct{selected(i)}.setting,'vector');
    imagetime(i) = etime(timevec(i,:),timevec(1,:));
    image{i} = double(image_struct{selected(i)}.image);
end
[imagetime,sortind] = sort(imagetime);
imagetime = imagetime - min(imagetime);
image = image(sortind);

if strcmp(ext,'avi')
    writerObj = VideoWriter([pathname,filename],'Uncompressed AVI');
    writerObj.FrameRate = framerate;
    open(writerObj)
    for i = 1:Nframe
        %     numdig = findstr(namelist{1},'.sdt')-findstr(namelist{1},'_c')-2;
        %     typestr = ['%0',num2str(numdig),'d'];
        %     fname = [batchfname,'_c',num2str(i,typestr),'.sdt'];
        %     ind = find(strcmp(namelist,fname)==1);
        %
        %     if isempty(ind)
        %         errordlg('image not found, check frame number')
        %         return;
        %     end
        img = image{i};
        
        h = figure;
        if showM1 && showM2
            img(:,:,1) = img(:,:,1)/max(max(img(:,:,1)));
            img(:,:,2) = img(:,:,2)/max(max(img(:,:,2)));
        end
        
        if filtered == 1
            img(:,:,1) = bpass(img(:,:,1),1,4);
            img(:,:,2) = bpass(img(:,:,2),1,4);
        end
        
        imagesc(img);
        truesize(h);
        axis off;
        axis image;
        if showM1+showM2 == 1
            colormap(gray);
        end
        hold on;
        
        if i == 1;
            
        end
        
        %Add scale bar
        %in micrometer
        barsize = 2;
        line([0.9*size(img,2)-round(barsize/pixsize),0.9*size(img,2)],...
            [0.9*size(img,1),0.9*size(img,1)],'LineWidth',2,'Color','Yellow')
        text(0.9*size(img,2)-round(barsize/pixsize),0.9*size(img,1)-6,...
            [num2str(barsize), '{\mu}', 'm'],'Color','yellow','fontsize',6)
        %Add real time
        H = floor(imagetime(i)/3600);
        MN = floor(rem(imagetime(i),3600)/60);
        S = imagetime(i)-3600*H-60*MN;
        timestr = [num2str(H,'%02d'),':',num2str(MN,'%02d'),':',num2str(S,'%02d')];
        
        text(0.1*size(img,2),0.1*size(img,1),timestr,'fontsize',6,...
            'Color','y')
        
        hold off;
        
        F = getframe;
        
        warning('off', 'Images:initSize:adjustingMag');
        writeVideo(writerObj,F);
        
        close(h);
    end
    
    close(writerObj)

else
    clear opt
    opt.message = false;
    if showM1&& showM2
        nameM1 = fullfile(pathname,[filename(1:end-4),'_m1',filename(end-3:end)]);
        nameM2 = fullfile(pathname,[filename(1:end-4),'_m2',filename(end-3:end)]);
    else
        name = [pathname,filename];
    end
    
    for i = 1:Nframe
        img = uint16(image{i});
        
        if i == 1
            opt.append = false;
        else
            opt.append = true;
        end
        
        
        if showM1 && showM2
            saveastiff(img(:,:,1),nameM1,opt);
            saveastiff(img(:,:,2),nameM2,opt);
        else
            saveastiff(img,name,opt);
        end
    end
end

disp('Movie generation completed')


%% Push Buttons for Pixel Selection

% Push button to select/deselect pixel
% --- Executes on button press in PixelSelection_pushbutton.
function PixelSelection_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PixelSelection_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%currently selected image
selected = get(handles.ImageSelection_slider,'Value');
selected_pixel = handles.image_struct{selected}.selected_pixel;
selected_pixel_handle = handles.image_struct{selected}.selected_pixel_handle;
flim = handles.image_struct{selected}.flim;
decay = handles.image_struct{selected}.decay;
decay_handle = handles.image_struct{selected}.decay_handle;
active_region = handles.image_struct{selected}.active_region;
img = handles.image_struct{selected}.image;
dt = handles.image_struct{selected}.dt;

update_gui_new(handles,0,1)

%time axis
time = (1:length(decay))'*dt;

button=1;

set(handles.MainGui,'CurrentAxes',handles.Image_axes);


while button==1
    [x,y,button]=ginput(1);
    x = round(x); y = round(y);
    
    set(handles.MainGui,'CurrentAxes',handles.Image_axes);
    if button ==1 
        selected_pixel(y,x) = ~selected_pixel(y,x);
        
        [yy,xx] = find(selected_pixel==1);
        
        if selected_pixel(y,x) && active_region(y,x)
            decay = decay + flim(:,y,x);
        else
            decay = decay - flim(:,y,x);
        end
        
        if ishandle(selected_pixel_handle)
            delete(selected_pixel_handle)
        end
        selected_pixel_handle = plot(xx,yy,'ws','MarkerSize',5); %mark the point
        
        set(handles.MainGui,'CurrentAxes',handles.Decay_axes);
        if ishandle(decay_handle)
            delete(decay_handle);
        end
        decay_handle = semilogy(time,decay,'or');
        hold on;
        %update total photon counts
        set(handles.TotalCount_text,'String',num2str(sum(decay)))
        %update total number of selected pixel
        set(handles.NumOfSelectedPixel_text,'String',num2str(sum(sum(selected_pixel.*active_region))))
    end
end

%update handles
handles.image_struct{selected}.selected_pixel = selected_pixel;
handles.image_struct{selected}.selected_pixel_handle = selected_pixel_handle;
handles.image_struct{selected}.decay = decay;
handles.image_struct{selected}.decay_handle = decay_handle;

guidata(hObject,handles);

% Push Button to deselect all pixels
% --- Executes on button press in DeselectAll_pushbutton.
function DeselectAll_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DeselectAll_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%currently selected image
selected = get(handles.ImageSelection_slider,'Value');
selected_pixel = handles.image_struct{selected}.selected_pixel;
img = handles.image_struct{selected}.image;
active_region = handles.image_struct{selected}.active_region;

update_gui_new(handles,0,1)

selected_pixel(active_region==1) = 0;

%update handles
handles.image_struct{selected}.selected_pixel = selected_pixel;

handles = updateSelectedPixel(handles,selected);

guidata(hObject,handles);


% --- Executes on button press in SelectBetween_pushbutton.
function SelectBetween_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectBetween_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%currently selected image
selected = get(handles.ImageSelection_slider,'Value');
img = handles.image_struct{selected}.image;
selected_pixel = handles.image_struct{selected}.selected_pixel;
flim = handles.image_struct{selected}.flim;
above_number = str2double(get(handles.SelectAbove_edit,'String'));
below_number = str2double(get(handles.SelectBelow_edit,'String'));
active_region = handles.image_struct{selected}.active_region;

update_gui_new(handles,0,1)

Mind = squeeze(sum(flim,1))>above_number & squeeze(sum(flim,1))<below_number;

set(handles.MainGui,'CurrentAxes',handles.Image_axes);

selected_pixel(active_region==1)=Mind(active_region==1);

handles.image_struct{selected}.selected_pixel = selected_pixel;

handles = updateSelectedPixel(handles,selected);

guidata(hObject,handles);


% --- Executes on button press in SetActiveRegion_pushbutton.
function SetActiveRegion_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SetActiveRegion_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%currently selected image
selected = get(handles.ImageSelection_slider,'Value');
active_region_handle = handles.image_struct{selected}.active_region_handle;

update_gui_new(handles,0,1)

set(handles.MainGui,'CurrentAxes',handles.Image_axes);
if isempty(active_region_handle) == 0
    delete(active_region_handle)
end
[active_region,xi,yi] = roipoly();
if isempty(xi)
    return
end
active_region_handle = drawPolygon([xi,yi],'w','LineWidth',2);

handles.image_struct{selected}.active_region = active_region;
handles.image_struct{selected}.active_region_handle = active_region_handle;

handles = updateSelectedPixel(handles,selected);

guidata(hObject,handles);


% --- Executes on button press in RemoveActiveRegion_pushbutton.
function RemoveActiveRegion_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveActiveRegion_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.ImageSelection_slider,'Value');

active_region = handles.image_struct{selected}.active_region;
active_region_handle = handles.image_struct{selected}.active_region_handle;
img = handles.image_struct{selected}.image;

if isempty(active_region) ==0
    
    active_region = ones(size(img,1),size(img,2));
    
    set(handles.MainGui,'CurrentAxes',handles.Image_axes);
    delete(active_region_handle);
    active_region_handle = [];
    
    handles.image_struct{selected}.active_region = active_region;
    handles.image_struct{selected}.active_region_handle = active_region_handle;
    
    handles = updateSelectedPixel(handles,selected);
    
    guidata(hObject,handles);
    
end


% --- Executes on button press in ImportMask_pushbutton.
function ImportMask_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ImportMask_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;
Nselected = length(selected);

[fname, pthname,filterind] = uigetfile3({'*.h5','Mask image in h5 format (*.h5)';'*.tif','Tiff images (*.tif)'},'Mode','analysis','MultiSelect','on');
drawnow; pause(0.05);

if iscell(fname)
    Nfile = length(fname);
else
    Nfile = 1;
    fname = {fname};
end

if Nfile ~= Nselected
    errordlg('The number of masks doesn''t match the number of selected images');
    return
end

mask = cell(Nfile,1);

if filterind == 1
    for i = 1:Nfile
        pred = h5read([pthname,fname{i}],'/volume/prediction');
        mask{i} = squeeze(pred(2,:,:)>0.5);
    end
elseif filterind ==2
    for i = 1:Nfile
        mask{i} = imread([pthname,fname{i}]);
        mask{i} = mask{i}>0; %make binary mask
        mask{i} = transpose(mask{i});
    end
end

for i = 1:Nselected
    image_struct{selected(i)}.selected_pixel = mask{i};
end
handles.image_struct = image_struct;

handles = updateSelectedPixel(handles,selected);

guidata(hObject,handles);



%% Batch Analysis

% --- Executes on button press in SameActiveRegion_pushbutton.
function SameActiveRegion_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SameActiveRegion_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current = get(handles.ImageSelection_slider,'Value');
selected = get(handles.FileName_listbox,'Value');
current_active_region = handles.image_struct{current}.active_region;
current_active_region_handle = handles.image_struct{current}.active_region_handle;

if isempty(current_active_region)==0
    
    cand = selected(selected~=current);
    
    for ind = 1:length(cand);
        
        i = cand(ind);
        
        image_struct = handles.image_struct{i};
        
        active_region_handle = image_struct.active_region_handle;
        
        if ishandle(active_region_handle)
            delete(active_region_handle);
        end
        
        set(handles.MainGui,'CurrentAxes',handles.Image_axes);
        active_region_handle = copyobj(current_active_region_handle,handles.Image_axes);
        set(active_region_handle,'Visible','off');

        %update handles
        image_struct.active_region = current_active_region;
        image_struct.active_region_handle = active_region_handle;

        handles.image_struct{i} = image_struct;
    end
end

handles = updateSelectedPixel(handles,cand);

guidata(hObject,handles);

% --- Executes on button press in SameSelectCriteria_pushbutton.
function SameSelectCriteria_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SameSelectCriteria_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.FileName_listbox,'Value');
current = get(handles.ImageSelection_slider,'Value');
above_number = str2double(get(handles.SelectAbove_edit,'String'));
below_number = str2double(get(handles.SelectBelow_edit,'String'));
image_struct = handles.image_struct;

selected = selected(selected~=current);

for idx = 1:length(selected);
    i = selected(idx);
    
    active_region = image_struct{i}.active_region;
    img = image_struct{i}.image;
    flim = image_struct{i}.flim;
    selected_pixel = image_struct{i}.selected_pixel;
    
    Mind = squeeze(sum(flim,1))>above_number & squeeze(sum(flim,1))<below_number;
    
    set(handles.MainGui,'CurrentAxes',handles.Image_axes);
    
    selected_pixel(active_region==1)=Mind(active_region==1);

    %update image_struct
    image_struct{i}.selected_pixel = selected_pixel;
end

handles.image_struct = image_struct;
handles = updateSelectedPixel(handles,selected);
guidata(hObject,handles);



% --- Executes on button press in KinetochoreSelection_pushbutton.
function KinetochoreSelection_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to KinetochoreSelection_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


figname = 'KinetochoreSelectionTool_ver9_1';
hfig = CheckOpenState(figname);
if hfig ~= -99
    choice = questdlg([figname ' is currently open. Pressing "Yes" will delete the data previously in ',figname,' and open new one.'],'!Already opened!');
    if strcmp(choice,'Yes')==0
        return;
    else
        close(hfig)
    end
end

selected = get(handles.FileName_listbox,'Value');

image_struct = handles.image_struct;

if isempty(image_struct)
    errordlg('Open and choose image first')
    return;
end

N_frame = length(selected);

%Frames of interst
FOI = cell(length(selected),1);
for j = 1:length(selected)
    FOI{j} = image_struct{selected(j)};
    rmfield(FOI{j},'flim');
end



%batch filename
eg_fname = image_struct{selected(1)}.filename;
eg_fname = eg_fname(1:(end-8));

%Example repeat time
ind = findstr(eg_fname,'repeat');
tempind = findstr(eg_fname,'sec');
ind2 = tempind(tempind>ind);
if (isempty(ind) & isempty(ind2)) == 0 
    eg_repeat = eg_fname((ind+6):(ind2-1));
else
    eg_repeat = 15;
end


prompt = {'Magnification (e.g. 60)'...
    'Zoom Factor','Pixel Size (optional)'};
dlg_title = 'Kinetochore Analysis';
num_lines = 1;
def = {'40','32',''};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

mag = str2double(answer{1});
zm = str2double(answer{2});
pixsize = answer{3};
% field of view is 440um for 1x zoom, 40x objective
if isempty(pixsize) || isNaN(pixsize)
    pixsize = 440*40/mag/zm/size(FOI{1}.image,1);
else
    pixsize = str2double(pixsize);
end



setappdata(0  , 'hMainGui'    , gcf);
setappdata(gcf, 'N_frame', N_frame);
setappdata(gcf, 'FOI', FOI);
setappdata(gcf, 'selected',selected);
setappdata(gcf, 'pixsize', pixsize);

eval([figname,'(''fromMainGui'')'])


% --- Executes on button press in SaveSelectedDecays_pushbutton.
function SaveSelectedDecays_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSelectedDecays_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;
saved_decay = handles.saved_decay;
NumOfSavedDecays = handles.NumOfSavedDecays;    

%Example batch decayname
eg_decayname = image_struct{selected(1)}.filename(1:2);

prompt = {'Decay batch name:','Frame start:','Threshold:'};
dlg_title = 'Decay Batch Save';
num_lines = 1;
def = {eg_decayname,'1','100'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

decaybatchname = answer{1};
framestart = str2num(answer{2});
thres = str2double(answer{3});
namelist = get(handles.FileName_listbox,'String');

set(handles.SavedDecay_listbox,'Min',1)
set(handles.SavedDecay_listbox,'Max',NumOfSavedDecays+length(selected))

for i = 1:length(selected)
%     fname = [batchfname,'_c',num2str(i,'%02d'),'.sdt'];
% %    fname = [batchfname,'_c',num2str(i),'.sdt'];
%     ind = find(strcmp(namelist,fname)==1);
%     if isempty(ind)
%         errordlg('image not found, check frame number')
%         return;
%     end
    img = image_struct{selected(i)}.image;
    decay = image_struct{selected(i)}.decay;
    filename = image_struct{selected(i)}.filename;
    pathname = image_struct{selected(i)}.pathname;
    selected_pixel = image_struct{selected(i)}.selected_pixel;
    dt = image_struct{selected(i)}.dt;
    setting = image_struct{selected(i)}.setting;
    flimblock = image_struct{selected(i)}.flimblock;
    
    if sum(decay)<thres
        continue;
    end
    
    if isempty(decaybatchname);
        decay_name = namelist{selected(i)};
    else
        decay_name = [decaybatchname, '_fr', num2str(framestart-1+i,'%02d')];
    end
    
    if NumOfSavedDecays == 0;
        set(handles.SavedDecay_listbox,'String',{decay_name})
        %Enable pushbuttons
        Switch_pushbuttons(handles,'on','decay')
    else
        names = get(handles.SavedDecay_listbox,'String');
        set(handles.SavedDecay_listbox,'String',[names;{decay_name}])
    end
    
    decay_to_save = cell(1,1);
    decay_to_save{1}.decay = decay;
    decay_to_save{1}.name = decay_name;
    decay_to_save{1}.filename = filename;
    decay_to_save{1}.image = img;
    decay_to_save{1}.selected_pixel = selected_pixel;
    decay_to_save{1}.setting = setting;
    decay_to_save{1}.pathname = pathname;
    decay_to_save{1}.flimblock = flimblock;
    
    NumOfSavedDecays = NumOfSavedDecays + 1;
    
    %time axis
    time = (1:length(decay))'*dt;
    
    decay_to_save{1}.time = time;
    
    set(handles.MainGui,'CurrentAxes',handles.Decay_axes)
    decay_handle = semilogy(time,decay,'or');
    set(decay_handle,'Visible','off');
    
    decay_to_save{1}.decay_handle = decay_handle;
    
    saved_decay = [saved_decay;decay_to_save];
    
end

handles.saved_decay = saved_decay;
handles.NumOfSavedDecays = NumOfSavedDecays;

set(handles.SavedDecay_listbox, 'Max', NumOfSavedDecays);
set(handles.SavedDecay_listbox, 'Value', 1);


guidata(hObject,handles);


%% Image Selection
% --- Executes on slider movement.
function ImageSelection_slider_Callback(hObject, eventdata, handles)
% hObject    handle to ImageSelection_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject,'Value');
value = round(value);
set(hObject,'Value',value);

% previous_value = handles.previous_value;

update_gui_new(handles,1,1);
% 
% %update slider previous value
% handles.previous_value = value;

guidata(hObject,handles);

% --- Executes on selection change in Filename_popupmenu.
function Filename_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Filename_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filename_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filename_popupmenu

NumOfImages = handles.NumOfImages;

if NumOfImages>0
    value = get(hObject,'Value');
    set(handles.ImageSelection_slider,'Value',value);
    
    update_gui_new(handles,1,1);
    
%     
%     %update slider previous value
%     handles.previous_value = value;
    
end

guidata(hObject,handles);




%% Decay handling
% --- Executes on button press in SaveDecay_pushbutton.
function SaveDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


selected = get(handles.Filename_popupmenu,'Value');


NumOfSavedDecays = handles.NumOfSavedDecays;
filename = handles.image_struct{selected}.filename;
pathname = handles.image_struct{selected}.pathname;
decay = handles.image_struct{selected}.decay;
saved_decay = handles.saved_decay;
img = handles.image_struct{selected}.image;
selected_pixel = handles.image_struct{selected}.selected_pixel;
dt = handles.image_struct{selected}.dt;
setting = handles.image_struct{selected}.setting;
flimblock = handles.image_struct{selected}.flimblock;

decay_name = get(handles.DecayName_edit,'String');
if isempty(decay_name)
    decay_name = {['decay' num2str(NumOfSavedDecays+1)]};
end

if NumOfSavedDecays == 0;
    set(handles.SavedDecay_listbox,'String',{decay_name})
    %Enable pushbuttons
    Switch_pushbuttons(handles,'on','decay')
else
    names = get(handles.SavedDecay_listbox,'String');
    set(handles.SavedDecay_listbox,'String',[names;{decay_name}])
end

decay_to_save = cell(1,1);
decay_to_save{1}.decay = decay;
decay_to_save{1}.name = decay_name;
decay_to_save{1}.filename = filename;
decay_to_save{1}.image = img;
decay_to_save{1}.selected_pixel = selected_pixel;
decay_to_save{1}.setting = setting;
decay_to_save{1}.pathname = pathname;
decay_to_save{1}.flimblock = flimblock;

NumOfSavedDecays = NumOfSavedDecays + 1;

%time axis
time = (1:length(decay))'*dt;

decay_to_save{1}.time = time;

set(handles.MainGui,'CurrentAxes',handles.Decay_axes)
decay_handle = semilogy(time,decay,'or');
set(decay_handle,'Visible','off');

decay_to_save{1}.decay_handle = decay_handle;

saved_decay = [saved_decay;decay_to_save];

handles.saved_decay = saved_decay;
handles.NumOfSavedDecays = NumOfSavedDecays;

set(handles.SavedDecay_listbox,'Min',1)
set(handles.SavedDecay_listbox,'Max',NumOfSavedDecays+2)

set(handles.SavedDecay_listbox, 'Value', NumOfSavedDecays);

guidata(hObject,handles)
    
    


% --- Executes on button press in DeleteDecay_pushbutton.
function DeleteDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decay_sel =  get(handles.SavedDecay_listbox,'Value');
NumOfSavedDecays = handles.NumOfSavedDecays;

set(handles.MainGui,'CurrentAxes',handles.Decay_axes)

for i = decay_sel;
    delete(handles.saved_decay{i}.decay_handle)
end

saved_decay = handles.saved_decay;
saved_decay(decay_sel) = [];
handles.saved_decay = saved_decay;

names = get(handles.SavedDecay_listbox,'String');
names(decay_sel) = [];

NumOfSavedDecays = NumOfSavedDecays - length(decay_sel);

if NumOfSavedDecays == 0
    set(handles.SavedDecay_listbox,'String',' ');
    Switch_pushbuttons(handles,'off','decay')
else
    set(handles.SavedDecay_listbox,'String',names);
end

set(handles.SavedDecay_listbox,'Min',1)
set(handles.SavedDecay_listbox,'Max',NumOfSavedDecays+2)

set(handles.SavedDecay_listbox, 'Value', max(NumOfSavedDecays,1));

handles.NumOfSavedDecays = NumOfSavedDecays;

guidata(hObject,handles)


% --- Executes on button press in ShowDecay_pushbutton.
function ShowDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ShowDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decay_sel =  get(handles.SavedDecay_listbox,'Value');

if length(decay_sel) > 1
    errordlg('Select a single decay')
else
    decay = handles.saved_decay{decay_sel}.decay;
    decay_handle = handles.saved_decay{decay_sel}.decay_handle;
    
    update_gui_new(handles,0,1,decay,decay_handle)
end

guidata(hObject,handles)



% --- Executes on button press in SetIRF_pushbutton.
function SetIRF_pushbutton_Callback(hObject, ~, handles)
% hObject    handle to SetIRF_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

decay_sel = get(handles.SavedDecay_listbox,'Value');


prompt = {'Peak region (from)','Peak region (to)',...
    'Constant Background region (from)','Constant Background region (to)'};
dlg_title = 'Save IRF setting';
num_lines = 1;
def = {'1.5','3','7','9'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

peakfrom = str2num(answer{1});
peakto = str2num(answer{2});
backgrfrom = str2num(answer{3});
backgrto = str2num(answer{4});

[name pathname filterindex] = uiputfile('IRF/*.mat');
drawnow; pause(0.05);

if length(decay_sel) > 1
    errordlg('Select a single decay')
else
    decay = handles.saved_decay{decay_sel}.decay;
    time = handles.saved_decay{decay_sel}.time;
    decay_struct = handles.saved_decay{decay_sel};
    
    backgr = mean(decay(time>backgrfrom & time<backgrto));
    decay(time<peakfrom | time>peakto) = 0;
    decay(time>=peakfrom & time<=peakto) =...
        max(decay(time>=peakfrom & time<=peakto) - backgr,0);
    
    
    save(['IRF/' name],'decay','time','decay_struct');
end



% --- Executes on button press in SaveRefCurve_pushbutton.
function SaveRefCurve_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveRefCurve_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decay_sel = get(handles.SavedDecay_listbox,'Value');

prompt = {'smoothing parameter'};
dlg_title = 'Save Reference Curve setting';
num_lines = 1;
def = {'100'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

smoothfactor = str2double(answer{1});

[name pathname filterindex] = uiputfile('ReferenceCurve/*.mat');
drawnow; pause(0.05);

if length(decay_sel) > 1
    errordlg('Select a single decay')
else
    decay = double(handles.saved_decay{decay_sel}.decay);
    decay = smooth(decay,smoothfactor);
    time = handles.saved_decay{decay_sel}.time;
    decay_struct = handles.saved_decay{decay_sel};
    
    save([pathname, name],'decay','time','decay_struct');
end


% --- Executes on button press in ExportDecay_pushbutton.
function ExportDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ExportDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[name pathname filterindex] = uiputfile3('*.mat','mode','analysis');
drawnow; pause(0.05);
if name ~= 0
    decay_sel = get(handles.SavedDecay_listbox,'Value');
    saved_decay = handles.saved_decay;
    
    decay_struct = saved_decay(decay_sel);
    
    save([pathname name],'decay_struct')
end


% --- Executes on button press in ImportDecay_pushbutton.
function ImportDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ImportDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name pathname filterindex] = uigetfile3('*.mat','mode','analysis');
drawnow; pause(0.05);

if name ~= 0
    load([pathname name]);
    imported_decay = decay_struct;
    saved_decay = handles.saved_decay;
    NumOfSavedDecays = handles.NumOfSavedDecays;
    
    set(handles.MainGui,'CurrentAxes',handles.Decay_axes)
    for i = 1:length(imported_decay)
        time = imported_decay{i}.time;
        decay_handle = semilogy(time,imported_decay{i}.decay,'or');
        hold on;
        set(decay_handle,'Visible','off')
        imported_decay{i}.decay_handle = decay_handle;
    end
    
    saved_decay = [saved_decay;imported_decay];
    
    imported_decay_name = cell(length(imported_decay),1);
    for i = 1:length(imported_decay)
        imported_decay_name(i) = {imported_decay{i}.name};
    end
    
    if NumOfSavedDecays == 0;
        set(handles.SavedDecay_listbox,'String',imported_decay_name)
        %Enable pushbuttons
        Switch_pushbuttons(handles,'on','decay')
    else
        names = get(handles.SavedDecay_listbox,'String');
        set(handles.SavedDecay_listbox,'String',[names;imported_decay_name])
    end
    
    NumOfSavedDecays = NumOfSavedDecays + length(imported_decay);
    
    handles.saved_decay = saved_decay;
    handles.NumOfSavedDecays = NumOfSavedDecays;
    
    set(handles.SavedDecay_listbox,'Min',1)
    set(handles.SavedDecay_listbox,'Max',max(2,NumOfSavedDecays))
    
    set(handles.SavedDecay_listbox, 'Value', NumOfSavedDecays);
    
    guidata(hObject,handles);
end



% --- Executes on button press in ShowImage_pushbutton.
function ShowImage_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ShowImage_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
decay_sel = get(handles.SavedDecay_listbox,'Value');
saveornot = get(handles.SaveImage_checkbox,'Value');

if saveornot == 0
    for i = decay_sel
        decay_struct = handles.saved_decay{i};
        fnames = fieldnames(decay_struct);
        
        if sum(strcmp(fnames,'image'))==0
            errordlg([decay_struct.name, ': No corresponding image to show'])
        else
            img = double(decay_struct.image);
            selected_pixel = decay_struct.selected_pixel;
            %            [max_x,max_y] = find(img == max(max(img)));
            
            h = figure;
            if size(img,3) == 1
                imagesc(img);
                colormap(gray);
            else
                normimg = img;
                normimg(:,:,1) = normimg(:,:,1)/max(max(normimg(:,:,1)));
                normimg(:,:,2) = normimg(:,:,2)/max(max(normimg(:,:,2)));
                
                imagesc(normimg);
            end
%            colormap(gray);
%            axis([max_y(1)-90,max_y(1)+90,max_x(1)-90, max_x(1)+90])
            %axis([128-60,128+60,128-60,128+60])
            axis image;
            hold on;
            [xx,yy] = find(selected_pixel' == 1);
            plot(xx,yy,'ws','MarkerSize',5)
            
            scrsz = get(0,'ScreenSize');
            set(h,'Position',[100 scrsz(4)/2-100 scrsz(3)/2 scrsz(4)/2])
            hh = gca;
            hh.XTick = [];
            hh.YTick = [];
            
        end
    end
else
    load('lastUsedDir.mat');
    pathname = uigetdir(lastUsedDir,'Choose a folder to save results');
    drawnow; pause(0.05);
    
    if pathname ~= 0
        for i = decay_sel
            decay_struct = handles.saved_decay{i};
            fnames = fieldnames(decay_struct);
            
            if sum(strcmp(fnames,'image'))==0
                errordlg([decay_struct.name, ': No corresponding image to show'])
            else
                img = decay_struct.image;
                selected_pixel = decay_struct.selected_pixel;
                %                [max_x,max_y] = find(img == max(max(img)));
                normimg = img;
                normimg(:,:,1) = normimg(:,:,1)/max(max(normimg(:,:,1)));
                normimg(:,:,2) = normimg(:,:,2)/max(max(normimg(:,:,2)));
                h = figure;
                imagesc(normimg);
%                colormap(gray);
%                axis([max_y(1)-60,max_y(1)+60,max_x(1)-60, max_x(1)+60])
                axis image;
                colorbar;
                hold on;
                [xx,yy] = find(selected_pixel' == 1);
                plot(xx,yy,'ws','MarkerSize',5)
                
                scrsz = get(0,'ScreenSize');
                set(h,'Position',[100 scrsz(4)/2-100 scrsz(3)/2 scrsz(4)/2])
                
                print(h,'-dpng',[pathname,'/',decay_struct.name,'_img'])
                
                close(h);
            end
        end
    end
end

guidata(hObject,handles)

% --- Executes on button press in FitDecay_pushbutton.
function FitDecay_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FitDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

decay_sel = get(handles.SavedDecay_listbox,'Value');
decay_struct = handles.saved_decay(decay_sel);

figname = 'FittingGUI_ver9_2';

hfig = CheckOpenState(figname);
if hfig ~= -99
    choice = questdlg([figname ' is currently open. Pressing "New" will delete the data previously in ',figname,' and open new one.'],'!Already opened!','New','Append','Cancel','Cancel');
    if strcmp(choice,'New')==1
        close(hfig);
    elseif strcmp(choice,'Append')==1
    else
        return;
    end
else
    choice = 'New';
end
eval([figname,'(''inputdecaystruct'',decay_struct,''mode'',choice)'])





%%
% --- Executes during object creation, after setting all properties.
function ImageSelection_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageSelection_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Image_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Image_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Image_axes


% --- Executes during object creation, after setting all properties.
function Decay_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Decay_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate Decay_axes


% --- Executes during object creation, after setting all properties.
function TotalCount_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TotalCount_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String',num2str(0))






% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in SavedDecay_popupmenu.
function SavedDecay_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to SavedDecay_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SavedDecay_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SavedDecay_popupmenu


% --- Executes during object creation, after setting all properties.
function SavedDecay_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SavedDecay_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',' ');

guidata(hObject,handles);






function DecayName_edit_Callback(hObject, eventdata, handles)
% hObject    handle to DecayName_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DecayName_edit as text
%        str2double(get(hObject,'String')) returns contents of DecayName_edit as a double


% --- Executes during object creation, after setting all properties.
function DecayName_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecayName_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function SaveDecay_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off')
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function ExportDecay_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExportDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off')
guidata(hObject,handles)


% --- Executes on mouse press over figure background.
function MainGui_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to MainGui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function ShowDecay_pushbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowDecay_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Enable','off')
guidata(hObject,handles)


% --- Executes on selection change in SavedDecay_listbox.
function SavedDecay_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to SavedDecay_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SavedDecay_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SavedDecay_listbox


% --- Executes during object creation, after setting all properties.
function SavedDecay_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SavedDecay_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',' ');

guidata(hObject,handles);




% --- Executes when uipanel2 is resized.
function uipanel2_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function RefTau_edit_Callback(hObject, eventdata, handles)
% hObject    handle to RefTau_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RefTau_edit as text
%        str2double(get(hObject,'String')) returns contents of RefTau_edit as a double


% --- Executes during object creation, after setting all properties.
function RefTau_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RefTau_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function SelectAbove_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectAbove_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SelectAbove_edit_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAbove_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SelectAbove_edit as text
%        str2double(get(hObject,'String')) returns contents of SelectAbove_edit as a double



% --- Executes on button press in SaveImage_checkbox.
function SaveImage_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveImage_checkbox



function SelectBelow_edit_Callback(hObject, eventdata, handles)
% hObject    handle to SelectBelow_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SelectBelow_edit as text
%        str2double(get(hObject,'String')) returns contents of SelectBelow_edit as a double


% --- Executes during object creation, after setting all properties.
function SelectBelow_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectBelow_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FileName_listbox.
function FileName_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to FileName_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileName_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileName_listbox


% --- Executes when user attempts to close MainGui.
function MainGui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to MainGui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
fclose all
delete(hObject);





% --- Executes on button press in ShowIRF_checkbox.
function ShowIRF_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to ShowIRF_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowIRF_checkbox
showvalue = get(hObject,'Value');

if isfield(handles,'irf_handle') && ishandle(handles.irf_handle)
    if showvalue
        set(handles.irf_handle,'Visible','on');
    else
        set(handles.irf_handle,'Visible','off');
    end
else
    return
end



% --- Executes on button press in LoadIRF_pushbutton.
function LoadIRF_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadIRF_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name pathname filterindex] = uigetfile('IRF/*.mat');
drawnow; pause(0.05);
if name == 0 
    return;
end

showvalue = get(handles.ShowIRF_checkbox,'Value');

loaded_irf = load([pathname name]);
time_irf = loaded_irf.time;
irf = loaded_irf.decay;
irf = irf/max(irf)*1E3;

set(handles.MainGui,'CurrentAxes',handles.Decay_axes);
if isfield(handles,'irf_handle') && ishandle(handles.irf_handle)
    delete(handles.irf_handle);
end
irf_handle = semilogy(time_irf,irf,'g');
    
set(irf_handle,'Visible','off');
if showvalue == 1
    set(decay_struct{selected(1)}.irf_handle,'Visible','on');
end

handles.irf = irf;
handles.time_irf = time_irf;
handles.irfname = name;
handles.irf_handle = irf_handle;

%set(handles.NoIRF_text,'Visible','off')

guidata(hObject,handles);


% --- Executes on selection change in NumOfExpo_popupmenu.
function NumOfExpo_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfExpo_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns NumOfExpo_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumOfExpo_popupmenu


% --- Executes during object creation, after setting all properties.
function NumOfExpo_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfExpo_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FittingMethod_popupmenu.
function FittingMethod_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to FittingMethod_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FittingMethod_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FittingMethod_popupmenu


% --- Executes during object creation, after setting all properties.
function FittingMethod_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FittingMethod_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ShowSample_pushbutton.
function ShowSample_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ShowSample_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;

binning = str2double(get(handles.BinningFactor_edit,'String'));
downsize = str2double(get(handles.DownsizeFactor_edit,'String'));

flim_downsize = downsamp3d(image_struct{selected(1)}.flim,[1,downsize,downsize]);
[binned_flim,W] = ndnanfilter(flim_downsize,@rectwin,[0,binning,binning]);
sampleimage = squeeze(sum(binned_flim,1))*sum(W(:));
h = figure;
imagesc(sampleimage);   
colormap gray;
axis image
colorbar



% --- Executes on button press in Fit_pushbutton.
function Fit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Fit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath CONVNFFT_Folder
addpath FLIMFitting\

selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;

if isfield(handles,'irf') && isempty(handles.irf)==0
    irf = handles.irf;
    time_irf = handles.time_irf;
else
    errordlg('Load IRF first');
    return
end

load('analysisDir.mat');
pathname = uigetdir(lastUsedDir,'Choose a folder to save results');
drawnow; pause(0.05);
if pathname ==0
    return;
end


fitstart = str2double(get(handles.FitStart_edit,'String'));
fitend = str2double(get(handles.FitEnd_edit,'String'));
noisefrom = str2double(get(handles.NoiseFrom_edit,'String'));
noiseto = str2double(get(handles.NoiseFrom_edit,'String'));

binning = str2double(get(handles.BinningFactor_edit,'String'));
fitmethod = get(handles.FittingMethod_popupmenu,'Value');
nexpo = get(handles.NumOfExpo_popupmenu,'Value');
thres = str2double(get(handles.Threshold_edit,'String'));
downsize = str2double(get(handles.DownsizeFactor_edit,'String'));
prior = 1;


fitsetting = get(handles.FitSetting_table,'Data');
fitsetting(:,3:5) = fitsetting(:,2:4);
fitsetting(:,2) = zeros(5,1); %dummy column

dt = image_struct{selected(1)}.dt;
fitstart = round(fitstart/dt);
fitend = round(fitend/dt);
noisefrom = round(noisefrom/dt);
noiseto = round(noiseto/dt);
time = (1:length(image_struct{selected(1)}.decay))'*dt;

% A = cell(length(selected),1);
% tau1 = cell(length(selected),1);
% f = cell(length(selected),1);
% tau2 = cell(length(selected),1);
% Chisq = cell(length(selected),1);
% counts = cell(length(selected),1);

FLIMImageFitResult = cell(length(selected),1);

%matlabpool;
disp('making FLIM image...');
tstart = tic;
for i = 1:length(selected)    
    flimimage = image_struct{selected(i)}.flim;
    [A,tau1,f,tau2,Chisq,counts] = flimImageFit(image_struct{selected(i)}.flim,...
        time,irf,time_irf,binning,downsize,thres,fitsetting,fitmethod,nexpo,fitstart,...
        fitend,noisefrom,noiseto,prior);
    FLIMImageFitResult{i} = image_struct{selected(i)};
    FLIMImageFitResult{i} = rmfield(FLIMImageFitResult{i},...
        {'image_handle','selected_pixel','selected_pixel_handle',...
        'flim','decay','decay_handle','active_region','active_region_handle'});
    FLIMImageFitResult{i}.A = A;
    FLIMImageFitResult{i}.tau1 = tau1;
    FLIMImageFitResult{i}.f = f;
    FLIMImageFitResult{i}.tau2 = tau2;
    FLIMImageFitResult{i}.Chisq = Chisq;
    FLIMImageFitResult{i}.counts = counts;
    FLIMImageFitResult{i}.fitsetting = fitsetting;
    FLIMImageFitResult{i}.nexpo = nexpo;
    FLIMImageFitResult{i}.fitstart = fitstart;
    FLIMImageFitResult{i}.fitend = fitend;
    FLIMImageFitResult{i}.binning = binning;
    FLIMImageFitResult{i}.fitmethod = fitmethod;
    FLIMImageFitResult{i}.thres = thres;
    FLIMImageFitResult{i}.prior = prior;
    FLIMImageFitResult{i}.time = time;
    FLIMImageFitResult{i}.irf = irf;
    FLIMImageFitResult{i}.time_irf = time_irf;
    FLIMImageFitResult{i}.downsize = downsize;

    for j = 2:size(fitsetting,1)
        if fitsetting(j,3)==0
            h = figure;
            switch j
                case 2
                    varstring = 'A';
                    imagesc(FLIMImageFitResult{i}.A(:,:,1));
                case 3
                    varstring = 'tau1';
                    imagesc(FLIMImageFitResult{i}.tau1(:,:,1));
                case 4
                    varstring = 'f';
                    imagesc(FLIMImageFitResult{i}.f(:,:,1));
                case 5
                    varstring = 'tau2';
                    imagesc(FLIMImageFitResult{i}.tau2(:,:,1));
            end
            colormap gray; axis image; colorbar;
            
            saveas(h,[pathname,'/Result',num2str(i,'%03d'),'_',varstring,'.fig']);
            close(h);
        end
    end
    
    h = figure
    imagesc(FLIMImageFitResult{i}.counts(:,:,1));
    colormap gray; axis image; colorbar;
    saveas(h,[pathname,'/Result',num2str(i,'%03d'),'_counts.fig']);
    close(h);
    
    h = figure
    imagesc(FLIMImageFitResult{i}.Chisq(:,:,1));
    colormap gray; axis image; colorbar;
    saveas(h,[pathname,'/Result',num2str(i,'%03d'),'_Chisq.fig']);
    close(h);
end
toc(tstart)
%matlabpool close

save([pathname,'/FLIMImageFitResult.mat'],'FLIMImageFitResult','fitsetting',...
    'irf','time_irf','fitstart','fitend','time','binning','fitmethod','thres','prior','-v7.3');


function BinningFactor_edit_Callback(hObject, eventdata, handles)
% hObject    handle to BinningFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BinningFactor_edit as text
%        str2double(get(hObject,'String')) returns contents of BinningFactor_edit as a double
value = str2double(get(hObject,'String'));
set(hObject,'String',num2str(round(value)));

% --- Executes during object creation, after setting all properties.
function BinningFactor_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BinningFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of Threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function Threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FitStart_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FitStart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FitStart_edit as text
%        str2double(get(hObject,'String')) returns contents of FitStart_edit as a double


% --- Executes during object creation, after setting all properties.
function FitStart_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FitStart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FitEnd_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FitEnd_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FitEnd_edit as text
%        str2double(get(hObject,'String')) returns contents of FitEnd_edit as a double


% --- Executes during object creation, after setting all properties.
function FitEnd_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FitEnd_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseFrom_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseFrom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseFrom_edit as text
%        str2double(get(hObject,'String')) returns contents of NoiseFrom_edit as a double


% --- Executes during object creation, after setting all properties.
function NoiseFrom_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseFrom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseTo_edit_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseTo_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseTo_edit as text
%        str2double(get(hObject,'String')) returns contents of NoiseTo_edit as a double


% --- Executes during object creation, after setting all properties.
function NoiseTo_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseTo_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AutoSet_pushbutton.
function AutoSet_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to AutoSet_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;

currentdecay = sum(sum(image_struct{selected(1)}.flim,3),2);
currenttime = image_struct{selected(1)}.dt*(1:length(currentdecay))';
fit_start_x = currenttime(min(find(currentdecay>0)))+0.1;
fit_end_x = currenttime(max(find(currentdecay>0)))-0.1;
noise_region_from = currenttime(find(currentdecay == max(currentdecay)))-1;
noise_region_to = currenttime(find(currentdecay == max(currentdecay)))-0.5;

fit_start_x = fit_start_x(1);
fit_end_x = fit_end_x(1);
noise_region_from = noise_region_from(1);
noise_region_to = noise_region_to(1);

set(handles.FitStart_edit,'String',num2str(fit_start_x));
set(handles.FitEnd_edit,'String',num2str(fit_end_x));
set(handles.NoiseFrom_edit,'String',num2str(noise_region_from));
set(handles.NoiseTo_edit,'String',num2str(noise_region_to));

% --- Executes during object creation, after setting all properties.
function FitSetting_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FitSetting_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes on button press in ShowM1_togglebutton.
function ShowM1_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to ShowM1_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowM1_togglebutton
showM1 = get(handles.ShowM1_togglebutton,'Value');
showM2 = get(handles.ShowM2_togglebutton,'Value');


if showM1 && showM2
elseif showM1==0 && showM2==0
    set(hObject,'Value',1);
else
    
end

% --- Executes on button press in ShowM2_togglebutton.
function ShowM2_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to ShowM2_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowM2_togglebutton
showM1 = get(handles.ShowM1_togglebutton,'Value');
showM2 = get(handles.ShowM2_togglebutton,'Value');

if showM1 && showM2
elseif showM1 || showM2
    set(hObject,'Value',1);
else
    
end


% --- Executes on button press in Segmentation_pushbutton.
function Segmentation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct;
Nselected = length(selected);
flimblock = image_struct{selected(1)}.flimblock;

% 
% prompt = {'Min Area','Max Area','Level Factor'};
% dlg_title = 'Segmentation Parameter';
% defAns = {'100','50000','0.4'};
% answer = inputdlg(prompt,dlg_title,defAns);
% 
% area_cuts = [str2double(answer{1}),str2double(answer{2})];
% level_fact = str2double(answer{3});


addpath Segmentation\

imagestack = cell(Nselected,1);

for i = 1:Nselected
    imagestack{i} = image_struct{selected(i)}.image(:,:,flimblock);
end

check = CheckOpenState('SegmentationGUI');
if check == 1
    close('SegmentationGUI')
end

SegmentationGUI(handles.MainGui,handles,imagestack,selected);







% --- Executes on button press in SaveSession_pushbutton.
function SaveSession_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSession_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct(selected);

[fname,pthname] = uiputfile3('*.mat','mode','analysis');
drawnow; pause(0.05);

if pthname == 0
    return;
end

save([pthname,fname],'image_struct','-v7.3')



% --- Executes on button press in SortMultiD_pushbutton.
function SortMultiD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SortMultiD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected = get(handles.FileName_listbox,'Value');
image_struct = handles.image_struct(selected);

image_struct = cell2mat(image_struct);

pathname = unique({image_struct.pathname});
Nselected = length(selected);

if length(pathname)>1
    errordlg('At least one of the decay constructed from the data set in different folder.')
end

addpath MultiDAcq

sortinfo = MultiD_sdt_sort_TY(pathname{1});
if istable(sortinfo)==0 & sortinfo == -1 %uManager folder doesn't exist in the path
    prompt = {'The number of positions','The number of z sections','Repeat time (sec)'};
    answer = inputdlg(prompt,'No uManager folder',1,{'1','4','120'});
    
    if isempty(answer)
        return;
    end
    
    Npos = round(str2double(answer{1}));
    Nz = round(str2double(answer{2}));
    repeat = str2double(answer{3});
    sdt = [decay_struct.setting];
    
    if Npos > 1
        errordlg('Not available yet')
        return;
    end
    sortinfo = sortbyNz(sdt,Nz,repeat,Npos);
    
    % to be added
end

newname = cell(Nselected,1);

fnames = {image_struct.filename};
fnames = fnames(:);
sdtnums = cellfun(@str2double,regexp(fnames,'_c(\d)*','tokens','once'));

for i = 1:Nselected
    ind = find(sortinfo.sdtID==sdtnums(i));
    
    if isempty(ind)
        newname{i} = 'unsorted';
    else
        newname(i) = strcat(num2str(sortinfo.sdtID(ind),'c%03d_'),...
            num2str(sortinfo.PosID(ind),'Pos%01d_'),...
            num2str(sortinfo.timepoint(ind),'t%02d_'),sortinfo.z(ind));
    end
    
end

[~,sortind] = sort(cellfun(@(s) s(6:end),newname,'uni',false));
newname = newname(sortind);
image_struct = image_struct(sortind);

names = get(handles.FileName_listbox,'String');
names(selected) = newname;
set(handles.FileName_listbox,'String',names);
set(handles.Filename_popupmenu,'String',names);

handles.image_struct(selected) = num2cell(image_struct);

guidata(hObject,handles);




% --- Executes on button press in SaveToBase_pushbutton.
function SaveToBase_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveToBase_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

name = fieldnames(handles);

[s,ok]=listdlg('PromptString','Choose variables to save to base workspace:',...
    'Name','Variable Selection','SelectionMode','multiple','ListString',name);

if (ok == 0) || isempty(s)
    return
end

for i = s
    assignin('base',name{i},eval(['handles.' name{i}]))
end



% --- Executes on button press in SelectImages_pushbutton.
function SelectImages_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectImages_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Image name containing..:'};
dlg_title = 'Select Images...';
num_lines = 1;
def = {''};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)
    return;
end

str = answer{1};
fnames = get(handles.FileName_listbox,'String');
selected = get(handles.FileName_listbox,'Value');

idx = cell(length(selected),1);

for i = 1:length(selected)
   idx{i} = strfind(fnames{selected(i)},str); 
end

set(handles.FileName_listbox,'Value',selected(~cellfun(@isempty,idx)))







function DownsizeFactor_edit_Callback(hObject, eventdata, handles)
% hObject    handle to DownsizeFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DownsizeFactor_edit as text
%        str2double(get(hObject,'String')) returns contents of DownsizeFactor_edit as a double


% --- Executes during object creation, after setting all properties.
function DownsizeFactor_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DownsizeFactor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
