--
--  Majordomo Protocol client example - asynchronous
--  Uses the mdcli API to hide all MDP aspects
--
--  Author: Robert G. Jakabosky <bobby@sharedrealm.com>
--

require"mdcliapi2"
require"zmsg"
require"zhelpers"

local verbose = (arg[1] == "-v")
local session = mdcliapi2.new("tcp://localhost:5555", verbose)

local requests = 100000
for n=1,requests do
    local request = zmsg.new("Hello world")
    session:send("echo", request)
end
local count = 0
while count < requests do
    local reply = session:recv()
    if not reply then
        break   --  failure to reply
    end
    count = count + 1
end
printf("%d replies received\n", count)
session:destroy()

