%%
function tcpip_reconnect(obj, cbdata, timeout)
    global tcpip_reconnecting;
    if tcpip_reconnecting==true
        return
    end
    tcpip_reconnecting = true;
    if nargin==2
        timeout = 1e10;
    end
    server = tcpip('0.0.0.0', 6666, 'NetworkRole', 'server');
    server.bytesAvailableFcn = @tcpip_read;
    set(server,'Timeout',timeout)
    %disp('Waiting for TCPIP connection...')
    fopen(server);
    %disp('TCPIP established')
    tcpip_reconnecting = false;
end
