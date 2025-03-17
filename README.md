# TTR-500-2x8-Switch-Automation
Matlab commands to automate a low-noise commercial switch on 64-bit computer
![switch](https://github.com/alailink/MiniCircuits-2x8-Switch-Automation/blob/master/switch.jpg)  

## Matlab
The first step is to make sure that you have the "Instrument Control" toolbox. Like all matlab toolboxes, its pricey, so hopefully you already have it or your school/company can get it for you. A student license would also be pretty doable.  

Once that's installed, download the .NET dll from the mini circuits website. As of today it's https://www.minicircuits.com/softwaredownload/ztvx.html. For your 64-bit computer, place MCL_ZTVX_64.dll in /windows/sysWOW64.  

Next you can start setting it up in matlab. First initialize it:  
```matlab
SWITCH_USB = NET.addAssembly('C:\Windows\SysWOW64\MCL_ZTVX_64.dll');
MY_SWITCH = MCL_ZTVX_64.USB_Control;

if MY_SWITCH.Connect()==0;
    error("Switch is not turned on")
end
```
The if statement isn't necessary, it's just nice to check if the switch was turned on or not.  
Now you can try to do a simple switching command. The lights on the device indicate its current position.  
```matlab
retSTR = '';  %dummy variable for the switch
[status, retSTR] = MY_SWITCH.Send_SCPI(':PATH:A1:N2',retSTR);
[status, retSTR] = MY_SWITCH.Send_SCPI(':PATH:A2:N3',retSTR);
```  
As a final function, here is a useful loop in case you would like to iterate through every single possible switch combination. This assumes that you are using symmetry. For example, if you have A1=N2 and A2=N5, you don't need A1=N5 and A2=N2. There are 28 possible combinations.
```matlab
for i=1:7 %For an 8-port switch, to go through every single combination
	port1command = strcat(':PATH:A1:N',num2str(i));
	[status, retSTR] = MY_SWITCH.Send_SCPI(port1command,retSTR);
	for j=(i+1):8 
		port2command = strcat(':PATH:A2:N',num2str(j));
		[status, retSTR] = MY_SWITCH.Send_SCPI(port2command,retSTR);
	end
 end
```  

