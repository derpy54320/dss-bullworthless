-- SYNC: client peds
s = GetScriptSharedTable()

-- scripts:
LoadScript("actions.lur")

-- shared:
s.action_nodes = {} -- allowed nodes
s.action_styles = {} -- nodes with Default_KEY
s.all_action_nodes = ACT_GetRootNode() -- for nodetest.lua

-- globals:
gPeds = {}
gConverting = {n = 0} -- peds that are being converted to network peds
gConverted = -1

-- config:
gHardLimit = GetConfigNumber(GetScriptConfig(),"hard_ped_limit",24)
gSoftLimit = GetConfigNumber(GetScriptConfig(),"soft_ped_limit",gHardLimit)
gMinTrans = GetConfigNumber(GetScriptConfig(),"min_slide_duration",0)
gMaxTrans = GetConfigNumber(GetScriptConfig(),"max_slide_duration",0)
gAddBlips = GetConfigBoolean(GetScriptConfig(),"add_player_blips",false)

-- actions:
gTreeWhitelist = {
	"ACTIONS",
	"AMBIENT",
	"DOOR",
	"HITTREE",
	
	"2_08CONV",
	"404CONV",
	"5_09",
}
gNodeBlacklist = {
	"^/G/TAGS",
	"^/G/AMBIENT/TALKING/TALKING/GEN/SPEECHANIMS/SPAWNS",
}

