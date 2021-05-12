function varargout = Project(varargin)
% PROJECT MATLAB code for Project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project

% Last Modified by GUIDE v2.5 12-May-2021 15:03:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_OutputFcn, ...
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


% --- Executes just before Project is made visible.
function Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Project (see VARARGIN)

% Choose default command line output for Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Browse function
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath,fExt] =uigetfile({'*.jpg;*.jpeg;*.png;*.tif;*.tiff;*.bmp;*.oct;*.jfif','All Files'},'Select File to Open');
    
    % in case that we not allowed to limit user options the next line have all file types 'all files' option
    %and i handeled it if any other type it will give the user an error 
    %[filename,filepath,fExt] =uigetfile({'.jpg';'.png';'.tif';'.bmp';'.oct';'.jfif'},'Select File 
    
    if isequal(filename,0)
          axes(handles.axes1);
          cla reset
          set(handles.axes1,'visible','off')
        errordlg('No image Selected please select image','Browse Error!');
         % Disable all buttons until image selection
         set(handles.histbutton,'Enable','off');
         set(handles.histeqButton,'Enable','off');
         set(handles.filterButton,'Enable','off');
         set(handles.fourierbutton,'Enable','off');
         set(handles.SP,'Enable','off');
         set(handles.median_button,'Enable','off');
         set(handles.periodiButton,'Enable','off');
         set(handles.Preiodic_filter,'Enable','off');
         
    else
        try  
           fullname = [filepath,filename];
           image = imread(fullname);
           handles.image = image;
           guidata(hObject,handles)
           axes(handles.axes1);
           cla reset
           imshow(image);
           % Enable all buttons 
             set(handles.histbutton,'Enable','on');
             set(handles.histeqButton,'Enable','on');
             set(handles.filterButton,'Enable','on');
             set(handles.fourierbutton,'Enable','on');
             set(handles.SP,'Enable','on');
             set(handles.median_button,'Enable','on');
             set(handles.periodiButton,'Enable','on');
             set(handles.Preiodic_filter,'Enable','on');
        catch
            axes(handles.axes1);
            cla reset  
            set(handles.axes1,'visible','off')
            errordlg(['There was a problem loading ',filename],'Load Error!');
            
           % Disable all buttons 
             set(handles.histbutton,'Enable','off');
             set(handles.histeqButton,'Enable','off');
             set(handles.filterButton,'Enable','off');
             set(handles.fourierbutton,'Enable','off');
             set(handles.SP,'Enable','off');
             set(handles.median_button,'Enable','off');
             set(handles.periodiButton,'Enable','off');
             set(handles.Preiodic_filter,'Enable','off');
           return;
        end
       
    end
 

% Hisogram Function
% --- Executes on button press in histbutton.
function histbutton_Callback(hObject, eventdata, handles)
% hObject    handle to histbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
image=rgb2gray(image);
axes(handles.axes2);
cla reset
imhist(image);

% Hisogram equalization Function
% --- Executes on button press in histeqButton.
function histeqButton_Callback(hObject, eventdata, handles)
% hObject    handle to histeqButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
image=rgb2gray(image);
axes(handles.axes3);
cla reset
eqimage = histeq(image);
imshow(eqimage);
axes(handles.axes4);
cla reset
imhist(eqimage);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)



% --- Executes on selection change in FilterChoice.
function FilterChoice_Callback(hObject, eventdata, handles)

contents=cellstr(get(hObject,'String'));
FilterChoice=contents(get(hObject,'Value'));
handles.FilterChoice = FilterChoice;
guidata(hObject,handles)
% change the input text to know which value shoud user enter
if(strcmp(FilterChoice,'Sobel'))
    set(handles.inputValue,'String','Enter threshold')
elseif(strcmp(FilterChoice,'Laplace'))
    set(handles.inputValue,'String','Enter Alpha')
end



function FilterChoice_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function inputValue_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function inputValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Sobel and laplacian filters
% --- Executes on button press in filterButton.
function filterButton_Callback(hObject, eventdata, handles)
% hObject    handle to filterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
image=rgb2gray(image);
%get drop down menue value
contents=cellstr(get(handles.FilterChoice,'String'));
FilterChoice=contents(get(handles.FilterChoice,'Value'));
handles.FilterChoice = FilterChoice;
FilterChoice = handles.FilterChoice ;
%check which filter user choose 
if(strcmpi(FilterChoice,'Choose Filter'))
    f = errordlg('Please choose filter');
elseif(strcmpi(FilterChoice,'Sobel'))  
    th_value = get(handles.inputValue,'string');
    th_value = str2num(th_value);
    %apply default value of edge function if the user dose not enter
    %threshold value
    if(isempty(th_value))
        sobel_img = edge(image,'Sobel','vertical');
        axes(handles.axes5);
        cla reset
        imshow(sobel_img);
        sobel_img = edge(image,'Sobel','horizontal');
        axes(handles.axes6);
        cla reset
        imshow(sobel_img);
        msgbox('  Note: Default value applied  ');
    elseif(th_value > 1 || th_value < 0 )
        f = errordlg('Enter value from 0 to 1','out of range');
    elseif(th_value < 1 || th_value > 0 )
        sobel_img = edge(image,'Sobel',th_value,'vertical');
        axes(handles.axes5);
        cla reset
        imshow(sobel_img);
        sobel_img = edge(image,'Sobel',th_value,'horizontal');
        axes(handles.axes6);
        cla reset
        imshow(sobel_img);
    end
