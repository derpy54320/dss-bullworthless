-- how long we have to be not playing the action to force a reset (this allows time for client prediction of hit reactions)
NODE_RESET_DELAY = 200

-- lua patterns for action nodes that aren't allowed (though they *can* still be allowed if whitelisted)
BLACKLIST_NODES = {
	-- "pattern"
	"^/G/TAGS",
	"^/G/SIGNS",
	"^/G/VEHICLES/SKATEBOARD",
	"^/G/AMBIENT/TALKING/TALKING/GEN/SPEECHANIMS/SPAWNS",
}

-- lua patterns for action nodes that are always allowed (even if blacklisted)
WHITELIST_NODES = {
	-- {"pattern","replacement"}
	-- values in this table are checked in order
	-- the replacement node is optional, if not specified then it is just assumed the node being checked is safe
	{"^/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE","/G/VEHICLES/SKATEBOARD/LOCOMOTION/RIDE/COAST/LOCOMOTIONS/STILL/IDLE"},
}

-- allowed action trees (by default it contains all trees with a DEFAULT_KEY node)
ACTION_TREES = {
	-- ["/G/TREE"] = "FILE.ACT"
	["/G/1_02B/CONSTANTINOSIDLE"] = "1_02B.ACT",
	["/G/1_03_DAVIS"] = "1_03_DAVIS.ACT",
	["/G/2_07_GORD"] = "P_2_07_GORD.ACT",
	["/G/AMBIENT/SPECTATOR"] = "AMBIENT.ACT",
	["/G/AN_DOG"] = "AN_DOG.ACT",
	["/G/AN_RAT"] = "AN_RAT.ACT",
	["/G/AUTHORITY"] = "AUTHORITY.ACT",
	["/G/BASKETBALL/BASKETBALL"] = "BASKETBALL.ACT",
	["/G/BAT"] = "BAT.ACT",
	["/G/BOOKS/BOOKS"] = "BOOKS.ACT",
	["/G/BOSS_DARBY"] = "BOSS_DARBY.ACT",
	["/G/BOSS_RUSSELL"] = "BOSS_RUSSELL.ACT",
	["/G/BOXINGPLAYER"] = "BOXINGPLAYER.ACT",
	["/G/B_STRIKER_A"] = "B_STRIKER_A.ACT",
	["/G/CRAZY_BASIC"] = "CRAZY_BASIC.ACT",
	["/G/CV_DRUNK"] = "CV_DRUNK.ACT",
	["/G/CV_FEMALE_A"] = "CV_FEMALE_A.ACT",
	["/G/CV_MALE_A"] = "CV_MALE_A.ACT",
	["/G/CV_OLD"] = "CV_OLD.ACT",
	["/G/DO_EDGAR"] = "DO_EDGAR.ACT",
	["/G/DO_GRAPPLER_A"] = "DO_GRAPPLER_A.ACT",
	["/G/DO_MELEE_A"] = "DO_MELEE_A.ACT",
	["/G/DO_STRIKER_A"] = "DO_STRIKER_A.ACT",
	["/G/EDGARSHIELD"] = "EDGARSHIELD.ACT",
	["/G/FIGHT_TUTORIAL"] = "FIGHT_TUTORIAL.ACT",
	["/G/FLASHLIGHT/FLASHLIGHT"] = "FLASHLIGHT.ACT",
	["/G/GS_FAT_A"] = "GS_FAT_A.ACT",
	["/G/GS_FEMALE_A"] = "GS_FEMALE_A.ACT",
	["/G/GS_MALE_A"] = "GS_MALE_A.ACT",
	["/G/GUN/GUN"] = "GUN.ACT",
	["/G/G_GRAPPLER_A"] = "G_GRAPPLER_A.ACT",
	["/G/G_JOHNNY"] = "G_JOHNNY.ACT",
	["/G/G_MELEE_A"] = "G_MELEE_A.ACT",
	["/G/G_RANGED_A"] = "G_RANGED_A.ACT",
	["/G/G_STRIKER_A"] = "G_STRIKER_A.ACT",
	["/G/HF_SPECTATOR"] = "HF_SPECTATOR.ACT",
	["/G/HOBO_BLOCKER"] = "HOBO_BLOCKER.ACT",
	["/G/JBROOM"] = "JBROOM.ACT",
	["/G/J_DAMON"] = "J_DAMON.ACT",
	["/G/J_GRAPPLER_A"] = "J_GRAPPLER_A.ACT",
	["/G/J_MASCOT"] = "J_MASCOT.ACT",
	["/G/J_MELEE_A"] = "J_MELEE_A.ACT",
	["/G/J_STRIKER_A"] = "J_STRIKER_A.ACT",
	["/G/J_TED"] = "J_TED.ACT",
	["/G/KICKMESIGN/KICKMESIGN"] = "KICKMESIGN.ACT",
	["/G/LE_ORDERLY_A"] = "LE_ORDERLY_A.ACT",
	["/G/NEMESIS"] = "NEMESIS.ACT",
	["/G/NONWEAPON/NONWEAPON"] = "NONWEAPON.ACT",
	["/G/NORTON"] = "3_05_NORTON.ACT",
	["/G/NPC1_09"] = "NPC1_09.ACT",
	["/G/NPC_CHEER_A"] = "NPC_CHEER_A.ACT",
	["/G/N_EARNEST"] = "N_EARNEST.ACT",
	["/G/N_RANGED_A"] = "N_RANGED_A.ACT",
	["/G/N_STRIKER_A"] = "N_STRIKER_A.ACT",
	["/G/N_STRIKER_B"] = "N_STRIKER_B.ACT",
	["/G/PLAYER"] = "PLAYER.ACT",
	["/G/P_BIF"] = "P_BIF.ACT",
	["/G/P_GRAPPLER_A"] = "P_GRAPPLER_A.ACT",
	["/G/P_STRIKER_A"] = "P_STRIKER_A.ACT",
	["/G/P_STRIKER_B"] = "P_STRIKER_B.ACT",
	["/G/RUSSELL_102"] = "RUSSELL_102.ACT",
	["/G/SHIELDS"] = "SHIELDS.ACT",
	["/G/SIMPLELOCO"] = "SIMPLELOCO.ACT",
	["/G/SLASHER"] = "SLASHER.ACT",
	["/G/SLEDGEHAMMER"] = "SLEDGEHAMMER.ACT",
	["/G/SLINGSHOT/SLINGSHOT"] = "SLINGSHOT.ACT",
	["/G/SNOWSHOVEL/SNOWSHOVEL"] = "SNOWSHOVEL.ACT",
	["/G/SPECIAL_ITEMS"] = "SPECIAL_ITEMS.ACT",
	["/G/SPRAYCAN"] = "SPRAYCAN.ACT",
	["/G/TE_FEMALE_A"] = "TE_FEMALE_A.ACT",
	["/G/TE_SECRETARY"] = "TE_SECRETARY.ACT",
	["/G/THROWN/THROWN"] = "THROWN.ACT",
	["/G/TO_SIAMESE"] = "TO_SIAMESE.ACT",
	["/G/UMBRELLA"] = "UMBRELLA.ACT",
	["/G/WATERPIPE"] = "WATERPIPE.ACT",
	["/G/WCAMERA/WCAMERA"] = "WCAMERA.ACT",
	["/G/WFIREEXT"] = "WFIREEXT.ACT",
	["/G/WRESTLINGACT"] = "WRESTLINGACT.ACT",
	["/G/WRESTLINGNPC"] = "WRESTLINGNPC_ACT.ACT",
}

