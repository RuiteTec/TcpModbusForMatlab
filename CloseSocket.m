function CloseSocket(session)
%CLOSESOCKET 此处显示有关此函数的摘要
%   此处显示详细说明
try
    if session.IsOpened
        fclose(session.Socket);
        delete(session.Socket);
        %clear session;
    end
catch err
    disp(err);
end
end

