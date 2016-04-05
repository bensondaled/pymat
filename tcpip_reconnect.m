%%
function tcpip_reconnect(obj, cbdata, timeout)
    if nargin==2
        timeout = 1e10;
    end
    server = tcpip('0.0.0.0', 6666, 'NetworkRole', 'server');
    server.bytesAvailableFcn = @tcpip_read;
    set(server,'Timeout',timeout)
    %disp('Waiting for TCPIP connection...')
    fopen(server);
    %disp('TCPIP established')
end
