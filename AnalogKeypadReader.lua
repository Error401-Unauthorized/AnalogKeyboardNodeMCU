--[[
    Error 401 8/18/2016
    a script designed for displaying keypad entrys on a NodeMCU from a RobotDyn 3x4 
    Analog Output Keyboard. 

    This code can be adjusted for diffrent sized analoge keyboards
]]

--This voltage table represents the adc values recieved by the NodeMCU when the VCC was 3V3.
--If this table does not work please see findVoltageTable.lua to create your own.

voltage = {    543, 1024, 993, 911, --0,1,2,3,  | NOTE: 
                837, 778, 726, 	    --4,5,6,    |    0 is the first adc value on the list, but 
		680, 638, 603, 	    --7,8,9,    |    it is NOT the 1st Button on the 3x4 keypad.
                571, 517  	    --10, 11,   |    This was to keep the indexes in sync with 
          }             --                      |    their real values.

function getKeyPressed(adcV)
    if (adcV < 350) then 
        wasReleased = true 
        return --no need to loop, no button is pressed
    end

    for i,v in ipairs(voltage) do --looping through voltage table to find the number pressed
        if (v - 5 < adcV and v + 5 > adcV) and wasReleased then --allows for some tollerence from the tabled values
            print(i-1) --key that was pressed
            wasReleased = false
        end
        --press is ignored if it does not find it's respective value
    end
end


if adc.force_init_mode(adc.INIT_ADC)
	then
	  node.restart() --restart is needed if analog pin is not set to read.
	  return -- don't bother continuing, the restart is scheduled
end

wasReleased = true --debouncing

tmr.alarm(1,100,tmr.ALARM_AUTO, --loops through to see the keypad's status
    function() 
        getKeyPressed(adc.read(0)) 
    end
) 
