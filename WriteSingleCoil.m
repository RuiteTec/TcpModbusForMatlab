function status = WriteSingleCoil(session,reg_addr,coil_status)
global transId;

status = false;

if coil_status == true
    reg_value = hex2dec('ff00');
elseif coil_status == false
    reg_value = 0;
end

protocolId = uint16(0);
dataLeng = uint16(6);
uintId = uint8(1);
%¹¦ÄÜÂëĞ´µ¥¼Ä´æÆ÷
funcCode = uint8(5);

reg_addr_from1 =  reg_addr - 1;
reg_addr_hi = high_uint16(reg_addr_from1);
reg_addr_low = low_uint16(reg_addr_from1);

reg_value_hi = high_uint16(reg_value);
reg_value_low = low_uint16(reg_value);

if transId < 65535
    transId = uint16(transId + 1);
else
    transId = uint16(0);
end

MBAP_Header=[high_uint16(transId),low_uint16(transId),...
             high_uint16(protocolId),low_uint16(protocolId),...
             high_uint16(dataLeng),low_uint16(dataLeng),...
             uintId, funcCode];
Data_Body = [reg_addr_hi,reg_addr_low,reg_value_hi,reg_value_low];

PDU = [MBAP_Header,Data_Body];
if session.IsOpened
    fwrite(session.Socket,PDU);
   
    pause(0.3);
    bytes = fread(session.Socket,session.Socket.BytesAvailable,'uint8');
    
    %Check transId and funcCode is OK.
    if length(bytes) == 12
        if transId ~= (bytes(1) * 256 + bytes(2))
            disp('TransactionId is Err!')
        end
        if funcCode ~= bytes(8)
           disp('TransactionId is Err!');
        elseif funcCode == (bytes(8)+128);
           disp('Device is Except!');
        else
            status = (0 ~= (bytes(11)*256 + bytes(12)));
        end
    else
        disp('Recive is Incorrect!');
    end
else
    disp('Socket is Err or Except!');
end


end

function hi = high_uint16(num)
hi = uint8(bitand(bitshift(num,-8),255));
end

function low = low_uint16(num)
low = uint8(bitand(num,255));


end