-- speech:
gSpeechEvents = {
	"ALLY_ACCEPT_ALLIANCE","ALLY_CHATTER","ALLY_HELP_ME","AMBIENT_SCENARIO","ART",
	"ASS_PINCHED","ASYLUM","ASYLUM_PA","ATTACKED","BASEBALL",
	"BIKE_CRASH","BIKE_SEE_TRICK","BIKE_SEE_TRICK_FAIL","BIKE_STEALING","BIKE_STOLEN",
	"BOISTEROUS","BRAG_FOUNTAIN","BUMPED","BUMP_FRIENDLY","BUMP_IN_CAR",
	"BUMP_RUDE","BUMP_RUDE_DROPOUT","BUMP_RUDE_FALLEN","BUMP_RUDE_GREASER","BUMP_RUDE_IN_CAR",
	"BUMP_RUDE_JOCK","BUMP_RUDE_NERD","BUMP_RUDE_OUT_OF_CAR","BUMP_RUDE_PREP","BUMP_VEHICLE",
	"BURTON_COACH","BUS","BUSTED_CLASS","BUSTING","BUSTING_JIMMY",
	"BYE","CALL_FOR_HELP","CARNIE_FUNHOUSE_ATTRACT","CARNIE_FUNHOUSE_ATTRACT_PLAYER","CARNIE_FUNHOUSE_EXIT",
	"CARNIE_GAME_ATTRACT","CARNIE_GAME_ATTRACT_PLAYER","CARNIE_GAME_EXIT_LOSE","CARNIE_GAME_EXIT_WIN","CARNIE_GAME_SELL",
	"CARNIE_GOCART_ATTRACT","CARNIE_GOCART_ATTRACT_PLAYER","CARNIE_GOCART_EXIT_LOSE","CARNIE_GOCART_EXIT_WIN","CARNIE_GOCART_SELL",
	"CARNIE_HAVE_FUN","CARNIE_RIDE_ATTRACT","CARNIE_RIDE_ATTRACT_PLAYER","CARNIE_RIDE_EXIT","CARNIE_TICKETS_BROWSE",
	"CARNIE_TICKETS_NOT_ENOUGH","CARNIE_TICKETS_TRADE","CARNIVAL_EXIT_COMMENT","CHASE","CHASE_ESCAPE",
	"CHASE_OUT_OF_BREATH","CHATTER","CHEERLEADING","CHEM","CITIZEN_ARREST",
	"ClassArt","ClassBiology","ClassChem","ClassEnglish","ClassGeography",
	"ClassMath","ClassMusic","ClassPhoto","ClassShop","COMPLAIN",
	"CONFUSED","CONGRATULATIONS","CONVERSATION_CONTINUATION","CONVERSATION_CONTINUE","CONVERSATION_END",
	"CONVERSATION_GOSSIP","CONVERSATION_GOSSIP_CHAPTER_1","CONVERSATION_GOSSIP_CHAPTER_2","CONVERSATION_GOSSIP_CHAPTER_3","CONVERSATION_GOSSIP_CHAPTER_4",
	"CONVERSATION_GOSSIP_CHAPTER_5","CONVERSATION_GOSSIP_CHAPTER_6","CONVERSATION_GOSSIP_PERSONAL_PRIVATE","CONVERSATION_GOSSIP_PRIVATE","CONVERSATION_GOSSIP_REPLY",
	"CONVERSATION_NEGATIVE_PERSONAL","CONVERSATION_NEGATIVE_REPLY","CONVERSATION_NEGATIVE_STATEMENT","CONVERSATION_PARTING","CONVERSATION_POSITIVE_PERSONAL",
	"CONVERSATION_POSITIVE_PRIVATE","CONVERSATION_POSITIVE_REPLY","CONVERSATION_QUESTION","CONVERSATION_QUESTION_PRIVATE","CONVERSATION_QUESTION_REPLY",
	"CONVERSATION_QUESTION_RESPONSE","CONVERSATION_START","DARE","DEFEAT_INDIVIDUAL","DEFEAT_TEAM",
	"DISGUST","DODGEBALL","DONT_HIT","DUNK_TANK","ENGLISH",
	"FAKE_ID","FIGHT","FIGHTING","FIGHTING_DROPOUT","FIGHTING_GREASER",
	"FIGHTING_JOCK","FIGHTING_NERD","FIGHTING_PREP","FIGHT_BEATEN","FIGHT_FLEE",
	"FIGHT_INITIATE","FIGHT_SACKED","FIGHT_SPAT_UPON","FIGHT_WATCH","FIGHT_WTF",
	"FIREALARM_REACTION","FLEE","FLUSTERED","FOOD_FIGHT","FOOT_STOMPED",
	"FOR_SALE","FREAKSHOW_REACTION","FREAK_OUT_GIRL","FREAK_OUT_GIRL_DORM","FREAK_SHOW",
	"GENERIC_GIFT_REQUEST","GIFT_RECEIVE","GIFT_RECEIVE_EXTORTION","GIFT_RECEIVE_ROMANTIC","GIFT_REQUEST_EXTORTION",
	"GIFT_REQUEST_GIRL","GIVE","GRAFFITI","GREAT_ESCAPE","GREET",
	"GREET_AUTHORITY_FEMALE","GREET_AUTHORITY_MALE","GREET_CLOTHES_LIKE","GREET_GIRL_WON","GREET_HOT_GIRL",
	"GREET_PANTS_LIKE","GREET_PLAYER_CLOTHES_LIKE","GREET_PLAYER_HAIRCUT_LIKE","GREET_PLAYER_HAT_LIKE","GREET_PLAYER_PANTS_LIKE",
	"GREET_PLAYER_SHIRT_LIKE","GREET_PLAYER_SHOES_LIKE","GREET_PLAYER_TATTOO_LIKE","GROOMING","GROOOMING",
	"HELP_EXPLANATION","HELP_REQUIRED","HISTRIKE","HOMELESS_HELP","HUMILIATION_ANIM",
	"INDIGNANT","INFIRMARY","INTIMIDATED_HELLO","JEER","KEEPUPS",
	"LAUGH","LAUGH_CRUEL","LAUGH_FRIENDLY","LAWNMOWER","MAKE_OUT_READY",
	"MAKING_OUT","MAKING_OUT_FINISHED","MP_TAUNT_GARY","MP_TAUNT_JIMMY","MP_TAUNT_LMG",
	"MP_TAUNT_MS","MP_TAUNT_WMG","MYSTERY_MEAT","M_1_01","M_1_02",
	"M_1_02A","M_1_02B","M_1_03","M_1_04","M_1_05",
	"M_1_06","M_1_06_01","M_1_07","M_1_08","M_1_09",
	"M_1_10","M_1_11","M_1_11X1","M_1_11X2","M_1_B",
	"M_1_G1","M_1_S01","M_2_01","M_2_02","M_2_03",
	"M_2_04","M_2_05","M_2_06","M_2_07","M_2_08",
	"M_2_09","M_2_B","M_2_G2","M_2_R03","M_2_R11",
	"M_2_S02","M_2_S04","M_2_S05","M_2_S06","M_2_S07",
	"M_3_01","M_3_01A","M_3_01B","M_3_01C","M_3_01D",
	"M_3_02","M_3_03","M_3_04","M_3_05","M_3_06",
	"M_3_07","M_3_08","M_3_B","M_3_B_2D","M_3_G3",
	"M_3_R05A","M_3_R06","M_3_R07","M_3_R08","M_3_R09",
	"M_3_R09_D","M_3_R09_G","M_3_R09_J","M_3_R09_N","M_3_R09_P",
	"M_3_S03","M_3_S08","M_3_S10","M_3_S11","M_4_01",
	"M_4_02","M_4_02_2D","M_4_03","M_4_03_2D","M_4_04",
	"M_4_05","M_4_06","M_4_07","M_4_B1","M_4_B2",
	"M_4_B3","M_4_G4","M_4_G5","M_4_G6","M_4_S11",
	"M_4_S12","M_5_01","M_5_02","M_5_03","M_5_04",
	"M_5_05","M_5_06","M_5_07","M_5_07A","M_5_09",
	"M_5_B","M_5_G5","M_6_02","M_6_03","M_6_B",
	"M_E","NARRATION","OFFICE_GREETING","OFFICE_VANDALIZE","PAIN",
	"PAYBACK","PA_CHAPTER_1","PA_CHAPTER_2","PA_CHAPTER_3","PA_CHAPTER_4",
	"PA_CHAPTER_56","PA_CHRISTMAS_JIMMY","PA_FIREALARM","PA_GALLOWAY","PA_GALLOWAY_BACK",
	"PA_GENERAL","PA_JIMMY_OFFICE_MILD","PA_JIMMY_OFFICE_STRONG","PENALTY","PHOTOGRAPHER",
	"PHOTOGRAPHY","PLAYER_AFFIRMATIVE","PLAYER_APOLOGY_AUTHORITY_GOOD","PLAYER_APOLOGY_AUTHORITY_POOR","PLAYER_APOLOGY_BEG",
	"PLAYER_APOLOGY_CHILL","PLAYER_APOLOGY_GENERIC","PLAYER_APOLOGY_GIRL","PLAYER_APOLOGY_SMOOTH","PLAYER_BEATEN",
	"PLAYER_BIKE_CRASH","PLAYER_BIKE_STEALING","PLAYER_BIKE_STOLEN","PLAYER_BINNING","PLAYER_BOOT",
	"PLAYER_CAMERA","PLAYER_CAMERA_BAD","PLAYER_CAMERA_GOOD","PLAYER_DEFEAT_INDIVIDUAL","PLAYER_DEFEAT_TEAM",
	"PLAYER_DEJECTED","PLAYER_DRINK","PLAYER_ENTER_RIDE","PLAYER_EXCUSE","PLAYER_EXIT_RIDE",
	"PLAYER_FLIRT_DEFAULT","PLAYER_FLIRT_GOOD","PLAYER_FLIRT_POOR","PLAYER_GET_COLLECTIBLE","PLAYER_GET_MONEY",
	"PLAYER_GET_WEAPON","PLAYER_GIFT_GENERAL","PLAYER_GIFT_GIVE_DOG","PLAYER_GIFT_GIVE_EXTORTION","PLAYER_GIFT_GIVE_GIRL",
	"PLAYER_GREET_ADULT_FEMALE","PLAYER_GREET_ADULT_MALE","PLAYER_GREET_ASSIST","PLAYER_GREET_FRIENDLY_DOG","PLAYER_GREET_GENERIC",
	"PLAYER_GREET_GENERIC_BOY","PLAYER_GREET_GENERIC_GIRL","PLAYER_GREET_HARASS","PLAYER_HIT_SWITCH","PLAYER_IDLE",
	"PLAYER_IDLE_CLASS","PLAYER_IDLE_RAIN","PLAYER_IDLE_SHIVER","PLAYER_IDLE_TIRED","PLAYER_IDLE_WINTER",
	"PLAYER_INFIRMARY","PLAYER_JEER","PLAYER_LAUGH_CRUEL","PLAYER_LAUGH_FRIENDLY","PLAYER_LOCKED",
	"PLAYER_LOCKERING","PLAYER_MAKE_OUT","PLAYER_MISCHIEVOUS","PLAYER_MISSION_SUCCESS","PLAYER_NEGATIVE",
	"PLAYER_OFFICE","PLAYER_PRIZE_TICKETS","PLAYER_STEALTH","PLAYER_STEALTH_POTTY","PLAYER_SUCCESS",
	"PLAYER_TAG_COMPLETE","PLAYER_TAUNT","PLAYER_TAUNT_AUTHORITY","PLAYER_TAUNT_BURN","PLAYER_TAUNT_COMBAT",
	"PLAYER_TAUNT_COMBAT_SHOVE","PLAYER_TAUNT_CONTINUED","PLAYER_TAUNT_DOG","PLAYER_TAUNT_DROPOUT","PLAYER_TAUNT_FACTION",
	"PLAYER_TAUNT_FLEE","PLAYER_TAUNT_FLIRT_INSULT","PLAYER_TAUNT_GIRL","PLAYER_TAUNT_GREASER","PLAYER_TAUNT_HARASS",
	"PLAYER_TAUNT_HARASS_FEMALE","PLAYER_TAUNT_HARASS_MALE","PLAYER_TAUNT_HUMILIATE","PLAYER_TAUNT_HUMILIATE_HIT","PLAYER_TAUNT_JOCK",
	"PLAYER_TAUNT_KO","PLAYER_TAUNT_NERD","PLAYER_TAUNT_PREP","PLAYER_TAUNT_VICTIM","PLAYER_THROW_BALL",
	"PLAYER_TIRED","PLAYER_TOILET_DUNK","PLAYER_TRASH_TALK","PLAYER_URINATING","PLAYER_VICTORY_INDIVIDUAL",
	"PLAYER_VICTORY_TEAM","PLAYER_WHEE","PRANK","PRINCIPAL_LECTURING","PRIOFF",
	"PUKE","PUKE_START","RAT_HIT","RAT_KILLER","RESPONSE_GREET_DISS",
	"RESPONSE_GREET_FRIENDLY","RESPONSE_IGNORE","RESPONSE_UNINTERESTED","SCARED","SCARED_CRY",
	"SEE_ALLY_ATTACKED","SEE_BOY_IN_DORM","SEE_SOMETHING_COOL","SEE_SOMETHING_CRAP","SEE_VANDALISM",
	"SEE_WEAPON_FIRED","SHIPPING","SHOP_CLASS","SNOW_SHOVELLING","SOLD",
	"STEALTH_CONFUSION","STEALTH_DISCOVERING","STEALTH_INVESTIGATING","STEALTH_PURSUIT","STEALTH_TARGET_LOST",
	"STINK_BOMB","STORE_BYE_BUY","STORE_BYE_NOBUY","STORE_BYE_NO_BUY","STORE_CHASE_VANDAL",
	"STORE_CLOTHES_BROWSING","STORE_CLOTHING_COMMENT","STORE_VIOLENCE_RESPONSE","STORE_WELCOME","STRANGE_HOBO",
	"SUCKING_UP","TAGGING_DISAPPROVE","TATTLE","TATTLED","TATTLED_TO",
	"TAUNT","TAUNT_AGGRO","TAUNT_BACK_DOWN","TAUNT_HARASS","TAUNT_KICK",
	"TAUNT_NEIGHBOURHOOD_DROPOUT","TAUNT_NEIGHBOURHOOD_GREASER","TAUNT_NEIGHBOURHOOD_PREP","TAUNT_NEW_KID","TAUNT_PLAYER_DISLIKE_CLOTHES",
	"TAUNT_PLAYER_DISLIKE_HAIR","TAUNT_PLAYER_DISLIKE_HAT","TAUNT_PLAYER_DISLIKE_PANTS","TAUNT_PLAYER_DISLIKE_SHIRT","TAUNT_PLAYER_DISLIKE_SHOES",
	"TAUNT_PLAYER_DISLIKE_TATTOO","TAUNT_PLAYER_EGGS","TAUNT_PLAYER_FALLEN","TAUNT_PLAYER_LIKES_CLOTHES","TAUNT_RESPONSE",
	"TAUNT_RESPONSE_CRY","TAUNT_RESPONSE_DONT_CARE","TAUNT_RESPONSE_PLEAD","THANKS_JIMMY","THANK_YOU",
	"THIS_WAY","TOILET_DUNK_DEFEAT","TOILET_DUNK_STRUGGLE","TRASH_TALK_PERSONAL","TRASH_TALK_TEAM",
	"UNKNOWN","UNKOWN","VENDETTA_NERD","VICTIMIZED","VICTMIZING",
	"VICTORY_INDIVIDUAL","VICTORY_TEAM","WAIT_FOR_ME","WARNING_CLOTHING_RESPONSE","WARNING_COMING_TO_CATCH",
	"WARNING_CURFEW","WARNING_GET_TO_CLASS","WARNING_MINOR_INFRACTION","WARNING_TRESPASSING","WARNING_TRUANCY",
	"WHAT_IS_THAT","WHERES_YOUR_COSTUME","WHINE","WRESTLING","Wrestling1","WTF_TV","YEARBOOK","NUM_SPEECH_EVENTS"
}