elseif(strcmpi(FilterChoice,'Laplace'))
    %reset axes
    axes(handles.axes5);
    cla reset
    axes(handles.axes6);
    cla reset
    set(handles.axes6,'visible', 'off');
    alpha_value = get(handles.inputValue,'string');
    alpha_value  = str2num(alpha_value );    
    if(isempty(alpha_value ))
        lap = fspecial('laplacian');
        img_lap = filter2(lap,image);
        axes(handles.axes5);
        cla reset
        imshow((img_lap)/100);
        msgbox('Note: Default value applied');
    elseif(alpha_value  > 1 || alpha_value  < 0 )
        f = errordlg('Enter value from 0 to 1','out of range');
    elseif(alpha_value  < 1 || alpha_value  > 0 )
        lap = fspecial('laplacian',alpha_value );
        img_lap = filter2(lap,image);
        axes(handles.axes5);
        cla reset
        imshow((img_lap)/100);
      %  msgbox('      Note: Default value applied         ');
    end
    
end

% fourier function
% --- Executes on button press in fourierbutton.
function fourierbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fourierbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
grayimage=rgb2gray(image);
fourier = fftshift(fft2(image));
fl = log(1+abs(fourier));
fm = max(fl(:));
axes(handles.axes7);
cla reset
imshow(im2uint8(fl/fm))
axes(handles.axes18);
cla reset
imshow(grayimage)

function spp_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function spp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Salt and pepper noise function 

function SP_Callback(hObject, eventdata, handles)
% hObject    handle to SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
image=rgb2gray(image);
Sp_percentage = get(handles.spp,'string');
Sp_percentage = str2num(Sp_percentage);
Sp_percentage=Sp_percentage/100;
% apply default value if the user does not enter percentage 
 if(isempty(Sp_percentage))
   sp_img = imnoise(image,'salt & pepper'); % default noise density d = 0.05, 5% 
   handles.sp_img = sp_img;
   guidata(hObject,handles)
   axes(handles.axes9);
   cla reset
   imshow(sp_img)
   msgbox('     Note: Default value applied       ');
 elseif(Sp_percentage > 1 || Sp_percentage < 0 )
   f = errordlg('Enter value from 0 to 100','out of range');
 elseif(Sp_percentage < 1 || Sp_percentage > 0 )
   sp_img = imnoise(image,'salt & pepper', Sp_percentage );
   handles.sp_img = sp_img;
   guidata(hObject,handles)
   axes(handles.axes9);
   cla reset
   imshow(sp_img)
 end


% median filter function
function median_button_Callback(hObject, eventdata, handles)
% hObject    handle to median_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try 
    sp_img = handles.sp_img;
    median_size= get(handles.median_size,'string');
    median_size = str2num(median_size);

    if(isempty(median_size))
        median_img = medfilt2(sp_img);
        axes(handles.axes11);
        cla reset
        imshow(median_img)
        msgbox('     Note: Default value applied      ');
    elseif(median_size < 3 || median_size > 50 )
        f = errordlg('Enter value from 3 to 50','out of range');
    elseif(median_size >= 3 || median_size < 50 )
        median_img = medfilt2(sp_img , [median_size,median_size]);
        axes(handles.axes11);
        cla reset
        imshow(median_img)
    end
catch 
      errordlg('    Apply Salt&pepper Noise','Error!'   );
      return;
end
    

function median_size_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function median_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to median_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nx_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Nx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ny_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Ny_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sin.
function sin_Callback(hObject, eventdata, handles)


% --- Executes on button press in cos.
function cos_Callback(hObject, eventdata, handles)


% priodic noise function 
function periodiButton_Callback(hObject, eventdata, handles)
% hObject    handle to periodiButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image=handles.image;
image=rgb2gray(image);
nx= get(handles.Nx,'string');
nx = str2num(nx);
if(isempty(nx))
  nx=1;
elseif (nx >0)
   nx = nx;
end
ny= get(handles.Ny,'string');
ny = str2num(ny);
if(isempty(ny))
  ny=1;
elseif (ny >0)
    ny = ny;
end

s = size(image);
[x, y]= meshgrid(1:s(2),1:s(1));

%%% x-direction
Wx = max(max(x)); %Length of signal (x) (ncols)
fx = nx/Wx;
%%% y-direction
Wy = max(max(y)); %Length of signal (y) (nrows)
fy = ny/Wy;

cos_button = get(handles.cos,'Value');
sin_button = get(handles.sin,'Value');

