

srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        --print(request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        path=string.sub(path, 2)
        
        --print(path)
        --cgi scripts
        if(path=="ap.html") then
          --say ok to client
          conn:send('HTTP/1.1 200 OK\n\n')
          
          conn:send("<!DOCTYPE html><html><head><title>Access Points</title></head><body><h1>Ap list</h1>")
          -- print ap list
          --wifi.sta.getap(function(t) if t then conn:send("\n\nVisible Access Points:\n") for k,v in pairs(t) do l = string.format("%-10s",k) conn:send(l.."  "..v) end else conn:send("Try again") end  end)
          conn:send("</body></html>")
          conn:on("sent",function(conn) conn:close() end) 
          
        elseif(file.open(""..path, "r")~=nil) then
          conn:send('HTTP/1.1 200 OK\n\n')
          repeat
            line = file.readline()
            if (line~=nil) then conn:send(line) end
          until line == nil
          file.close()
          else
            --print("path not found .!.")
            file.open("404_not_found.html", "r")
            
            
            repeat
              line = file.readline()
              if (line~=nil) then conn:send(line) end
            until line == nil
            file.close()
        end
        conn:on("sent",function(conn) conn:close() end) 
        collectgarbage();
    end)
end)