function reg_value = ReadSingleReg(session,reg_addr)
reg_values = ReadMultiReg(session,reg_addr,1);
reg_value = reg_values(1);
end

