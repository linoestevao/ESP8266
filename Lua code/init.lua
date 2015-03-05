uart.setup(0,115200,8,0,1,1)
wifi.setmode(wifi.STATIONAP)
--cfg={}
--     cfg.ssid="ESP8266"
--     cfg.pwd="12345678"
--     wifi.ap.config(cfg)
--print(wifi.ap.getip())

wifi.ap.config({ssid="Lino_ESP",pwd="12345678"});

function start()
dofile("server.lua")
print("Server started at ip:"..wifi.ap.getip())
end
--tmr.alarm(0,20000,0, start())