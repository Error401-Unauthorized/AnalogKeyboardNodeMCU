--[[ 
    ASD1233456 8/18/2016

    A description and code that helps the process of finding a voltage table
    to be used to display the key that is pressed

    This code can be resued for diffrent sized analog keypads.
]]

tmr.alarm(1,100,tmr.ALARM_AUTO, --loops through to see the keypad's status
    function() 
        print(adc.read(0)) --displays the adc value read by the node MCU
    end
) 

--Press each button on the keypad and record the average measurement read by the MCU. 
--If 2 or more keys have the same measurement of 1024, reduce the voltage and try again.
--If your keypad is not 3x4 then adjust the size of the voltage table accordingly.
--If your voltage read is consistently beneath 10 when a button is clicked, double check your wiring. 

voltage = { --0,1,2,3,       | NOTE: 
            --4,5,6,         |    0 is the first adc value on the list, but 
            --7,8,9,         |    it is NOT the 1st Button on the 3x4 keypad.
            --10,11,         |    This was to keep the indexes in sync with
            --...,           |    their real values.  
          } --               
