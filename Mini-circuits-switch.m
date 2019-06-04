%Initialize switch
SWITCH_USB = NET.addAssembly('C:\Windows\SysWOW64\MCL_ZTVX_64.dll');
MY_SWITCH = MCL_ZTVX_64.USB_Control;

if MY_SWITCH.Connect()==0;
    error("Switch is not turned on")
end

%dummy variable for the switch
retSTR = '';

%Example of switch command
[status, retSTR] = MY_SWITCH.Send_SCPI(':PATH:A1:N2',retSTR);

%How to iterate through every single switch combination of two ports, assuming reflections aren't wanted
for i=1:7 %For an 8-port switch, to go through every single combination
	port1command = strcat(':PATH:A1:N',num2str(i));
	[status, retSTR] = MY_SWITCH.Send_SCPI(port1command,retSTR);
	for j=(i+1):8 
		port2command = strcat(':PATH:A2:N',num2str(j));
		[status, retSTR] = MY_SWITCH.Send_SCPI(port2command,retSTR);
	end
 end
