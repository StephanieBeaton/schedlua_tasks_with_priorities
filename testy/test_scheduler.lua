--test_scheduler.lua
package.path = package.path..";../?.lua"

Scheduler = require("schedlua.scheduler")()
Task = require("schedlua.task")
local taskID = 0;

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end

-- signature change steph
-- local function spawn(scheduler, func, ...)
local function spawn(scheduler, func, priority, ...)
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
	-- new line steph
	task.priority = priority;
	scheduler:scheduleTask(task, {...});
	
	return task;
end


local function task1()
	print("first task, first line")
	-- why isn't this Task.yield() ?
	-- self.yield()
	Scheduler:yield();
	print("first task, second line")
end

local function task2()
	print("second task, only line")
end

local function main()
	-- steph
	-- local t1 = spawn(Scheduler, task1)
	local priority1 = 1
	local t1 = spawn(Scheduler, task1, priority1)
	-- steph
    -- local t2 = spawn(Scheduler, task2)
    local priority2 = 2
	local t2 = spawn(Scheduler, task2, priority2)

	while (true) do
		--print("STATUS: ", t1:getStatus(), t2:getStatus())
		if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
			break;
		end
		-- steph
		-- change Scheduler:step()
		Scheduler:step()
	end
end

main()


