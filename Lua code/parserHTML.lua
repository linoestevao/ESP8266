--------------------------------------------------------------------------------
-- parserHTML module for NODEMCU
-- Lino Estêvão
-- LICENCE: http://opensource.org/licenses/MIT
-- Lino Estêvão <linoestevao461@gmail.com
--------------------------------------------------------------------------------

-- Set module name as parameter of require
local modname = ...
local M = {}
_G[modname] = M
setfenv(1,M)
--------------------------------------------------------------------------------
-- Local used variables
--------------------------------------------------------------------------------
local head=""
local body=""
local html=""

--------------------------------------------------------------------------------
-- Local used modules
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Implementation
--------------------------------------------------------------------------------
function createBody(data)
  body=body..data
end

function deleteBody()
  body=""
end

function createHead(data)
  head=head..data
end


function deleteHead()
  head=""
end

function parseHTML()
  return "<!DOCTYPE html><html>"..head..body.."</html>"
end

-- Return module table
return M