-- ped core events:
RegisterNetworkEventHandler("sync:createPed",function(id,type,owned)
	-- all functions in this script that take a "ped" argument expect this net ped table unless noted otherwise
	local ped = {
		-- core:
		ped = -1,
		type = type,
		owned = owned or false, -- if we own the ped
		active = false, -- peds activate after first update (and can only spawn when active)
		spawned = false, -- if the ped was created (so that it may be reported as no longer valid)
		deleted = false, -- sent delete event for the ped becoming invalid after spawned
		needreclaim = false, -- if a ped was synced due to not being owned, and should be "fixed" when owned
		converting = -1, -- use this ped for setting the ped when the ped becomes active
		-- state:
		state = {},
		update = {}, -- fields that are being updated by the server
		-- miscellaneous:
		ahints = "/G",
		ahintn = s.action_nodes,
		ncount = 0, -- current node id
		ntimer = 0, -- current node timer
		position = {started = GetTimer()}, -- smoothed position
	}
	gPeds[id] = ped
	if owned and type == "converted" then
		ped.converting = gConverted
		gConverted = -1
	elseif gConverted ~= -1 then
		error("expected conversion ped")
	end
end)
RegisterNetworkEventHandler("sync:deletePed",function(id)
	local ped = gPeds[id]
	if not ped then
		error("invalid ped")
	elseif PedIsValid(ped.ped) and ped.ped ~= gPlayer then
		PedDelete(ped.ped)
	end
	gPeds[id] = nil
end)
RegisterNetworkEventHandler("sync:controlPed",function(id,owned)
	local ped = gPeds[id]
	if not ped then
		error("invalid ped")
	end
	ped.owned = owned or false
end)
RegisterNetworkEventHandler("sync:updatePeds",function(allchanges,allupdates)
	for id,changes in pairs(allchanges) do
		local ped = gPeds[id]
		if not ped then
			error("invalid ped")
		end
		for k,v in pairs(changes) do
			ped.state[k] = v
		end
		ped.active = true
	end
	if allupdates then
		for id,updates in pairs(allupdates) do
			local ped = gPeds[id]
			if not ped then
				error("invalid ped")
			end
			for k,v in pairs(updates) do
				ped.update[k] = true
			end
		end
		SendNetworkEvent("sync:updatedPeds",allupdates)
	end
end)