-- default action tree for each ped model
PEDS = {
	-- [model] = {"/G/TREE","FILE.ACT"}
	[0] = {"/G/PLAYER","PLAYER.ACT"},
	[1] = {"/G/PLAYER","PLAYER.ACT"},
	[2] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[3] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[4] = {"/G/N_STRIKER_B","N_STRIKER_B.ACT"},
	[5] = {"/G/N_STRIKER_A","N_STRIKER_A.ACT"},
	[6] = {"/G/N_STRIKER_A","N_STRIKER_A.ACT"},
	[7] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[8] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[9] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[10] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[11] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[12] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[13] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[14] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[15] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[16] = {"/G/J_GRAPPLER_A","J_GRAPPLER_A.ACT"},
	[17] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[18] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[19] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[20] = {"/G/J_GRAPPLER_A","J_GRAPPLER_A.ACT"},
	[21] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[22] = {"/G/G_GRAPPLER_A","G_GRAPPLER_A.ACT"},
	[23] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[24] = {"/G/G_MELEE_A","G_MELEE_A.ACT"},
	[25] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[26] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[27] = {"/G/G_MELEE_A","G_MELEE_A.ACT"},
	[28] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[29] = {"/G/G_GRAPPLER_A","G_GRAPPLER_A.ACT"},
	[30] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[31] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[32] = {"/G/P_GRAPPLER_A","P_GRAPPLER_A.ACT"},
	[33] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[34] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[35] = {"/G/P_GRAPPLER_A","P_GRAPPLER_A.ACT"},
	[36] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[37] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[38] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[39] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[40] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[41] = {"/G/DO_GRAPPLER_A","DO_GRAPPLER_A.ACT"},
	[42] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[43] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[44] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[45] = {"/G/DO_GRAPPLER_A","DO_GRAPPLER_A.ACT"},
	[46] = {"/G/DO_GRAPPLER_A","DO_GRAPPLER_A.ACT"},
	[47] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[48] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[49] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[50] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[51] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[52] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[53] = {"/G/LE_ORDERLY_A","LE_ORDERLY_A.ACT"},
	[54] = {"/G/TE_FEMALE_A","TE_FEMALE_A.ACT"},
	[55] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[56] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[57] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[58] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[59] = {"/G/TE_FEMALE_A","TE_FEMALE_A"},
	[60] = {"/G/TE_FEMALE_A","TE_FEMALE_A"},
	[61] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[62] = {"/G/TE_FEMALE_A","TE_FEMALE_A.ACT"},
	[63] = {"/G/TE_FEMALE_A","TE_FEMALE_A.ACT"},
	[64] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[65] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[66] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[67] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[68] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[69] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[70] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[71] = {"/G/GS_FAT_A","GS_FAT_A.ACT"},
	[72] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[73] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[74] = {"/G/GS_FAT_A","GS_FAT_A.ACT"},
	[75] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[76] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[77] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[78] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[79] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[80] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[81] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[82] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[83] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[84] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[85] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[86] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[87] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[88] = {"/G/J_MASCOT","J_MASCOT.ACT"},
	[89] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[90] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[91] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[92] = {"/G/J_GRAPPLER_A","J_GRAPPLER_A.ACT"},
	[93] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[94] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[95] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[96] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[97] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[98] = {"/G/PLAYER","PLAYER.ACT"},
	[99] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[100] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[101] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[102] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[103] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[104] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[105] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[106] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[107] = {"/G/CV_OLD","CV_OLD.ACT"},
	[108] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[109] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[110] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[111] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[112] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[113] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[114] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[115] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[116] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[117] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[118] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[119] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[120] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[121] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[122] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[123] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[124] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[125] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[126] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[127] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[128] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[129] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[130] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[131] = {"/G/CV_OLD","CV_OLD.ACT"},
	[132] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[133] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[134] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[135] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[136] = {"/G/AN_RAT","AN_RAT.ACT"},
	[137] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[138] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[139] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[140] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[141] = {"/G/AN_DOG","AN_DOG.ACT"},
	[142] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[143] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[144] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[145] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[146] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[147] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[148] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[149] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[150] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[151] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[152] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[153] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[154] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[155] = {"/G/N_STRIKER_A","N_STRIKER_A.ACT"},
	[156] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[157] = {"/G/CV_OLD","CV_OLD.ACT"},
	[158] = {"/G/LE_ORDERLY_A","LE_ORDERLY_A.ACT"},
	[159] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[160] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[161] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[162] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[163] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[164] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[165] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[166] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[167] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[168] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[169] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[170] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[171] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[172] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[173] = {"/G/G_MELEE_A","G_MELEE_A.ACT"},
	[174] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[175] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[176] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[177] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[178] = {"/G/P_GRAPPLER_A","P_GRAPPLER_A.ACT"},
	[179] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[180] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[181] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[182] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[183] = {"/G/CV_OLD","CV_OLD.ACT"},
	[184] = {"/G/CV_OLD","CV_OLD.ACT"},
	[185] = {"/G/CV_OLD","CV_OLD.ACT"},
	[186] = {"/G/N_STRIKER_A","N_STRIKER_A.ACT"},
	[187] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[188] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[189] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[190] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[191] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[192] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[193] = {"/G/CV_FEMALE_A","CV_FEMALE_A.ACT"},
	[194] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[195] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[196] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[197] = {"/G/DO_GRAPPLER_A","DO_GRAPPLER_A.ACT"},
	[198] = {"/G/DO_GRAPPLER_A","DO_GRAPPLER_A.ACT"},
	[199] = {"/G/DO_STRIKER_A","DO_STRIKER_A.ACT"},
	[200] = {"/G/G_GRAPPLER_A","G_GRAPPLER_A.ACT"},
	[201] = {"/G/G_GRAPPLER_A","G_GRAPPLER_A.ACT"},
	[202] = {"/G/G_STRIKER_A","G_STRIKER_A.ACT"},
	[203] = {"/G/G_MELEE_A","G_MELEE_A.ACT"},
	[204] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[205] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[206] = {"/G/J_GRAPPLER_A","J_GRAPPLER_A.ACT"},
	[207] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[208] = {"/G/N_STRIKER_B","N_STRIKER_B.ACT"},
	[209] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[210] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[211] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[212] = {"/G/P_STRIKER_B","P_STRIKER_B.ACT"},
	[213] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[214] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[215] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[216] = {"/G/J_STRIKER_A","J_STRIKER_A.ACT"},
	[217] = {"/G/G_JOHNNY","G_JOHNNY.ACT"},
	[218] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[219] = {"/G/AN_DOG","AN_DOG.ACT"},
	[220] = {"/G/AN_DOG","AN_DOG.ACT"},
	[221] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[222] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[223] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[224] = {"/G/N_RANGED_A","N_RANGED_A.ACT"},
	[225] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[226] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[227] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[228] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[229] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[230] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[231] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[232] = {"/G/J_MELEE_A","J_MELEE_A.ACT"},
	[233] = {"/G/B_STRIKER_A","B_STRIKER_A.ACT"},
	[234] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[235] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[236] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[237] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[238] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[239] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[240] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[241] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[242] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[243] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[244] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[245] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[246] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[247] = {"/G/P_STRIKER_A","P_STRIKER_A.ACT"},
	[248] = {"/G/AUTHORITY","AUTHORITY.ACT"},
	[249] = {"/G/TE_FEMALE_A","TE_FEMALE_A.ACT"},
	[250] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[251] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[252] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[253] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[254] = {"/G/CV_MALE_A","CV_MALE_A.ACT"},
	[255] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[256] = {"/G/GS_FAT_A","GS_FAT_A.ACT"},
	[257] = {"/G/GS_FEMALE_A","GS_FEMALE_A.ACT"},
	[258] = {"/G/GS_MALE_A","GS_MALE_A.ACT"},
	[579] = {"/G/PLAYER","PLAYER.ACT"},
	[580] = {"/G/PLAYER","PLAYER.ACT"},
	[581] = {"/G/PLAYER","PLAYER.ACT"},
	[582] = {"/G/PLAYER","PLAYER.ACT"},
	[583] = {"/G/PLAYER","PLAYER.ACT"},
	[584] = {"/G/PLAYER","PLAYER.ACT"},
	[585] = {"/G/PLAYER","PLAYER.ACT"},
	[586] = {"/G/PLAYER","PLAYER.ACT"},
	[587] = {"/G/PLAYER","PLAYER.ACT"},
	[588] = {"/G/PLAYER","PLAYER.ACT"},
	[589] = {"/G/PLAYER","PLAYER.ACT"},
	[590] = {"/G/PLAYER","PLAYER.ACT"},
	[591] = {"/G/PLAYER","PLAYER.ACT"},
	[592] = {"/G/PLAYER","PLAYER.ACT"},
	[593] = {"/G/PLAYER","PLAYER.ACT"},
	[594] = {"/G/PLAYER","PLAYER.ACT"},
	[595] = {"/G/PLAYER","PLAYER.ACT"},
	[596] = {"/G/PLAYER","PLAYER.ACT"},
	[597] = {"/G/PLAYER","PLAYER.ACT"},
	[598] = {"/G/PLAYER","PLAYER.ACT"},
	[599] = {"/G/PLAYER","PLAYER.ACT"},
	[600] = {"/G/PLAYER","PLAYER.ACT"},
	[601] = {"/G/PLAYER","PLAYER.ACT"},
	[602] = {"/G/PLAYER","PLAYER.ACT"},
	[603] = {"/G/PLAYER","PLAYER.ACT"},
	[604] = {"/G/PLAYER","PLAYER.ACT"},
	[605] = {"/G/PLAYER","PLAYER.ACT"},
	[606] = {"/G/PLAYER","PLAYER.ACT"},
	[607] = {"/G/PLAYER","PLAYER.ACT"},
	[608] = {"/G/PLAYER","PLAYER.ACT"},
}