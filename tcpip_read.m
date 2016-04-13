%%
function tcpip_read(srvr, event)
    msg = fread(srvr, srvr.BytesAvailable);
    msg = native2unicode(msg, 'UTF-8');
    msg = msg';
    msg = deblank(msg);
    msg = JSON.parse(msg);
    %disp(msg)
    
    siHandle = evalin('base', 'hSI');
    
    while siHandle.active==1
        waitfor(msgbox('ScanImage is running an acqusition while TCPIP attempted to communicate. Abort, then click okay.'))
    end
    
    siHandle.hScan2D.logFilePath = msg.path;
    siHandle.hScan2D.logFileStem = msg.name;
    siHandle.hScan2D.logFileCounter = msg.idx;
    
    % defaults
    siHandle.hScan2D.logFramesPerFile = 1000;
    siHandle.hStackManager.framesPerSlice = inf;
    siHandle.acqsPerLoop = 10000;
    siHandle.extTrigEnable = 1;
    
    siHandle.startLoop;
    
    fwrite(srvr, '_ok');
    tcpip_reconnect(0,0);
end
