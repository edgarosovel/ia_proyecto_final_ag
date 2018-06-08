function varargout = GUIAlgoritmoGen(varargin)
% GUIALGORITMOGEN MATLAB code for GUIAlgoritmoGen.fig
%      GUIALGORITMOGEN, by itself, creates a new GUIALGORITMOGEN or raises the existing
%      singleton*.
%
%      H = GUIALGORITMOGEN returns the handle to a new GUIALGORITMOGEN or the handle to
%      the existing singleton*.
%
%      GUIALGORITMOGEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIALGORITMOGEN.M with the given input arguments.
%
%      GUIALGORITMOGEN('Property','Value',...) creates a new GUIALGORITMOGEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIAlgoritmoGen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIAlgoritmoGen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIAlgoritmoGen

% Last Modified by GUIDE v2.5 06-Jun-2018 17:37:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIAlgoritmoGen_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIAlgoritmoGen_OutputFcn, ...
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


% --- Executes just before GUIAlgoritmoGen is made visible.
function GUIAlgoritmoGen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIAlgoritmoGen (see VARARGIN)

% Choose default command line output for GUIAlgoritmoGen
handles.output = hObject;

handles.datos.numGeneraciones=200;
handles.datos.numElementosGeneracion=500;
handles.datos.umbral1=0.5;
handles.datos.umbralCruzamiento=0.3;
handles.datos.umbralMutacion=0.8;
handles.datos.numElementosElitismo=1;

set(handles.edtNumGeneraciones,'String',handles.datos.numGeneraciones);
set(handles.edtNumElementosGeneracion,'String',handles.datos.numElementosGeneracion);
set(handles.edtNumElementosElitismo,'String',handles.datos.numElementosElitismo);

set(handles.edtUmbral1,'String',handles.datos.umbral1);
set(handles.edtUmbralCruzamiento,'String',handles.datos.umbralCruzamiento);
set(handles.edtUmbralMutacion,'String',handles.datos.umbralMutacion);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIAlgoritmoGen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIAlgoritmoGen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edtNumGeneraciones_Callback(hObject, eventdata, handles)
% hObject    handle to edtNumGeneraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtNumGeneraciones as text
%        str2double(get(hObject,'String')) returns contents of edtNumGeneraciones as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor)|| valor<1)
    valor=1;
else
    valor=abs(round(valor));
end;
handles.datos.numGeneraciones=valor;
set(handles.edtNumGeneraciones,'String',handles.datos.numGeneraciones);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edtNumGeneraciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtNumGeneraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resetResultados(handles)
set(handles.txtResultadoX,'String','X:');
set(handles.txtResultadoY,'String','Y:');
set(handles.txtResultadoFuncion,'String','Función (x,y):');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.datos.numGeneraciones;
%handles.datos.numElementosGeneracion
%handles.datos.umbral1;
%handles.datos.umbralCruzamiento;
%handles.datos.umbralMutacion;

clc;

fitnessFunction = @fitness;
populationSize = handles.datos.numElementosGeneracion;
elitism = handles.datos.numElementosElitismo;
generations = handles.datos.numGeneraciones;
umbralGeneration = handles.datos.umbral1;
umbralCruzamiento = handles.datos.umbralCruzamiento;
umbralMutation = handles.datos.umbralMutacion;
left = -360;
right = 360;

[x, y, fval] = ga(fitnessFunction,populationSize,elitism,generations,umbralGeneration,umbralCruzamiento,umbralMutation,left,right);

set(handles.txtResultadoX,'String',sprintf('X: %d',x));
set(handles.txtResultadoY,'String',sprintf('Y: %d',y));
set(handles.txtResultadoFuncion,'String',sprintf('Función (x,y): %f', fval));

[X, Y] = meshgrid(left:4:right, left:4:right);
Z = fitnessFunction(X,Y);
figure;
mesh(X,Y,Z);
hold on;
scatter3(x,y,fval,'filled','v','k');
hold off;



function edtNumElementosGeneracion_Callback(hObject, eventdata, handles)
% hObject    handle to edtNumElementosGeneracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtNumElementosGeneracion as text
%        str2double(get(hObject,'String')) returns contents of edtNumElementosGeneracion as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor) || valor<1)
    valor=10;
else
    valor=abs(round(valor));
end;
handles.datos.numElementosGeneracion=valor;
set(handles.edtNumElementosGeneracion,'String',handles.datos.numElementosGeneracion);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edtNumElementosGeneracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtNumElementosGeneracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtNumElementosElitismo_Callback(hObject, eventdata, handles)
% hObject    handle to edtNumElementosElitismo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtNumElementosElitismo as text
%        str2double(get(hObject,'String')) returns contents of edtNumElementosElitismo as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor))
    valor=1;
else
    valor=abs(round(valor));
end;
if valor > handles.datos.numElementosGeneracion
    valor =  handles.datos.numElementosGeneracion;
end
handles.datos.numElementosElitismo=valor;
set(handles.edtNumElementosElitismo,'String',handles.datos.numElementosElitismo);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edtNumElementosElitismo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtNumElementosElitismo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtUmbral1_Callback(hObject, eventdata, handles)
% hObject    handle to edtUmbral1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtUmbral1 as text
%        str2double(get(hObject,'String')) returns contents of edtUmbral1 as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor))
    valor=0.5;
elseif valor<0
    valor=0;
elseif valor>1
    valor=1;
else
    valor=abs(valor);
end;
handles.datos.umbral1=valor;
set(handles.edtUmbral1,'String',handles.datos.umbral1);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edtUmbral1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtUmbral1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtUmbralCruzamiento_Callback(hObject, eventdata, handles)
% hObject    handle to edtUmbralCruzamiento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtUmbralCruzamiento as text
%        str2double(get(hObject,'String')) returns contents of edtUmbralCruzamiento as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor))
    valor=0.5;
elseif valor<0
    valor=0;
elseif valor>1
    valor=1;
else
    valor=abs(valor);
end;
handles.datos.umbralCruzamiento=valor;
set(handles.edtUmbralCruzamiento,'String',handles.datos.umbralCruzamiento);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edtUmbralCruzamiento_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtUmbralCruzamiento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtUmbralMutacion_Callback(hObject, eventdata, handles)
% hObject    handle to edtUmbralMutacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtUmbralMutacion as text
%        str2double(get(hObject,'String')) returns contents of edtUmbralMutacion as a double
resetResultados(handles);
valor=str2double(get(hObject,'String'));
if (isnan(valor))
    valor=0.5;
elseif valor<0
    valor=0;
elseif valor>1
    valor=1;
else
    valor=abs(valor);
end;
handles.datos.umbralMutacion=valor;
set(handles.edtUmbralMutacion,'String',handles.datos.umbralMutacion);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edtUmbralMutacion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtUmbralMutacion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
