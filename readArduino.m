s = serial('/dev/cu.wchusbserial1420');

s.InputBufferSize = 1;
try
    fopen(s);
catch err
    fclose(instrfind);
    error('Make sure you select the correct COM Port where the Arduino is connected.');
end


value=0

%data=fscanf(s,'%f');
data = fread(s)
if(s==13)
    %ho finito una linea
    value=0;
    
else
    value=value*10 +(data-48)
    
end


    