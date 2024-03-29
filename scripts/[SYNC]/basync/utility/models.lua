-- model utility

-- [number] = name tables
PED_MODELS = {
	[0] = "player",--[[1] = "DEFAULTPED",]][2] = "DOgirl_Zoe_EG",[3] = "NDGirl_Beatrice",[4] = "NDH1a_Algernon",
	[5] = "NDH1_Fatty",[6] = "ND2nd_Melvin",[7] = "NDH2_Thad",[8] = "NDH3_Bucky",[9] = "NDH2a_Cornelius",
	[10] = "NDLead_Earnest",[11] = "NDH3a_Donald",[12] = "JKH1_Damon",[13] = "JKH1a_Kirby",[14] = "JKGirl_Mandy",
	[15] = "JKH2_Dan",[16] = "JKH2a_Luis",[17] = "JKH3_Casey",[18] = "JKH3a_Bo",[19] = "JKlead_Ted",
	[20] = "JK2nd_Juri",[21] = "GR2nd_Peanut",[22] = "GRH2A_Hal",[23] = "GRlead_Johnny",[24] = "GRH1_Lefty",
	[25] = "GRGirl_Lola",[26] = "GRH3_Lucky",[27] = "GRH1a_Vance",[28] = "GRH3a_Ricky",[29] = "GRH2_Norton",
	[30] = "PRH1_Gord",[31] = "PRH1a_Tad",[32] = "PRH2a_Chad",[33] = "PR2nd_Bif",[34] = "PRH3_Justin",
	[35] = "PRH2_Bryce",[36] = "PRH2_Bryce_OBOX",[37] = "PRlead_Darby",[38] = "PRGirl_Pinky",[39] = "GN_Asiangirl",
	[40] = "PRH3a_Parker",[41] = "DOH2_Jerry",[42] = "DOH1a_Otto",[43] = "DOH2a_Leon",[44] = "DOH1_Duncan",
	[45] = "DOH3_Henry",[46] = "DOH3a_Gurney",[47] = "DO2nd_Omar",[48] = "DOGirl_Zoe",[49] = "PF2nd_Max",
	[50] = "PFH1_Seth",[51] = "PFH2_Edward",[52] = "PFlead_Karl",[53] = "TO_Orderly",[54] = "TE_HallMonitor",
	[55] = "TE_GymTeacher",[56] = "TE_Janitor",[57] = "TE_English",[58] = "TE_Cafeteria",[59] = "TE_Secretary",
	[60] = "TE_Nurse",[61] = "TE_MathTeacher",[62] = "TE_Librarian",[63] = "TE_Art",[64] = "TE_Biology",
	[65] = "TE_Principal",[66] = "GN_Littleblkboy",[67] = "GN_SexyGirl",[68] = "GN_Littleblkgirl",[69] = "GN_Hispanicboy",
	[70] = "GN_Greekboy",[71] = "GN_Fatboy",[72] = "GN_Boy01",[73] = "GN_Boy02",[74] = "GN_Fatgirl",
	[75] = "DOlead_Russell",[76] = "TO_Business1",[77] = "TO_Business2",[78] = "TO_BusinessW1",[79] = "TO_BusinessW2",
	[80] = "TO_RichW1",[81] = "TO_RichW2",[82] = "TO_Fireman",[83] = "TO_Cop",[84] = "TO_Comic",
	[85] = "GN_Bully03",[86] = "TO_Bikeowner",[87] = "TO_Hobo",[88] = "Player_Mascot",[89] = "TO_GroceryOwner",
	[90] = "GN_Sexygirl_UW",[91] = "DOLead_Edgar",[92] = "JK_LuisWrestle",[93] = "JKGirl_MandyUW",[94] = "PRGirl_PinkyUW",
	[95] = "NDGirl_BeatriceUW",[96] = "GRGirl_LolaUW",[97] = "TO_Cop2",[98] = "Player_OWres",[99] = "GN_Bully02",
	[100] = "TO_RichM1",[101] = "TO_RichM2",[102] = "GN_Bully01",[103] = "TO_FireOwner",[104] = "TO_CSOwner_2",
	[105] = "TO_CSOwner_3",[106] = "TE_Chemistry",[107] = "TO_Poorwoman",[108] = "TO_MotelOwner",[109] = "JKKirby_FB",
	[110] = "JKTed_FB",[111] = "JKDan_FB",[112] = "JKDamon_FB",[113] = "TO_Carny02",[114] = "TO_Carny01",
	[115] = "TO_CarnyMidget",[116] = "TO_Poorman2",[117] = "PRH2A_Chad_OBOX",[118] = "PRH3_Justin_OBOX",[119] = "PRH3a_Parker_OBOX",
	[120] = "TO_BarberRich",[121] = "GenericWrestler",[122] = "ND_FattyWrestle",[123] = "TO_Industrial",[124] = "TO_Associate",
	[125] = "TO_Asylumpatient",[126] = "TE_Autoshop",[127] = "TO_Mailman",[128] = "TO_Tattooist",[129] = "TE_Assylum",
	[130] = "Nemesis_Gary",[131] = "TO_Oldman2",[132] = "TO_BarberPoor",[133] = "PR2nd_Bif_OBOX",[134] = "Peter",
	[135] = "TO_RichM3",[136] = "Rat_Ped",[137] = "GN_LittleGirl_2",[138] = "GN_LittleGirl_3",[139] = "GN_WhiteBoy",
	[140] = "TO_FMidget",[141] = "Dog_Pitbull",[142] = "GN_SkinnyBboy",[143] = "TO_Carnie_female",[144] = "TO_Business3",
	[145] = "GN_Bully04",[146] = "GN_Bully05",[147] = "GN_Bully06",[148] = "TO_Business4",[149] = "TO_Business5",
	[150] = "DO_Otto_asylum",[151] = "TE_History",[152] = "TO_Record",[153] = "DO_Leon_Assylum",[154] = "DO_Henry_Assylum",
	[155] = "NDH1_FattyChocolate",[156] = "TO_GroceryClerk",[157] = "TO_Handy",[158] = "TO_Orderly2",[159] = "GN_Hboy_Ween",
	[160] = "Nemesis_Ween",[161] = "GRH3_Lucky_Ween",[162] = "NDH3a_Donald_ween",[163] = "PRH3a_Parker_Ween",[164] = "JKH3_Casey_Ween",
	[165] = "Peter_Ween",[166] = "GN_AsianGirl_Ween",[167] = "PRGirl_Pinky_Ween",[168] = "JKH1_Damon_ween",[169] = "GN_WhiteBoy_Ween",
	[170] = "GN_Bully01_Ween",[171] = "GN_Boy02_Ween",[172] = "PR2nd_Bif_OBOX_D1",[173] = "GRH1a_Vance_Ween",[174] = "NDH2_Thad_Ween",
	[175] = "PRGirl_Pinky_BW",[176] = "DOlead_Russell_BU",[177] = "PRH1a_Tad_BW",[178] = "PRH2_Bryce_BW",[179] = "PRH3_Justin_BW",
	[180] = "GN_Asiangirl_CH",[181] = "GN_Sexygirl_CH",[182] = "PRGirl_Pinky_CH",[183] = "TO_NH_Res_01",[184] = "TO_NH_Res_02",
	[185] = "TO_NH_Res_03",[186] = "NDH1_Fatty_DM",[187] = "TO_PunkBarber",[188] = "FightingMidget_01",[189] = "FightingMidget_02",
	[190] = "TO_Skeletonman",[191] = "TO_Beardedwoman",[192] = "TO_CarnieMermaid",[193] = "TO_Siamesetwin2",[194] = "TO_Paintedman",
	[195] = "TO_GN_Workman",[196] = "DOLead_Edgar_GS",[197] = "DOH3a_Gurney_GS",[198] = "DOH2_Jerry_GS",[199] = "DOH2a_Leon_GS",
	[200] = "GRH2a_Hal_GS",[201] = "GRH2_Norton_GS",[202] = "GR2nd_Peanut_GS",[203] = "GRH1a_Vance_GS",[204] = "JKH3a_Bo_GS",
	[205] = "JKH1_Damon_GS",[206] = "JK2nd_Juri_GS",[207] = "JKH1a_Kirby_GS",[208] = "NDH1a_Algernon_GS",[209] = "NDH3_Bucky_GS",
	[210] = "NDH2_Thad_GS",[211] = "PRH3a_Parker_GS",[212] = "PRH3_Justin_GS",[213] = "PRH1a_Tad_GS",[214] = "PRH1_Gord_GS",
	[215] = "NDLead_Earnest_EG",[216] = "JKlead_Ted_EG",[217] = "GRlead_Johnny_EG",[218] = "PRlead_Darby_EG",[219] = "Dog_Pitbull2",
	[220] = "Dog_Pitbull3",[221] = "TE_CafeMU_W",[222] = "TO_Millworker",[223] = "TO_Dockworker",[224] = "NDH2_Thad_PJ",
	[225] = "GN_Lblkboy_PJ",[226] = "GN_Hboy_PJ",[227] = "GN_Boy01_PJ",[228] = "GN_Boy02_PJ",[229] = "TE_Gym_Incog",
	[230] = "JK_Mandy_Towel",[231] = "JK_Bo_FB",[232] = "JK_Casey_FB",[233] = "PunchBag",[234] = "TO_Cop3",
	[235] = "GN_GreekboyUW",[236] = "TO_Construct01",[237] = "TO_Construct02",[238] = "TO_Cop4",[239] = "PRH2_Bryce_OBOX_D1",
	[240] = "PRH2_Bryce_OBOX_D2",[241] = "PRH2A_Chad_OBOX_D1",[242] = "PRH2A_Chad_OBOX_D2",[243] = "PR2nd_Bif_OBOX_D2",[244] = "PRH3_Justin_OBOX_D1",
	[245] = "PRH3_Justin_OBOX_D2",[246] = "PRH3a_Prkr_OBOX_D1",[247] = "PRH3a_Prkr_OBOX_D2",[248] = "TE_Geography",[249] = "TE_Music",
	[250] = "TO_ElfF",[251] = "TO_ElfM",[252] = "TO_HoboSanta",[253] = "TO_Santa",[254] = "TO_Santa_NB",
	[255] = "Peter_Nutcrack",[256] = "GN_Fatgirl_Fairy",[257] = "GN_Lgirl_2_Flower",[258] = "GN_Hboy_Flower",--[[579] = "spfirst",
	[580] = "special2",[581] = "special3",[582] = "special4",[583] = "special5",[584] = "special6",
	[585] = "special7",[586] = "special8",[587] = "special9",[588] = "special10",[589] = "special11",
	[590] = "special12",[591] = "special13",[592] = "special14",[593] = "special15",[594] = "special16",
	[595] = "special17",[596] = "special18",[597] = "special19",[598] = "special20",[599] = "special21",
	[600] = "special22",[601] = "special23",[602] = "special24",[603] = "special25",[604] = "special26",
	[605] = "special27",[606] = "special28",[607] = "special29",[608] = "splast"]]
}
VEHICLE_MODELS = {
	[272] = "bmxrace",[273] = "retro",[274] = "crapbmx",[275] = "bikecop",[276] = "Scooter",[277] = "bike",[278] = "custombike",
	[279] = "banbike",[280] = "mtnbike",[281] = "oladbike",[282] = "racer",[283] = "aquabike",[284] = "Mower",[285] = "Arc_3",
	[286] = "taxicab",[287] = "Arc_2",[288] = "Dozer",[289] = "GoCart",[290] = "Limo",[291] = "Dlvtruck",[292] = "Foreign",
	[293] = "cargreen",[294] = "70wagon",[295] = "policecar",[296] = "domestic",[297] = "Truck",[298] = "Arc_1"
}

-- other model data
VEHICLE_SEATS = {
	-- 0 = bike, 1 = car, 2+ = car w/ passenger(s)
	[272] = 0, -- bmxrace
	[273] = 0, -- retro
	[274] = 0, -- crapbmx
	[275] = 1, -- bikecop
	[276] = 1, -- Scooter
	[277] = 0, -- bike
	[278] = 0, -- custombike
	[279] = 0, -- banbike
	[280] = 0, -- mtnbike
	[281] = 0, -- oladbike
	[282] = 0, -- racer
	[283] = 0, -- aquabike
	[284] = 1, -- Mower
	[285] = 1, -- Arc_3
	[286] = 2, -- taxicab
	[287] = 1, -- Arc_2
	[288] = 1, -- Dozer
	[289] = 1, -- GoCart
	[290] = 4, -- Limo
	[291] = 2, -- Dlvtruck
	[292] = 2, -- Foreign
	[293] = 2, -- cargreen
	[294] = 2, -- 70wagon
	[295] = 2, -- policecar
	[296] = 2, -- domestic
	[297] = 2, -- Truck
	[298] = 1, -- Arc_1
}
