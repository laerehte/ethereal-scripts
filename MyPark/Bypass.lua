
local v1 = {
	_version = 1
};
v1.__index = v1;
local l__HttpService__1 = game:GetService("HttpService");
local u2 = {
	version = "number", 
	size = "number", 
	count = "number", 
	columns = "number", 
	rows = "number", 
	images = "table"
};
function v1.new(p1, p2)
	if type(p1) == "string" then
		p1 = l__HttpService__1:JSONDecode(p1);
	elseif type(p1) ~= "table" then
		error("Argument #1 (configuration) must be a JSON string or table.", 2);
	end;
	local v2, v3, v4 = pairs(p1);
	while true do
		local v5, v6 = v2(v3, v4);
		if not v5 then
			break;
		end;
		if u2[v5] == nil then
			error(("Invalid property name in Radial Image configuration: %s"):format(v5), 2);
		end;
		if type(v6) ~= u2[v5] then
			error(("Invalid property type \"%s\" in Radial Image configuration: must be a %s."):format(v5, u2[v5]), 2);
		end;	
	end;
	if p1.version ~= v1._version then
		error(("Passed configuration version does not match this module's version (which is %d)"):format(v1._version), 2);
	end;
	local v7 = {
		config = p1, 
		label = p2
	};
	setmetatable(v7, v1);
	return v7;
end;
function v1.GetFromAlpha(p3, p4)
	if type(p4) ~= "number" then
		error("Argument #1 (alpha) to GetFromAlpha must be a number.");
	end;
	local l__count__8 = p3.config.count;
	local l__size__9 = p3.config.size;
	local l__columns__10 = p3.config.columns;
	local l__rows__11 = p3.config.rows;
	local v12 = p4 >= 1 and l__count__8 - 1 or math.floor(p4 * l__count__8);
	local v13 = math.floor(v12 / (l__columns__10 * l__rows__11)) + 1;
	local v14 = v12 - l__columns__10 * l__rows__11 * (v13 - 1);
	return v14 % l__columns__10 * l__size__9, math.floor(v14 / l__rows__11) * l__size__9, v13;
end;
function v1.UpdateLabel(p5, p6, p7)
	p7 = p7 or p5.label;
	if type(p6) ~= "number" then
		error("Argument #1 (alpha) to UpdateLabel must be a number.");
	end;
	if typeof(p7) ~= "Instance" or not p7:IsA("ImageLabel") and not p7:IsA("ImageButton") then
		error("Attempt to update label but no label has been given. Either pass the label as argument #2 to `new`, or as argument #2 to `UpdateLabel`.", 2);
	end;
	local v15, v16, v17 = p5:GetFromAlpha(p6);
	p7.ImageRectSize = Vector2.new(p5.config.size, p5.config.size);
	p7.ImageRectOffset = Vector2.new(v15, v16);
	if p6 <= 0 then
		local v18 = "";
	else
		v18 = p5.config.images[v17];
	end;
	p7.Image = v18;
end;
return v1;
