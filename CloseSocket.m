function CloseSocket(session)
%CLOSESOCKET �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

