%%
function tcpip_read(srvr, event)
    msg = fread(srvr, srvr.BytesAvailable);
    msg = native2unicode(msg, 'UTF-8');
    msg = msg';
    msg = deblank(msg);
    msg = JSON.parse(msg);
    %disp(msg)
    
    siHandle = evalin('base', 'hSI');
    siHandle.hScan2D.logFilePath = msg.path;
    siHandle.hScan2D.logFileStem = msg.name;
    siHandle.hScan2D.logFileCounter = msg.count;
    
    fwrite(srvr, '_ok');
    tcpip_reconnect;
end