if (sin_button == 1 )
    pxy = sin(2*pi*fx*x + 2*pi*fy*y)+1;
    p_img = mat2gray((im2double(image)+pxy));
    handles.p_img=p_img;
    guidata(hObject,handles)
    axes(handles.axes12);
    cla reset
    imshow(p_img)
elseif (cos_button == 1 )
    pxy = cos(2*pi*fx*x + 2*pi*fy*y)+1;
    p_img = mat2gray((im2double(image)+pxy));
    handles.p_img=p_img;
    guidata(hObject,handles)
    axes(handles.axes12);
    cla reset
    imshow(p_img)
   
end
p_img_f=fftshift(fft2( p_img));
handles.p_img_f=p_img_f;
guidata(hObject,handles)
fl = log(1+abs(p_img_f));
fm = max(fl(:));
axes(handles.axes15);
cla reset
imshow(im2uint8(fl/fm))
axes(handles.axes15);
zoom(6);


% --- Executes on selection change in Pfilter.
function Pfilter_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Pfilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% mask , band reject and notch filters function
function Preiodic_filter_Callback(hObject, eventdata, handles)
% hObject    handle to Preiodic_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents=cellstr(get(handles.Pfilter,'String'));
periodic_filter=contents(get(handles.Pfilter,'Value'));
try
    periodic_img=handles.p_img;
    p_img_f=handles.p_img_f;
    fa = abs(p_img_f);
    fm = max(fa(:));
    BR_fimg = (fa/fm);
    [p1, p2] = find(BR_fimg >= 0.2 & BR_fimg < 0.9);
    
    if(strcmpi(periodic_filter,'Notch'))
        notch_p_img_f=p_img_f;
        notch_p_img_f(p1,:)=0;
        notch_p_img_f(:,p2)=0;
        f_clean_img=notch_p_img_f;
        clean_img = ifft2(ifftshift(notch_p_img_f));
        axes(handles.axes16);
        cla reset
        imshow(abs(clean_img))
    elseif(strcmpi(periodic_filter,'Band-Reject'))   
        [s_x,s_y] = size(periodic_img);
        [rx,ry] = meshgrid(-s_y/2 : s_y/2-1 , -s_x/2 : s_x/2-1);
        z = sqrt(rx.^2+ry.^2);
        filter_area = z(p1,p2);  
        BR = (z > filter_area(1)+1 | z < filter_area(2)-1);
        f_clean_img= p_img_f.*BR;
        clean_img = ifft2(ifftshift(f_clean_img));
        axes(handles.axes16);
       cla reset
       imshow(abs(clean_img))
     elseif(strcmpi(periodic_filter,'Mask'))   
      try
          m= msgbox('    Note: you should choose 2 points from fourier of noisy image graph to apply mask filter use zoom in and out from the toolbar      ');
          uiwait(m); 
          m= msgbox(' zoom in before press ok  ');
          uiwait(m);
          magImageNoisy = log(abs(p_img_f));
            mask = ones(size(magImageNoisy));
          m= msgbox(' choose first point ');
          uiwait(m);
            [x1,y1]=ginput(1); 
            x1=round(x1);
            y1=round(y1);
          m= msgbox(' choose second point ');
          uiwait(m);
            [x2,y2]=ginput(1); 
            x2=round(x2);
            y2=round(y2);

            mask(y1,x1) = 0;
            mask(y2,x2) = 0;
            
            filtered = mask.*p_img_f;
            f_clean_img=filtered;
            filteredImage = ifft2(ifftshift(filtered));
            ampFilteredImage = abs(filteredImage);
            minValue = min(min(ampFilteredImage));
            maxValue = max(max(ampFilteredImage));
            axes(handles.axes16);
            cla reset
            imshow(ampFilteredImage, [minValue maxValue])
      catch
          errordlg('Choose point inside the fouier of noisy img graph','Error!');
          return;
      end
    end
    axes(handles.axes20);
    cla reset
    fl = log(1+abs(f_clean_img));
    fm = max(fl(:));
    imshow((im2uint8(fl/fm)));
    axes(handles.axes20);
    zoom(4);    
catch 
    errordlg('Apply periodic Noise First','Error!');
    return;
end
    


% --- Executes during object creation, after setting all properties.
function pGroupBtn_CreateFcn(hObject, eventdata, handles)


%%%%%% tabs button functions

% --- Executes on button press in tab1Button.
function tab1Button_Callback(hObject, eventdata, handles)
% hObject    handle to tab1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.tab1,'visible','on') 
set(handles.tab2,'visible','off')
set(handles.tab3,'visible','off')

% --- Executes on button press in tab2Button.
function tab2Button_Callback(hObject, eventdata, handles)
% hObject    handle to tab2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%background = imread('background.jpg'); 
%axes(handles.axes29);
%cla reset
%imshow(background);
 
set(handles.tab2,'visible','on') 
set(handles.tab1,'visible','off')
set(handles.tab3,'visible','off')

% --- Executes on button press in tab3Button.
function tab3Button_Callback(hObject, eventdata, handles)
% hObject    handle to tab3Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.tab3,'visible','on') 
set(handles.tab1,'visible','off')
set(handles.tab2,'visible','off')
