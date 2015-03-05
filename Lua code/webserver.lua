cfg={}
     cfg.ssid="ESP8266"
     cfg.pwd="12345678"
     wifi.ap.config(cfg)
    outpin=7
    srv=net.createServer(net.TCP) srv:listen(80,function(conn)
    conn:on("receive",function(conn,payload)
    
    function ctrlpower()
    pwm.close(outpin)
    gpio.mode(outpin,gpio.OUTPUT)
    dotaz=string.sub(payload,kdesi[2]+1,#payload)
    if dotaz=="ON"  then gpio.write(outpin,gpio.HIGH)return end
    if dotaz=="OFF" then gpio.write(outpin,gpio.LOW)return end
    if dotaz=="FLC" then pwm.setup(outpin,2,512)pwm.start(outpin)return end
    pwm.setup(outpin,1000,dotaz*10)
    pwm.start(outpin)
    end
    --parse position POST value from header
    kdesi={string.find(payload,"pwmi=")}
    --If POST value exist, set LED power
    if kdesi[2]~=nil then ctrlpower()end
    conn:send('HTTP/1.1 200 OK\n\n')
    
    
    file.open("index.html", "r")
    repeat
      line = file.readline()
      if (line~=nil) then conn:send(line) end
    until line == nil
    file.close()
    conn:on("sent",function(conn) conn:close() end) 
    end)
end)