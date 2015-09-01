%
Session = OpenSocket('129.0.0.10',502);
if Session.IsOpened
    ReadMultiReg(Session,7000,10)
    %ReadMultiReg(Session,127,126)
    %WriteMultiReg(Session,1,10:2:126)
    %ReadSingleReg(Session,12)
    %WriteSingleCoil(Session,1,false);
end
CloseSocket(Session);
clear Session;
