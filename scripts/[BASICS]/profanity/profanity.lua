-- derpy's script server: profanity filter - derpy54320
api = GetScriptNetworkTable()

-- globals
gClean = {}
gDirty = {}
gDefaultLevel = 2
gHarshFilter = false

-- api
function api.is_dirty_str(str,level) -- use level 0 for the default level
	return F_IsBadString(F_FixArguments(str,level))
end
function api.get_clean_str(str,level) -- this function can be pretty slow (so it is suggested you use it on the client and just check if for dirty strings on the server)
	str,level = F_FixArguments(str,level)
	if F_IsBadString(str,level) then
		if gHarshFilter then
			str = string.gsub(str,"%a","*")
		else
			str = F_GetCleanString(str,level)
			if F_IsBadString(str,level) then
				error("failed to censor string")
			end
		end
	end
	return str
end

-- utility
function F_FixArguments(str,level) -- return a valid str and level no matter what
	str = tostring(str)
	level = tonumber(level) or 0
	if level == 0 then
		return str,gDefaultLevel
	elseif level < 1 then
		return str,1
	elseif level > gDirty.n then
		return str,gDirty.n
	end
	return str,math.floor(level)
end
function F_IsBadString(str,level)
	local letters = string.gsub(string.lower(str),"%A+","")
	for i = level,gDirty.n do
		for _,word in ipairs(gDirty[i]) do
			local a,b = string.find(letters,word,1,true)
			if a and not F_IsClean(string.sub(letters,a)) then
				return true
			end
		end
	end
	return false
end
function F_GetCleanString(str,level)
	local letters = string.gsub(string.lower(str),"%A+","")
	local length = string.len(str)
	local check = ""
	local start = 1
	for index = 1,length do
		if string.find(str,"^%a",index) then
			check = check..string.lower(string.sub(str,index,index)) -- the checked string is just a sequence of letters
			for i = level,gDirty.n do
				for _,word in ipairs(gDirty[i]) do
					local a,b = string.find(check,word,1,true)
					if a and not F_IsClean(string.sub(letters,a)) then -- the bad word's last letter is "index"
						local count = string.len(word)
						count = count + F_GetSpaces(str,count,index) -- add spaces in word
						str = F_CensorWords(str,index-count+1,index)
						check = "" -- reset check since we already checked these words
						start = index + 1
					end
				end
			end
		end
	end
	return str
end
function F_IsClean(word)
	for _,clean in ipairs(gClean) do
		if string.find(word,clean) then
			return true
		end
	end
	return false
end
function F_GetSpaces(str,count,index)
	local spaces = 0
	while count > 0 and index > 0 do
		if string.find(str,"^%a",index) then -- non-letters in the word are counted as part of the word
			count = count - 1
		else
			spaces = spaces + 1
		end
		index = index - 1
	end
	return spaces
end
function F_CensorWords(str,start,finish)
	while start > 1 and string.find(str,"^%a",start-1) do
		start = start - 1 -- push start back to the start of a word
	end
	while string.find(str,"^%a",finish+1) do
		finish = finish + 1 -- push finish up to the end of a word
	end
	return string.sub(str,1,start-1)..string.rep("*",finish-start+1)..string.sub(str,finish+1)
end

-- initialize
function main()
	local cfg = GetScriptConfig()
	local n = 0
	for word in AllConfigStrings(cfg,"clean_word") do
		n = n + 1
		gClean[n] = "^"..word -- clean words are just used with string.find as patterns so ^ anchors to the start
	end
	for level = 1,3 do
		local words = {}
		n = 0
		for word in AllConfigStrings(cfg,"profanity"..level) do
			n = n + 1
			words[n] = word
		end
		gDirty[level] = words
	end
	gDirty.n = table.getn(gDirty)
	gDefaultLevel = GetConfigNumber(cfg,"default_level",gDefaultLevel)
	gHarshFilter = GetConfigNumber(cfg,"harsh_filter",gHarshFilter)
end
main()
main = nil
