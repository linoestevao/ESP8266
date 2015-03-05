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
    conn:send('<!DOCTYPE HTML>\n')
    conn:send('<html>\n')
    conn:send('<head><meta  content="text/html; charset=utf-8">\n')
    conn:send('<title>ESP8266</title></head>\n')
    conn:send('<body><h1>Controlador gpio</h1>\n')
    conn:send('<form action="" method="POST">\n')
    conn:send('<input type="submit" name="pwmi" value="OFF">\n')
    conn:send('<input type="submit" name="pwmi" value="10">\n')
    conn:send('<input type="submit" name="pwmi" value="20">\n')
    conn:send('<input type="submit" name="pwmi" value="30">\n')
    conn:send('<input type="submit" name="pwmi" value="40">\n')
    conn:send('<input type="submit" name="pwmi" value="50">\n')
    conn:send('<input type="submit" name="pwmi" value="60">\n')
    conn:send('<input type="submit" name="pwmi" value="70">\n')
    conn:send('<input type="submit" name="pwmi" value="80">\n')
    conn:send('<input type="submit" name="pwmi" value="90">\n')
    conn:send('<input type="submit" name="pwmi" value="ON"> % of power<br><br>\n')
    conn:send('<input type="submit" name="pwmi" value="FLC"> HW blinker</form>\n')
    conn:send('</body></html>\n')
    conn:on("sent",function(conn) conn:close() end)
    end)
end)

 if(path=="ap.html") then
          --say ok to client
          conn:send('HTTP/1.1 200 OK\n\n')
          
          conn:send("<!DOCTYPE html><html><head><title>Access Points</title></head><body><h1>Ap list</h1>")
          -- print ap list
          --wifi.sta.getap(function(t) if t then conn:send("\n\nVisible Access Points:\n") for k,v in pairs(t) do l = string.format("%-10s",k) conn:send(l.."  "..v) end else conn:send("Try again") end  end)
          conn:send("</body></html>")
          conn:on("sent",function(conn) conn:close() end) 
          
        else