-- ped event responses:
RegisterNetworkEventHandler("sync:denyDeletion",function(id)
	local ped = gPeds[id]
	if not ped then
		error("invalid ped")
	end
	ped.deleted = false
end)
RegisterNetworkEventHandler("sync:acceptConvert",function()
	local ped = table.remove(gConverting,1)
	if not ped then
		error("unexpected conversion acceptance")
	end
	gConverted = ped -- createPed directly follows this event so we remember the ped we're converting
end)
RegisterNetworkEventHandler("sync:refuseConvert",function()
	if not table.remove(gConverting,1) then
		error("unexpected conversion refusal")
	end
end)

-- ped sync update:
RegisterLocalEventHandler("sync:updateServer",function() -- tell the server about our owned peds
	local allchanges = {}
	for id,ped in pairs(gPeds) do
		if ped.owned and PedIsValid(ped.ped) then
			local changes = {}
			for k,v in pairs(F_GetPedUpdate(ped)) do
				if not ped.update[k] and (k == "pos" or F_Different(v,ped.state[k])) then -- don't update the server if we haven't updated ourselves
					ped.state[k] = v -- predict the change will be accepted (so we don't spam send the updates), we'll be corrected if needed.
					changes[k] = v
				end
			end
			if next(changes) then
				allchanges[id] = changes
			end
		end
	end
	if next(allchanges) then
		SendNetworkEvent("sync:updatePeds",allchanges)
	end
end)

-- ped limit:
RegisterLocalEventHandler("PedBeingCreated",function()
	while F_GetPedCount() >= gHardLimit do
		local giveup = true
		for id,ped in pairs(gPeds) do
			if PedIsValid(ped.ped) and ped.ped ~= gPlayer and (not ped.owned or ped.type ~= "converted") then
				PrintOutput("ped deleted to keep under hard limit")
				PedDelete(ped.ped)
				ped.ped = -1
				giveup = false
				break
			end
		end
		if giveup then
			PrintWarning("hard ped limit reached")
			return
		end
	end
end)

-- ped misc:
RegisterLocalEventHandler("PedUpdateThrottle",function(ped)
	for _,p in pairs(gPeds) do
		if p.ped == ped then
			if not p.owned then
				PedSetThrottle(ped,p.state.throttle)
			end
			break
		end
	end
end)

-- cleanup:
function MissionCleanup()
	StopPedProduction(false)
	PlayerSwapModel("player")
	PedSetActionTree(gPlayer,"","")
	PedSetAITree(gPlayer,"/Global/PlayerAI","Act/PlayerAI.act")
	SoundEnableSpeech_ActionTree()
end

-- main:
function main()
	local fixed = true
	F_SetupActionNodes()
	while not SystemIsReady() do
		Wait(0)
	end
	CreateThread("T_Leader")
	CreateThread("T_Convert")
	while true do
		if not PedIsModel(gPlayer,136) then
			F_FixStyleAi()
			fixed = true
		elseif fixed then
			F_RestoreStyleAi()
			fixed = false
		end
		F_FixInvalid()
		F_DeletePeds()
		F_CreatePeds()
		F_UpdatePeds()
		Wait(0)
	end
end
function F_FixStyleAi()
	local model = s.pedModels[PedGetModelId(gPlayer)+1]
	if model then
		if model[12] ~= "/Global/Player" and PedMePlaying(gPlayer,"Default_KEY",true) and PedIsPlaying(gPlayer,model[12],true) then
			PedSetActionTree(gPlayer,"/Global/Player","Act/Player.act")
		end
		if not PedIsDoingTask(gPlayer,"/Global/PlayerAI",true) then
			PedSetAITree(gPlayer,"/Global/PlayerAI","Act/PlayerAI.act")
		end
	end
end
function F_RestoreStyleAi()
	local model = s.pedModels[PedGetModelId(gPlayer)+1]
	PedSetActionTree(gPlayer,"","")
	PedSetAITree(gPlayer,model[14],model[15])
end
function F_FixInvalid()
	for id,ped in pairs(gPeds) do
		if ped.ped ~= -1 and not PedIsValid(ped.ped) then
			ped.ped = -1
		end
	end
end
function F_DeletePeds()
	for id,ped in pairs(gPeds) do
		if ped.spawned and not ped.deleted and not PedIsValid(ped.ped) then
			if ped.owned then
				SendNetworkEvent("sync:deletePed",id)
				ped.deleted = true
			else
				ped.spawned = false -- allow the ped to spawn again since we shouldn't be deleting it
			end
		end
	end
end
function F_CreatePeds()
	for id,ped in pairs(gPeds) do
		if ped.active and not ped.spawned and not ped.dead and not PedIsValid(ped.ped) then
			if ped.owned and ped.type == "player" then -- use gPlayer for an owned player ped
				ped.ped = gPlayer
				ped.spawned = true
				PlayerSwapModel(s.pedModels[ped.state.model+1][1])
			elseif ped.owned and ped.type == "converted" then
				if PedIsValid(ped.converting) then
					ped.ped = ped.converting
					ped.converting = -1
				end
				ped.spawned = true
			elseif F_GetPedCount() < gSoftLimit then
				local x,y,z,h = unpack(ped.state.pos)
				ped.ped = PedCreateXYZ(ped.state.model,x,y,z)
				if PedIsValid(ped.ped) then
					if gAddBlips and ped.type == "player" then
						AddBlipForChar(ped.ped,0,1,1)
					end
					PedFaceHeading(ped.ped,h,0)
					ped.needreclaim = true
					ped.spawned = true
				else
					PrintWarning("failed to create ped")
					ped.ped = -1 -- very rare that a ped isn't valid but just a failsafe
				end
			end
		end
	end
end
function F_UpdatePeds()
	for id,ped in pairs(gPeds) do
		if PedIsValid(ped.ped) then
			if not ped.owned then
				F_SetPedMode(ped,false)
				ped.needreclaim = true
			elseif ped.needreclaim then
				F_SetPedMode(ped,true)
				ped.needreclaim = false
			end
			F_SetPedUpdate(ped)
		end
	end
end

-- leader mode:
function T_Leader()
	local leading = true -- true so that the first loop cycle clears peds
	while true do
		if not s.leader then
			if leading then
				AreaClearAllPeds()
				leading = false
			end
			SoundDisableSpeech_ActionTree()
			StopPedProduction(true)
		elseif not leading then
			SoundEnableSpeech_ActionTree()
			StopPedProduction(false)
			leading = true
		end
		Wait(0)
	end
end

-- convert peds:
function T_Convert()
	while true do
		if s.leader then
			F_ConvertPeds()
			F_DebugConvert(" UNCONVERTED PEDS")
		else
			F_DebugConvert(" UNWANTED PEDS")
		end
		Wait(0)
	end
end
function F_ConvertPeds()
	for ped in AllPeds() do
		if ped ~= gPlayer and F_ShouldConvert(ped) and not F_Contains(gConverting,ped) then
			table.insert(gConverting,ped)
			SendNetworkEvent("sync:convertPed",F_GetPedUpdate({ped = ped}))
		end
	end
end
function F_ShouldConvert(ped)
	for _,v in pairs(gPeds) do
		if v.ped == ped or v.converting == ped then
			return false
		end
	end
	return true
end
function F_DebugConvert(suffix)
	local count = 0
	for ped in AllPeds() do
		if not F_GetPedNet(ped) then
			count = count + 1
		end
	end
	if count ~= 0 then
		SetTextFont("Arial")
		SetTextBlack()
		SetTextOutline()
		SetTextColor(255,32,32,255)
		SetTextPosition(0.5,0)
		DrawText(count..suffix)
	end
end

-- update ped mode:
function F_SetPedMode(ped,owned)
	if owned then
		for dtype = 0,3 do
			PedSetDamageTakenMultiplier(ped.ped,dtype,1)
		end
		for f = 0,13 do
			if f ~= 12 then
				PedSetPedToTypeAttitude(ped.ped,f,PedGetTypeToTypeAttitude(PedGetFaction(ped.ped),f))
			end
		end
		PedSetFlag(ped.ped,58,false)
		--PedSetEffectedByGravity(ped.ped,true)
		--PedSetInvulnerable(ped.ped,false)
		PedIgnoreAttacks(ped.ped,false)
		PedIgnoreStimuli(ped.ped,false)
		return
	end
	-- function is called repeatedly if not owned
	for dtype = 0,3 do
		if PedGetDamageTakenMultiplier(ped.ped,dtype) ~= 0 then
			PedSetDamageTakenMultiplier(ped.ped,dtype,0) -- so damage is not weirdly predicted
		end
	end
	for f = 0,13 do
		if f ~= 12 and PedGetPedToTypeAttitude(ped.ped,f) ~= 2 then
			PedSetPedToTypeAttitude(ped.ped,f,2) -- this unowned ped is neutral of other peds (so that attacks will register)
		end
	end
	if PedGetFaction(ped.ped) == 13 then
		PedSetFaction(ped.ped,14) -- use PLAYER2 instead of PLAYER1 because many functions check for PLAYER1 (like PedSetWeapon)
	end
	if not PedGetFlag(ped.ped,58) then
		PedSetFlag(ped.ped,58,true) -- can't die
	end
	--PedSetEffectedByGravity(ped.ped,false)
	--PedSetInvulnerable(ped.ped,true)
	PedIgnoreAttacks(ped.ped,true)
	PedIgnoreStimuli(ped.ped,true)
end

-- update the client:
function F_SetPedUpdate(ped)
	local state = ped.state
	local active = not PedGetFlag(ped.ped,17)
	F_SwapModel(ped,state)
	if not PedIsValid(ped.ped) then
		return
	end
	if active then
		F_SetBasics(ped,state)
		F_SetHealth(ped,state)
	end
	F_SetPosition(ped,state)
	if active and not PedIsModel(ped.ped,136) then
		F_SetWeapon(ped,state)
		F_SetAction(ped,state)
		F_SetSpeech(ped,state)
	end
end
function F_SwapModel(ped,state)
	if F_UpdateState(ped,"model") and not PedIsModel(ped.ped,state.model) then
		if ped.owned and ped.type == "converted" then
			PedSwapModel(ped.ped,s.pedModels[state.model+1][1])
		else
			PedDelete(ped.ped)
			--ped.ped = PedCreateXYZ(state.model,0,0,0)
		end
	end
end
function F_SetBasics(ped,state)
	if F_UpdateState(ped,"crouch") and PedGetFlag(ped.ped,2) ~= state.crouch then
		PedSetFlag(ped.ped,2,state.crouch)
	end
end
function F_SetHealth(ped,state)
	local hp,maxhp = state.hp,state.maxhp
	if maxhp < 1 then
		maxhp = 1
	end
	if F_UpdateState(ped,"maxhp") and PedGetMaxHealth(ped.ped) ~= maxhp then
		PedSetMaxHealth(ped.ped,maxhp)
	end
	if hp < 0 then
		hp = 0
	elseif ped.ped ~= gPlayer and hp > PedGetMaxHealth(ped.ped) then
		hp = PedGetMaxHealth(ped.ped)
	end
	if F_UpdateState(ped,"hp") and PedGetHealth(ped.ped) ~= hp then
		if ped.ped == gPlayer then
			PlayerSetHealth(hp)
		else
			PedSetHealth(ped.ped,hp)
		end
	end
end
function F_SetWeapon(ped,state)
	if F_UpdateState(ped,"weapon") --[[and PedGetWeapon(ped.ped) ~= state.weapon]] then
		--PedClearAllWeapons(ped.ped)
		if state.weapon ~= -1 then
			--PedSetWeapon(ped.ped,state.weapon,50,false)
			--PedSetFlag(ped.ped,24,true)
		end
		-- just get rid of all weapons for now since weapons are fucked up
		if PedGetWeapon(ped.ped) ~= -1 then
			PedClearAllWeapons(ped.ped)
			PedSetWeapon(ped.ped,-1)
		end
	end
end
function F_SetPosition(ped,state)
	local warp = ped.update.pos
	if F_UpdateState(ped,"pos") then
		local x2,y2,z2,h2 = unpack(state.pos)
		if not warp then
			local smooth = ped.position
			if smooth.pos ~= state.pos then
				local timer = GetTimer()
				if smooth.area == state.area then
					smooth.duration = math.max(gMinTrans,math.min(gMaxTrans,timer-smooth.started)) / 1000
				else
					smooth.duration = 0
				end
				smooth.started = timer
				smooth.seconds = GetFrameTime()
				smooth.from = {math.deg(PedGetHeading(ped.ped)),PedGetPosXYZ(ped.ped)}
				smooth.area = state.area
				smooth.pos = state.pos
			end
			if smooth.duration ~= 0 then
				local h1,x1,y1,z1 = unpack(smooth.from)
				local dx,dy,dz,dh = x2-x1,y2-y1,z2-z1,F_FixDegrees(h2-h1)
				local dist = math.min(2,smooth.seconds/smooth.duration)
				x2,y2,z2,h2 = x1+dx*dist,y1+dy*dist,z1+dz*dist,h1+dh*dist
				smooth.seconds = smooth.seconds + GetFrameTime()
			end
		else
			ped.position = {started = GetTimer()}
		end
		PedSetPosSimple(ped.ped,x2,y2,z2)
		PedFaceHeading(ped.ped,h2,0)
	end
end
function F_SetAction(ped,state)
	if F_UpdateState(ped,"action") then
		if ped.ncount ~= ped.state.act_count or not PedIsPlaying(ped.ped,state.act_node,true) then
			if ped.ncount ~= ped.state.act_count then
				ped.ncount = ped.state.act_count
				ped.ntimer = 0 -- COUNT CHANGED! RESET TIMER.
			end
			if ped.ntimer > ped.state.act_timer then
				return -- already played as far as we're meant to
			--[[elseif PedIsHit(ped.ped,2,1000) and PedIsPlaying(ped.ped,"/Global/HitTree",true) then
				return -- some time to allow client-predicted hits to play]]
			elseif F_FixActionNode(state.act_node) ~= state.act_node then
				return -- forbidden node that shouldn't have even been sent to us
			end
			PedSetActionNode(ped.ped,state.act_node,"")
			if not PedIsPlaying(ped.ped,state.act_node,true) then
				return -- not playing so return before updating timer
			end
		end
		ped.ntimer = PedGetNodeTime(ped.ped) -- NODE PLAYING! UPDATE TIMER.
	else
		ped.ntimer = 0 -- NOT NETWORKED OR DOING MOTION! RESET TIMER.
	end
end
function F_SetSpeech(ped,state)
	if F_UpdateState(ped,"speech") then
		if state.speech ~= 0 then
			local speech = gSpeechEvents[state.speech]
			if not SoundSpeechPlaying(ped.ped,speech) then
				SoundStopCurrentSpeechEvent(ped.ped)
				SoundPlayAmbientSpeechEvent(ped.ped,speech)
				if not SoundSpeechPlaying(ped.ped,speech) then
					SoundPlayScriptedSpeechEvent(ped.ped,speech,state.speechv)
				end
			end
		elseif SoundSpeechPlaying(ped.ped) then
			SoundStopCurrentSpeechEvent(ped.ped)
		end
	end
end

-- update the server:
function F_GetPedUpdate(ped)
	local speech = F_GetSpeech(ped)
	local ncount,ntimer = 0,PedGetNodeTime(ped.ped)
	if ped.state then
		ncount = ped.state.act_count
		if ntimer < ped.state.act_timer then
			ncount = ncount + 1
		end
	end
	return {
		-- basics:
		model = PedGetModelId(ped.ped),
		area = F_GetArea(ped),
		pos = F_GetPosition(ped),
		dead = PedIsDead(ped.ped),
		-- actions:
		act_node = F_FixActionNode(F_GetAction(ped)),
		act_count = ncount,
		act_timer = ntimer,
		-- extra:
		hp = PedGetHealth(ped.ped),
		maxhp = PedGetMaxHealth(ped.ped),
		crouch = PedGetFlag(ped.ped,2),
		weapon = PedGetWeapon(ped.ped),
		throttle = F_GetThrottle(ped),
		speech = speech,
		speechv = F_GetSpeechVariation(ped,speech)
	}
end
function F_GetArea(ped)
	if ped.ped == gPlayer then
		return AreaGetVisible()
	end
	return 0
end
function F_GetPosition(ped)
	local x,y,z = PedGetPosXYZ(ped.ped)
	return {x,y,z,math.deg(PedGetHeading(ped.ped))}
end
function F_GetStyle(ped)
	if PedMePlaying(ped.ped,"Default_KEY",true) then
		for _,tree in ipairs(s.action_styles) do
			if PedIsPlaying(ped.ped,"/G/"..tree,true) then
				return tree
			end
		end
	end
	-- returning nothing means it just won't update
end
function F_GetAction(ped)
	if ped.ahints then -- check because F_GetPedUpdate can be called with a "fake" ped object
		ped.ahints,ped.ahintn = ACT_GetPedAction(ped.ped,ped.ahints,ped.ahintn)
		return ped.ahints
	end
	return ACT_GetPedAction(ped.ped)
end
function F_GetThrottle(ped)
	if PedMePlaying(ped.ped,"Default_KEY",true) then
		return PedGetThrottle(ped.ped)
	end
	return 0
end
function F_GetSpeech(ped)
	if SoundSpeechPlaying(ped.ped) then
		for index,speech in ipairs(gSpeechEvents) do
			if SoundSpeechPlaying(ped.ped,speech) then
				return index
			end
		end
	end
	return 0
end
function F_GetSpeechVariation(ped,speech)
	if speech ~= 0 then
		speech = gSpeechEvents[speech]
		for v = 0,200 do -- TODO: figure out the real highest value
			if SoundSpeechPlaying(ped.ped,speech,v) then
				return v
			end
		end
	end
	return 0
end

-- ped state utility:
function F_UpdateState(ped,...) -- check if any of the state fields should be updated and clear them all if so
	if not ped.owned then
		for _,key in ipairs(arg) do
			ped.update[key] = nil
		end
		return true
	end
	for _,key in ipairs(arg) do
		if ped.update[key] then
			for _,key in ipairs(arg) do
				ped.update[key] = nil
			end
			return true
		end
	end
	return false
end

-- action utility:
function F_SetupActionNodes()
	local global = ACT_GetRootNode()
	for _,tree in ipairs(gTreeWhitelist) do
		s.action_nodes[tree] = global[tree]
	end
	for tree,nodes in pairs(global) do
		if nodes.DEFAULT_KEY then
			s.action_nodes[tree] = nodes
		end
	end
	ACT_SetRootNode(s.action_nodes)
	for k,v in pairs(global) do
		F_AddActionStyles(k,v)
	end
end
function F_AddActionStyles(node,nodes)
	if nodes.DEFAULT_KEY then
		table.insert(s.action_styles,node)
	end
	for k,v in pairs(nodes) do
		F_AddActionStyles(node.."/"..k,v)
	end
end
function F_FixActionNode(node)
	for _,black in ipairs(gNodeBlacklist) do
		if string.find(node,black) then
			return "/G"
		end
	end
	if string.find(node,"^/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1") then
		if not string.find(node,"RELEASE") then
			return "/G"
		elseif node == "/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1/RELEASE/JAB" then
			return "/G/PLAYER/ATTACKS/STRIKES/LIGHTATTACKS/LEFT1/RELEASE"
		end
	end
	return node
end

-- general utility:
function F_GetPedNet(ped) -- get net ped table from ped handle
	for id,v in pairs(gPeds) do
		if v.ped == ped then
			return id
		end
	end
end
function F_GetPedCount()
	local count = 0
	for ped in AllPeds() do
		count = count + 1
	end
	return count
end
function F_FixDegrees(degs)
	while degs > 180 do
		degs = degs - 360
	end
	while degs <= -180 do
		degs = degs + 360
	end
	return degs
end
function F_FixRadians(rads)
	while rads > 180 do
		rads = rads - 360
	end
	while rads <= -180 do
		rads = rads + 360
	end
	return rads
end
function F_Contains(array,value)
	for _,v in ipairs(array) do
		if v == value then
			return true
		end
	end
	return false
end
function F_Different(a,b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a ~= b
	end
	for k,v in pairs(a) do
		if b[k] == nil then
			return true
		end
	end
	for k,v in pairs(b) do
		if F_Different(a[k],v) then
			return true
		end
	end
	return false
end

-- reset peds:
function F_ResetPeds() -- needed occasionally because of a bug that hasn't been figured out yet
	for _,ped in pairs(gPeds) do
		if not ped.owned and ped.ped ~= gPlayer then
			if PedIsValid(ped.ped) then
				PedDelete(ped.ped)
			end
			ped.ped = -1
		end
	end
end
CreateThread(function()
	local interval = GetConfigNumber(GetScriptConfig(),"ped_reset_interval",0)
	if interval <= 0 then
		return
	end
	while true do
		Wait(interval)
		F_ResetPeds()
	end
end)
SetCommand("reset_peds",F_ResetPeds)

-- debug:
function s.getPedDebug()
	local count = 0
	for id in pairs(gPeds) do
		count = count + 1
	end
	return count.." net peds"
end
function s.debugPeds(fmt,startx,starty,indent)
	local hide = {"ahints","ahintn"}
	while true do
		local sorted = {}
		local x,y,w,h = startx,starty
		for id,ped in pairs(gPeds) do
			if ped.type ~= "converted" then
				table.insert(sorted,{id,ped})
			end
		end
		table.sort(sorted,function(a,b)
			return a[1] < b[1]
		end)
		for _,v in pairs(sorted) do
			local hidden = {}
			local id,ped = unpack(v)
			local model = ped.state.model and s.pedModels[ped.state.model+1][1]
			SetTextFormatting(fmt)
			SetTextPosition(x,y)
			if model then
				w,h = DrawText("("..id..") "..model)
			else
				w,h = DrawText("("..id..") unknown model: "..tostring(ped.state.model))
			end
			y = y + h
			for _,k in ipairs(hide) do
				hidden[k] = ped[k]
				ped[k] = nil
			end
			y = y + s.drawDebugTable(ped,fmt,x+indent,y,indent)
			for _,k in ipairs(hide) do
				ped[k] = hidden[k]
			end
			if y >= 0.8 then
				break
			end
		end
		Wait(0)
	end
end
