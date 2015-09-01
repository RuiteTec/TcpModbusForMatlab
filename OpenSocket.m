function s = OpenSocket(ip,port)
try
    s.Socket = tcpip(ip,port);
    set(s.Socket ,'InputBufferSize',1024);
    fopen(s.Socket );
    s.IsOpened = strcmp(s.Socket.Status,'open');
catch err
    disp(err);
    s.IsOpened = false;
end
end

