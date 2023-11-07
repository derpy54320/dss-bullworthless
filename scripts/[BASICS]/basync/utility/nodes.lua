-- node utility

local COMMON
local GLOBAL
local F_GetActNode
local F_GetAiNode
local none = {}

-- utility:
function GetRootActionNode()
	return GLOBAL
end
function PedGetActionNode(ped,hints,hintr) -- returns the node as a string and also the node table for hinting the next call
	if hints and PedIsPlaying(ped,hints,true) then
		return F_GetActNode(ped,hintr,hints.."/")
	end
	return F_GetActNode(ped,GLOBAL,"/G/")
end
function PedGetTaskNode(ped,hints,hintr)
	if hints and PedIsDoingTask(ped,hints,true) then
		return F_GetAiNode(ped,hintr,hints.."/")
	end
	return F_GetAiNode(ped,GLOBAL,"/G/")
end

-- internal:
function F_GetActNode(ped,root,text)
	for k,v in pairs(root) do
		if PedIsPlaying(ped,text..k,true) then
			return F_GetActNode(ped,v,text..k.."/")
		end
	end
	return string.sub(text,1,-2),root -- get rid of trailing /
end
function F_GetAiNode(ped,root,text)
	for k,v in pairs(root) do
		if PedIsDoingTask(ped,text..k,true) then
			return F_GetAiNode(ped,v,text..k.."/")
		end
	end
	return string.sub(text,1,-2),root -- get rid of trailing /
end

-- actions:
if type(shared._derpys_cached_nodes) == "table" then
	GLOBAL = shared._derpys_cached_nodes
	return
end
COMMON = { -- saves ~917 KB
	{ -- 4
		EVADE = none,
	},
	{ -- 42
		COMBAT = {
			SPINECONTROL = {
				AUTHORITY = none,
				DEFAULT = none,
			},
			CHEERSTRAFE = {
				CHEERUPPERBODY = {
					CHEERUPPER3 = none,
					CHEERUPPER2 = none,
					CHEERUPPER1 = none,
				},
			},
			STRAFEBASE = {
				STRAFEBASIC = {
					STRAFEBASICLOCOOPP = none,
				},
			},
			CLOSERANGESTRAFE = none,
			STRAFEIDLE = {
				NEEDSACCURATEHEADING = none,
			},
			LONGRANGESTRAFE = none,
		},
		CROUCH = {
			CROUCHLOCORUN = none,
			CROUCHLOCO = none,
			CROUCHIDLE = {
				CROUCHRELEASE = none,
			},
		},
		HANDHOLDING = {
			GIRL = {
				RUN = none,
				IDLE = none,
				WALK = {
					LOCO = {
						ISALLYFOLLOWER = none,
						HASALLYFOLLOWER = none,
					},
				},
			},
			OLD = {
				IDLE = none,
				WALK = {
					LOCO = {
						ISALLYFOLLOWER = none,
						HASALLYFOLLOWER = none,
					},
				},
			},
			GUY = {
				RUN = none,
				IDLE = none,
				WALK = {
					LOCO = {
						ISALLYFOLLOWER = none,
						HASALLYFOLLOWER = none,
					},
				},
			},
			FAT = {
				RUN = none,
				IDLE = none,
				WALK = {
					LOCO = {
						ISALLYFOLLOWER = none,
						HASALLYFOLLOWER = none,
					},
				},
			},
		},
		CROUCHACTIONOPPSBASE = none,
		CROUCHACTIONOPPS = none,
		FREE = {
			RUN = none,
			SPRINT = {
				TIRED = {
					TIREDSPEECH = none,
				},
				SPRINTSLOW = none,
				SPRINT = none,
				SPRINTGESTURE = {
					SPRINTGESTURE = {
						SHAKEFIST = {
							SHAKEFISTSPEECH = {
								SHAKEFISTSB = none,
								SHAKEFISTSPEECHADULT = {
									SHAKEFISTSB1 = none,
									SHAKEFISTSB2 = none,
								},
							},
						},
					},
				},
			},
			WALK = none,
			IDLE = {
				SPINECONTROL = {
					IDLE = none,
				},
				IDLE_CHECK = {
					IDLE_REGULAR = none,
					IDLE_SOCIAL = {
						GENERICS = {
							FAIL = none,
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEINTIMIDATED = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
						NERDS = {
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEINTIMIDATED = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
						AUTHORITY = {
							SOCIALIDLEUNFRIENDLY = none,
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEAGGRESSIVE = none,
						},
						UBO_CHECKS = {
							UBO_EXECUTE = none,
						},
						OLD = {
							FAIL = none,
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEINTIMIDATED = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
						TOUGHFACTIONS = {
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEUNFRIENDLY = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
						GIRLS = {
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEDISMISSIVE = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
						FAT = {
							FAIL = none,
							SOCIALIDLEFRIENDLY = none,
							SOCIALIDLEINTIMIDATED = none,
							SOCIALIDLEAGGRESSIVE = none,
							SOCIALIDLESCARED = none,
						},
					},
					IDLE_STEALTH = none,
				},
			},
		},
		ACTIONOPPS = none,
	},
	{ -- 2
		FREE = {
			PREPPY_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			RUNBASIC = none,
			WALKBASIC = {
				WALKWEENVAMP = none,
			},
			SPRINTBASIC = {
				SPRINTBASICTAD208 = none,
				SPRINTBASIC = none,
			},
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						ACTIONBRIDGE = none,
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					UPPERBODY = {
						GRAPPLER = none,
						STRIKER = none,
					},
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				COMBATSTRAFEIDLE = {
					IDLESPAWN = {
						GRAPPLER = {
							IDLE_A = none,
							IDLE_B = none,
							IDLE_D = none,
							IDLE_C = none,
						},
						STRIKER = {
							IDLE_C = none,
							IDLE_A = none,
							IDLE_B = none,
						},
					},
				},
				WEAPONCOMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 10
		GRAPPLESATTEMPT = none,
	},
	{ -- 3
		HEAVYPUNCHCHARGE = {
			HEAVYPUNCH = none,
		},
	},
	{ -- 2
		TAUNT_1 = none,
	},
	{ -- 2
		HOPBACK = none,
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		EXECUTENODES = {
			FREE = {
				DEFAULT_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							FAT = {
								GENERIC = {
									WALKIDLESEXECUTE = none,
								},
								FACTION_SPECIFIC = {
									FACTION_IDLE2 = none,
									FACTION_IDLE1 = none,
								},
								NOOVERRIDE = none,
							},
							GEN = {
								GENERIC = {
									WALKIDLESEXECUTE = none,
								},
								DONOTHING = none,
							},
						},
					},
				},
				RUNBASIC = {
					FAT = none,
					GEN = none,
				},
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						AUTHORITY = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKD = {
										IDLES = {
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_A_OPP = none,
													IDLE_D = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
						ADULT = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
						FAT = {
							ACTIONSGIRL = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_A_OPP = none,
													IDLE_D = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_A_OPP = none,
													IDLE_D = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
										},
									},
								},
							},
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
						GENERIC = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
					},
				},
				WALKBASIC = {
					FAT = none,
					WALKBASIC = {
						WALKWEEN = none,
					},
					HOBODRUNK = {
						WALKBASIC = none,
					},
				},
				SPRINTBASIC = {
					AUTHORITY = none,
					FAT = none,
					GEN = none,
				},
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = {
						BILLYCLUBCOMBATBASIC = none,
						BATCOMBATBASIC = none,
						COMBATBASIC = none,
					},
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = {
					GREASERCOMBATSTRAFEIDLE = none,
					WEAPONCOMBATSTRAFEIDLE = none,
					PREFECTCOMBATSTRAFEIDLE = none,
					COMBATSTRAFEIDLE = none,
					JOCKCOMBATSTRAFEIDLE = none,
				},
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
		IDLE = none,
		RISINGATTACKS = none,
	},
	{ -- 3
		SLOPPYJAB = {
			SLOPPYCROSS = none,
		},
	},
	{ -- 3
		SHOVE2HAND = none,
	},
	{ -- 2
		BLOCK = {
			BLOCKHITS = {
				BREAKER = none,
				HITSLIGHT = none,
			},
		},
	},
	{ -- 2
		UPPERLANDGV = none,
		UPPERLANDRCV = none,
	},
	{ -- 3
		HEAVYPUNCH = none,
	},
	{ -- 2
		HOOK2LAND = none,
	},
	{ -- 3
		FINISHINGCROSS = none,
	},
	{ -- 2
		HOOK = {
			HOOK1LAND = none,
		},
	},
	{ -- 8
		TIRED = none,
	},
	{ -- 3
		DASHLOCO = none,
	},
	{ -- 2
		WEAVER = none,
	},
	{ -- 2
		JAB = {
			CROSS = none,
		},
	},
	{ -- 2
		GETWEAPON = {
			RELEASE = {
				EMPTY = none,
			},
		},
		THROWLOOP = none,
	},
	{ -- 42
		SPINECONTROL = {
			AUTHORITY = none,
			DEFAULT = none,
		},
		CHEERSTRAFE = {
			CHEERUPPERBODY = {
				CHEERUPPER3 = none,
				CHEERUPPER2 = none,
				CHEERUPPER1 = none,
			},
		},
		STRAFEBASE = {
			STRAFEBASIC = {
				STRAFEBASICLOCOOPP = none,
			},
		},
		CLOSERANGESTRAFE = none,
		STRAFEIDLE = {
			NEEDSACCURATEHEADING = none,
		},
		LONGRANGESTRAFE = none,
	},
	{ -- 44
		CROUCHLOCORUN = none,
		CROUCHLOCO = none,
		CROUCHIDLE = {
			CROUCHRELEASE = none,
		},
	},
	{ -- 42
		GIRL = {
			RUN = none,
			IDLE = none,
			WALK = {
				LOCO = {
					ISALLYFOLLOWER = none,
					HASALLYFOLLOWER = none,
				},
			},
		},
		OLD = {
			IDLE = none,
			WALK = {
				LOCO = {
					ISALLYFOLLOWER = none,
					HASALLYFOLLOWER = none,
				},
			},
		},
		GUY = {
			RUN = none,
			IDLE = none,
			WALK = {
				LOCO = {
					ISALLYFOLLOWER = none,
					HASALLYFOLLOWER = none,
				},
			},
		},
		FAT = {
			RUN = none,
			IDLE = none,
			WALK = {
				LOCO = {
					ISALLYFOLLOWER = none,
					HASALLYFOLLOWER = none,
				},
			},
		},
	},
	{ -- 42
		RUN = none,
		SPRINT = {
			TIRED = {
				TIREDSPEECH = none,
			},
			SPRINTSLOW = none,
			SPRINT = none,
			SPRINTGESTURE = {
				SPRINTGESTURE = {
					SHAKEFIST = {
						SHAKEFISTSPEECH = {
							SHAKEFISTSB = none,
							SHAKEFISTSPEECHADULT = {
								SHAKEFISTSB1 = none,
								SHAKEFISTSB2 = none,
							},
						},
					},
				},
			},
		},
		WALK = none,
		IDLE = {
			SPINECONTROL = {
				IDLE = none,
			},
			IDLE_CHECK = {
				IDLE_REGULAR = none,
				IDLE_SOCIAL = {
					GENERICS = {
						FAIL = none,
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEINTIMIDATED = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
					NERDS = {
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEINTIMIDATED = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
					AUTHORITY = {
						SOCIALIDLEUNFRIENDLY = none,
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEAGGRESSIVE = none,
					},
					UBO_CHECKS = {
						UBO_EXECUTE = none,
					},
					OLD = {
						FAIL = none,
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEINTIMIDATED = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
					TOUGHFACTIONS = {
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEUNFRIENDLY = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
					GIRLS = {
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEDISMISSIVE = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
					FAT = {
						FAIL = none,
						SOCIALIDLEFRIENDLY = none,
						SOCIALIDLEINTIMIDATED = none,
						SOCIALIDLEAGGRESSIVE = none,
						SOCIALIDLESCARED = none,
					},
				},
				IDLE_STEALTH = none,
			},
		},
	},
	{ -- 5
		PREPPY_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
			},
		},
		RUNBASIC = none,
		WALKBASIC = {
			WALKWEENVAMP = none,
		},
		SPRINTBASIC = {
			SPRINTBASICTAD208 = none,
			SPRINTBASIC = none,
		},
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					ACTIONBRIDGE = none,
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 43
		CUSTOMACTIONOPS = none,
	},
	{ -- 6
		COMBAT = {
			COMBATBASIC = none,
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = {
			COMBATSTRAFEIDLE = none,
		},
	},
	{ -- 3
		NOBALL = none,
	},
	{ -- 61
		IDLE = none,
	},
	{ -- 3
		PURCHASE = none,
	},
	{ -- 6
		BROWSE = none,
	},
	{ -- 3
		BROKE = none,
	},
	{ -- 3
		SHOP = {
			STARTSTOREMODE = none,
		},
	},
	{ -- 3
		STOCK = none,
	},
	{ -- 2
		CANCEL = none,
	},
	{ -- 20
		RIGHT = none,
	},
	{ -- 20
		LEFT = none,
	},
	{ -- 7
		RELEASE = none,
	},
	{ -- 4
		MOUNTEXECUTE = none,
	},
	{ -- 2
		GROUNDSTOMP = none,
	},
	{ -- 3
		JACKIEKICK = {
			JACKIEKICKLAND = none,
		},
	},
	{ -- 2
		SCRIPTEXECUTE = none,
	},
	{ -- 2
		POWERBOMB = {
			GIVE = none,
			RCV = none,
		},
	},
	{ -- 3
		TAKEDOWN = {
			BACK = {
				GIVE = none,
				RCV = none,
			},
			FRONT = {
				TOMOUNT = {
					GIVE = none,
					RCV = none,
				},
			},
			RCV_WAIT = none,
		},
	},
	{ -- 3
		BACK = {
			GIVE = none,
			RCV = none,
		},
		FRONT = {
			TOMOUNT = {
				GIVE = none,
				RCV = none,
			},
		},
		RCV_WAIT = none,
	},
	{ -- 3
		SCAFFOLD_01 = none,
		SCAFFOLD_02 = none,
	},
	{ -- 55
		GIVE = none,
		RCV = none,
	},
	{ -- 4
		TOMOUNT = {
			GIVE = none,
			RCV = none,
		},
	},
	{ -- 2
		FALL_LAND = none,
	},
	{ -- 2
		RELEASE = {
			EMPTY = none,
		},
	},
	{ -- 42
		AUTHORITY = none,
		DEFAULT = none,
	},
	{ -- 43
		CHEERUPPERBODY = {
			CHEERUPPER3 = none,
			CHEERUPPER2 = none,
			CHEERUPPER1 = none,
		},
	},
	{ -- 46
		STRAFEBASIC = {
			STRAFEBASICLOCOOPP = none,
		},
	},
	{ -- 42
		NEEDSACCURATEHEADING = none,
	},
	{ -- 65
		CROUCHRELEASE = none,
	},
	{ -- 126
		RUN = none,
		IDLE = none,
		WALK = {
			LOCO = {
				ISALLYFOLLOWER = none,
				HASALLYFOLLOWER = none,
			},
		},
	},
	{ -- 42
		IDLE = none,
		WALK = {
			LOCO = {
				ISALLYFOLLOWER = none,
				HASALLYFOLLOWER = none,
			},
		},
	},
	{ -- 168
		LOCO = {
			ISALLYFOLLOWER = none,
			HASALLYFOLLOWER = none,
		},
	},
	{ -- 168
		ISALLYFOLLOWER = none,
		HASALLYFOLLOWER = none,
	},
	{ -- 42
		TIRED = {
			TIREDSPEECH = none,
		},
		SPRINTSLOW = none,
		SPRINT = none,
		SPRINTGESTURE = {
			SPRINTGESTURE = {
				SHAKEFIST = {
					SHAKEFISTSPEECH = {
						SHAKEFISTSB = none,
						SHAKEFISTSPEECHADULT = {
							SHAKEFISTSB1 = none,
							SHAKEFISTSB2 = none,
						},
					},
				},
			},
		},
	},
	{ -- 42
		SPINECONTROL = {
			IDLE = none,
		},
		IDLE_CHECK = {
			IDLE_REGULAR = none,
			IDLE_SOCIAL = {
				GENERICS = {
					FAIL = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				NERDS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				AUTHORITY = {
					SOCIALIDLEUNFRIENDLY = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEAGGRESSIVE = none,
				},
				UBO_CHECKS = {
					UBO_EXECUTE = none,
				},
				OLD = {
					FAIL = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				TOUGHFACTIONS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEUNFRIENDLY = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				GIRLS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEDISMISSIVE = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				FAT = {
					FAIL = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
			},
			IDLE_STEALTH = none,
		},
	},
	{ -- 3
		FREE = {
			DEFAULT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						NOOVERRIDE = none,
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
					},
				},
			},
			RUNBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
				},
			},
			WALKBASIC = {
				WALKBASIC = {
					WALKWEEN = none,
				},
			},
			SPRINTBASIC = {
				RUSSELL6_03 = none,
				SPRINTBASIC = none,
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					BILLYCLUBCOMBATBASIC = none,
					BATCOMBATBASIC = none,
					COMBATBASIC = none,
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				GREASERCOMBATSTRAFEIDLE = none,
				WEAPONCOMBATSTRAFEIDLE = none,
				PREFECTCOMBATSTRAFEIDLE = none,
				COMBATSTRAFEIDLE = none,
				JOCKCOMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 11
		LONG = {
			ATTACKEXECUTE = none,
		},
		RUNNINGATTACKS = none,
		MEDIUM = {
			ATTACKEXECUTE = none,
		},
		SHORT = {
			ATTACKEXECUTE = none,
		},
	},
	{ -- 5
		ANIMATIONS = {
			WEAPONWALK = {
				COMBAT = none,
				DEFAULT = none,
			},
			WEAPONBIKEIDLE = none,
			WEAPONSOCIAL = {
				WEAPONIDLE = none,
				PERFORMINGACTION = none,
			},
			WEAPONCROUCH = none,
			WEAPONRUN = none,
			WEAPONSTRAFE = none,
			WEAPONIDLE = {
				COMBAT = none,
				DEFAULT = none,
			},
		},
		GLOBALLOCO = {
			LOCOMOTION = {
				SPRINTDEPLETE = {
					SPRINTDEPLETEEXEC = none,
				},
				WALK = {
					TIRED = {
						TIRED_UBO = none,
						WALKTIRED = none,
					},
					SNEAK = {
						STEALTHWALKSTART = {
							ANIM = none,
						},
						STEALTHWALK = {
							RUNSTART = none,
							WALKSTOP = none,
						},
					},
					NOTTIRED = {
						WALKSTART = none,
						WALK = none,
						WALKSTOP = none,
					},
					ALLY = {
						WALKALLY = none,
					},
					FEMALE = {
						WALKBASIC = none,
					},
				},
				COMBAT = {
					COMBATTRANSITION = {
						COMBATIDLE_OUT = {
							COMBATIDLE_OUT = none,
							STRAFE = none,
						},
						COMBATSTART = {
							IDLE = none,
							STRAFE = {
								ANIM = none,
							},
						},
					},
					DEFAULT = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = {
								ANIM = none,
								NOANIM = none,
							},
						},
					},
					EXECNODES = {
						COMBATIDLETURN = {
							FACINGINTENDED = {
								CCW_SLOW = {
									CCW = none,
									WAIT = none,
									END = none,
								},
								RESET = none,
								FORWARDS = none,
								CW_SLOW = {
									CW = none,
									END = none,
									WAIT = none,
								},
							},
						},
						TARGET = {
							STRAFEMODE = none,
							LOCK = none,
						},
					},
					["0_BLOCK_0"] = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATIDLEBLOCK = none,
						BLOCKSTRAFE = none,
					},
				},
				LOCOMOTIONEXECUTES = {
					CROUCHLOCOTARGET = none,
					NONCOMBATSTRAFE = {
						NC_LOCO = {
							COMBATIDLE_OUT = none,
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
							IDLE = {
								IDLE_ANIM = {
									ANIM = none,
									SOCIALIZING = none,
								},
							},
							NONCOMBATSTRAFEANIMS = {
								WALKSTOP = none,
							},
						},
					},
					STRAFELOCOBASIC = {
						NOSTEERING = none,
						STEERING = none,
					},
					STRAFELOCOBASICANIMS = {
						MELEE = none,
						WEAPON = none,
					},
					RUN_STARTLOCO = {
						DEFAULT = none,
						TURNFAST = none,
					},
					WALK_STARTLOCO = none,
					TIRED_UPPERBODY = none,
					WALKBASIC = none,
					EXHAUSTED_COLLAPSE = {
						EXHAUSTED_COLLAPSE_LOADCHECK = {
							COLLAPSE = {
								COLLAPSELOAD = {
									COLLAPSE = none,
									GRAPPLETARGET = none,
								},
								COLLAPSEOFFLADDER = {
									FALL = none,
								},
								COLLAPSEOFFTREEBRANCH = {
									DOWN = {
										DOWN_END = none,
									},
								},
								COLLAPSEOFFTREEHANG = {
									DOWN = none,
								},
							},
						},
					},
				},
				OFFSETCAM = {
					OFFSETCAM_WEAPON = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = none,
						},
					},
					OFFSETCAM_LOCO = none,
				},
				RUN = {
					RUN = {
						RUNCONTROLLER = {
							RUN = {
								RUN = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
							SPRINT = {
								SPRINTBASIC = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
						},
					},
					TIRED_STOP = none,
					NEWLOCOANIMS = {
						RUNLOCOANIMS = none,
						TIRED_UPPERBODY_SPAWN = {
							NOTTIRED = none,
							TIRED = none,
						},
						TIRED_UPPERBODY = none,
						SPRINTLOCOANIMS = none,
					},
					RUNSTOP = {
						WALKSTOP_WAIT = none,
						RUNSTOP = {
							SKID = {
								RUN_TO_IDLE = {
									LOCO = {
										WINTER = none,
										NORMAL = none,
									},
								},
								SPRINT_SLIDE = none,
							},
						},
						RUNSTOP_WAIT = none,
					},
					RUNSTART = {
						RUNSTART = none,
					},
				},
				CROUCH = {
					CROUCHIDLE = {
						CROUCHIDLE = none,
						CROUCHAIM = {
							TURN = {
								FACINGINTENDED = {
									CCW_SLOW = {
										CCW = none,
										WAIT = none,
										END = none,
									},
									RESET = none,
									FORWARDS = none,
									CW_SLOW = {
										CW = none,
										END = none,
										WAIT = none,
									},
								},
							},
						},
						CROUCHIDLETARGET = none,
					},
					CROUCHEND = {
						CROUCH_OUT_COMBAT = {
							CROUCH_OUT_TARGET = none,
						},
						CROUCH_OUT = none,
					},
					CROUCHSTART = {
						CROUCHSTARTCOMBAT = none,
						CROUCHSTART = none,
					},
					CROUCHLOCO = {
						CROUCHLOCOTARGET = none,
						CROUCHLOCO = {
							CROUCHLOCOANIMS = {
								CROUCHLOCORUN = none,
								CROUCHLOCOBASIC = none,
							},
							RUNCONTROLLER = {
								CROUCHRUN = none,
								CROUCHLOCO = none,
							},
						},
					},
					CROUCH_TIRED = {
						TIRED_UBO = none,
					},
					CRAWLLOCO = {
						CRAWLSTART = {
							CRAWLCYCLE = {
								CROUCHRELEASE = none,
							},
						},
					},
				},
				IDLE = {
					VTIRED = {
						VTIREDACTIONS = {
							AMBIENTACTIONS_VTIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					FEMALE = none,
					TURN = {
						FACINGINTENDED = {
							CW_SLOW_OLD = {
								CW = none,
								END = none,
								WAIT = none,
							},
							RESET = none,
							CCW_SLOW_FEMALE = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS_ACCURATE = none,
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS = none,
							CW_SLOW_FEMALE = {
								CW = none,
								END = none,
								WAIT = none,
							},
							CCW_SLOW_OLD = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
					EXHAUSTED = none,
					TIRED = {
						TIREDACTIONS = {
							AMBIENTACTIONS_TIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					IDLE = {
						AMBIENTACTIONS = {
							AMBIENTACTIONS_GROUPLOAD2 = {
								AMBIENTACTIONS = {
									AMBIENT_9 = none,
									AMBIENT_10 = none,
									AMBIENT_12 = none,
									AMBIENT_11 = none,
									AMBIENT_8 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD1 = {
								AMBIENTACTIONS = {
									AMBIENT_4 = none,
									AMBIENT_6 = none,
									AMBIENT_2 = none,
									AMBIENT_1 = none,
									AMBIENT_7 = none,
									AMBIENT_5 = none,
									AMBIENT_3 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD3 = {
								AMBIENTACTIONS = {
									ARMSONHIPS = none,
									SCRATCHARSE = none,
									SCRATCHHEAD = none,
									SCRATCHPIT = none,
									STRETCH = none,
								},
							},
						},
						MIRRORIDLE = {
							MIRROR_LOAD = {
								MIRRORACTIONS = {
									MIRRORACTIONS2 = none,
									MIRRORACTIONS3 = none,
									MIRRORACTIONS4 = none,
									MIRRORACTIONS1 = none,
								},
							},
						},
						WARMTHFACTOR = {
							FREEZING = {
								DAMAGE = none,
							},
						},
						AMBIENTSPAWN = {
							AMBIENTSPAWN = {
								OPPS = none,
							},
						},
						IDLESPEECH = {
							WAIT = none,
							SAYSOMETHING = {
								VTIRED = none,
								TIRED = none,
								NORMAL = none,
							},
						},
					},
				},
				SOCIAL = {
					SOCIAL_ACTIONS = none,
					SOCIAL = none,
				},
				HANDHOLDING = {
					IDLE = none,
					WALK = {
						WALK_SPEEDS = {
							HANDHOLDING = none,
							OLDPED = none,
						},
						WALKSTOP = none,
					},
				},
			},
		},
	},
	{ -- 2
		EVADEBACKPUNCH = none,
	},
	{ -- 46
		STRAFEBASICLOCOOPP = none,
	},
	{ -- 3
		LOOKAROUND = {
			LOOKAROUND_SPAWNER = none,
			LOOKLAYER_2 = {
				OVERALLTIME = {
					["8SEC"] = none,
					["10SEC"] = none,
					["6SEC"] = none,
				},
				DOWN = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				UP = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				RIGHT = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				LEFT = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
			},
			LOOKLAYER_1 = {
				RIGHT2 = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				RIGHT = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				LEFT2 = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
				LEFT = {
					LONG = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					SHORT = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
				},
			},
			LOOK_B = {
				UP = {
					UP = {
						LOOK2ND = {
							DOWN = {
								DOWN = none,
							},
							RIGHT = {
								RIGHT = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				DOWN = {
					DOWN = {
						LOOK2ND = {
							RIGHT = {
								RIGHT = none,
							},
							UP = {
								UP = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				RIGHT = {
					RIGHT = {
						LOOK2ND = {
							DOWN = {
								DOWN = none,
							},
							UP = {
								UP = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				LEFT = {
					LEFT = {
						LOOK2ND = {
							DOWN = {
								DOWN = none,
							},
							RIGHT = {
								RIGHT = none,
							},
							UP = {
								UP = none,
							},
						},
					},
				},
			},
			IDLE_BASE = {
				PREP = none,
				JOCK = none,
				NERD = none,
				GREAS = none,
				BULLY = none,
			},
			LOOK_A = {
				RIGHT2 = {
					RIGHT2 = {
						LOOK2ND = {
							RIGHT = {
								RIGHT = none,
							},
							LEFT2 = {
								LEFT2 = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				RIGHT = {
					RIGHT = {
						LOOK2ND = {
							RIGHT2 = {
								RIGHT2 = none,
							},
							LEFT2 = {
								LEFT2 = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				LEFT2 = {
					LEFT2 = {
						LOOK2ND = {
							RIGHT = {
								RIGHT = none,
							},
							RIGHT2 = {
								RIGHT2 = none,
							},
							LEFT = {
								LEFT = none,
							},
						},
					},
				},
				LEFT = {
					LEFT = {
						LOOK2ND = {
							RIGHT = {
								RIGHT = none,
							},
							LEFT2 = {
								LEFT2 = none,
							},
							RIGHT2 = {
								RIGHT2 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 48
		SOCIALIDLEFRIENDLY = none,
		SOCIALIDLEINTIMIDATED = none,
		SOCIALIDLEAGGRESSIVE = none,
		SOCIALIDLESCARED = none,
	},
	{ -- 3
		UNARMED = {
			UNARMED_LOOP = none,
		},
		WEAPON = {
			PERFORMINGACTIONLHANDWEAP = {
				PERFORMINGACTION = none,
			},
			PERFORMINGACTION = {
				PERFORMINGACTION = none,
			},
		},
	},
	{ -- 47
		SOCIALIDLEFRIENDLY = none,
		SOCIALIDLEUNFRIENDLY = none,
		SOCIALIDLEAGGRESSIVE = none,
		SOCIALIDLESCARED = none,
	},
	{ -- 47
		SOCIALIDLEFRIENDLY = none,
		SOCIALIDLEDISMISSIVE = none,
		SOCIALIDLEAGGRESSIVE = none,
		SOCIALIDLESCARED = none,
	},
	{ -- 47
		SOCIALIDLEUNFRIENDLY = none,
		SOCIALIDLEFRIENDLY = none,
		SOCIALIDLEAGGRESSIVE = none,
	},
	{ -- 2
		FREE = {
			PREPPY_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			RUNBASIC = none,
			WALKBASIC = {
				WALKWEENVAMP = none,
			},
			SPRINTBASIC = {
				SPRINTBASICTAD208 = none,
				SPRINTBASIC = none,
			},
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						ACTIONBRIDGE = none,
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = none,
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				COMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 2
		LIGHTATTACKS = {
			JAB = {
				CROSS = none,
			},
			LEFTHOOK = {
				FINISHINGCROSS = none,
			},
		},
		HEAVYATTACKS = {
			UPPERCUT = none,
		},
	},
	{ -- 2
		HEAVYATTACKS = {
			SHOULDERANDPUNCH = none,
		},
	},
	{ -- 43
		CHEERUPPER3 = none,
		CHEERUPPER2 = none,
		CHEERUPPER1 = none,
	},
	{ -- 42
		TIREDSPEECH = none,
	},
	{ -- 42
		SPRINTGESTURE = {
			SHAKEFIST = {
				SHAKEFISTSPEECH = {
					SHAKEFISTSB = none,
					SHAKEFISTSPEECHADULT = {
						SHAKEFISTSB1 = none,
						SHAKEFISTSB2 = none,
					},
				},
			},
		},
	},
	{ -- 42
		IDLE_REGULAR = none,
		IDLE_SOCIAL = {
			GENERICS = {
				FAIL = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			NERDS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			AUTHORITY = {
				SOCIALIDLEUNFRIENDLY = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEAGGRESSIVE = none,
			},
			UBO_CHECKS = {
				UBO_EXECUTE = none,
			},
			OLD = {
				FAIL = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			TOUGHFACTIONS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEUNFRIENDLY = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			GIRLS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEDISMISSIVE = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			FAT = {
				FAIL = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
		},
		IDLE_STEALTH = none,
	},
	{ -- 5
		GREASER_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
			},
		},
		RUNBASIC = none,
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
					},
				},
			},
		},
		SPRINTBASIC = {
			["306PEANUTSPRINT"] = none,
			SPRINTBASIC = none,
		},
		WALKBASIC = {
			WALKBASICWEEN = none,
		},
	},
	{ -- 10
		COMBAT = {
			COMBATBASIC = none,
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = none,
	},
	{ -- 2
		HEAVYATTACKS = none,
	},
	{ -- 5
		UPPERCUT = none,
	},
	{ -- 42
		SHAKEFIST = {
			SHAKEFISTSPEECH = {
				SHAKEFISTSB = none,
				SHAKEFISTSPEECHADULT = {
					SHAKEFISTSB1 = none,
					SHAKEFISTSB2 = none,
				},
			},
		},
	},
	{ -- 42
		GENERICS = {
			FAIL = none,
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEINTIMIDATED = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
		NERDS = {
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEINTIMIDATED = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
		AUTHORITY = {
			SOCIALIDLEUNFRIENDLY = none,
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEAGGRESSIVE = none,
		},
		UBO_CHECKS = {
			UBO_EXECUTE = none,
		},
		OLD = {
			FAIL = none,
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEINTIMIDATED = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
		TOUGHFACTIONS = {
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEUNFRIENDLY = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
		GIRLS = {
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEDISMISSIVE = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
		FAT = {
			FAIL = none,
			SOCIALIDLEFRIENDLY = none,
			SOCIALIDLEINTIMIDATED = none,
			SOCIALIDLEAGGRESSIVE = none,
			SOCIALIDLESCARED = none,
		},
	},
	{ -- 2
		RUNBASIC = none,
		SPRINTBASIC = none,
		WALKBASIC = none,
	},
	{ -- 22
		COMBATBASIC = none,
		STRAFEIDLE = none,
	},
	{ -- 2
		RUNNINGTAKEDOWN = none,
	},
	{ -- 42
		SHAKEFISTSPEECH = {
			SHAKEFISTSB = none,
			SHAKEFISTSPEECHADULT = {
				SHAKEFISTSB1 = none,
				SHAKEFISTSB2 = none,
			},
		},
	},
	{ -- 134
		FAIL = none,
		SOCIALIDLEFRIENDLY = none,
		SOCIALIDLEINTIMIDATED = none,
		SOCIALIDLEAGGRESSIVE = none,
		SOCIALIDLESCARED = none,
	},
	{ -- 44
		UBO_EXECUTE = none,
	},
	{ -- 3
		FREE = {
			WALKBASIC = none,
			RUNBASIC = none,
			JOCK_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			SPRINTBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_D = none,
											IDLE_E_OPP = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
									IDLE_E = {
										IDLE_E = {
											IDLE_A_OPP = none,
											IDLE_E = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					BILLYCLUBCOMBATBASIC = none,
					BATCOMBATBASIC = none,
					COMBATBASIC = none,
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				GREASERCOMBATSTRAFEIDLE = none,
				WEAPONCOMBATSTRAFEIDLE = none,
				PREFECTCOMBATSTRAFEIDLE = none,
				COMBATSTRAFEIDLE = none,
				JOCKCOMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 7
		TAUNTPLAYER = none,
	},
	{ -- 74
		END = none,
	},
	{ -- 2
		ACTIVECOMBAT = {
			PURSUITLOCO = none,
			CLOSEDRANGELOCO = none,
		},
		OBSERVER = {
			ENGAGED = none,
			CHASEFIGHT = none,
			OBSERVER = none,
		},
		GETWEAPON = {
			PICKUPWEAPON = none,
		},
	},
	{ -- 9
		MOVEOBJECTIVE = none,
		FOLLOWPATH = none,
		IDLE = none,
		FACEOBJECTIVE = none,
	},
	{ -- 6
		GREET = {
			GIRFRIEND = {
				GFGREET = {
					GFSOCIALCHOICE = {
						GFSOCIALCHOICELONG = none,
						GFSOCIALCHOICENORM = none,
					},
					GIRLFRIENDSOCIAL = none,
				},
				GIRFRIENDSEE = {
					GIRFRIENDSEEHH = {
						GIRFRIENDATTACKCHOICE = {
							GIRFRIENDATTACKBOY = {
								GIRFRIENDATTACKBOY = none,
								GIRFRIENDATTACKPLAYER = none,
							},
							GIRFRIENDATTACKALLY = none,
							GIRFRIENDATTACKPLAYER = none,
						},
						SFSEESPEECH = {
							THARASS = none,
							COMPLAIN = none,
						},
					},
				},
			},
			DISLIKE = {
				DISLIKECHOICES = {
					HARASSCOND = {
						STEALOPP = none,
						HARASS = {
							HARASSRANGE = {
								HARASSHIT = {
									HARASSCHOICE = {
										TAUNTAFTER = none,
									},
								},
								HARASSRANGEWEAPON = {
									HARASSRANGEEQUIP = none,
									HARASSRANGEUSE = none,
								},
							},
							HUNT = none,
						},
						TAUNTCHECK = {
							TAUNT = none,
						},
						HUMILIATE = {
							HUMILNODE = none,
							BOOKSTEALEXEC = none,
						},
					},
					TAUNTCHECK = {
						TAUNT = none,
					},
				},
			},
			CLOTHINGGREET = {
				CLOTHINGGIMMICK = {
					CLOTHINGGIMMICKFACE = {
						CLOTHINGGIMMICKSPEECH = {
							GIMMICKLAUGH = none,
							GIMMICKSPEAK = none,
						},
					},
				},
			},
			NEWKID = {
				NEWKIDTAUNT = {
					TAUNTPLAYER = none,
				},
			},
		},
		BEEF = {
			BEEFEXIT = {
				BEEFCLEARFLAG = none,
			},
			BEEFACTIONS = {
				BS1WAIT = {
					BS1RESPONSES = {
						BS1TAUNT = {
							BS1TAUNTBACKDOWN = none,
							BS1HARASS = none,
							BS1TAUNTBACK = none,
						},
					},
				},
			},
			BEEFSTART = {
				BEEFAPPROACH = {
					BEEFRESPONSE1 = none,
				},
			},
		},
		CRIMINAL = {
			BREAKPROPS = {
				SETPROPOBJ = none,
			},
			STEALBIKE = {
				TAKEBIKE = {
					MOUNTBIKE = none,
				},
			},
			STEALBOOKS = {
				STEALBOOKSSEEK = {
					STEALBOOKSTEAL = {
						POSTSTEALCHOICES = {
							POSTSTEALTHROWACTION = none,
							POSTSTEALFLEE = none,
						},
					},
				},
			},
			USEPRANK = {
				USEPRANKFINDTARGET = {
					USEPRANKCHOICES = {
						USEPRANKSEEKPROJECTILE = {
							USEPRANKRANGE = {
								USEPRANKPROJECTILE = none,
								USEPRANKFLEE = {
									USEPRANKFLEENODE = none,
								},
								USEPRANKPLANT = none,
							},
						},
						USEPRANKKICKME = {
							PLANTSIGN = none,
						},
					},
				},
			},
			PULLFIREALARM = {
				SEEKALARM = {
					USEALARM = none,
				},
			},
			TARGETCAR = {
				SETCAROBJ = none,
			},
			HARASSAUTHORITY = {
				HARASSRANGEWEAPON = {
					HARASSRANGEEQUIP = none,
					HARASSRANGEUSE = none,
				},
			},
			FINDTAGSPOT = {
				SEEKTAG = {
					SPRAYTAG = none,
				},
			},
			BREAKPROPSSPECIAL = {
				SETPROPOBJ = none,
			},
			PROJATTACK = {
				SETPROPOBJ = {
					BREAKPROPEGG = {
						BREAKPROPCLEAR = none,
					},
				},
				SCRIPTEDPROJ = {
					SCRIPTEDPROJTRACK = none,
				},
			},
		},
		STIMULI = {
			TARGETED = {
				TARGETEDCHECK = {
					TARGETEDCHOICES = {
						TARGETDISS = none,
						TARGETANGRY = none,
					},
					TARGETEDFRIENDWBALL = none,
					ISALLY = none,
				},
			},
			TAGGING = {
				LOOKATTAGGING = {
					TAGSPEECH = none,
				},
			},
			SURPRISED = {
				SURPRISEDACT = none,
			},
			PEDHITNEARBY = {
				LOOKATHIT = {
					HITHANGOUT = {
						HITHANGOUTCHOICES = {
							LOOKAROUND = {
								LOOKAROUND = none,
								LOOKAROUNDSURP = {
									FLEERUN = none,
								},
								LOOKAROUND2 = none,
							},
							TARGETPLAYERCOMBAT = {
								TARGETPLAYERCOMBATCHOICE = {
									TARGETPLAYERSEQ = none,
									TARGETPLAYERCOMBAT = none,
								},
							},
						},
					},
				},
			},
			BIKESTOLEN = {
				MYBIKESTOLEN = {
					MYBIKESTOLENACTIONS = {
						MYBIKESTOLENFEAR = none,
						MYBIKESTOLENATTACK = {
							MYBIKESTOLENSPEECH = none,
						},
					},
				},
				BIKESTOLENFACE = none,
			},
			VOMIT = {
				VOMITFACE = {
					VOMITCHOICE = {
						VOMITLAUGH = none,
						VOMITSPEAK = none,
						VOMITNOW = {
							VOMITNOW = none,
						},
						VOMITFACE2 = none,
					},
				},
			},
			HUMILIATION = {
				TURNLAUGH = none,
			},
			BOYKISS = {
				FACEBOYS = {
					BOYSSPEAK = {
						BOYSSPEAKCOOL = none,
						BOYSSPEAKGROSS = none,
					},
				},
			},
			BIKECRASH = {
				FACEBIKECRASH = {
					FACECRASHSPEAK = none,
				},
			},
			PROPBROKEN = {
				LOOKATPROP = {
					BREAKPROPSPEECH = none,
				},
			},
			PROJECTILE = none,
			TAGATTACK = {
				LOOKATTAGGING = {
					TAGSPEECH = none,
				},
				TAGGETPISSED = none,
			},
			WEAPONFIRED = {
				LOOKATFIRING = {
					WEAPONSPEAK = none,
				},
			},
			EXPLOSION = {
				LOOKAT = none,
				FLEEREACTION = none,
			},
			BULLYING = {
				BULLYINGSEE = none,
				BULLYLAUGH = none,
			},
			RESPONSE = {
				RESPONDTAUNT = {
					TAUNTTURN = {
						TAUNTRESPONSES = {
							TAUNTNOTVISIBLE = none,
							TAUNTISVISIBLE = {
								TAUNTAGGROCHECK = {
									TCHOICES = {
										TAUNTBEEF = none,
										TAUNTHARASS = none,
									},
								},
								TAUNTNOTAGGRO = {
									TAUNTFEARCHECK = {
										TAUNTFEARRESPONSE = {
											TAUNTFLEE = none,
										},
									},
									TAUNTNOTHING = {
										TAUNTSHRUG = none,
									},
								},
							},
							TAUNTFIX = none,
						},
					},
					TAUNTSOCIAL = none,
				},
				RESPONDGREET = {
					GREETSOCIAL = none,
				},
			},
			AUTHORITYFIGHT = {
				ADULTAUTHORITYFIGHT = {
					LOOKATAUHFIGHT = none,
				},
				CHEERFLEE = none,
			},
			COWDANCE = {
				TURNTOFACE = none,
				JOCKS = none,
				COWDANCESPEAK = {
					COOLSPEAK = none,
					CRAPSPEAK = none,
				},
			},
			STIMOPPBANK = {
				STIMOPPS = none,
			},
			KICKMESIGN = {
				KICKMEREACTIONS = {
					KICKLAUGH = none,
					KICKLOADED = {
						KICKHIM = {
							KICKKICK = none,
						},
					},
					SCRIPTED = {
						KICKSCRIPT = none,
					},
				},
			},
			SEEBUSTED = {
				LOOKAT = none,
			},
			TV = {
				TVPISSED = none,
			},
			FIREEXT = {
				LOOKAT = none,
				FLEEREACTION = none,
			},
			COWDANCEFAIL = {
				TURNTOFACE = {
					RETALIATE = none,
				},
			},
			TATTLEFRIEND = {
				TATTLEREACT = {
					WAIT = none,
				},
			},
			SLINGERSTIM = {
				SLINGERFEAR = none,
				SLINGEROBJ = {
					STATS = {
						STATSFF = none,
						STATSSNOW = none,
					},
					SLINGERSPEECHEXEC = {
						SLINGERTRAY = none,
						SLINGERSPEECH = none,
					},
				},
				FACEOBJ = none,
			},
			CAMERATARGET = {
				CAMERADISLIKE = {
					CAMERADISLIKEACTIONREPEAT = none,
					CAMERADISLIKEACTION = none,
				},
				CAMERALIKE = {
					CAMERALIKEACTION = none,
				},
			},
			COWDANCESUCCESS = {
				TURNTOFACE = {
					FINISH = none,
				},
			},
			DEADRAT = {
				FACERAT = {
					RATREACTIONS = {
						RATSPEECH = {
							RATSPEECHNODE = none,
						},
						RATFLEE = none,
						LOOKAT = none,
					},
				},
			},
			FIREWORKLURE = {
				MOVETOLURE = {
					FACELURE = {
						ENDLURE = none,
					},
				},
			},
			VEHICLEDAMAGE = {
				LOOKAT = none,
			},
			FIREALARM = {
				LOOKFIRE = none,
			},
			DEATHTAUNT = {
				KNOCKOUTTAUNT = none,
			},
			FIGHTNEARBY = {
				CHEERING = {
					CHEERSPEAK = none,
					CHEERDEATH = none,
				},
				ADULTFIGHT = {
					ADULTFIGHTMOVE = {
						FIGTHMOVEAWAY = none,
					},
					ADULTFIGHTFEMALE = {
						LOOKATFIGHT = none,
						AUTHCHECK = {
							HELPYELL = none,
						},
					},
					ADULTFIGHTEXEC = {
						ADULTFIGHWARN = none,
					},
					ADULTFIGHTMALE = {
						LOOKATFIGHT = none,
						AUTHCHECK = {
							HELPYELL = none,
						},
					},
				},
				CHEERLITTLEGIRLS = none,
			},
		},
		BROADCASTSTIM = {
			DISPERSEBCAST = {
				DISPERSEDOCK = none,
			},
			FIREALARMBCAST = {
				FIREALARMDOCK = {
					FIREALARMSPEECH = {
						ALARMSPEECH = none,
					},
				},
			},
		},
		TRIGGERED = {
			BOOBYTRAP = {
				MOVETOTRAP = none,
			},
			GIRLSBATHROOM = {
				GIRLNOTICE = {
					GIRLNOTICECHOICES = {
						GIRLNOTICEANIM = {
							GIRLFREAKCHOICES = {
								FREAKHOSTILE = {
									FREAKATTACK = {
										FREAKATTACKTARGET = {
											FREAKATTACKTARGETGO = {
												FREAKATTACKFLEE = none,
											},
											FREAKATTACKTARGETWAIT = none,
										},
									},
									FREAKFLEE = none,
								},
								FREAKFLEE = none,
							},
						},
					},
					SPEAKOPTIONS = {
						DORMFREAKOUT = none,
						REGFREAK = none,
					},
				},
			},
			PRINCIPALOFFICE = {
				OFFICENOTICE = {
					OFFICENOTICECHOICES = {
						GIRLAUTHORITYNOTICE = none,
					},
				},
			},
		},
		FACTION = {
			FRIENDATTACKED = none,
			HATECHECK = {
				HATECHECK = none,
				HATECHECKGIRLTARGET = none,
			},
			FACTIONGIRLS = {
				HATECHECKGIRL = {
					CHECKFORPALS = {
						SEEKHELP = {
							FINDHELP = {
								TELLPAL = none,
							},
						},
					},
					TAUNT = none,
				},
				GIRLFRIENDATTACKED = {
					CHECKFORPALS = {
						SEEKHELP = {
							FINDHELP = {
								TELLPAL = none,
							},
						},
					},
				},
			},
		},
		HITREACT = {
			HITREACTWAIT = {
				TURNTOFACE = {
					ATTACKCHECK = {
						SEEATTACKER = {
							FEAR = {
								AUTHCHECK = {
									FLEE = none,
									HELPYELL = {
										HELPYELLBIKE = none,
									},
								},
								FLEE = none,
							},
							ATTACKED = none,
							CHICKENS = {
								CHICKENWARN = {
									CHICKENFLEE = {
										TELLAUTHORITY = none,
									},
								},
							},
						},
						HITREACTSOCIAL = none,
						HITREACTSLINGER = none,
						SEEDISLIKED = {
							RETALIATE = none,
						},
						DEAD = none,
						ATTACKSPEECHBANK = {
							ATTACKSPEECH = {
								ATTACKWARNADULT = none,
								ATTACKWARNSPEECH = none,
							},
						},
						LOOKAROUND = none,
						ADOREREACT = {
							ATTITUDEADJUST = none,
						},
						ATTACKFIX = none,
					},
				},
			},
		},
	},
	{ -- 6
		BLOCK = none,
	},
	{ -- 2
		RANGEDWEAPONACTIONS = {
			RANGEDWEAPONFIRINGPATTERNS = {
				APPLE = none,
				FOOTBALL = none,
				JOKECANDY = none,
				WFTBOMB = none,
				BANANA = none,
				BOSS = {
					TED = none,
				},
				DART = {
					CLEAROBJECTIVES = none,
				},
				BALL = none,
				POTATOGUN = none,
				BOTTLEROCKET = none,
				EGG = none,
				GARBPICK = none,
				MARBLE = none,
				KICKSIGN = none,
				TRAY = none,
				SLINGSHOT = none,
				ITCHINGPOWDER = none,
				STINKBOMB = none,
				SCHOOLHOUSE = none,
				BAGMARBLES = none,
				FOUNTAIN = none,
				DEADRAT = none,
				CHERRYBOMB = none,
				BRICK = none,
				PLANTPOT = none,
				WDISH = none,
				SNOWBALL = none,
				BASEBALL = none,
			},
		},
		MELEEACTIONS = {
			LONG = none,
			SHORT = none,
			MEDIUM = none,
		},
		AMMOCHECK = {
			DEEQUIPWEAPON = none,
		},
	},
	{ -- 18
		COUNTERATTACK = none,
	},
	{ -- 6
		FOLLOWPLAYER = none,
		IDLE = none,
	},
	{ -- 2
		CARNYLAST = none,
	},
	{ -- 2
		FACEPLAYER = none,
	},
	{ -- 68
		ANIM = none,
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		IDLE = none,
		EXECUTENODES = {
			FREE = {
				WALKBASIC = none,
				RUNBASIC = none,
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKD = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
					},
				},
				DROPOUT_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				SPRINTBASIC = none,
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = {
						BILLYCLUBCOMBATBASIC = none,
						BATCOMBATBASIC = none,
						COMBATBASIC = none,
					},
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = {
					GREASERCOMBATSTRAFEIDLE = none,
					WEAPONCOMBATSTRAFEIDLE = none,
					PREFECTCOMBATSTRAFEIDLE = none,
					COMBATSTRAFEIDLE = none,
					JOCKCOMBATSTRAFEIDLE = none,
				},
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
	},
	{ -- 6
		SHORT = none,
	},
	{ -- 2
		LOCK_PICKING_LOOP_TO_IDLE = none,
		LOCK_PICKING_LOOP = none,
	},
	{ -- 2
		GRAPPLESUCCESS = {
			PULL_IN_HEAVY = {
				HELD = none,
				HOLD_IDLE = {
					GIVE = none,
					GRAPPLEBREAK = {
						BREAK_RCV = none,
						BREAK_GIVE = none,
					},
					RCV = none,
				},
				HOLD = none,
			},
			GRAPPLERCVWAIT = none,
		},
		GRAPPLETEACH = none,
	},
	{ -- 3
		WALL_SMOKE_IDLE = {
			WALL_SMOKE_A = none,
			WALL_SMOKE_B = none,
			WALL_SMOKE_STUB = none,
		},
	},
	{ -- 8
		GRAPPLEATTEMPT = {
			GRAPPLESUCCESS = {
				PULL_IN_HEAVY = {
					HELD = none,
					HOLD_IDLE = {
						GIVE = none,
						GRAPPLEBREAK = {
							BREAK_RCV = none,
							BREAK_GIVE = none,
						},
						RCV = none,
					},
					HOLD = none,
				},
				GRAPPLERCVWAIT = none,
			},
		},
	},
	{ -- 6
		RELEASEGROUP = none,
	},
	{ -- 10
		GRAPPLESUCCESS = {
			PULL_IN_HEAVY = {
				HELD = none,
				HOLD_IDLE = {
					GIVE = none,
					GRAPPLEBREAK = {
						BREAK_RCV = none,
						BREAK_GIVE = none,
					},
					RCV = none,
				},
				HOLD = none,
			},
			GRAPPLERCVWAIT = none,
		},
	},
	{ -- 3
		PASSACTION = {
			RECPASSTHROWCHECK = {
				RECPASSTHROW = none,
			},
		},
	},
	{ -- 3
		RECPASSTHROWCHECK = {
			RECPASSTHROW = none,
		},
	},
	{ -- 3
		RECPASSTHROW = none,
	},
	{ -- 2
		THROWSTART = {
			THROWMID = {
				THROWFINISH = none,
			},
		},
	},
	{ -- 2
		THROWMID = {
			THROWFINISH = none,
		},
	},
	{ -- 4
		SPECIALTHROWSM = none,
	},
	{ -- 87
		STRAFERUNFWD = none,
		STRAFERUNBKW = none,
	},
	{ -- 2
		ANIMS = {
			DEFAULT = none,
			NERD = none,
		},
	},
	{ -- 2
		DEFAULT = none,
		NERD = none,
	},
	{ -- 2
		DIFFICULTY = {
			HARD = none,
			NORMAL = none,
			EASY = none,
		},
	},
	{ -- 2
		HARD = none,
		NORMAL = none,
		EASY = none,
	},
	{ -- 4
		GIVE = {
			WEAPONATTACH = none,
			WEAPONDETACH = none,
		},
		RCV = none,
	},
	{ -- 7
		CATCHMISS = none,
		CATCHSUCCESS = none,
	},
	{ -- 2
		LOADANIMS = none,
		PLAYERIDLE = none,
		LINE1 = {
			LINE2 = {
				LINE3 = {
					LINE4 = {
						LINE5 = {
							LINE6 = {
								END = none,
							},
						},
					},
				},
			},
		},
		PINKYIDLE = {
			PINKYIDLE_END = none,
		},
		CONVINITIATE = none,
	},
	{ -- 2
		PURSUITLOCO = none,
		CLOSEDRANGELOCO = none,
	},
	{ -- 2
		ENGAGED = none,
		CHASEFIGHT = none,
		OBSERVER = none,
	},
	{ -- 7
		PICKUPWEAPON = none,
	},
	{ -- 6
		GIRFRIEND = {
			GFGREET = {
				GFSOCIALCHOICE = {
					GFSOCIALCHOICELONG = none,
					GFSOCIALCHOICENORM = none,
				},
				GIRLFRIENDSOCIAL = none,
			},
			GIRFRIENDSEE = {
				GIRFRIENDSEEHH = {
					GIRFRIENDATTACKCHOICE = {
						GIRFRIENDATTACKBOY = {
							GIRFRIENDATTACKBOY = none,
							GIRFRIENDATTACKPLAYER = none,
						},
						GIRFRIENDATTACKALLY = none,
						GIRFRIENDATTACKPLAYER = none,
					},
					SFSEESPEECH = {
						THARASS = none,
						COMPLAIN = none,
					},
				},
			},
		},
		DISLIKE = {
			DISLIKECHOICES = {
				HARASSCOND = {
					STEALOPP = none,
					HARASS = {
						HARASSRANGE = {
							HARASSHIT = {
								HARASSCHOICE = {
									TAUNTAFTER = none,
								},
							},
							HARASSRANGEWEAPON = {
								HARASSRANGEEQUIP = none,
								HARASSRANGEUSE = none,
							},
						},
						HUNT = none,
					},
					TAUNTCHECK = {
						TAUNT = none,
					},
					HUMILIATE = {
						HUMILNODE = none,
						BOOKSTEALEXEC = none,
					},
				},
				TAUNTCHECK = {
					TAUNT = none,
				},
			},
		},
		CLOTHINGGREET = {
			CLOTHINGGIMMICK = {
				CLOTHINGGIMMICKFACE = {
					CLOTHINGGIMMICKSPEECH = {
						GIMMICKLAUGH = none,
						GIMMICKSPEAK = none,
					},
				},
			},
		},
		NEWKID = {
			NEWKIDTAUNT = {
				TAUNTPLAYER = none,
			},
		},
	},
	{ -- 6
		BEEFEXIT = {
			BEEFCLEARFLAG = none,
		},
		BEEFACTIONS = {
			BS1WAIT = {
				BS1RESPONSES = {
					BS1TAUNT = {
						BS1TAUNTBACKDOWN = none,
						BS1HARASS = none,
						BS1TAUNTBACK = none,
					},
				},
			},
		},
		BEEFSTART = {
			BEEFAPPROACH = {
				BEEFRESPONSE1 = none,
			},
		},
	},
	{ -- 6
		BREAKPROPS = {
			SETPROPOBJ = none,
		},
		STEALBIKE = {
			TAKEBIKE = {
				MOUNTBIKE = none,
			},
		},
		STEALBOOKS = {
			STEALBOOKSSEEK = {
				STEALBOOKSTEAL = {
					POSTSTEALCHOICES = {
						POSTSTEALTHROWACTION = none,
						POSTSTEALFLEE = none,
					},
				},
			},
		},
		USEPRANK = {
			USEPRANKFINDTARGET = {
				USEPRANKCHOICES = {
					USEPRANKSEEKPROJECTILE = {
						USEPRANKRANGE = {
							USEPRANKPROJECTILE = none,
							USEPRANKFLEE = {
								USEPRANKFLEENODE = none,
							},
							USEPRANKPLANT = none,
						},
					},
					USEPRANKKICKME = {
						PLANTSIGN = none,
					},
				},
			},
		},
		PULLFIREALARM = {
			SEEKALARM = {
				USEALARM = none,
			},
		},
		TARGETCAR = {
			SETCAROBJ = none,
		},
		HARASSAUTHORITY = {
			HARASSRANGEWEAPON = {
				HARASSRANGEEQUIP = none,
				HARASSRANGEUSE = none,
			},
		},
		FINDTAGSPOT = {
			SEEKTAG = {
				SPRAYTAG = none,
			},
		},
		BREAKPROPSSPECIAL = {
			SETPROPOBJ = none,
		},
		PROJATTACK = {
			SETPROPOBJ = {
				BREAKPROPEGG = {
					BREAKPROPCLEAR = none,
				},
			},
			SCRIPTEDPROJ = {
				SCRIPTEDPROJTRACK = none,
			},
		},
	},
	{ -- 6
		TARGETED = {
			TARGETEDCHECK = {
				TARGETEDCHOICES = {
					TARGETDISS = none,
					TARGETANGRY = none,
				},
				TARGETEDFRIENDWBALL = none,
				ISALLY = none,
			},
		},
		TAGGING = {
			LOOKATTAGGING = {
				TAGSPEECH = none,
			},
		},
		SURPRISED = {
			SURPRISEDACT = none,
		},
		PEDHITNEARBY = {
			LOOKATHIT = {
				HITHANGOUT = {
					HITHANGOUTCHOICES = {
						LOOKAROUND = {
							LOOKAROUND = none,
							LOOKAROUNDSURP = {
								FLEERUN = none,
							},
							LOOKAROUND2 = none,
						},
						TARGETPLAYERCOMBAT = {
							TARGETPLAYERCOMBATCHOICE = {
								TARGETPLAYERSEQ = none,
								TARGETPLAYERCOMBAT = none,
							},
						},
					},
				},
			},
		},
		BIKESTOLEN = {
			MYBIKESTOLEN = {
				MYBIKESTOLENACTIONS = {
					MYBIKESTOLENFEAR = none,
					MYBIKESTOLENATTACK = {
						MYBIKESTOLENSPEECH = none,
					},
				},
			},
			BIKESTOLENFACE = none,
		},
		VOMIT = {
			VOMITFACE = {
				VOMITCHOICE = {
					VOMITLAUGH = none,
					VOMITSPEAK = none,
					VOMITNOW = {
						VOMITNOW = none,
					},
					VOMITFACE2 = none,
				},
			},
		},
		HUMILIATION = {
			TURNLAUGH = none,
		},
		BOYKISS = {
			FACEBOYS = {
				BOYSSPEAK = {
					BOYSSPEAKCOOL = none,
					BOYSSPEAKGROSS = none,
				},
			},
		},
		BIKECRASH = {
			FACEBIKECRASH = {
				FACECRASHSPEAK = none,
			},
		},
		PROPBROKEN = {
			LOOKATPROP = {
				BREAKPROPSPEECH = none,
			},
		},
		PROJECTILE = none,
		TAGATTACK = {
			LOOKATTAGGING = {
				TAGSPEECH = none,
			},
			TAGGETPISSED = none,
		},
		WEAPONFIRED = {
			LOOKATFIRING = {
				WEAPONSPEAK = none,
			},
		},
		EXPLOSION = {
			LOOKAT = none,
			FLEEREACTION = none,
		},
		BULLYING = {
			BULLYINGSEE = none,
			BULLYLAUGH = none,
		},
		RESPONSE = {
			RESPONDTAUNT = {
				TAUNTTURN = {
					TAUNTRESPONSES = {
						TAUNTNOTVISIBLE = none,
						TAUNTISVISIBLE = {
							TAUNTAGGROCHECK = {
								TCHOICES = {
									TAUNTBEEF = none,
									TAUNTHARASS = none,
								},
							},
							TAUNTNOTAGGRO = {
								TAUNTFEARCHECK = {
									TAUNTFEARRESPONSE = {
										TAUNTFLEE = none,
									},
								},
								TAUNTNOTHING = {
									TAUNTSHRUG = none,
								},
							},
						},
						TAUNTFIX = none,
					},
				},
				TAUNTSOCIAL = none,
			},
			RESPONDGREET = {
				GREETSOCIAL = none,
			},
		},
		AUTHORITYFIGHT = {
			ADULTAUTHORITYFIGHT = {
				LOOKATAUHFIGHT = none,
			},
			CHEERFLEE = none,
		},
		COWDANCE = {
			TURNTOFACE = none,
			JOCKS = none,
			COWDANCESPEAK = {
				COOLSPEAK = none,
				CRAPSPEAK = none,
			},
		},
		STIMOPPBANK = {
			STIMOPPS = none,
		},
		KICKMESIGN = {
			KICKMEREACTIONS = {
				KICKLAUGH = none,
				KICKLOADED = {
					KICKHIM = {
						KICKKICK = none,
					},
				},
				SCRIPTED = {
					KICKSCRIPT = none,
				},
			},
		},
		SEEBUSTED = {
			LOOKAT = none,
		},
		TV = {
			TVPISSED = none,
		},
		FIREEXT = {
			LOOKAT = none,
			FLEEREACTION = none,
		},
		COWDANCEFAIL = {
			TURNTOFACE = {
				RETALIATE = none,
			},
		},
		TATTLEFRIEND = {
			TATTLEREACT = {
				WAIT = none,
			},
		},
		SLINGERSTIM = {
			SLINGERFEAR = none,
			SLINGEROBJ = {
				STATS = {
					STATSFF = none,
					STATSSNOW = none,
				},
				SLINGERSPEECHEXEC = {
					SLINGERTRAY = none,
					SLINGERSPEECH = none,
				},
			},
			FACEOBJ = none,
		},
		CAMERATARGET = {
			CAMERADISLIKE = {
				CAMERADISLIKEACTIONREPEAT = none,
				CAMERADISLIKEACTION = none,
			},
			CAMERALIKE = {
				CAMERALIKEACTION = none,
			},
		},
		COWDANCESUCCESS = {
			TURNTOFACE = {
				FINISH = none,
			},
		},
		DEADRAT = {
			FACERAT = {
				RATREACTIONS = {
					RATSPEECH = {
						RATSPEECHNODE = none,
					},
					RATFLEE = none,
					LOOKAT = none,
				},
			},
		},
		FIREWORKLURE = {
			MOVETOLURE = {
				FACELURE = {
					ENDLURE = none,
				},
			},
		},
		VEHICLEDAMAGE = {
			LOOKAT = none,
		},
		FIREALARM = {
			LOOKFIRE = none,
		},
		DEATHTAUNT = {
			KNOCKOUTTAUNT = none,
		},
		FIGHTNEARBY = {
			CHEERING = {
				CHEERSPEAK = none,
				CHEERDEATH = none,
			},
			ADULTFIGHT = {
				ADULTFIGHTMOVE = {
					FIGTHMOVEAWAY = none,
				},
				ADULTFIGHTFEMALE = {
					LOOKATFIGHT = none,
					AUTHCHECK = {
						HELPYELL = none,
					},
				},
				ADULTFIGHTEXEC = {
					ADULTFIGHWARN = none,
				},
				ADULTFIGHTMALE = {
					LOOKATFIGHT = none,
					AUTHCHECK = {
						HELPYELL = none,
					},
				},
			},
			CHEERLITTLEGIRLS = none,
		},
	},
	{ -- 6
		DISPERSEBCAST = {
			DISPERSEDOCK = none,
		},
		FIREALARMBCAST = {
			FIREALARMDOCK = {
				FIREALARMSPEECH = {
					ALARMSPEECH = none,
				},
			},
		},
	},
	{ -- 6
		BOOBYTRAP = {
			MOVETOTRAP = none,
		},
		GIRLSBATHROOM = {
			GIRLNOTICE = {
				GIRLNOTICECHOICES = {
					GIRLNOTICEANIM = {
						GIRLFREAKCHOICES = {
							FREAKHOSTILE = {
								FREAKATTACK = {
									FREAKATTACKTARGET = {
										FREAKATTACKTARGETGO = {
											FREAKATTACKFLEE = none,
										},
										FREAKATTACKTARGETWAIT = none,
									},
								},
								FREAKFLEE = none,
							},
							FREAKFLEE = none,
						},
					},
				},
				SPEAKOPTIONS = {
					DORMFREAKOUT = none,
					REGFREAK = none,
				},
			},
		},
		PRINCIPALOFFICE = {
			OFFICENOTICE = {
				OFFICENOTICECHOICES = {
					GIRLAUTHORITYNOTICE = none,
				},
			},
		},
	},
	{ -- 6
		FRIENDATTACKED = none,
		HATECHECK = {
			HATECHECK = none,
			HATECHECKGIRLTARGET = none,
		},
		FACTIONGIRLS = {
			HATECHECKGIRL = {
				CHECKFORPALS = {
					SEEKHELP = {
						FINDHELP = {
							TELLPAL = none,
						},
					},
				},
				TAUNT = none,
			},
			GIRLFRIENDATTACKED = {
				CHECKFORPALS = {
					SEEKHELP = {
						FINDHELP = {
							TELLPAL = none,
						},
					},
				},
			},
		},
	},
	{ -- 6
		HITREACTWAIT = {
			TURNTOFACE = {
				ATTACKCHECK = {
					SEEATTACKER = {
						FEAR = {
							AUTHCHECK = {
								FLEE = none,
								HELPYELL = {
									HELPYELLBIKE = none,
								},
							},
							FLEE = none,
						},
						ATTACKED = none,
						CHICKENS = {
							CHICKENWARN = {
								CHICKENFLEE = {
									TELLAUTHORITY = none,
								},
							},
						},
					},
					HITREACTSOCIAL = none,
					HITREACTSLINGER = none,
					SEEDISLIKED = {
						RETALIATE = none,
					},
					DEAD = none,
					ATTACKSPEECHBANK = {
						ATTACKSPEECH = {
							ATTACKWARNADULT = none,
							ATTACKWARNSPEECH = none,
						},
					},
					LOOKAROUND = none,
					ADOREREACT = {
						ATTITUDEADJUST = none,
					},
					ATTACKFIX = none,
				},
			},
		},
	},
	{ -- 14
		RISINGATTACKS = none,
	},
	{ -- 8
		RANGEDWEAPONFIRINGPATTERNS = {
			APPLE = none,
			FOOTBALL = none,
			JOKECANDY = none,
			WFTBOMB = none,
			BANANA = none,
			BOSS = {
				TED = none,
			},
			DART = {
				CLEAROBJECTIVES = none,
			},
			BALL = none,
			POTATOGUN = none,
			BOTTLEROCKET = none,
			EGG = none,
			GARBPICK = none,
			MARBLE = none,
			KICKSIGN = none,
			TRAY = none,
			SLINGSHOT = none,
			ITCHINGPOWDER = none,
			STINKBOMB = none,
			SCHOOLHOUSE = none,
			BAGMARBLES = none,
			FOUNTAIN = none,
			DEADRAT = none,
			CHERRYBOMB = none,
			BRICK = none,
			PLANTPOT = none,
			WDISH = none,
			SNOWBALL = none,
			BASEBALL = none,
		},
	},
	{ -- 3
		LONG = none,
		SHORT = none,
		MEDIUM = none,
	},
	{ -- 4
		DEEQUIPWEAPON = none,
	},
	{ -- 3
		FIRE = none,
	},
	{ -- 3
		HEADTRACKONBIKE = {
			HEADTRACKONBIKE_FLEEING = {
				WAITING = none,
				TRACKING = none,
			},
		},
		BIKEGENERALOBJECTIVES = {
			GETOFFBIKE = {
				HALTBIKE = {
					DISMOUNTWAIT = none,
				},
			},
			BBRAWL = none,
			BGETONVEHICLE = none,
			BFLEEONPATHOBJECTIVE = none,
			BFOLLOWPATH = none,
			BRACE = {
				BSTOPRACE = none,
			},
			BFLEEONROADOBJECTIVE = none,
			BWANDER = none,
			BFOLLOWFOCUS = none,
			BMOVEOBJECTIVE = none,
			BIDLE = none,
			BFACEOBJECTIVE = none,
			BFLEEOBJECTIVE = none,
		},
		BIKECOMBAT = {
			FOLLOW = none,
			BIKEAUTHORITYATTACKOBJ = {
				FINDBADDIESBIKEATTACKOBJ = {
					DISMOUNTANDRESPONDATTACKOBJ = none,
				},
			},
			["3_04_FOLLOW"] = none,
			MELEEGETCLOSE = none,
		},
		BIKEDUMMYIDLE = none,
		BIKEREACTIONS = {
			CRIMINAL = {
				BREAKPROPS = {
					FIREATPROP = none,
				},
				HARASSAUTHORITY = {
					FIREATAUTHORITY = none,
				},
			},
			STIMULI = {
				HUMILIATION = {
					TURNLAUGH = none,
				},
				TAGGING = {
					TAGGETPISSED = none,
				},
				SEEBUSTED = {
					LOOKAT = none,
				},
				AUTHORITYFIGHT = {
					CHEERFLEE = none,
				},
				FIGHTNEARBY = {
					RIDETOFIGHT = {
						DISMOUNTCHEER = none,
					},
				},
				BIKECRASH = {
					FACEBIKECRASH = {
						FACECRASHSPEAK = none,
					},
				},
				EXPLOSION = {
					FLEEREACTION = none,
					BIKELOOKAT = none,
				},
			},
			BIKEAUTHORITY = {
				FINDBADDIESONBIKE = none,
			},
			FACTION = {
				FRIENDATTACKED = none,
				ABHORCHECK = none,
				AVERSECHECK = none,
			},
			HITREACT = {
				HITREACTBIKEEXEC = none,
				MYBIKESTOLENACTIONS = {
					MYBIKESTOLENFEAR = none,
					MYBIKESTOLENATTACK = {
						MYBIKESTOLENSPEECH = none,
					},
				},
				HITBYEGG = none,
			},
		},
		BIKECOMBATACTIONS = {
			CONTROLNODE = none,
			BIKECOMBATACTIONS = {
				FACTIONSCAN = none,
				ATTACKACTIONS = {
					MELEE = {
						PUNCH = {
							RIGHT = none,
							LEFT = none,
						},
						WEAPON_TO_BE_DELETED = {
							RIGHT = none,
							LEFT = none,
						},
					},
					RANGEDACTIONS = {
						RANGEDWEAPONEQUIPPED = {
							DEEQUIPRANGEDWEAPON = none,
							FIRE = {
								CHECKLINEOFFIRE = none,
								DEFAULT = none,
							},
						},
						EQUIPRANGEDWEAPON = none,
					},
				},
				ATTACKSPEECH = {
					BIKEATTACKSPEECHNODE = none,
				},
			},
		},
	},
	{ -- 4
		HITREACT = {
			HITREACTWAIT = {
				TURNTOFACE = {
					ATTACKCHECK = {
						SEEATTACKER = {
							FEAR = {
								AUTHCHECK = {
									FLEE = none,
									HELPYELL = none,
								},
								FLEE = none,
							},
							ATTACKED = none,
							CHICKENS = {
								CHICKENWARN = {
									CHICKENFLEE = {
										TELLAUTHORITY = none,
									},
								},
							},
						},
						SEEDISLIKED = {
							RETALIATE = none,
						},
						DEGRADEFACTION = {
							DEGRADEFACTIONEXEC = none,
						},
						LOOKAROUND = none,
						REACTTEXT = {
							HELPTEXT1 = none,
							TATTLETEXT1 = none,
						},
						ATTACKFIX = none,
					},
				},
			},
		},
		PUNISHMENTPOINTS = {
			RUNAWAY = none,
		},
	},
	{ -- 8
		ATTACKRIGHTSRELEASE = none,
	},
	{ -- 3
		GETWEAPON = {
			AUTHORITY = {
				PICKUP = none,
			},
			ADULTS = {
				PICKUP = none,
			},
			TOUGH = {
				PICKUP = none,
			},
			WIMPS = {
				PICKUP = none,
			},
			PICKUPACTION = {
				PICKUPWEAPON = none,
			},
		},
	},
	{ -- 7
		GROUNDATTACK = none,
	},
	{ -- 10
		TAUNTCALL = none,
	},
	{ -- 3
		RUNNINGATTACK = {
			RUNNINGATTACK = {
				TIRED = none,
				RUNNINGATTACKCALL = none,
			},
		},
		PROJECTILECOUNTER = {
			PROJECTILECOUNTER = none,
		},
		PURSUITATTACK = {
			PURSUITATTACK = none,
		},
	},
	{ -- 3
		BLOCK = {
			CHARGE_COUNTERATTACK = {
				COUNTERATTACK = none,
			},
		},
	},
	{ -- 3
		INCAPACITATED = {
			DEAD = none,
			ONGROUND = {
				RISINGATTACKS = none,
			},
		},
		HIT = {
			HIT = none,
			PROJECTILEHIT = none,
		},
		GRAPPLED = {
			GRAPPLED = none,
		},
	},
	{ -- 4
		COMBATTALK = {
			TAUNTCALL = none,
		},
	},
	{ -- 3
		INRANGE = {
			EQUIPWEAPON = none,
		},
	},
	{ -- 3
		LONG = none,
	},
	{ -- 8
		MEDIUM = none,
	},
	{ -- 4
		SPECIAL = none,
	},
	{ -- 3
		LOWATTACK = none,
		SHORT = none,
	},
	{ -- 2
		JOHNNY = none,
	},
	{ -- 4
		WAITFORTARGETTAUNT = none,
	},
	{ -- 3
		TALK = {
			TALK3 = none,
			TALK4 = none,
			TALK1 = none,
			TALK2 = none,
		},
	},
	{ -- 33
		ATTACKEXECUTE = none,
	},
	{ -- 16
		COMBAT = none,
		DEFAULT = none,
	},
	{ -- 14
		WEAPONIDLE = none,
		PERFORMINGACTION = none,
	},
	{ -- 21
		LOCOMOTION = {
			SPRINTDEPLETE = {
				SPRINTDEPLETEEXEC = none,
			},
			WALK = {
				TIRED = {
					TIRED_UBO = none,
					WALKTIRED = none,
				},
				SNEAK = {
					STEALTHWALKSTART = {
						ANIM = none,
					},
					STEALTHWALK = {
						RUNSTART = none,
						WALKSTOP = none,
					},
				},
				NOTTIRED = {
					WALKSTART = none,
					WALK = none,
					WALKSTOP = none,
				},
				ALLY = {
					WALKALLY = none,
				},
				FEMALE = {
					WALKBASIC = none,
				},
			},
			COMBAT = {
				COMBATTRANSITION = {
					COMBATIDLE_OUT = {
						COMBATIDLE_OUT = none,
						STRAFE = none,
					},
					COMBATSTART = {
						IDLE = none,
						STRAFE = {
							ANIM = none,
						},
					},
				},
				DEFAULT = {
					COMBATRUN = {
						RUNSTRAFEMODE = {
							STRAFERUNFWD = none,
							STRAFERUNBKW = none,
						},
					},
					COMBATSTRAFE = none,
					COMBATIDLE = {
						ANIM = {
							ANIM = none,
							NOANIM = none,
						},
					},
				},
				EXECNODES = {
					COMBATIDLETURN = {
						FACINGINTENDED = {
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							RESET = none,
							FORWARDS = none,
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
					TARGET = {
						STRAFEMODE = none,
						LOCK = none,
					},
				},
				["0_BLOCK_0"] = {
					COMBATRUN = {
						RUNSTRAFEMODE = {
							STRAFERUNFWD = none,
							STRAFERUNBKW = none,
						},
					},
					COMBATIDLEBLOCK = none,
					BLOCKSTRAFE = none,
				},
			},
			LOCOMOTIONEXECUTES = {
				CROUCHLOCOTARGET = none,
				NONCOMBATSTRAFE = {
					NC_LOCO = {
						COMBATIDLE_OUT = none,
						RUNSTRAFEMODE = {
							STRAFERUNFWD = none,
							STRAFERUNBKW = none,
						},
						IDLE = {
							IDLE_ANIM = {
								ANIM = none,
								SOCIALIZING = none,
							},
						},
						NONCOMBATSTRAFEANIMS = {
							WALKSTOP = none,
						},
					},
				},
				STRAFELOCOBASIC = {
					NOSTEERING = none,
					STEERING = none,
				},
				STRAFELOCOBASICANIMS = {
					MELEE = none,
					WEAPON = none,
				},
				RUN_STARTLOCO = {
					DEFAULT = none,
					TURNFAST = none,
				},
				WALK_STARTLOCO = none,
				TIRED_UPPERBODY = none,
				WALKBASIC = none,
				EXHAUSTED_COLLAPSE = {
					EXHAUSTED_COLLAPSE_LOADCHECK = {
						COLLAPSE = {
							COLLAPSELOAD = {
								COLLAPSE = none,
								GRAPPLETARGET = none,
							},
							COLLAPSEOFFLADDER = {
								FALL = none,
							},
							COLLAPSEOFFTREEBRANCH = {
								DOWN = {
									DOWN_END = none,
								},
							},
							COLLAPSEOFFTREEHANG = {
								DOWN = none,
							},
						},
					},
				},
			},
			OFFSETCAM = {
				OFFSETCAM_WEAPON = {
					COMBATRUN = {
						RUNSTRAFEMODE = {
							STRAFERUNFWD = none,
							STRAFERUNBKW = none,
						},
					},
					COMBATSTRAFE = none,
					COMBATIDLE = {
						ANIM = none,
					},
				},
				OFFSETCAM_LOCO = none,
			},
			RUN = {
				RUN = {
					RUNCONTROLLER = {
						RUN = {
							RUN = {
								LOCOTRACKS = {
									DEFAULT = none,
									TURNFAST = none,
								},
							},
						},
						SPRINT = {
							SPRINTBASIC = {
								LOCOTRACKS = {
									DEFAULT = none,
									TURNFAST = none,
								},
							},
						},
					},
				},
				TIRED_STOP = none,
				NEWLOCOANIMS = {
					RUNLOCOANIMS = none,
					TIRED_UPPERBODY_SPAWN = {
						NOTTIRED = none,
						TIRED = none,
					},
					TIRED_UPPERBODY = none,
					SPRINTLOCOANIMS = none,
				},
				RUNSTOP = {
					WALKSTOP_WAIT = none,
					RUNSTOP = {
						SKID = {
							RUN_TO_IDLE = {
								LOCO = {
									WINTER = none,
									NORMAL = none,
								},
							},
							SPRINT_SLIDE = none,
						},
					},
					RUNSTOP_WAIT = none,
				},
				RUNSTART = {
					RUNSTART = none,
				},
			},
			CROUCH = {
				CROUCHIDLE = {
					CROUCHIDLE = none,
					CROUCHAIM = {
						TURN = {
							FACINGINTENDED = {
								CCW_SLOW = {
									CCW = none,
									WAIT = none,
									END = none,
								},
								RESET = none,
								FORWARDS = none,
								CW_SLOW = {
									CW = none,
									END = none,
									WAIT = none,
								},
							},
						},
					},
					CROUCHIDLETARGET = none,
				},
				CROUCHEND = {
					CROUCH_OUT_COMBAT = {
						CROUCH_OUT_TARGET = none,
					},
					CROUCH_OUT = none,
				},
				CROUCHSTART = {
					CROUCHSTARTCOMBAT = none,
					CROUCHSTART = none,
				},
				CROUCHLOCO = {
					CROUCHLOCOTARGET = none,
					CROUCHLOCO = {
						CROUCHLOCOANIMS = {
							CROUCHLOCORUN = none,
							CROUCHLOCOBASIC = none,
						},
						RUNCONTROLLER = {
							CROUCHRUN = none,
							CROUCHLOCO = none,
						},
					},
				},
				CROUCH_TIRED = {
					TIRED_UBO = none,
				},
				CRAWLLOCO = {
					CRAWLSTART = {
						CRAWLCYCLE = {
							CROUCHRELEASE = none,
						},
					},
				},
			},
			IDLE = {
				VTIRED = {
					VTIREDACTIONS = {
						AMBIENTACTIONS_VTIRED = {
							AMBIENTACTIONS_OPP = none,
							AMBIENTACTIONS = {
								AMBIENT_1 = none,
								AMBIENT_2 = none,
								AMBIENT_3 = none,
							},
						},
					},
				},
				FEMALE = none,
				TURN = {
					FACINGINTENDED = {
						CW_SLOW_OLD = {
							CW = none,
							END = none,
							WAIT = none,
						},
						RESET = none,
						CCW_SLOW_FEMALE = {
							CCW = none,
							WAIT = none,
							END = none,
						},
						FORWARDS_ACCURATE = none,
						CCW_SLOW = {
							CCW = none,
							WAIT = none,
							END = none,
						},
						FORWARDS = none,
						CW_SLOW_FEMALE = {
							CW = none,
							END = none,
							WAIT = none,
						},
						CCW_SLOW_OLD = {
							CCW = none,
							WAIT = none,
							END = none,
						},
						CW_SLOW = {
							CW = none,
							END = none,
							WAIT = none,
						},
					},
				},
				EXHAUSTED = none,
				TIRED = {
					TIREDACTIONS = {
						AMBIENTACTIONS_TIRED = {
							AMBIENTACTIONS_OPP = none,
							AMBIENTACTIONS = {
								AMBIENT_1 = none,
								AMBIENT_2 = none,
								AMBIENT_3 = none,
							},
						},
					},
				},
				IDLE = {
					AMBIENTACTIONS = {
						AMBIENTACTIONS_GROUPLOAD2 = {
							AMBIENTACTIONS = {
								AMBIENT_9 = none,
								AMBIENT_10 = none,
								AMBIENT_12 = none,
								AMBIENT_11 = none,
								AMBIENT_8 = none,
							},
						},
						AMBIENTACTIONS_GROUPLOAD1 = {
							AMBIENTACTIONS = {
								AMBIENT_4 = none,
								AMBIENT_6 = none,
								AMBIENT_2 = none,
								AMBIENT_1 = none,
								AMBIENT_7 = none,
								AMBIENT_5 = none,
								AMBIENT_3 = none,
							},
						},
						AMBIENTACTIONS_GROUPLOAD3 = {
							AMBIENTACTIONS = {
								ARMSONHIPS = none,
								SCRATCHARSE = none,
								SCRATCHHEAD = none,
								SCRATCHPIT = none,
								STRETCH = none,
							},
						},
					},
					MIRRORIDLE = {
						MIRROR_LOAD = {
							MIRRORACTIONS = {
								MIRRORACTIONS2 = none,
								MIRRORACTIONS3 = none,
								MIRRORACTIONS4 = none,
								MIRRORACTIONS1 = none,
							},
						},
					},
					WARMTHFACTOR = {
						FREEZING = {
							DAMAGE = none,
						},
					},
					AMBIENTSPAWN = {
						AMBIENTSPAWN = {
							OPPS = none,
						},
					},
					IDLESPEECH = {
						WAIT = none,
						SAYSOMETHING = {
							VTIRED = none,
							TIRED = none,
							NORMAL = none,
						},
					},
				},
			},
			SOCIAL = {
				SOCIAL_ACTIONS = none,
				SOCIAL = none,
			},
			HANDHOLDING = {
				IDLE = none,
				WALK = {
					WALK_SPEEDS = {
						HANDHOLDING = none,
						OLDPED = none,
					},
					WALKSTOP = none,
				},
			},
		},
	},
	{ -- 2
		ANIMATIONS = {
			WEAPONWALK = none,
			WEAPONCROUCH = none,
			WEAPONIDLE = none,
			WEAPONSTRAFE = none,
			ONTREE = {
				OFFSETIDLE = none,
				IDLE = none,
			},
			WEAPONRUN = none,
			WEAPONBIKEIDLE = none,
			WEAPONSOCIAL = {
				WEAPONIDLE = none,
				WEAPONIDLERUN = none,
				PERFORMINGACTION = none,
			},
		},
		GLOBALLOCO = {
			LOCOMOTION = {
				SPRINTDEPLETE = {
					SPRINTDEPLETEEXEC = none,
				},
				WALK = {
					TIRED = {
						TIRED_UBO = none,
						WALKTIRED = none,
					},
					SNEAK = {
						STEALTHWALKSTART = {
							ANIM = none,
						},
						STEALTHWALK = {
							RUNSTART = none,
							WALKSTOP = none,
						},
					},
					NOTTIRED = {
						WALKSTART = none,
						WALK = none,
						WALKSTOP = none,
					},
					ALLY = {
						WALKALLY = none,
					},
					FEMALE = {
						WALKBASIC = none,
					},
				},
				COMBAT = {
					COMBATTRANSITION = {
						COMBATIDLE_OUT = {
							COMBATIDLE_OUT = none,
							STRAFE = none,
						},
						COMBATSTART = {
							IDLE = none,
							STRAFE = {
								ANIM = none,
							},
						},
					},
					DEFAULT = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = {
								ANIM = none,
								NOANIM = none,
							},
						},
					},
					EXECNODES = {
						COMBATIDLETURN = {
							FACINGINTENDED = {
								CCW_SLOW = {
									CCW = none,
									WAIT = none,
									END = none,
								},
								RESET = none,
								FORWARDS = none,
								CW_SLOW = {
									CW = none,
									END = none,
									WAIT = none,
								},
							},
						},
						TARGET = {
							STRAFEMODE = none,
							LOCK = none,
						},
					},
					["0_BLOCK_0"] = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATIDLEBLOCK = none,
						BLOCKSTRAFE = none,
					},
				},
				LOCOMOTIONEXECUTES = {
					CROUCHLOCOTARGET = none,
					NONCOMBATSTRAFE = {
						NC_LOCO = {
							COMBATIDLE_OUT = none,
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
							IDLE = {
								IDLE_ANIM = {
									ANIM = none,
									SOCIALIZING = none,
								},
							},
							NONCOMBATSTRAFEANIMS = {
								WALKSTOP = none,
							},
						},
					},
					STRAFELOCOBASIC = {
						NOSTEERING = none,
						STEERING = none,
					},
					STRAFELOCOBASICANIMS = {
						MELEE = none,
						WEAPON = none,
					},
					RUN_STARTLOCO = {
						DEFAULT = none,
						TURNFAST = none,
					},
					WALK_STARTLOCO = none,
					TIRED_UPPERBODY = none,
					WALKBASIC = none,
					EXHAUSTED_COLLAPSE = {
						EXHAUSTED_COLLAPSE_LOADCHECK = {
							COLLAPSE = {
								COLLAPSELOAD = {
									COLLAPSE = none,
									GRAPPLETARGET = none,
								},
								COLLAPSEOFFLADDER = {
									FALL = none,
								},
								COLLAPSEOFFTREEBRANCH = {
									DOWN = {
										DOWN_END = none,
									},
								},
								COLLAPSEOFFTREEHANG = {
									DOWN = none,
								},
							},
						},
					},
				},
				OFFSETCAM = {
					OFFSETCAM_WEAPON = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = none,
						},
					},
					OFFSETCAM_LOCO = none,
				},
				RUN = {
					RUN = {
						RUNCONTROLLER = {
							RUN = {
								RUN = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
							SPRINT = {
								SPRINTBASIC = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
						},
					},
					TIRED_STOP = none,
					NEWLOCOANIMS = {
						RUNLOCOANIMS = none,
						TIRED_UPPERBODY_SPAWN = {
							NOTTIRED = none,
							TIRED = none,
						},
						TIRED_UPPERBODY = none,
						SPRINTLOCOANIMS = none,
					},
					RUNSTOP = {
						WALKSTOP_WAIT = none,
						RUNSTOP = {
							SKID = {
								RUN_TO_IDLE = {
									LOCO = {
										WINTER = none,
										NORMAL = none,
									},
								},
								SPRINT_SLIDE = none,
							},
						},
						RUNSTOP_WAIT = none,
					},
					RUNSTART = {
						RUNSTART = none,
					},
				},
				CROUCH = {
					CROUCHIDLE = {
						CROUCHIDLE = none,
						CROUCHAIM = {
							TURN = {
								FACINGINTENDED = {
									CCW_SLOW = {
										CCW = none,
										WAIT = none,
										END = none,
									},
									RESET = none,
									FORWARDS = none,
									CW_SLOW = {
										CW = none,
										END = none,
										WAIT = none,
									},
								},
							},
						},
						CROUCHIDLETARGET = none,
					},
					CROUCHEND = {
						CROUCH_OUT_COMBAT = {
							CROUCH_OUT_TARGET = none,
						},
						CROUCH_OUT = none,
					},
					CROUCHSTART = {
						CROUCHSTARTCOMBAT = none,
						CROUCHSTART = none,
					},
					CROUCHLOCO = {
						CROUCHLOCOTARGET = none,
						CROUCHLOCO = {
							CROUCHLOCOANIMS = {
								CROUCHLOCORUN = none,
								CROUCHLOCOBASIC = none,
							},
							RUNCONTROLLER = {
								CROUCHRUN = none,
								CROUCHLOCO = none,
							},
						},
					},
					CROUCH_TIRED = {
						TIRED_UBO = none,
					},
					CRAWLLOCO = {
						CRAWLSTART = {
							CRAWLCYCLE = {
								CROUCHRELEASE = none,
							},
						},
					},
				},
				IDLE = {
					VTIRED = {
						VTIREDACTIONS = {
							AMBIENTACTIONS_VTIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					FEMALE = none,
					TURN = {
						FACINGINTENDED = {
							CW_SLOW_OLD = {
								CW = none,
								END = none,
								WAIT = none,
							},
							RESET = none,
							CCW_SLOW_FEMALE = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS_ACCURATE = none,
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS = none,
							CW_SLOW_FEMALE = {
								CW = none,
								END = none,
								WAIT = none,
							},
							CCW_SLOW_OLD = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
					EXHAUSTED = none,
					TIRED = {
						TIREDACTIONS = {
							AMBIENTACTIONS_TIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					IDLE = {
						AMBIENTACTIONS = {
							AMBIENTACTIONS_GROUPLOAD2 = {
								AMBIENTACTIONS = {
									AMBIENT_9 = none,
									AMBIENT_10 = none,
									AMBIENT_12 = none,
									AMBIENT_11 = none,
									AMBIENT_8 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD1 = {
								AMBIENTACTIONS = {
									AMBIENT_4 = none,
									AMBIENT_6 = none,
									AMBIENT_2 = none,
									AMBIENT_1 = none,
									AMBIENT_7 = none,
									AMBIENT_5 = none,
									AMBIENT_3 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD3 = {
								AMBIENTACTIONS = {
									ARMSONHIPS = none,
									SCRATCHARSE = none,
									SCRATCHHEAD = none,
									SCRATCHPIT = none,
									STRETCH = none,
								},
							},
						},
						MIRRORIDLE = {
							MIRROR_LOAD = {
								MIRRORACTIONS = {
									MIRRORACTIONS2 = none,
									MIRRORACTIONS3 = none,
									MIRRORACTIONS4 = none,
									MIRRORACTIONS1 = none,
								},
							},
						},
						WARMTHFACTOR = {
							FREEZING = {
								DAMAGE = none,
							},
						},
						AMBIENTSPAWN = {
							AMBIENTSPAWN = {
								OPPS = none,
							},
						},
						IDLESPEECH = {
							WAIT = none,
							SAYSOMETHING = {
								VTIRED = none,
								TIRED = none,
								NORMAL = none,
							},
						},
					},
				},
				SOCIAL = {
					SOCIAL_ACTIONS = none,
					SOCIAL = none,
				},
				HANDHOLDING = {
					IDLE = none,
					WALK = {
						WALK_SPEEDS = {
							HANDHOLDING = none,
							OLDPED = none,
						},
						WALKSTOP = none,
					},
				},
			},
		},
	},
	{ -- 2
		AUTOAIMON = none,
		AUTOAIMOFF = none,
	},
	{ -- 3
		RETURNTOAIM = none,
	},
	{ -- 3
		DEFAULT = none,
		AIMOUT = {
			DEFAULT = none,
			CROUCH = none,
		},
		CROUCH = none,
	},
	{ -- 2
		SWING1 = {
			SWING2 = {
				SWING3 = none,
			},
		},
		FORCEFEEDBACK = {
			FF144 = none,
			INCREMENTSTATKICK = none,
			FF120 = none,
		},
	},
	{ -- 2
		EVADEINTERRUPT = {
			EVADEINTERRUPT = {
				TAUNT = none,
				OPPORTUNITYINSERT = none,
			},
		},
	},
	{ -- 15
		TAUNT = none,
	},
	{ -- 2
		UNBLOCKABLE = {
			DOUBLEAXEHANDLE = none,
		},
		HEAVYATTACKS = {
			HAMMERSTRIKE_L = none,
		},
		LIGHTATTACKS = {
			OVERHAND = none,
		},
	},
	{ -- 2
		HEADBUTT_ANTICSTART = {
			HEADBUTT_ANTICCYC = {
				HEADBUTT_RUNCYC = {
					HEADBUTT_SUCCESS = {
						GIVE = none,
						HEADBUTT_SUCCESS_WALL_HIT = {
							HEADBUTT_SUCCESS_WALL_HIT_GIVE = none,
							HEADBUTT_SUCCESS_WALL_HIT_RCV = none,
						},
						RCV = none,
					},
					HEADBUTT_FAIL = {
						HEADBUTT_FAIL = {
							HEADBUTT_DIZZY = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		GOTOSPECIAL = none,
	},
	{ -- 3
		GRAPPLEATTEMPT = none,
	},
	{ -- 2
		DOUBLEAXEHANDLE = none,
	},
	{ -- 2
		HAMMERSTRIKE_L = none,
	},
	{ -- 2
		OVERHAND = none,
	},
	{ -- 2
		IDLE_CHECK = {
			IDLE_REGULAR = {
				LOOKAROUND = {
					LOOKAROUND_SPAWNER = none,
					LOOKLAYER_2 = {
						OVERALLTIME = {
							["8SEC"] = none,
							["10SEC"] = none,
							["6SEC"] = none,
						},
						DOWN = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						UP = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						RIGHT = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						LEFT = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
					},
					LOOKLAYER_1 = {
						RIGHT2 = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						RIGHT = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						LEFT2 = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
						LEFT = {
							LONG = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
							SHORT = {
								PREP = none,
								JOCK = none,
								NERD = none,
								GREAS = none,
								BULLY = none,
							},
						},
					},
					LOOK_B = {
						UP = {
							UP = {
								LOOK2ND = {
									DOWN = {
										DOWN = none,
									},
									RIGHT = {
										RIGHT = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						DOWN = {
							DOWN = {
								LOOK2ND = {
									RIGHT = {
										RIGHT = none,
									},
									UP = {
										UP = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						RIGHT = {
							RIGHT = {
								LOOK2ND = {
									DOWN = {
										DOWN = none,
									},
									UP = {
										UP = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						LEFT = {
							LEFT = {
								LOOK2ND = {
									DOWN = {
										DOWN = none,
									},
									RIGHT = {
										RIGHT = none,
									},
									UP = {
										UP = none,
									},
								},
							},
						},
					},
					IDLE_BASE = {
						PREP = none,
						JOCK = none,
						NERD = none,
						GREAS = none,
						BULLY = none,
					},
					LOOK_A = {
						RIGHT2 = {
							RIGHT2 = {
								LOOK2ND = {
									RIGHT = {
										RIGHT = none,
									},
									LEFT2 = {
										LEFT2 = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						RIGHT = {
							RIGHT = {
								LOOK2ND = {
									RIGHT2 = {
										RIGHT2 = none,
									},
									LEFT2 = {
										LEFT2 = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						LEFT2 = {
							LEFT2 = {
								LOOK2ND = {
									RIGHT = {
										RIGHT = none,
									},
									RIGHT2 = {
										RIGHT2 = none,
									},
									LEFT = {
										LEFT = none,
									},
								},
							},
						},
						LEFT = {
							LEFT = {
								LOOK2ND = {
									RIGHT = {
										RIGHT = none,
									},
									LEFT2 = {
										LEFT2 = none,
									},
									RIGHT2 = {
										RIGHT2 = none,
									},
								},
							},
						},
					},
				},
			},
			IDLE_SOCIAL = {
				GENERICS = {
					FAIL = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				UBO_CHECKS = {
					UNARMED = {
						UNARMED_LOOP = none,
					},
					WEAPON = {
						PERFORMINGACTIONLHANDWEAP = {
							PERFORMINGACTION = none,
						},
						PERFORMINGACTION = {
							PERFORMINGACTION = none,
						},
					},
				},
				AUTHORITY = {
					SOCIALIDLEUNFRIENDLY = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEAGGRESSIVE = none,
				},
				NERDS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				TOUGHFACTIONS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEUNFRIENDLY = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				GIRLS = {
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEDISMISSIVE = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
				FAT = {
					FAIL = none,
					SOCIALIDLEFRIENDLY = none,
					SOCIALIDLEINTIMIDATED = none,
					SOCIALIDLEAGGRESSIVE = none,
					SOCIALIDLESCARED = none,
				},
			},
			IDLE_STEALTH = none,
		},
	},
	{ -- 3
		HEAVYATTACKS = {
			RISINGATTACKS = none,
		},
	},
	{ -- 2
		EVADEINTERRUPT = {
			TAUNT = none,
			OPPORTUNITYINSERT = none,
		},
	},
	{ -- 2
		HIT = {
			HIT_LEFT = none,
			HIT_RIGHT = none,
		},
		NO_HIT = none,
	},
	{ -- 2
		SWING2 = none,
		SWING1 = none,
	},
	{ -- 5
		BREAKPROP = none,
	},
	{ -- 2
		IDLE_REGULAR = {
			LOOKAROUND = {
				LOOKAROUND_SPAWNER = none,
				LOOKLAYER_2 = {
					OVERALLTIME = {
						["8SEC"] = none,
						["10SEC"] = none,
						["6SEC"] = none,
					},
					DOWN = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					UP = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					RIGHT = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					LEFT = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
				},
				LOOKLAYER_1 = {
					RIGHT2 = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					RIGHT = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					LEFT2 = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
					LEFT = {
						LONG = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
						SHORT = {
							PREP = none,
							JOCK = none,
							NERD = none,
							GREAS = none,
							BULLY = none,
						},
					},
				},
				LOOK_B = {
					UP = {
						UP = {
							LOOK2ND = {
								DOWN = {
									DOWN = none,
								},
								RIGHT = {
									RIGHT = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					DOWN = {
						DOWN = {
							LOOK2ND = {
								RIGHT = {
									RIGHT = none,
								},
								UP = {
									UP = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					RIGHT = {
						RIGHT = {
							LOOK2ND = {
								DOWN = {
									DOWN = none,
								},
								UP = {
									UP = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					LEFT = {
						LEFT = {
							LOOK2ND = {
								DOWN = {
									DOWN = none,
								},
								RIGHT = {
									RIGHT = none,
								},
								UP = {
									UP = none,
								},
							},
						},
					},
				},
				IDLE_BASE = {
					PREP = none,
					JOCK = none,
					NERD = none,
					GREAS = none,
					BULLY = none,
				},
				LOOK_A = {
					RIGHT2 = {
						RIGHT2 = {
							LOOK2ND = {
								RIGHT = {
									RIGHT = none,
								},
								LEFT2 = {
									LEFT2 = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					RIGHT = {
						RIGHT = {
							LOOK2ND = {
								RIGHT2 = {
									RIGHT2 = none,
								},
								LEFT2 = {
									LEFT2 = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					LEFT2 = {
						LEFT2 = {
							LOOK2ND = {
								RIGHT = {
									RIGHT = none,
								},
								RIGHT2 = {
									RIGHT2 = none,
								},
								LEFT = {
									LEFT = none,
								},
							},
						},
					},
					LEFT = {
						LEFT = {
							LOOK2ND = {
								RIGHT = {
									RIGHT = none,
								},
								LEFT2 = {
									LEFT2 = none,
								},
								RIGHT2 = {
									RIGHT2 = none,
								},
							},
						},
					},
				},
			},
		},
		IDLE_SOCIAL = {
			GENERICS = {
				FAIL = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			UBO_CHECKS = {
				UNARMED = {
					UNARMED_LOOP = none,
				},
				WEAPON = {
					PERFORMINGACTIONLHANDWEAP = {
						PERFORMINGACTION = none,
					},
					PERFORMINGACTION = {
						PERFORMINGACTION = none,
					},
				},
			},
			AUTHORITY = {
				SOCIALIDLEUNFRIENDLY = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEAGGRESSIVE = none,
			},
			NERDS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			TOUGHFACTIONS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEUNFRIENDLY = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			GIRLS = {
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEDISMISSIVE = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
			FAT = {
				FAIL = none,
				SOCIALIDLEFRIENDLY = none,
				SOCIALIDLEINTIMIDATED = none,
				SOCIALIDLEAGGRESSIVE = none,
				SOCIALIDLESCARED = none,
			},
		},
		IDLE_STEALTH = none,
	},
	{ -- 2
		RUNBASIC = none,
	},
	{ -- 34
		WALKBASIC = none,
	},
	{ -- 7
		COMBATSTRAFEIDLE = none,
	},
	{ -- 2
		LEFTARM_ACTION3 = none,
		LEFTARM_ACTION1 = none,
		LEFTARM_ACTION2 = none,
		LEFTARM_ACTION5 = none,
		LEFTARM_ACTION4 = none,
	},
	{ -- 2
		BOTHARMS_ACTION2 = none,
		BOTHARMS_ACTION1 = none,
		BOTHARMS_ACTION3 = none,
	},
	{ -- 3
		LOOKAROUND_IDLE5 = none,
		LOOKAROUND_IDLE1 = none,
		LOOKAROUND_IDLE6 = none,
		LOOKAROUND_IDLE3 = none,
		LOOKAROUND_IDLE2 = none,
		LOOKAROUND_IDLE4 = none,
	},
	{ -- 2
		RIGHTARM_ACTION1 = none,
		RIGHTARM_ACTION2 = none,
		RIGHTARM_ACTION3 = none,
		RIGHTARM_ACTION5 = none,
		RIGHTARM_ACTION6 = none,
		RIGHTARM_ACTION4 = none,
	},
	{ -- 2
		LOOKLEFT = none,
		LOOKRIGHT = none,
	},
	{ -- 23
		GIVE = none,
		RECEIVE = none,
	},
	{ -- 19
		GIVEINITIATE = {
			GIVE_SEEK = none,
			RECEIVEWAIT = none,
		},
		LOADWAIT = none,
	},
	{ -- 37
		RECEIVE = none,
		GIVE = none,
		SEEK = none,
		RECEIVEWAIT = none,
	},
	{ -- 25
		GIVE = none,
		RECEIVE = none,
		SEEK = none,
	},
	{ -- 2
		ZOE = {
			ZOE = none,
		},
	},
	{ -- 7
		ZOE = none,
	},
	{ -- 7
		PLAYER = none,
	},
	{ -- 2
		ZOESTART = {
			ZOE = {
				PLAYER = {
					ZOE = none,
				},
			},
		},
	},
	{ -- 42
		SHAKEFISTSB = none,
		SHAKEFISTSPEECHADULT = {
			SHAKEFISTSB1 = none,
			SHAKEFISTSB2 = none,
		},
	},
	{ -- 4
		FREE = {
			WALKBASIC = none,
			RUNBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
				},
			},
			DROPOUT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			SPRINTBASIC = none,
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					BILLYCLUBCOMBATBASIC = none,
					BATCOMBATBASIC = none,
					COMBATBASIC = none,
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				GREASERCOMBATSTRAFEIDLE = none,
				WEAPONCOMBATSTRAFEIDLE = none,
				PREFECTCOMBATSTRAFEIDLE = none,
				COMBATSTRAFEIDLE = none,
				JOCKCOMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 3
		LIGHTATTACKS = {
			PUNCH1 = {
				PUNCH2 = {
					HEAVYATTACKS = {
						PUNCH3 = none,
					},
				},
			},
		},
	},
	{ -- 4
		STARTSTOREMODE = none,
	},
	{ -- 5
		AUTHCHECK = {
			FLEE = none,
			HELPYELL = none,
		},
		FLEE = none,
	},
	{ -- 19
		RETALIATE = none,
	},
	{ -- 5
		DEGRADEFACTIONEXEC = none,
	},
	{ -- 5
		HELPTEXT1 = none,
		TATTLETEXT1 = none,
	},
	{ -- 5
		RUNAWAY = none,
	},
	{ -- 2
		ENOUGHMONEY = {
			STARTGAME = none,
		},
	},
	{ -- 3
		FALLDOWN = none,
	},
	{ -- 9
		FEMALE = none,
		MALE = none,
	},
	{ -- 19
		NULL = none,
	},
	{ -- 2
		IDLE = none,
		LOCOMOTETOPROP = none,
	},
	{ -- 2
		RUINDATE = none,
	},
	{ -- 2
		WALL_START = {
			WALL_IDLE = {
				WALL_SMOKE_START = {
					WALL_SMOKE_IDLE = {
						WALL_SMOKE_A = none,
						WALL_SMOKE_B = none,
						WALL_SMOKE_C = none,
					},
				},
				WALL_END = none,
			},
		},
		WALKTOWALL = none,
	},
	{ -- 2
		STEPAWAYEND = none,
	},
	{ -- 5
		JIMMY01 = none,
	},
	{ -- 2
		NONTARGETLOCO = {
			LOCO = none,
		},
	},
	{ -- 2
		GROUNDMOUNT = {
			MOUNTEXECUTE = none,
		},
		STRIKES = {
			HEAVYATTACKS = {
				GROUNDKICK = {
					GROUNDKICKCHARGED = {
						GKFF = none,
						COLLISION = {
							RATPED = none,
							PED = none,
						},
					},
					GROUNDKICK = {
						COLLISION = {
							RATPED = none,
							PED = none,
						},
					},
				},
			},
			LIGHTATTACKS_OLD = {
				GROUNDSTOMP1 = {
					GKFF = none,
					GROUNDSTOMP2 = {
						GKFF = none,
						GROUNDSTOMP3 = {
							GKFF = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		HEAVYATTACKS = {
			LIGHTGROUNDKICK_OLD = none,
			GROUNDKICK = none,
		},
	},
	{ -- 2
		CHECK_DESELECT = none,
		HEAVYATTACKS = {
			RUNSHOULDER = {
				RUNSHOULDERFF = none,
				RUNSHOULDERBACKTORUN = none,
			},
			RUNPUNCH = {
				RUNPUNCHFF = none,
				RUNPUNCHBACKTORUN = none,
			},
		},
	},
	{ -- 2
		HEAVYKICK_FF = none,
		INCREMENTSTATKICKS = none,
		INCREMENTSTATPUNCHES = none,
		HEAVYPUNCH_FF = none,
	},
	{ -- 2
		JAB = none,
		UNBLOCKABLE = {
			HEAVY_PUNCH2 = none,
		},
		HEAVYATTACKS = {
			JAB_CHARGED = none,
			STUNPUNCH = none,
		},
	},
	{ -- 2
		UNBLOCKABLE = {
			LEGKICKRELEASEMAX = none,
		},
		HEAVYATTACKS = {
			CROSS_CHARGED = none,
		},
		CROSS = none,
	},
	{ -- 2
		UNBLOCKABLE = {
			JACKIEKICK = {
				JACKIEKICKLAND = none,
			},
		},
		HEAVYATTACKS = {
			HOOK_CHARGED = none,
		},
		HOOK = none,
	},
	{ -- 2
		GUTPUNCH = none,
		UNBLOCKABLE = {
			HIGHKICK2 = none,
		},
		HEAVYATTACKS = {
			GUTPUNCH_CHARGED = none,
		},
	},
	{ -- 2
		RELEASE = {
			UNBLOCKABLE = {
				HEAVY_PUNCH2 = none,
			},
			HEAVYATTACKS = {
				UPPERCUT_CHARGED = none,
			},
			UPPERCUT = {
				UPPERCUTFF = none,
			},
		},
	},
	{ -- 2
		ANIMATIONS = {
			WEAPONWALK = none,
			WEAPONCROUCH = none,
			WEAPONIDLE = none,
			WEAPONSTRAFE = none,
			ONTREE = {
				IDLE = none,
			},
			WEAPONRUN = none,
			WEAPONBIKEIDLE = none,
			WEAPONSOCIAL = {
				WEAPONIDLE = none,
				PERFORMINGACTION = none,
			},
		},
		GLOBALLOCO = {
			LOCOMOTION = {
				SPRINTDEPLETE = {
					SPRINTDEPLETEEXEC = none,
				},
				WALK = {
					TIRED = {
						TIRED_UBO = none,
						WALKTIRED = none,
					},
					SNEAK = {
						STEALTHWALKSTART = {
							ANIM = none,
						},
						STEALTHWALK = {
							RUNSTART = none,
							WALKSTOP = none,
						},
					},
					NOTTIRED = {
						WALKSTART = none,
						WALK = none,
						WALKSTOP = none,
					},
					ALLY = {
						WALKALLY = none,
					},
					FEMALE = {
						WALKBASIC = none,
					},
				},
				COMBAT = {
					COMBATTRANSITION = {
						COMBATIDLE_OUT = {
							COMBATIDLE_OUT = none,
							STRAFE = none,
						},
						COMBATSTART = {
							IDLE = none,
							STRAFE = {
								ANIM = none,
							},
						},
					},
					DEFAULT = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = {
								ANIM = none,
								NOANIM = none,
							},
						},
					},
					EXECNODES = {
						COMBATIDLETURN = {
							FACINGINTENDED = {
								CCW_SLOW = {
									CCW = none,
									WAIT = none,
									END = none,
								},
								RESET = none,
								FORWARDS = none,
								CW_SLOW = {
									CW = none,
									END = none,
									WAIT = none,
								},
							},
						},
						TARGET = {
							STRAFEMODE = none,
							LOCK = none,
						},
					},
					["0_BLOCK_0"] = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATIDLEBLOCK = none,
						BLOCKSTRAFE = none,
					},
				},
				LOCOMOTIONEXECUTES = {
					CROUCHLOCOTARGET = none,
					NONCOMBATSTRAFE = {
						NC_LOCO = {
							COMBATIDLE_OUT = none,
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
							IDLE = {
								IDLE_ANIM = {
									ANIM = none,
									SOCIALIZING = none,
								},
							},
							NONCOMBATSTRAFEANIMS = {
								WALKSTOP = none,
							},
						},
					},
					STRAFELOCOBASIC = {
						NOSTEERING = none,
						STEERING = none,
					},
					STRAFELOCOBASICANIMS = {
						MELEE = none,
						WEAPON = none,
					},
					RUN_STARTLOCO = {
						DEFAULT = none,
						TURNFAST = none,
					},
					WALK_STARTLOCO = none,
					TIRED_UPPERBODY = none,
					WALKBASIC = none,
					EXHAUSTED_COLLAPSE = {
						EXHAUSTED_COLLAPSE_LOADCHECK = {
							COLLAPSE = {
								COLLAPSELOAD = {
									COLLAPSE = none,
									GRAPPLETARGET = none,
								},
								COLLAPSEOFFLADDER = {
									FALL = none,
								},
								COLLAPSEOFFTREEBRANCH = {
									DOWN = {
										DOWN_END = none,
									},
								},
								COLLAPSEOFFTREEHANG = {
									DOWN = none,
								},
							},
						},
					},
				},
				OFFSETCAM = {
					OFFSETCAM_WEAPON = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = none,
						},
					},
					OFFSETCAM_LOCO = none,
				},
				RUN = {
					RUN = {
						RUNCONTROLLER = {
							RUN = {
								RUN = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
							SPRINT = {
								SPRINTBASIC = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
						},
					},
					TIRED_STOP = none,
					NEWLOCOANIMS = {
						RUNLOCOANIMS = none,
						TIRED_UPPERBODY_SPAWN = {
							NOTTIRED = none,
							TIRED = none,
						},
						TIRED_UPPERBODY = none,
						SPRINTLOCOANIMS = none,
					},
					RUNSTOP = {
						WALKSTOP_WAIT = none,
						RUNSTOP = {
							SKID = {
								RUN_TO_IDLE = {
									LOCO = {
										WINTER = none,
										NORMAL = none,
									},
								},
								SPRINT_SLIDE = none,
							},
						},
						RUNSTOP_WAIT = none,
					},
					RUNSTART = {
						RUNSTART = none,
					},
				},
				CROUCH = {
					CROUCHIDLE = {
						CROUCHIDLE = none,
						CROUCHAIM = {
							TURN = {
								FACINGINTENDED = {
									CCW_SLOW = {
										CCW = none,
										WAIT = none,
										END = none,
									},
									RESET = none,
									FORWARDS = none,
									CW_SLOW = {
										CW = none,
										END = none,
										WAIT = none,
									},
								},
							},
						},
						CROUCHIDLETARGET = none,
					},
					CROUCHEND = {
						CROUCH_OUT_COMBAT = {
							CROUCH_OUT_TARGET = none,
						},
						CROUCH_OUT = none,
					},
					CROUCHSTART = {
						CROUCHSTARTCOMBAT = none,
						CROUCHSTART = none,
					},
					CROUCHLOCO = {
						CROUCHLOCOTARGET = none,
						CROUCHLOCO = {
							CROUCHLOCOANIMS = {
								CROUCHLOCORUN = none,
								CROUCHLOCOBASIC = none,
							},
							RUNCONTROLLER = {
								CROUCHRUN = none,
								CROUCHLOCO = none,
							},
						},
					},
					CROUCH_TIRED = {
						TIRED_UBO = none,
					},
					CRAWLLOCO = {
						CRAWLSTART = {
							CRAWLCYCLE = {
								CROUCHRELEASE = none,
							},
						},
					},
				},
				IDLE = {
					VTIRED = {
						VTIREDACTIONS = {
							AMBIENTACTIONS_VTIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					FEMALE = none,
					TURN = {
						FACINGINTENDED = {
							CW_SLOW_OLD = {
								CW = none,
								END = none,
								WAIT = none,
							},
							RESET = none,
							CCW_SLOW_FEMALE = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS_ACCURATE = none,
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS = none,
							CW_SLOW_FEMALE = {
								CW = none,
								END = none,
								WAIT = none,
							},
							CCW_SLOW_OLD = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
					EXHAUSTED = none,
					TIRED = {
						TIREDACTIONS = {
							AMBIENTACTIONS_TIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					IDLE = {
						AMBIENTACTIONS = {
							AMBIENTACTIONS_GROUPLOAD2 = {
								AMBIENTACTIONS = {
									AMBIENT_9 = none,
									AMBIENT_10 = none,
									AMBIENT_12 = none,
									AMBIENT_11 = none,
									AMBIENT_8 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD1 = {
								AMBIENTACTIONS = {
									AMBIENT_4 = none,
									AMBIENT_6 = none,
									AMBIENT_2 = none,
									AMBIENT_1 = none,
									AMBIENT_7 = none,
									AMBIENT_5 = none,
									AMBIENT_3 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD3 = {
								AMBIENTACTIONS = {
									ARMSONHIPS = none,
									SCRATCHARSE = none,
									SCRATCHHEAD = none,
									SCRATCHPIT = none,
									STRETCH = none,
								},
							},
						},
						MIRRORIDLE = {
							MIRROR_LOAD = {
								MIRRORACTIONS = {
									MIRRORACTIONS2 = none,
									MIRRORACTIONS3 = none,
									MIRRORACTIONS4 = none,
									MIRRORACTIONS1 = none,
								},
							},
						},
						WARMTHFACTOR = {
							FREEZING = {
								DAMAGE = none,
							},
						},
						AMBIENTSPAWN = {
							AMBIENTSPAWN = {
								OPPS = none,
							},
						},
						IDLESPEECH = {
							WAIT = none,
							SAYSOMETHING = {
								VTIRED = none,
								TIRED = none,
								NORMAL = none,
							},
						},
					},
				},
				SOCIAL = {
					SOCIAL_ACTIONS = none,
					SOCIAL = none,
				},
				HANDHOLDING = {
					IDLE = none,
					WALK = {
						WALK_SPEEDS = {
							HANDHOLDING = none,
							OLDPED = none,
						},
						WALKSTOP = none,
					},
				},
			},
		},
	},
	{ -- 2
		JUMP = {
			RUNJUMP = {
				PICKLAUNCH = {
					COMPRESSLEFT = {
						JUMP = {
							LAND = {
								LAND = {
									LOCOBASIC = none,
								},
								LAND_STILL = {
									RESET = none,
								},
							},
						},
					},
					COMPRESSRIGHT = {
						JUMP = {
							LAND = {
								LAND = {
									LOCOBASIC = none,
								},
								LAND_STILL = {
									RESET = none,
								},
							},
						},
					},
				},
			},
			FALLING = {
				FALL_OLD = {
					BELLYUP = {
						AIRSTATE = {
							FALL_LAND = {
								FALL_DAMAGE_LAND = none,
							},
						},
					},
					BELLYDOWN = {
						AIRSTATE = {
							FALL_LAND = {
								FALL_DAMAGE_LAND = none,
							},
						},
					},
					FALL = {
						FALLINGHITGROUND = none,
						FALL_FLAIL = {
							FALL_LAND_SPLAT = {
								SPLAT_DIE = {
									DIE = none,
								},
								SPLAT = none,
							},
							FALL_LAND = none,
							FALL_DAMAGE = {
								LAND = none,
							},
						},
					},
				},
				LAND = {
					SPLAT_DIE = {
						DIE = none,
					},
					FALL_LAND = none,
					SPLAT = none,
					FALL_LAND_NO_DAMAGE = none,
				},
				FALL = {
					FALLING = {
						FALL_NO_DAMAGE = none,
						FALL_DAMAGE = {
							FALL = none,
							FALL_FLAIL = none,
						},
					},
					BELLYDOWN = {
						AIRSTATE = {
							FALL_LAND = {
								FALL_DAMAGE_LAND = none,
							},
						},
					},
					BELLYUP = {
						AIRSTATE = {
							FALL_LAND = {
								FALL_DAMAGE_LAND = none,
							},
						},
					},
				},
			},
			EXECUTENODES = {
				ANIMUPDATE = none,
			},
			RAIL = {
				RAILINTERACT = none,
			},
			IDLEJUMP = {
				IDLEJUMP = none,
				CLIMB_1M = {
					SHAREDCLIMB = none,
				},
				CLIMB_ACTIONS = {
					["6FOOTWALLLANDEARLY"] = none,
					["6FOOTWALLFALL"] = none,
					WALLSTAND = none,
				},
				["CLIMB_2-25M"] = none,
				["CLIMB_1-5M"] = {
					SHAREDCLIMB = none,
				},
			},
			SPRINTJUMP = {
				PICKLAUNCH = {
					COMPRESSLEFT = {
						JUMP = {
							LAND = {
								LAND = {
									SPEEDRUN = none,
								},
								LAND_STILL = {
									RESET = none,
								},
							},
						},
					},
					COMPRESSRIGHT = {
						JUMP = {
							LAND = {
								LAND = {
									SPEEDRUN = none,
								},
								LAND_STILL = {
									RESET = none,
								},
							},
						},
					},
				},
			},
			GENERICEXECUTE = {
				SETUPBBALL = none,
			},
			FALLINGOPPS = {
				FALLINGOPPSBASE = none,
			},
			JUMPOPS = {
				PLAYERUNINTERRUPTIBLE = none,
			},
		},
	},
	{ -- 2
		CHEER2 = none,
	},
	{ -- 2
		CROUCHHIDE = none,
		ENDHIDE = none,
	},
	{ -- 4
		WALL_SMOKE_A = none,
		WALL_SMOKE_B = none,
		WALL_SMOKE_STUB = none,
	},
	{ -- 7
		NUTKICK = none,
	},
	{ -- 3
		ENDINGSEQUENCES = {
			PUTOUTCIGEND = none,
			STEPAWAYEND = none,
		},
		WALKTOWALL = none,
		WALL_START = {
			WALL_IDLE = {
				WALL_SMOKE_START = {
					WALL_SMOKE_IDLE = {
						WALL_SMOKE_IDLE_CHILD = {
							WALL_SMOKE_A = none,
							WALL_SMOKE_B = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		PED1_IDLE2 = none,
		PED1_IDLE_END = none,
	},
	{ -- 2
		ACTIVECOMBAT = {
			SPECIAL = none,
			COMBATLOCO = none,
			WAIT = none,
		},
	},
	{ -- 4
		HITREACTWAIT = {
			TURNTOFACE = {
				ATTACKCHECK = {
					SEEATTACKER = {
						FEAR = {
							AUTHCHECK = {
								FLEE = none,
								HELPYELL = none,
							},
							FLEE = none,
						},
						ATTACKED = none,
						CHICKENS = {
							CHICKENWARN = {
								CHICKENFLEE = {
									TELLAUTHORITY = none,
								},
							},
						},
					},
					SEEDISLIKED = {
						RETALIATE = none,
					},
					DEGRADEFACTION = {
						DEGRADEFACTIONEXEC = none,
					},
					LOOKAROUND = none,
					REACTTEXT = {
						HELPTEXT1 = none,
						TATTLETEXT1 = none,
					},
					ATTACKFIX = none,
				},
			},
		},
	},
	{ -- 7
		DEAD = none,
		ONGROUND = {
			RISINGATTACKS = none,
		},
	},
	{ -- 6
		GRAPPLED = none,
	},
	{ -- 2
		AMBIENT = {
			GREET = {
				WAIT = none,
				WAVE = none,
			},
			FOLLOWPATH = none,
			WANDER = none,
			IDLE = none,
		},
		REACTIONS = {
			COMBAT = {
				PROJECTILE = none,
				COWER = none,
				FLEE = none,
				HANDTOHAND = none,
			},
			OBJECTIVES = {
				MOVEOBJECTIVE = none,
				H2HATTACKOBJ = none,
				RANGEATTACKOBJ = none,
				FACEOBJECTIVE = none,
			},
			WORK = {
				PREFECT = {
					PREFPUNISH2 = none,
					PREFPUNISH1 = none,
				},
				COP = {
					COPPUNISH2 = none,
					COPPUNISH1 = none,
				},
				TEACHER = {
					WARNING = none,
				},
			},
			CONTROLLER = {
				CONTROLLER2 = none,
			},
		},
		STOP = none,
	},
	{ -- 2
		COUNTER = {
			GRAPPLE = none,
		},
	},
	{ -- 42
		SHAKEFISTSB1 = none,
		SHAKEFISTSB2 = none,
	},
	{ -- 2
		STANDINGIDLESEXECUTE = none,
	},
	{ -- 36
		FACTION_IDLE2 = none,
		FACTION_IDLE1 = none,
	},
	{ -- 55
		WALKIDLESEXECUTE = none,
	},
	{ -- 5
		LAND = none,
	},
	{ -- 2
		BAIL = none,
		LAND = none,
	},
	{ -- 2
		BASE = none,
	},
	{ -- 58
		JOINTDRIVERS = none,
	},
	{ -- 2
		SWINGRIGHTEXEC = none,
		SWINGLEFTEXEC = none,
		DIRECTIONAL = {
			RIGHT = none,
			LEFT = none,
		},
	},
	{ -- 2
		ATTEMPT = {
			ATTEMPTCOLLISION = none,
		},
		RCV = {
			JOINTDRIVERS = {
				MOWER = none,
				NOTMOWER = none,
			},
		},
		GIVE = {
			JOINTDRIVERS = none,
		},
	},
	{ -- 17
		GIVE = none,
	},
	{ -- 11
		RIGHT = none,
		LEFT = none,
	},
	{ -- 2
		ATTEMPTCOLLISION = none,
	},
	{ -- 2
		JOINTDRIVERS = {
			MOWER = none,
			NOTMOWER = none,
		},
	},
	{ -- 3
		BIKEJACKRIGHT = none,
	},
	{ -- 2
		DESELECTONRIGHT = none,
		DESELECT = none,
		DROPNONINV = {
			DROP = none,
		},
	},
	{ -- 4
		GETON = none,
	},
	{ -- 3
		BIKEJACKLEFT = none,
	},
	{ -- 3
		DROP = none,
	},
	{ -- 2
		NOTUPRIGHT = {
			MOVETOPICKUP = none,
			MOVETOPULLUP = none,
		},
		MOVETOVEHICLEBASE = {
			MOVETO = none,
		},
		MOVETO = none,
	},
	{ -- 2
		MOVETOPICKUP = none,
		MOVETOPULLUP = none,
	},
	{ -- 6
		MOVETO = none,
	},
	{ -- 3
		TURNLEFT = none,
		TURNRIGHT = none,
	},
	{ -- 2
		MAINTAIN_COAST = none,
	},
	{ -- 2
		HIGHSEAT = none,
		LOWSEAT = none,
	},
	{ -- 2
		TURNLEFT = {
			TURNEND = none,
		},
		TURNRIGHT = {
			TURNEND = none,
		},
	},
	{ -- 2
		MISSIONSUCCESS = none,
	},
	{ -- 4
		TURNEND = none,
	},
	{ -- 2
		ONMARK2 = none,
		ONMARK1 = none,
		ONMARK3 = none,
	},
	{ -- 2
		RESETONFOOT = none,
	},
	{ -- 2
		HITHARDFRONTLONG = none,
	},
	{ -- 2
		HITHARDBACKLONG = none,
	},
	{ -- 4
		STINKSPEECHNODE = none,
	},
	{ -- 4
		HITFRONT = none,
	},
	{ -- 3
		HITRIGHT = {
			HITRIGHT = none,
		},
		HITFRONT = {
			HITFRONT = none,
		},
		HITLEFT = {
			HITLEFT = none,
		},
		HITBACK = {
			HITBACK = none,
		},
	},
	{ -- 2
		HITINTHEAIR = {
			PLAYERCAMERACUT = none,
		},
	},
	{ -- 2
		RIDEON = {
			HITHARDLEFT = {
				HITHARDLEFT = none,
			},
			HITHARDRIGHT = {
				HITHARDRIGHT = none,
			},
		},
	},
	{ -- 2
		AIRSTAND = none,
	},
	{ -- 6
		SPEECH = none,
	},
	{ -- 3
		BUNNYHOP_LAND = none,
	},
	{ -- 2
		BUNNYHOP_LANDTRICK = none,
		BUNNYHOP_LAND = none,
	},
	{ -- 2
		PUNCHTRANSITIONOUT = {
			RIDING = none,
			NOTRIDING = none,
		},
	},
	{ -- 2
		CHARGE = {
			RELEASE = {
				LIGHTATTACKS = {
					EXTENDED = {
						RETRACT = none,
					},
				},
				HEAVYATTACKS = {
					EXTENDED = {
						RETRACT = none,
					},
				},
			},
		},
	},
	{ -- 2
		RELEASE = {
			LIGHTATTACKS = {
				EXTENDED = {
					RETRACT = none,
				},
			},
			HEAVYATTACKS = {
				EXTENDED = {
					RETRACT = none,
				},
			},
		},
	},
	{ -- 3
		RIDING = none,
		NOTRIDING = none,
	},
	{ -- 2
		PLAYER = none,
		PED = none,
	},
	{ -- 2
		DEFAULT = {
			FRONT = none,
		},
	},
	{ -- 2
		RIGHT = none,
		BACK = none,
		LEFT = none,
	},
	{ -- 2
		GETOFF = {
			GETOFFVEHICLERIDE = none,
			GETOFFVEHICLESTILL_SLOWDOWN = {
				GETOFFVEHICLESTILLLEFT = none,
				GETOFFVEHICLESTILL = none,
			},
		},
	},
	{ -- 2
		SELACTION = none,
	},
	{ -- 2
		JV_STAND = none,
	},
	{ -- 2
		JOHNNY01 = none,
	},
	{ -- 5
		POINTS = {
			RATE = none,
		},
	},
	{ -- 5
		RATE = none,
	},
	{ -- 3
		PASSENGER = {
			PASSENGERIDLE = none,
		},
		DRIVER = {
			FORWARD = {
				DRIVERIDLE = none,
				TURNRIGHT = none,
				TURNLEFT = none,
			},
			REVERSE = {
				BACK = none,
				TURNLEFT = none,
				TURNRIGHT = none,
			},
		},
	},
	{ -- 3
		PASSENGERIDLE = none,
	},
	{ -- 5
		FORWARD = {
			DRIVERIDLE = none,
			TURNRIGHT = none,
			TURNLEFT = none,
		},
		REVERSE = {
			BACK = none,
			TURNLEFT = none,
			TURNRIGHT = none,
		},
	},
	{ -- 2
		DRIVER = {
			FORWARD = {
				DRIVERIDLE = none,
				TURNRIGHT = none,
				TURNLEFT = none,
			},
			REVERSE = {
				BACK = none,
				TURNLEFT = none,
				TURNRIGHT = none,
			},
		},
	},
	{ -- 5
		DRIVERIDLE = none,
		TURNRIGHT = none,
		TURNLEFT = none,
	},
	{ -- 5
		BACK = none,
		TURNLEFT = none,
		TURNRIGHT = none,
	},
	{ -- 2
		ATTEMPT = none,
		RCV = {
			JOINTDRIVERS = none,
		},
		GIVE = {
			JOINTDRIVERS = none,
		},
	},
	{ -- 8
		VICTORY = none,
	},
	{ -- 2
		EXITVEHICLERIGHT = none,
		EXITVEHICLE = none,
	},
	{ -- 3
		PASSENGER = {
			EXITVEHICLE = none,
		},
		DRIVER = {
			EXITVEHICLE = none,
		},
	},
	{ -- 9
		EXITVEHICLE = none,
	},
	{ -- 4
		MOVETO = none,
		MOVETOVEHICLEBASE = {
			MOVETO = none,
		},
	},
	{ -- 2
		TRUCK = none,
		MOWER = none,
		["GO-KART"] = none,
		SEDAN = none,
		SUV = none,
	},
	{ -- 3
		HITRIGHT = none,
	},
	{ -- 3
		HITLEFT = none,
	},
	{ -- 3
		HITBACK = none,
	},
	{ -- 2
		TURN = {
			TURNLEFT = none,
			TURNRIGHT = none,
		},
		NONCOAST = {
			LINEAR = {
				PEDAL = none,
				BREAK = none,
				WALKBACK = none,
			},
			STAND = none,
		},
		COAST = none,
	},
	{ -- 2
		STINKSPEECH = {
			STINKSPEECHNODE = none,
		},
	},
	{ -- 5
		PLAYERCAMERACUT = none,
	},
	{ -- 2
		HITHARDLEFT = {
			HITHARDLEFT = none,
		},
		HITHARDRIGHT = {
			HITHARDRIGHT = none,
		},
	},
	{ -- 2
		GRAPTHROW = none,
	},
	{ -- 25
		FRONT = none,
	},
	{ -- 2
		PUNCHLEFT = {
			PUNCHLEFTHOLD = {
				PUNCHLEFTRELEASE = none,
			},
		},
	},
	{ -- 2
		PUNCHLEFTHOLD = {
			PUNCHLEFTRELEASE = none,
		},
	},
	{ -- 2
		PUNCHRIGHT = {
			PUNCHRIGHTHOLD = {
				PUNCHRIGHTRELEASE = none,
			},
		},
	},
	{ -- 2
		PUNCHRIGHTHOLD = {
			PUNCHRIGHTRELEASE = none,
		},
	},
	{ -- 2
		GETOFFVEHICLERIDE = none,
		GETOFFVEHICLESTILL_SLOWDOWN = {
			GETOFFVEHICLESTILLLEFT = none,
			GETOFFVEHICLESTILL = none,
		},
	},
	{ -- 2
		PICKUPBIKERIGHT = none,
		PICKUPBIKELEFT = none,
	},
	{ -- 2
		CHECK_DESELECT = none,
		BASE = {
			GETON = none,
		},
		RIGHTHANDSIDE = none,
		LEFTHANDSIDE = none,
	},
	{ -- 2
		LINEAR = {
			PEDAL = none,
			BREAK = none,
			WALKBACK = none,
		},
		STAND = none,
	},
	{ -- 3
		MOVETO = {
			ORIENTONLY = none,
		},
	},
	{ -- 4
		ORIENTONLY = none,
	},
	{ -- 3
		GETOFFVEHICLESTILLLEFT = none,
		GETOFFVEHICLESTILL = none,
	},
	{ -- 2
		ACTIVATEDOOR = none,
	},
	{ -- 2
		KICKBALLSPAWN = {
			DETERMINESPEED = {
				RUN = none,
				WALK = none,
				SPRINT = none,
			},
		},
		LOOP = none,
	},
	{ -- 2
		IDLE = {
			TURNSTART = {
				TURNING = {
					TURNSPAWNS = {
						DELAY = none,
						WAIT = none,
					},
					TURN_END = none,
				},
			},
		},
	},
	{ -- 2
		TURNSTART = {
			TURNING = {
				TURNSPAWNS = {
					DELAY = none,
					WAIT = none,
				},
				TURN_END = none,
			},
		},
	},
	{ -- 2
		FALL_LOOP = {
			ONGROUNDBOUNCE = {
				BELLYDOWNGETUP = none,
			},
		},
	},
	{ -- 2
		ONGROUNDBOUNCE = {
			BELLYDOWNGETUP = none,
		},
	},
	{ -- 2
		GETON_PLAYER = none,
	},
	{ -- 2
		BREAKER = {
			BREAKER_RIGHT = none,
			BREAKER = none,
			BREAKER_LEFT = none,
		},
		HITSLIGHT = {
			HITRIGHT = none,
			HITMID = none,
			HITLEFT = none,
			HIT = none,
		},
	},
	{ -- 2
		FRONT = {
			MEDCHAR = none,
			LARGECHAR = none,
		},
		REAR = none,
	},
	{ -- 4
		FRONT = {
			FRONT = none,
		},
		REAR = none,
	},
	{ -- 6
		FRONT = {
			FRONT = none,
		},
		REAR = {
			REAR = none,
		},
	},
	{ -- 3
		FRONT = {
			FRONT = none,
		},
	},
	{ -- 2
		MEDCHAR = none,
		LARGECHAR = none,
	},
	{ -- 2
		FRONT = none,
		REAR = {
			REAR = none,
		},
	},
	{ -- 13
		REAR = none,
	},
	{ -- 39
		FRONT = none,
		REAR = none,
	},
	{ -- 4
		FRONT = {
			FRONT_FLOAT = {
				FRONT_FALL = none,
			},
		},
		REAR = {
			REAR = none,
		},
	},
	{ -- 4
		FRONT_FLOAT = {
			FRONT_FALL = none,
		},
	},
	{ -- 4
		FRONT_FALL = none,
	},
	{ -- 16
		DEFAULT = none,
	},
	{ -- 12
		ON_GROUND = none,
	},
	{ -- 19
		DEFAULT = none,
		SHOVED = none,
	},
	{ -- 2
		SHOVED_S = {
			DEFAULT = none,
			SHOVED = none,
		},
		SHOVED_A = {
			DEFAULT = none,
			SHOVED = none,
		},
		SHOVED_I = {
			DEFAULT = none,
			SHOVED = none,
		},
		SHOVED_F = {
			DEFAULT = none,
			SHOVED = none,
		},
	},
	{ -- 3
		DEFAULTREAR = none,
		DEFAULTFRONT = none,
	},
	{ -- 2
		LARGE = {
			FRONT = none,
			REAR = none,
		},
		DEFAULT = {
			FRONT = none,
			REAR = none,
		},
	},
	{ -- 14
		GETUP = none,
	},
	{ -- 2
		DEFAULT = none,
		MEDIUM = none,
		SPUD = none,
	},
	{ -- 2
		DEFAULT = none,
		SPUD = none,
	},
	{ -- 2
		RBANDBALL = none,
	},
	{ -- 2
		HITFACE = none,
	},
	{ -- 2
		SLIDEDOWNWALL = {
			SLIDE = none,
		},
		HITBACK = none,
		REHITS = {
			RIGHT = none,
			LEFT = none,
			STRAIGHT = none,
		},
	},
	{ -- 2
		AUTHORITY = none,
		FEMALE = none,
		MALE = none,
		NERD = none,
	},
	{ -- 2
		DISPATCH = none,
		FILTER = none,
	},
	{ -- 2
		HIT_LEFT = none,
		HIT_RIGHT = none,
		HIT_OTHER = none,
	},
	{ -- 2
		IMMUNE = none,
		HIT = none,
	},
	{ -- 2
		HUMILIATEFLEE = none,
		MISSIONPED = {
			RUNSTART = {
				WEAKPED = none,
			},
		},
	},
	{ -- 2
		BELLYUP = none,
		BELLYDOWN = none,
	},
	{ -- 2
		HIT_LEFT = none,
		HIT_RIGHT = none,
	},
	{ -- 4
		APPLYTORCH = none,
	},
	{ -- 8
		SUCCESSHI2 = none,
		SUCCESSMED1 = none,
		SUCCESSHI1 = none,
		SUCCESSHI3 = none,
	},
	{ -- 4
		CLEANUPHANDS_CHILD = none,
	},
	{ -- 18
		PLAYERFAIL04 = none,
		PLAYERFAIL01 = none,
		PLAYERFAIL03 = none,
		PLAYERFAIL02 = none,
	},
	{ -- 2
		GIVE = none,
		RECEIVE = {
			SWITCHEROO2 = {
				DELETEBEAR = none,
			},
		},
	},
	{ -- 2
		GIVEINITIATE = {
			GIVE_SEEK = {
				SEEKENTITY = none,
				GIVE_WAIT = none,
				SWITCHEROO = none,
			},
			RECEIVEWAIT = none,
		},
		LOADWAIT = none,
	},
	{ -- 2
		RECEIVE = {
			FEMALE = none,
		},
		GIVE = none,
		SEEK = none,
		RECEIVEWAIT = none,
	},
	{ -- 6
		RECEIVE = none,
		GIVE = none,
		GIVEWAIT = none,
		SEEK = none,
		RECEIVEWAIT = none,
	},
	{ -- 6
		WEAPONWALK = {
			COMBAT = none,
			DEFAULT = none,
		},
		WEAPONBIKEIDLE = none,
		WEAPONSOCIAL = {
			WEAPONIDLE = none,
			PERFORMINGACTION = none,
		},
		WEAPONCROUCH = none,
		WEAPONRUN = none,
		WEAPONSTRAFE = none,
		WEAPONIDLE = {
			COMBAT = none,
			DEFAULT = none,
		},
	},
	{ -- 21
		SPRINTDEPLETE = {
			SPRINTDEPLETEEXEC = none,
		},
		WALK = {
			TIRED = {
				TIRED_UBO = none,
				WALKTIRED = none,
			},
			SNEAK = {
				STEALTHWALKSTART = {
					ANIM = none,
				},
				STEALTHWALK = {
					RUNSTART = none,
					WALKSTOP = none,
				},
			},
			NOTTIRED = {
				WALKSTART = none,
				WALK = none,
				WALKSTOP = none,
			},
			ALLY = {
				WALKALLY = none,
			},
			FEMALE = {
				WALKBASIC = none,
			},
		},
		COMBAT = {
			COMBATTRANSITION = {
				COMBATIDLE_OUT = {
					COMBATIDLE_OUT = none,
					STRAFE = none,
				},
				COMBATSTART = {
					IDLE = none,
					STRAFE = {
						ANIM = none,
					},
				},
			},
			DEFAULT = {
				COMBATRUN = {
					RUNSTRAFEMODE = {
						STRAFERUNFWD = none,
						STRAFERUNBKW = none,
					},
				},
				COMBATSTRAFE = none,
				COMBATIDLE = {
					ANIM = {
						ANIM = none,
						NOANIM = none,
					},
				},
			},
			EXECNODES = {
				COMBATIDLETURN = {
					FACINGINTENDED = {
						CCW_SLOW = {
							CCW = none,
							WAIT = none,
							END = none,
						},
						RESET = none,
						FORWARDS = none,
						CW_SLOW = {
							CW = none,
							END = none,
							WAIT = none,
						},
					},
				},
				TARGET = {
					STRAFEMODE = none,
					LOCK = none,
				},
			},
			["0_BLOCK_0"] = {
				COMBATRUN = {
					RUNSTRAFEMODE = {
						STRAFERUNFWD = none,
						STRAFERUNBKW = none,
					},
				},
				COMBATIDLEBLOCK = none,
				BLOCKSTRAFE = none,
			},
		},
		LOCOMOTIONEXECUTES = {
			CROUCHLOCOTARGET = none,
			NONCOMBATSTRAFE = {
				NC_LOCO = {
					COMBATIDLE_OUT = none,
					RUNSTRAFEMODE = {
						STRAFERUNFWD = none,
						STRAFERUNBKW = none,
					},
					IDLE = {
						IDLE_ANIM = {
							ANIM = none,
							SOCIALIZING = none,
						},
					},
					NONCOMBATSTRAFEANIMS = {
						WALKSTOP = none,
					},
				},
			},
			STRAFELOCOBASIC = {
				NOSTEERING = none,
				STEERING = none,
			},
			STRAFELOCOBASICANIMS = {
				MELEE = none,
				WEAPON = none,
			},
			RUN_STARTLOCO = {
				DEFAULT = none,
				TURNFAST = none,
			},
			WALK_STARTLOCO = none,
			TIRED_UPPERBODY = none,
			WALKBASIC = none,
			EXHAUSTED_COLLAPSE = {
				EXHAUSTED_COLLAPSE_LOADCHECK = {
					COLLAPSE = {
						COLLAPSELOAD = {
							COLLAPSE = none,
							GRAPPLETARGET = none,
						},
						COLLAPSEOFFLADDER = {
							FALL = none,
						},
						COLLAPSEOFFTREEBRANCH = {
							DOWN = {
								DOWN_END = none,
							},
						},
						COLLAPSEOFFTREEHANG = {
							DOWN = none,
						},
					},
				},
			},
		},
		OFFSETCAM = {
			OFFSETCAM_WEAPON = {
				COMBATRUN = {
					RUNSTRAFEMODE = {
						STRAFERUNFWD = none,
						STRAFERUNBKW = none,
					},
				},
				COMBATSTRAFE = none,
				COMBATIDLE = {
					ANIM = none,
				},
			},
			OFFSETCAM_LOCO = none,
		},
		RUN = {
			RUN = {
				RUNCONTROLLER = {
					RUN = {
						RUN = {
							LOCOTRACKS = {
								DEFAULT = none,
								TURNFAST = none,
							},
						},
					},
					SPRINT = {
						SPRINTBASIC = {
							LOCOTRACKS = {
								DEFAULT = none,
								TURNFAST = none,
							},
						},
					},
				},
			},
			TIRED_STOP = none,
			NEWLOCOANIMS = {
				RUNLOCOANIMS = none,
				TIRED_UPPERBODY_SPAWN = {
					NOTTIRED = none,
					TIRED = none,
				},
				TIRED_UPPERBODY = none,
				SPRINTLOCOANIMS = none,
			},
			RUNSTOP = {
				WALKSTOP_WAIT = none,
				RUNSTOP = {
					SKID = {
						RUN_TO_IDLE = {
							LOCO = {
								WINTER = none,
								NORMAL = none,
							},
						},
						SPRINT_SLIDE = none,
					},
				},
				RUNSTOP_WAIT = none,
			},
			RUNSTART = {
				RUNSTART = none,
			},
		},
		CROUCH = {
			CROUCHIDLE = {
				CROUCHIDLE = none,
				CROUCHAIM = {
					TURN = {
						FACINGINTENDED = {
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							RESET = none,
							FORWARDS = none,
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
				},
				CROUCHIDLETARGET = none,
			},
			CROUCHEND = {
				CROUCH_OUT_COMBAT = {
					CROUCH_OUT_TARGET = none,
				},
				CROUCH_OUT = none,
			},
			CROUCHSTART = {
				CROUCHSTARTCOMBAT = none,
				CROUCHSTART = none,
			},
			CROUCHLOCO = {
				CROUCHLOCOTARGET = none,
				CROUCHLOCO = {
					CROUCHLOCOANIMS = {
						CROUCHLOCORUN = none,
						CROUCHLOCOBASIC = none,
					},
					RUNCONTROLLER = {
						CROUCHRUN = none,
						CROUCHLOCO = none,
					},
				},
			},
			CROUCH_TIRED = {
				TIRED_UBO = none,
			},
			CRAWLLOCO = {
				CRAWLSTART = {
					CRAWLCYCLE = {
						CROUCHRELEASE = none,
					},
				},
			},
		},
		IDLE = {
			VTIRED = {
				VTIREDACTIONS = {
					AMBIENTACTIONS_VTIRED = {
						AMBIENTACTIONS_OPP = none,
						AMBIENTACTIONS = {
							AMBIENT_1 = none,
							AMBIENT_2 = none,
							AMBIENT_3 = none,
						},
					},
				},
			},
			FEMALE = none,
			TURN = {
				FACINGINTENDED = {
					CW_SLOW_OLD = {
						CW = none,
						END = none,
						WAIT = none,
					},
					RESET = none,
					CCW_SLOW_FEMALE = {
						CCW = none,
						WAIT = none,
						END = none,
					},
					FORWARDS_ACCURATE = none,
					CCW_SLOW = {
						CCW = none,
						WAIT = none,
						END = none,
					},
					FORWARDS = none,
					CW_SLOW_FEMALE = {
						CW = none,
						END = none,
						WAIT = none,
					},
					CCW_SLOW_OLD = {
						CCW = none,
						WAIT = none,
						END = none,
					},
					CW_SLOW = {
						CW = none,
						END = none,
						WAIT = none,
					},
				},
			},
			EXHAUSTED = none,
			TIRED = {
				TIREDACTIONS = {
					AMBIENTACTIONS_TIRED = {
						AMBIENTACTIONS_OPP = none,
						AMBIENTACTIONS = {
							AMBIENT_1 = none,
							AMBIENT_2 = none,
							AMBIENT_3 = none,
						},
					},
				},
			},
			IDLE = {
				AMBIENTACTIONS = {
					AMBIENTACTIONS_GROUPLOAD2 = {
						AMBIENTACTIONS = {
							AMBIENT_9 = none,
							AMBIENT_10 = none,
							AMBIENT_12 = none,
							AMBIENT_11 = none,
							AMBIENT_8 = none,
						},
					},
					AMBIENTACTIONS_GROUPLOAD1 = {
						AMBIENTACTIONS = {
							AMBIENT_4 = none,
							AMBIENT_6 = none,
							AMBIENT_2 = none,
							AMBIENT_1 = none,
							AMBIENT_7 = none,
							AMBIENT_5 = none,
							AMBIENT_3 = none,
						},
					},
					AMBIENTACTIONS_GROUPLOAD3 = {
						AMBIENTACTIONS = {
							ARMSONHIPS = none,
							SCRATCHARSE = none,
							SCRATCHHEAD = none,
							SCRATCHPIT = none,
							STRETCH = none,
						},
					},
				},
				MIRRORIDLE = {
					MIRROR_LOAD = {
						MIRRORACTIONS = {
							MIRRORACTIONS2 = none,
							MIRRORACTIONS3 = none,
							MIRRORACTIONS4 = none,
							MIRRORACTIONS1 = none,
						},
					},
				},
				WARMTHFACTOR = {
					FREEZING = {
						DAMAGE = none,
					},
				},
				AMBIENTSPAWN = {
					AMBIENTSPAWN = {
						OPPS = none,
					},
				},
				IDLESPEECH = {
					WAIT = none,
					SAYSOMETHING = {
						VTIRED = none,
						TIRED = none,
						NORMAL = none,
					},
				},
			},
		},
		SOCIAL = {
			SOCIAL_ACTIONS = none,
			SOCIAL = none,
		},
		HANDHOLDING = {
			IDLE = none,
			WALK = {
				WALK_SPEEDS = {
					HANDHOLDING = none,
					OLDPED = none,
				},
				WALKSTOP = none,
			},
		},
	},
	{ -- 3
		PIPE = none,
		DEFAULT_BAT = none,
	},
	{ -- 2
		POWSWING_CHARGED = none,
	},
	{ -- 3
		FREE = {
			RUNBASIC = {
				RUNBASIC = none,
				RUNBASICFAT = none,
			},
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					SEXYGIRL = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
					},
					NERDGIRL = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_D = none,
												IDLE_E_OPP = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
										IDLE_E = {
											IDLE_E = {
												IDLE_F_OPP = none,
												IDLE_E = none,
											},
										},
										IDLE_F = {
											IDLE_F = {
												IDLE_A_OPP = none,
												IDLE_F = none,
											},
										},
									},
								},
							},
						},
					},
					CHEERLEAD = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKA = {
									IDLES = {
										IDLE_E = {
											IDLE_E = {
												IDLE_F_OPP = none,
												IDLE_E = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_D = none,
												IDLE_E_OPP = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
										IDLE_G = {
											IDLE_G = {
												IDLE_A_OPP = none,
												IDLE_G = none,
											},
										},
										IDLE_F = {
											IDLE_F = {
												IDLE_G_OPP = none,
												IDLE_F = none,
											},
										},
									},
								},
							},
						},
					},
					WOMAN = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					GENERICGIRL = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
			SPRINTBASIC = none,
			WALKBASIC = {
				WALKBASICFAT = none,
				FAT_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				FEMALE_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								SKIPPING = {
									SKIPPING = none,
									BITCH = none,
								},
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				WALKBASIC = {
					WALKWEENVAMP = none,
					WALKWEENSKIP = none,
				},
				WALKBASICNERD = none,
				NERD_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							NOOVERRIDE = none,
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
						},
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = none,
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = none,
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 4
		LIGHTATTACKS = {
			SLAP = none,
		},
		HEAVYATTACKS = {
			NUTKICK = none,
		},
	},
	{ -- 2
		NPC_BAT = {
			HEAVYATTACKS = {
				POWERSWING = none,
				SWING1 = {
					SWING2 = {
						SWING3 = none,
					},
				},
			},
		},
	},
	{ -- 3
		PUTOUTCIGEND = none,
		STEPAWAYEND = none,
	},
	{ -- 3
		WALL_IDLE = {
			WALL_SMOKE_START = {
				WALL_SMOKE_IDLE = {
					WALL_SMOKE_IDLE_CHILD = {
						WALL_SMOKE_A = none,
						WALL_SMOKE_B = none,
					},
				},
			},
		},
	},
	{ -- 12
		PULL_IN_HEAVY = {
			HELD = none,
			HOLD_IDLE = {
				GIVE = none,
				GRAPPLEBREAK = {
					BREAK_RCV = none,
					BREAK_GIVE = none,
				},
				RCV = none,
			},
			HOLD = none,
		},
		GRAPPLERCVWAIT = none,
	},
	{ -- 2
		GRAPPLEATTEMPT = {
			GRAPPLESUCCESS = {
				PULL_IN_HEAVY = {
					HELD = none,
					DOBUSTEDANIMS = {
						GETHIT1 = none,
						GETHIT2 = none,
					},
					HOLD = none,
					BRUTEANIMATION = {
						BEHARSH = none,
					},
					DOCOPANIMATIONS = {
						COP3 = none,
						COP1 = none,
						COP2 = none,
						COP4 = none,
					},
				},
				GRAPPLERCVWAIT = none,
			},
		},
	},
	{ -- 3
		TALKINGLOOPS = {
			TALKING4 = none,
			TALKING7 = none,
			LISTEN2 = none,
			TALKING1 = none,
			TALKING3 = none,
			TALKING2 = none,
			LISTEN3 = none,
			LISTEN1 = none,
			LISTEN4 = none,
			TALKING5 = none,
			TALKING6 = none,
		},
	},
	{ -- 2
		BATHROOM_3 = none,
		BATHROOM_4 = none,
		BATHROOM_2 = none,
		BATHROOM_1 = none,
		RELEASEGROUP = {
			RELEASEGROUP_CHILD = none,
		},
	},
	{ -- 12
		HELD = none,
		HOLD_IDLE = {
			GIVE = none,
			GRAPPLEBREAK = {
				BREAK_RCV = none,
				BREAK_GIVE = none,
			},
			RCV = none,
		},
		HOLD = none,
	},
	{ -- 12
		GIVE = none,
		GRAPPLEBREAK = {
			BREAK_RCV = none,
			BREAK_GIVE = none,
		},
		RCV = none,
	},
	{ -- 2
		GRAPPLEATTEMPT = {
			GRAPPLESUCCESS = {
				PULL_IN_HEAVY = {
					HELD = none,
					HOLD = none,
					GRAPPLEBREAK = {
						BREAK_RCV = none,
						BREAK_GIVE = none,
					},
				},
				GRAPPLERCVWAIT = none,
			},
		},
	},
	{ -- 20
		BREAK_RCV = none,
		BREAK_GIVE = none,
	},
	{ -- 20
		HIT = none,
	},
	{ -- 3
		SHORTEXECUTE = none,
	},
	{ -- 23
		SPRINTDEPLETEEXEC = none,
	},
	{ -- 23
		IDLE = none,
		STRAFE = {
			ANIM = none,
		},
	},
	{ -- 22
		COMBATRUN = {
			RUNSTRAFEMODE = {
				STRAFERUNFWD = none,
				STRAFERUNBKW = none,
			},
		},
		COMBATSTRAFE = none,
		COMBATIDLE = {
			ANIM = {
				ANIM = none,
				NOANIM = none,
			},
		},
	},
	{ -- 22
		COMBATIDLETURN = {
			FACINGINTENDED = {
				CCW_SLOW = {
					CCW = none,
					WAIT = none,
					END = none,
				},
				RESET = none,
				FORWARDS = none,
				CW_SLOW = {
					CW = none,
					END = none,
					WAIT = none,
				},
			},
		},
		TARGET = {
			STRAFEMODE = none,
			LOCK = none,
		},
	},
	{ -- 22
		COMBATRUN = {
			RUNSTRAFEMODE = {
				STRAFERUNFWD = none,
				STRAFERUNBKW = none,
			},
		},
		COMBATIDLEBLOCK = none,
		BLOCKSTRAFE = none,
	},
	{ -- 22
		SOCIAL_ACTIONS = none,
		SOCIAL = none,
	},
	{ -- 44
		LOCOTRACKS = {
			DEFAULT = none,
			TURNFAST = none,
		},
	},
	{ -- 66
		DEFAULT = none,
		TURNFAST = none,
	},
	{ -- 22
		NOTTIRED = none,
		TIRED = none,
	},
	{ -- 2
		SLIDETURN = {
			SLIDETURN180SNAP = none,
		},
	},
	{ -- 22
		RUNSTART = none,
	},
	{ -- 4
		AMBIENTACTIONS = {
			AMBIENT_1 = none,
			AMBIENT_2 = none,
			AMBIENT_3 = none,
		},
	},
	{ -- 108
		CCW = none,
		WAIT = none,
		END = none,
	},
	{ -- 108
		CW = none,
		END = none,
		WAIT = none,
	},
	{ -- 3
		AMBIENTACTIONS_TIRED = {
			AMBIENTACTIONS = {
				AMBIENT_1 = none,
				AMBIENT_2 = none,
				AMBIENT_3 = none,
			},
		},
	},
	{ -- 22
		AMBIENTACTIONS_GROUPLOAD2 = {
			AMBIENTACTIONS = {
				AMBIENT_9 = none,
				AMBIENT_10 = none,
				AMBIENT_12 = none,
				AMBIENT_11 = none,
				AMBIENT_8 = none,
			},
		},
		AMBIENTACTIONS_GROUPLOAD1 = {
			AMBIENTACTIONS = {
				AMBIENT_4 = none,
				AMBIENT_6 = none,
				AMBIENT_2 = none,
				AMBIENT_1 = none,
				AMBIENT_7 = none,
				AMBIENT_5 = none,
				AMBIENT_3 = none,
			},
		},
		AMBIENTACTIONS_GROUPLOAD3 = {
			AMBIENTACTIONS = {
				ARMSONHIPS = none,
				SCRATCHARSE = none,
				SCRATCHHEAD = none,
				SCRATCHPIT = none,
				STRETCH = none,
			},
		},
	},
	{ -- 4
		AMBIENTSPAWN = none,
	},
	{ -- 22
		MIRROR_LOAD = {
			MIRRORACTIONS = {
				MIRRORACTIONS2 = none,
				MIRRORACTIONS3 = none,
				MIRRORACTIONS4 = none,
				MIRRORACTIONS1 = none,
			},
		},
	},
	{ -- 22
		WALKSTOP = none,
	},
	{ -- 22
		MELEE = none,
		WEAPON = none,
	},
	{ -- 2
		EXHAUSTED_COLLAPSE_LOADCHECK = {
			COLLAPSE = none,
		},
	},
	{ -- 23
		TIRED_UBO = none,
		WALKTIRED = none,
	},
	{ -- 23
		WALKSTART = none,
		WALK = none,
		WALKSTOP = none,
	},
	{ -- 22
		STEALTHWALKSTART = {
			ANIM = none,
		},
		STEALTHWALK = {
			RUNSTART = none,
			WALKSTOP = none,
		},
	},
	{ -- 2
		PLAYER = {
			DARBYLAST = none,
		},
	},
	{ -- 2
		DARBYLAST = none,
	},
	{ -- 2
		RUNNINGATTACKS = none,
		SHORT = {
			STRIKES = {
				LIGHTATTACKS = {
					JAB = {
						ELBOW = {
							HEAVYATTACKS = {
								UPPERCUT = none,
							},
						},
					},
				},
			},
		},
		MEDIUM = {
			GRAPPLES = {
				GRAPPLESATTEMPT = {
					TAKEDOWN = {
						GIVE = none,
						RCV = none,
					},
				},
			},
		},
	},
	{ -- 2
		BLOCKHITS = {
			BREAKER = none,
			HITSLIGHT = none,
		},
	},
	{ -- 5
		WALKBASIC = none,
		RUNBASIC = none,
		JOCK_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
			},
		},
		SPRINTBASIC = none,
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_D = none,
										IDLE_E_OPP = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
								IDLE_E = {
									IDLE_E = {
										IDLE_A_OPP = none,
										IDLE_E = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 17
		COMBAT = {
			COMBATBASIC = {
				BILLYCLUBCOMBATBASIC = none,
				BATCOMBATBASIC = none,
				COMBATBASIC = none,
			},
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = {
			GREASERCOMBATSTRAFEIDLE = none,
			WEAPONCOMBATSTRAFEIDLE = none,
			PREFECTCOMBATSTRAFEIDLE = none,
			COMBATSTRAFEIDLE = none,
			JOCKCOMBATSTRAFEIDLE = none,
		},
	},
	{ -- 3
		IDLE = none,
		FOOTBALLIDLE = none,
	},
	{ -- 6
		TALKING4 = none,
		TALKING7 = none,
		LISTEN2 = none,
		TALKING1 = none,
		TALKING3 = none,
		TALKING2 = none,
		LISTEN3 = none,
		LISTEN1 = none,
		LISTEN4 = none,
		TALKING5 = none,
		TALKING6 = none,
	},
	{ -- 2
		GRAB_BOTTLE = none,
	},
	{ -- 4
		WALL_SMOKE_A = none,
		WALL_SMOKE_B = none,
	},
	{ -- 8
		PLAYER01 = none,
	},
	{ -- 2
		GALLOWAY01 = none,
	},
	{ -- 2
		FIRESWITCH = {
			FIRESWITCH_IDLE = none,
			FIRESWITCH_OPEN = none,
		},
	},
	{ -- 2
		RUSSELL01 = none,
		RUSSELL02 = none,
	},
	{ -- 4
		PLAYER = {
			ZOE = none,
		},
	},
	{ -- 3
		ZOE = {
			PLAYER = {
				ZOE = none,
			},
		},
	},
	{ -- 2
		GIVEBALL = none,
	},
	{ -- 2
		LOWERBODY = {
			LOWERBODY_ANIM = none,
		},
		UPPERBODY = {
			FIREACTIONS = {
				CHARGE = {
					RELEASE = {
						RELEASE = {
							DETACH = none,
						},
					},
				},
			},
			AIM = {
				AIMIDLE = {
					DEFAULT = none,
					BASEBALL = none,
				},
			},
		},
	},
	{ -- 2
		DETTACH = none,
	},
	{ -- 9
		CLEAROBJECTIVES = none,
	},
	{ -- 2
		GIVE = {
			GIVE = none,
			RECEIVE = none,
		},
		GIVE_ATTEMPT = {
			GIVEINITIATE = {
				GIVE_SEEK = {
					SEEKENTITY = none,
					GIVE_WAIT = {
						FAIL = none,
						COLLISION = none,
					},
				},
				RECEIVEWAIT = none,
			},
			LOADWAIT = none,
		},
		EXECUTES = {
			ANIMS = {
				RECEIVE = none,
				GIVE = none,
				GIVEWAIT = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			SPEECH = {
				RECEIVE = none,
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			MODELS = {
				GIVE = none,
				RECEIVE = none,
				SEEK = none,
			},
			WEAPONREMOVAL = {
				REMOVEALLWEAPONS = none,
			},
		},
	},
	{ -- 3
		["4_S12_ENDCINEMATIC"] = none,
	},
	{ -- 2
		["4_S12_INCREMENTDELIVERY"] = none,
	},
	{ -- 2
		COUNTER = {
			GRAPPLE = none,
			COUNTER = none,
		},
	},
	{ -- 3
		FREE = {
			DEFAULT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FAT = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
						GEN = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							DONOTHING = none,
						},
					},
				},
			},
			RUNBASIC = {
				FAT = none,
				GEN = none,
			},
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					AUTHORITY = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKD = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					ADULT = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					FAT = {
						ACTIONSGIRL = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					GENERIC = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
			WALKBASIC = {
				FAT = none,
				WALKBASIC = {
					WALKWEEN = none,
				},
				HOBODRUNK = {
					WALKBASIC = none,
				},
			},
			SPRINTBASIC = {
				AUTHORITY = none,
				FAT = none,
				GEN = none,
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = none,
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				PREFECT = none,
				COMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 2
		GRAPPLES = {
			GRAPPLESATTEMPT = none,
		},
		LIGHTATTACKS = {
			SLOPPYJAB = {
				SLOPPYCROSS = none,
			},
		},
	},
	{ -- 2
		MALEADULT = none,
		FEMALE = none,
		MALEPREP = none,
	},
	{ -- 55
		ACTIVE = none,
	},
	{ -- 4
		SLAP = none,
	},
	{ -- 2
		HEAVYATTACKS = {
			POWERSWING = none,
			SWING1 = {
				SWING2 = {
					SWING3 = none,
				},
			},
		},
	},
	{ -- 2
		RUN = none,
	},
	{ -- 2
		STRIKES = {
			LIGHTATTACKS = {
				JAB = {
					ELBOW = {
						HEAVYATTACKS = {
							UPPERCUT = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		GRAPPLES = {
			GRAPPLESATTEMPT = {
				TAKEDOWN = {
					GIVE = none,
					RCV = none,
				},
			},
		},
	},
	{ -- 26
		CONTROLLER_NODE = {
			ACTIONS = {
				GENERIC = {
					WALKIDLESEXECUTE = none,
				},
				FACTION_SPECIFIC = {
					FACTION_IDLE2 = none,
					FACTION_IDLE1 = none,
				},
				NOOVERRIDE = none,
			},
		},
	},
	{ -- 5
		CONTROLLER_NODE = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKD = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_D = none,
									IDLE_E_OPP = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
							IDLE_E = {
								IDLE_E = {
									IDLE_A_OPP = none,
									IDLE_E = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 17
		COMBATBASIC = {
			BILLYCLUBCOMBATBASIC = none,
			BATCOMBATBASIC = none,
			COMBATBASIC = none,
		},
		STRAFEIDLE = none,
	},
	{ -- 17
		GREASERCOMBATSTRAFEIDLE = none,
		WEAPONCOMBATSTRAFEIDLE = none,
		PREFECTCOMBATSTRAFEIDLE = none,
		COMBATSTRAFEIDLE = none,
		JOCKCOMBATSTRAFEIDLE = none,
	},
	{ -- 26
		ACTIONS = {
			GENERIC = {
				WALKIDLESEXECUTE = none,
			},
			FACTION_SPECIFIC = {
				FACTION_IDLE2 = none,
				FACTION_IDLE1 = none,
			},
			NOOVERRIDE = none,
		},
	},
	{ -- 5
		WALKWEENVAMP = none,
	},
	{ -- 5
		SPRINTBASICTAD208 = none,
		SPRINTBASIC = none,
	},
	{ -- 5
		CONTROLLER_NODE = {
			ACTIONS = {
				ACTIONBRIDGE = none,
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKD = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		JAB = {
			CROSS = none,
		},
		LEFTHOOK = {
			FINISHINGCROSS = none,
		},
	},
	{ -- 2
		SHOULDERANDPUNCH = none,
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		EXECUTENODES = {
			FREE = {
				FAT_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				RUNBASIC = none,
				SPRINTBASIC = none,
				WALKBASIC = none,
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONSGIRL = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = none,
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = none,
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
		IDLE = none,
		RISINGATTACKS = none,
	},
	{ -- 3
		NERDJAB = {
			NERDHOOK = none,
		},
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		EXECUTENODES = {
			FREE = {
				WALKBASIC = none,
				RUNBASIC = none,
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKD = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
					},
				},
				DROPOUT_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				SPRINTBASIC = none,
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = {
						BILLYCLUBCOMBATBASIC = none,
						BATCOMBATBASIC = none,
						COMBATBASIC = none,
					},
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = {
					GREASERCOMBATSTRAFEIDLE = none,
					WEAPONCOMBATSTRAFEIDLE = none,
					PREFECTCOMBATSTRAFEIDLE = none,
					COMBATSTRAFEIDLE = none,
					JOCKCOMBATSTRAFEIDLE = none,
				},
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
		IDLE = none,
		RISINGATTACKS = none,
	},
	{ -- 2
		DO_STRIKECOMBO = {
			LIGHTATTACKS = {
				PUNCH1 = {
					PUNCH2 = {
						HEAVYATTACKS = {
							PUNCH3 = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		GRAPPLESATTEMPT = {
			TAKEDOWN = {
				GIVE = none,
				RCV = {
					BITEGRAPCYC = {
						GIVE = none,
						RCV = {
							BITEGRAPFINISH = {
								GIVE = none,
								RCV = {
									PUNCHESCAPESTARTGIVE = none,
								},
							},
							BEARHUGESCAPE_FALSE = {
								GIVE = none,
								RCV = none,
							},
							PUNCHSPAWN = {
								PUNCHSERIES = {
									HITREACTIONS = {
										HITESCAPESTARTRCV = none,
										HITRCV = none,
									},
									PUNCHGIVE = {
										PUNCHGIVE = {
											PUNCHGIVE = {
												PUNCHESCAPESTARTGIVE = {
													HITESCAPESTARTRCVOPP = none,
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		CLOSED = none,
	},
	{ -- 34
		CAM01 = none,
	},
	{ -- 31
		CAM02 = none,
		CAM03 = none,
		CAM01 = none,
	},
	{ -- 8
		CAM02 = none,
		CAM01 = none,
	},
	{ -- 2
		PICKSOCKET = {
			RIGHT = none,
			FRONT = none,
			LEFT = none,
		},
	},
	{ -- 2
		RIGHT = none,
		FRONT = none,
		LEFT = none,
	},
	{ -- 5
		ANIMATION = none,
	},
	{ -- 2
		JOHNNY_IDLE = none,
	},
	{ -- 2
		SCARED_03 = none,
		SCARED_04 = none,
		SCARED_01 = none,
		SCARED_02 = none,
		SCARED_05 = none,
	},
	{ -- 3
		CYCLE = none,
	},
	{ -- 2
		LINE2 = {
			END = none,
		},
	},
	{ -- 2
		DANCE03 = none,
		DANCE02 = none,
		DANCE05 = none,
		DANCE04 = none,
		DANCE01 = none,
	},
	{ -- 3
		ANIMATIONS = {
			WEAPONWALK = none,
			WEAPONBIKEIDLE = none,
			WEAPONSOCIAL = {
				WEAPONIDLE = none,
				PERFORMINGACTION = none,
			},
			WEAPONCROUCH = none,
			WEAPONRUN = none,
			WEAPONSTRAFE = none,
			WEAPONIDLE = none,
		},
		GLOBALLOCO = {
			LOCOMOTION = {
				SPRINTDEPLETE = {
					SPRINTDEPLETEEXEC = none,
				},
				WALK = {
					TIRED = {
						TIRED_UBO = none,
						WALKTIRED = none,
					},
					SNEAK = {
						STEALTHWALKSTART = {
							ANIM = none,
						},
						STEALTHWALK = {
							RUNSTART = none,
							WALKSTOP = none,
						},
					},
					NOTTIRED = {
						WALKSTART = none,
						WALK = none,
						WALKSTOP = none,
					},
					ALLY = {
						WALKALLY = none,
					},
					FEMALE = {
						WALKBASIC = none,
					},
				},
				COMBAT = {
					COMBATTRANSITION = {
						COMBATIDLE_OUT = {
							COMBATIDLE_OUT = none,
							STRAFE = none,
						},
						COMBATSTART = {
							IDLE = none,
							STRAFE = {
								ANIM = none,
							},
						},
					},
					DEFAULT = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = {
								ANIM = none,
								NOANIM = none,
							},
						},
					},
					EXECNODES = {
						COMBATIDLETURN = {
							FACINGINTENDED = {
								CCW_SLOW = {
									CCW = none,
									WAIT = none,
									END = none,
								},
								RESET = none,
								FORWARDS = none,
								CW_SLOW = {
									CW = none,
									END = none,
									WAIT = none,
								},
							},
						},
						TARGET = {
							STRAFEMODE = none,
							LOCK = none,
						},
					},
					["0_BLOCK_0"] = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATIDLEBLOCK = none,
						BLOCKSTRAFE = none,
					},
				},
				LOCOMOTIONEXECUTES = {
					CROUCHLOCOTARGET = none,
					NONCOMBATSTRAFE = {
						NC_LOCO = {
							COMBATIDLE_OUT = none,
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
							IDLE = {
								IDLE_ANIM = {
									ANIM = none,
									SOCIALIZING = none,
								},
							},
							NONCOMBATSTRAFEANIMS = {
								WALKSTOP = none,
							},
						},
					},
					STRAFELOCOBASIC = {
						NOSTEERING = none,
						STEERING = none,
					},
					STRAFELOCOBASICANIMS = {
						MELEE = none,
						WEAPON = none,
					},
					RUN_STARTLOCO = {
						DEFAULT = none,
						TURNFAST = none,
					},
					WALK_STARTLOCO = none,
					TIRED_UPPERBODY = none,
					WALKBASIC = none,
					EXHAUSTED_COLLAPSE = {
						EXHAUSTED_COLLAPSE_LOADCHECK = {
							COLLAPSE = {
								COLLAPSELOAD = {
									COLLAPSE = none,
									GRAPPLETARGET = none,
								},
								COLLAPSEOFFLADDER = {
									FALL = none,
								},
								COLLAPSEOFFTREEBRANCH = {
									DOWN = {
										DOWN_END = none,
									},
								},
								COLLAPSEOFFTREEHANG = {
									DOWN = none,
								},
							},
						},
					},
				},
				OFFSETCAM = {
					OFFSETCAM_WEAPON = {
						COMBATRUN = {
							RUNSTRAFEMODE = {
								STRAFERUNFWD = none,
								STRAFERUNBKW = none,
							},
						},
						COMBATSTRAFE = none,
						COMBATIDLE = {
							ANIM = none,
						},
					},
					OFFSETCAM_LOCO = none,
				},
				RUN = {
					RUN = {
						RUNCONTROLLER = {
							RUN = {
								RUN = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
							SPRINT = {
								SPRINTBASIC = {
									LOCOTRACKS = {
										DEFAULT = none,
										TURNFAST = none,
									},
								},
							},
						},
					},
					TIRED_STOP = none,
					NEWLOCOANIMS = {
						RUNLOCOANIMS = none,
						TIRED_UPPERBODY_SPAWN = {
							NOTTIRED = none,
							TIRED = none,
						},
						TIRED_UPPERBODY = none,
						SPRINTLOCOANIMS = none,
					},
					RUNSTOP = {
						WALKSTOP_WAIT = none,
						RUNSTOP = {
							SKID = {
								RUN_TO_IDLE = {
									LOCO = {
										WINTER = none,
										NORMAL = none,
									},
								},
								SPRINT_SLIDE = none,
							},
						},
						RUNSTOP_WAIT = none,
					},
					RUNSTART = {
						RUNSTART = none,
					},
				},
				CROUCH = {
					CROUCHIDLE = {
						CROUCHIDLE = none,
						CROUCHAIM = {
							TURN = {
								FACINGINTENDED = {
									CCW_SLOW = {
										CCW = none,
										WAIT = none,
										END = none,
									},
									RESET = none,
									FORWARDS = none,
									CW_SLOW = {
										CW = none,
										END = none,
										WAIT = none,
									},
								},
							},
						},
						CROUCHIDLETARGET = none,
					},
					CROUCHEND = {
						CROUCH_OUT_COMBAT = {
							CROUCH_OUT_TARGET = none,
						},
						CROUCH_OUT = none,
					},
					CROUCHSTART = {
						CROUCHSTARTCOMBAT = none,
						CROUCHSTART = none,
					},
					CROUCHLOCO = {
						CROUCHLOCOTARGET = none,
						CROUCHLOCO = {
							CROUCHLOCOANIMS = {
								CROUCHLOCORUN = none,
								CROUCHLOCOBASIC = none,
							},
							RUNCONTROLLER = {
								CROUCHRUN = none,
								CROUCHLOCO = none,
							},
						},
					},
					CROUCH_TIRED = {
						TIRED_UBO = none,
					},
					CRAWLLOCO = {
						CRAWLSTART = {
							CRAWLCYCLE = {
								CROUCHRELEASE = none,
							},
						},
					},
				},
				IDLE = {
					VTIRED = {
						VTIREDACTIONS = {
							AMBIENTACTIONS_VTIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					FEMALE = none,
					TURN = {
						FACINGINTENDED = {
							CW_SLOW_OLD = {
								CW = none,
								END = none,
								WAIT = none,
							},
							RESET = none,
							CCW_SLOW_FEMALE = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS_ACCURATE = none,
							CCW_SLOW = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							FORWARDS = none,
							CW_SLOW_FEMALE = {
								CW = none,
								END = none,
								WAIT = none,
							},
							CCW_SLOW_OLD = {
								CCW = none,
								WAIT = none,
								END = none,
							},
							CW_SLOW = {
								CW = none,
								END = none,
								WAIT = none,
							},
						},
					},
					EXHAUSTED = none,
					TIRED = {
						TIREDACTIONS = {
							AMBIENTACTIONS_TIRED = {
								AMBIENTACTIONS_OPP = none,
								AMBIENTACTIONS = {
									AMBIENT_1 = none,
									AMBIENT_2 = none,
									AMBIENT_3 = none,
								},
							},
						},
					},
					IDLE = {
						AMBIENTACTIONS = {
							AMBIENTACTIONS_GROUPLOAD2 = {
								AMBIENTACTIONS = {
									AMBIENT_9 = none,
									AMBIENT_10 = none,
									AMBIENT_12 = none,
									AMBIENT_11 = none,
									AMBIENT_8 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD1 = {
								AMBIENTACTIONS = {
									AMBIENT_4 = none,
									AMBIENT_6 = none,
									AMBIENT_2 = none,
									AMBIENT_1 = none,
									AMBIENT_7 = none,
									AMBIENT_5 = none,
									AMBIENT_3 = none,
								},
							},
							AMBIENTACTIONS_GROUPLOAD3 = {
								AMBIENTACTIONS = {
									ARMSONHIPS = none,
									SCRATCHARSE = none,
									SCRATCHHEAD = none,
									SCRATCHPIT = none,
									STRETCH = none,
								},
							},
						},
						MIRRORIDLE = {
							MIRROR_LOAD = {
								MIRRORACTIONS = {
									MIRRORACTIONS2 = none,
									MIRRORACTIONS3 = none,
									MIRRORACTIONS4 = none,
									MIRRORACTIONS1 = none,
								},
							},
						},
						WARMTHFACTOR = {
							FREEZING = {
								DAMAGE = none,
							},
						},
						AMBIENTSPAWN = {
							AMBIENTSPAWN = {
								OPPS = none,
							},
						},
						IDLESPEECH = {
							WAIT = none,
							SAYSOMETHING = {
								VTIRED = none,
								TIRED = none,
								NORMAL = none,
							},
						},
					},
				},
				SOCIAL = {
					SOCIAL_ACTIONS = none,
					SOCIAL = none,
				},
				HANDHOLDING = {
					IDLE = none,
					WALK = {
						WALK_SPEEDS = {
							HANDHOLDING = none,
							OLDPED = none,
						},
						WALKSTOP = none,
					},
				},
			},
		},
	},
	{ -- 2
		IDLE = {
			RETURNTOAIM = none,
		},
		TREELOCO = none,
	},
	{ -- 2
		PLAYER = none,
		AI = none,
	},
	{ -- 2
		INTOAIM = {
			AIMIDLE = {
				DEFAULT = none,
				AIMOUT = {
					DEFAULT = none,
					CROUCH = none,
				},
				CROUCH = none,
			},
			DEFAULT = {
				LOWERBODY = {
					TRANSITION = none,
					COMBATIDLE = none,
				},
			},
			CROUCH = none,
		},
	},
	{ -- 5
		SPEECHANIMS = {
			SPAWNS = none,
			ANIMS = {
				DISMISS_02 = none,
				PRAISE_F_01 = none,
				DEFEN_F_01 = none,
				DISMISS_01 = none,
				DEFEN_F_02 = none,
				PRAISE_F_02 = none,
			},
		},
		LOAD = none,
	},
	{ -- 12
		WAIT = none,
		GIVE_ATTEMPT = {
			GIVE_SEEK = {
				GET_OBJECT = none,
			},
			RECEIVE = {
				RECEIVE = {
					GIVE = none,
				},
			},
			GIVE_ATTEMPT_SPEECH = none,
			RECEIVEWAIT = none,
		},
	},
	{ -- 2
		EARGRABWALK_CYCLE = {
			GIVE = none,
			RCV = none,
		},
		RCV = none,
		GIVE = none,
	},
	{ -- 3
		FLAIL = none,
	},
	{ -- 2
		FREE = {
			RUNBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
			WALKBASIC = none,
			SPRINTBASIC = none,
			NERD_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = none,
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				COMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 3
		NERDHOOK = none,
	},
	{ -- 3
		SPEAR = none,
	},
	{ -- 2
		HEAVYATTACKS = {
			SPEAR = none,
		},
	},
	{ -- 3
		CONTROLLER_NODE = {
			ACTIONS = {
				NOOVERRIDE = none,
				FACTION_SPECIFIC = {
					FACTION_IDLE1 = none,
					FACTION_IDLE2 = none,
					FACTION_IDLE3 = none,
				},
			},
		},
	},
	{ -- 3
		ACTIONS = {
			NOOVERRIDE = none,
			FACTION_SPECIFIC = {
				FACTION_IDLE1 = none,
				FACTION_IDLE2 = none,
				FACTION_IDLE3 = none,
			},
		},
	},
	{ -- 2
		TAKEDOWN = {
			GIVE = none,
			RCV = {
				BITEGRAPCYC = {
					GIVE = none,
					RCV = {
						BITEGRAPFINISH = {
							GIVE = none,
							RCV = {
								PUNCHESCAPESTARTGIVE = none,
							},
						},
						BEARHUGESCAPE_FALSE = {
							GIVE = none,
							RCV = none,
						},
						PUNCHSPAWN = {
							PUNCHSERIES = {
								HITREACTIONS = {
									HITESCAPESTARTRCV = none,
									HITRCV = none,
								},
								PUNCHGIVE = {
									PUNCHGIVE = {
										PUNCHGIVE = {
											PUNCHESCAPESTARTGIVE = {
												HITESCAPESTARTRCVOPP = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 3
		STRIKES = {
			LIGHTATTACKS = {
				WINDMILL_R = {
					WINDMILL_L = {
						HEAVYATTACKS = {
							SWINGPUNCH_R = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		WEAPONWALK = none,
		WEAPONCROUCH = none,
		WEAPONIDLE = none,
		WEAPONSTRAFE = none,
		ONTREE = {
			OFFSETIDLE = none,
			IDLE = none,
		},
		WEAPONRUN = none,
		WEAPONBIKEIDLE = none,
		WEAPONSOCIAL = {
			WEAPONIDLE = none,
			WEAPONIDLERUN = none,
			PERFORMINGACTION = none,
		},
	},
	{ -- 21
		TIRED = {
			TIRED_UBO = none,
			WALKTIRED = none,
		},
		SNEAK = {
			STEALTHWALKSTART = {
				ANIM = none,
			},
			STEALTHWALK = {
				RUNSTART = none,
				WALKSTOP = none,
			},
		},
		NOTTIRED = {
			WALKSTART = none,
			WALK = none,
			WALKSTOP = none,
		},
		ALLY = {
			WALKALLY = none,
		},
		FEMALE = {
			WALKBASIC = none,
		},
	},
	{ -- 21
		COMBATTRANSITION = {
			COMBATIDLE_OUT = {
				COMBATIDLE_OUT = none,
				STRAFE = none,
			},
			COMBATSTART = {
				IDLE = none,
				STRAFE = {
					ANIM = none,
				},
			},
		},
		DEFAULT = {
			COMBATRUN = {
				RUNSTRAFEMODE = {
					STRAFERUNFWD = none,
					STRAFERUNBKW = none,
				},
			},
			COMBATSTRAFE = none,
			COMBATIDLE = {
				ANIM = {
					ANIM = none,
					NOANIM = none,
				},
			},
		},
		EXECNODES = {
			COMBATIDLETURN = {
				FACINGINTENDED = {
					CCW_SLOW = {
						CCW = none,
						WAIT = none,
						END = none,
					},
					RESET = none,
					FORWARDS = none,
					CW_SLOW = {
						CW = none,
						END = none,
						WAIT = none,
					},
				},
			},
			TARGET = {
				STRAFEMODE = none,
				LOCK = none,
			},
		},
		["0_BLOCK_0"] = {
			COMBATRUN = {
				RUNSTRAFEMODE = {
					STRAFERUNFWD = none,
					STRAFERUNBKW = none,
				},
			},
			COMBATIDLEBLOCK = none,
			BLOCKSTRAFE = none,
		},
	},
	{ -- 21
		CROUCHLOCOTARGET = none,
		NONCOMBATSTRAFE = {
			NC_LOCO = {
				COMBATIDLE_OUT = none,
				RUNSTRAFEMODE = {
					STRAFERUNFWD = none,
					STRAFERUNBKW = none,
				},
				IDLE = {
					IDLE_ANIM = {
						ANIM = none,
						SOCIALIZING = none,
					},
				},
				NONCOMBATSTRAFEANIMS = {
					WALKSTOP = none,
				},
			},
		},
		STRAFELOCOBASIC = {
			NOSTEERING = none,
			STEERING = none,
		},
		STRAFELOCOBASICANIMS = {
			MELEE = none,
			WEAPON = none,
		},
		RUN_STARTLOCO = {
			DEFAULT = none,
			TURNFAST = none,
		},
		WALK_STARTLOCO = none,
		TIRED_UPPERBODY = none,
		WALKBASIC = none,
		EXHAUSTED_COLLAPSE = {
			EXHAUSTED_COLLAPSE_LOADCHECK = {
				COLLAPSE = {
					COLLAPSELOAD = {
						COLLAPSE = none,
						GRAPPLETARGET = none,
					},
					COLLAPSEOFFLADDER = {
						FALL = none,
					},
					COLLAPSEOFFTREEBRANCH = {
						DOWN = {
							DOWN_END = none,
						},
					},
					COLLAPSEOFFTREEHANG = {
						DOWN = none,
					},
				},
			},
		},
	},
	{ -- 21
		OFFSETCAM_WEAPON = {
			COMBATRUN = {
				RUNSTRAFEMODE = {
					STRAFERUNFWD = none,
					STRAFERUNBKW = none,
				},
			},
			COMBATSTRAFE = none,
			COMBATIDLE = {
				ANIM = none,
			},
		},
		OFFSETCAM_LOCO = none,
	},
	{ -- 21
		RUN = {
			RUNCONTROLLER = {
				RUN = {
					RUN = {
						LOCOTRACKS = {
							DEFAULT = none,
							TURNFAST = none,
						},
					},
				},
				SPRINT = {
					SPRINTBASIC = {
						LOCOTRACKS = {
							DEFAULT = none,
							TURNFAST = none,
						},
					},
				},
			},
		},
		TIRED_STOP = none,
		NEWLOCOANIMS = {
			RUNLOCOANIMS = none,
			TIRED_UPPERBODY_SPAWN = {
				NOTTIRED = none,
				TIRED = none,
			},
			TIRED_UPPERBODY = none,
			SPRINTLOCOANIMS = none,
		},
		RUNSTOP = {
			WALKSTOP_WAIT = none,
			RUNSTOP = {
				SKID = {
					RUN_TO_IDLE = {
						LOCO = {
							WINTER = none,
							NORMAL = none,
						},
					},
					SPRINT_SLIDE = none,
				},
			},
			RUNSTOP_WAIT = none,
		},
		RUNSTART = {
			RUNSTART = none,
		},
	},
	{ -- 21
		CROUCHIDLE = {
			CROUCHIDLE = none,
			CROUCHAIM = {
				TURN = {
					FACINGINTENDED = {
						CCW_SLOW = {
							CCW = none,
							WAIT = none,
							END = none,
						},
						RESET = none,
						FORWARDS = none,
						CW_SLOW = {
							CW = none,
							END = none,
							WAIT = none,
						},
					},
				},
			},
			CROUCHIDLETARGET = none,
		},
		CROUCHEND = {
			CROUCH_OUT_COMBAT = {
				CROUCH_OUT_TARGET = none,
			},
			CROUCH_OUT = none,
		},
		CROUCHSTART = {
			CROUCHSTARTCOMBAT = none,
			CROUCHSTART = none,
		},
		CROUCHLOCO = {
			CROUCHLOCOTARGET = none,
			CROUCHLOCO = {
				CROUCHLOCOANIMS = {
					CROUCHLOCORUN = none,
					CROUCHLOCOBASIC = none,
				},
				RUNCONTROLLER = {
					CROUCHRUN = none,
					CROUCHLOCO = none,
				},
			},
		},
		CROUCH_TIRED = {
			TIRED_UBO = none,
		},
		CRAWLLOCO = {
			CRAWLSTART = {
				CRAWLCYCLE = {
					CROUCHRELEASE = none,
				},
			},
		},
	},
	{ -- 21
		VTIRED = {
			VTIREDACTIONS = {
				AMBIENTACTIONS_VTIRED = {
					AMBIENTACTIONS_OPP = none,
					AMBIENTACTIONS = {
						AMBIENT_1 = none,
						AMBIENT_2 = none,
						AMBIENT_3 = none,
					},
				},
			},
		},
		FEMALE = none,
		TURN = {
			FACINGINTENDED = {
				CW_SLOW_OLD = {
					CW = none,
					END = none,
					WAIT = none,
				},
				RESET = none,
				CCW_SLOW_FEMALE = {
					CCW = none,
					WAIT = none,
					END = none,
				},
				FORWARDS_ACCURATE = none,
				CCW_SLOW = {
					CCW = none,
					WAIT = none,
					END = none,
				},
				FORWARDS = none,
				CW_SLOW_FEMALE = {
					CW = none,
					END = none,
					WAIT = none,
				},
				CCW_SLOW_OLD = {
					CCW = none,
					WAIT = none,
					END = none,
				},
				CW_SLOW = {
					CW = none,
					END = none,
					WAIT = none,
				},
			},
		},
		EXHAUSTED = none,
		TIRED = {
			TIREDACTIONS = {
				AMBIENTACTIONS_TIRED = {
					AMBIENTACTIONS_OPP = none,
					AMBIENTACTIONS = {
						AMBIENT_1 = none,
						AMBIENT_2 = none,
						AMBIENT_3 = none,
					},
				},
			},
		},
		IDLE = {
			AMBIENTACTIONS = {
				AMBIENTACTIONS_GROUPLOAD2 = {
					AMBIENTACTIONS = {
						AMBIENT_9 = none,
						AMBIENT_10 = none,
						AMBIENT_12 = none,
						AMBIENT_11 = none,
						AMBIENT_8 = none,
					},
				},
				AMBIENTACTIONS_GROUPLOAD1 = {
					AMBIENTACTIONS = {
						AMBIENT_4 = none,
						AMBIENT_6 = none,
						AMBIENT_2 = none,
						AMBIENT_1 = none,
						AMBIENT_7 = none,
						AMBIENT_5 = none,
						AMBIENT_3 = none,
					},
				},
				AMBIENTACTIONS_GROUPLOAD3 = {
					AMBIENTACTIONS = {
						ARMSONHIPS = none,
						SCRATCHARSE = none,
						SCRATCHHEAD = none,
						SCRATCHPIT = none,
						STRETCH = none,
					},
				},
			},
			MIRRORIDLE = {
				MIRROR_LOAD = {
					MIRRORACTIONS = {
						MIRRORACTIONS2 = none,
						MIRRORACTIONS3 = none,
						MIRRORACTIONS4 = none,
						MIRRORACTIONS1 = none,
					},
				},
			},
			WARMTHFACTOR = {
				FREEZING = {
					DAMAGE = none,
				},
			},
			AMBIENTSPAWN = {
				AMBIENTSPAWN = {
					OPPS = none,
				},
			},
			IDLESPEECH = {
				WAIT = none,
				SAYSOMETHING = {
					VTIRED = none,
					TIRED = none,
					NORMAL = none,
				},
			},
		},
	},
	{ -- 21
		IDLE = none,
		WALK = {
			WALK_SPEEDS = {
				HANDHOLDING = none,
				OLDPED = none,
			},
			WALKSTOP = none,
		},
	},
	{ -- 5
		DEFAULT = none,
		CROUCH = none,
	},
	{ -- 2
		AIMIDLE = {
			DEFAULT = none,
			AIMOUT = {
				DEFAULT = none,
				CROUCH = none,
			},
			CROUCH = none,
		},
		DEFAULT = {
			LOWERBODY = {
				TRANSITION = none,
				COMBATIDLE = none,
			},
		},
		CROUCH = none,
	},
	{ -- 6
		SWING2 = {
			SWING3 = none,
		},
	},
	{ -- 2
		FF144 = none,
		INCREMENTSTATKICK = none,
		FF120 = none,
	},
	{ -- 5
		TELL_OFF_CHILD = none,
	},
	{ -- 2
		SETUPCAMERA = {
			DIALOGUE = {
				RETURNCAMERA = none,
			},
		},
	},
	{ -- 2
		JIMMY_02 = none,
		JIMMY_01 = none,
	},
	{ -- 13
		PICKUP = none,
	},
	{ -- 9
		SETINFO = none,
	},
	{ -- 2
		SLEDGEHAMMER = none,
	},
	{ -- 2
		DROP_ANIM = none,
	},
	{ -- 2
		SEQUENCED = none,
	},
	{ -- 2
		MOVEOBJECTIVE = none,
		FACEOBJECTIVE = none,
	},
	{ -- 2
		LOOP = none,
		WAITSTART = none,
	},
	{ -- 3
		LOOP = {
			WAIT = none,
			GRAPPLESTART = none,
			GETCLOSE = none,
		},
		WAITSTART = none,
	},
	{ -- 3
		WAIT = none,
		GRAPPLESTART = none,
		GETCLOSE = none,
	},
	{ -- 2
		M_2_04_21 = {
			END = none,
		},
	},
	{ -- 2
		GIRL = {
			ANIM02 = none,
			ANIM01 = none,
			ANIM03 = none,
			ANIM04 = none,
		},
		NERD = {
			ANIM02 = none,
			ANIM01 = none,
			ANIM03 = none,
			ANIM04 = none,
		},
		SPEECH = {
			SPEECHCHANCE = {
				SEESOMETHINGCOOL = none,
			},
		},
		PREP = {
			ANIM02 = none,
			ANIM01 = none,
			ANIM03 = none,
			ANIM04 = none,
		},
		DEFAULT = {
			ANIM01 = none,
			ANIM03 = none,
			ANIM02 = none,
		},
	},
	{ -- 22
		RUNSTART = none,
		WALKSTOP = none,
	},
	{ -- 22
		WALKALLY = none,
	},
	{ -- 21
		COMBATIDLE_OUT = {
			COMBATIDLE_OUT = none,
			STRAFE = none,
		},
		COMBATSTART = {
			IDLE = none,
			STRAFE = {
				ANIM = none,
			},
		},
	},
	{ -- 65
		RUNSTRAFEMODE = {
			STRAFERUNFWD = none,
			STRAFERUNBKW = none,
		},
	},
	{ -- 22
		ANIM = {
			ANIM = none,
			NOANIM = none,
		},
	},
	{ -- 43
		FACINGINTENDED = {
			CCW_SLOW = {
				CCW = none,
				WAIT = none,
				END = none,
			},
			RESET = none,
			FORWARDS = none,
			CW_SLOW = {
				CW = none,
				END = none,
				WAIT = none,
			},
		},
	},
	{ -- 23
		STRAFEMODE = none,
		LOCK = none,
	},
	{ -- 21
		NC_LOCO = {
			COMBATIDLE_OUT = none,
			RUNSTRAFEMODE = {
				STRAFERUNFWD = none,
				STRAFERUNBKW = none,
			},
			IDLE = {
				IDLE_ANIM = {
					ANIM = none,
					SOCIALIZING = none,
				},
			},
			NONCOMBATSTRAFEANIMS = {
				WALKSTOP = none,
			},
		},
	},
	{ -- 21
		NOSTEERING = none,
		STEERING = none,
	},
	{ -- 21
		EXHAUSTED_COLLAPSE_LOADCHECK = {
			COLLAPSE = {
				COLLAPSELOAD = {
					COLLAPSE = none,
					GRAPPLETARGET = none,
				},
				COLLAPSEOFFLADDER = {
					FALL = none,
				},
				COLLAPSEOFFTREEBRANCH = {
					DOWN = {
						DOWN_END = none,
					},
				},
				COLLAPSEOFFTREEHANG = {
					DOWN = none,
				},
			},
		},
	},
	{ -- 21
		COMBATRUN = {
			RUNSTRAFEMODE = {
				STRAFERUNFWD = none,
				STRAFERUNBKW = none,
			},
		},
		COMBATSTRAFE = none,
		COMBATIDLE = {
			ANIM = none,
		},
	},
	{ -- 21
		RUNCONTROLLER = {
			RUN = {
				RUN = {
					LOCOTRACKS = {
						DEFAULT = none,
						TURNFAST = none,
					},
				},
			},
			SPRINT = {
				SPRINTBASIC = {
					LOCOTRACKS = {
						DEFAULT = none,
						TURNFAST = none,
					},
				},
			},
		},
	},
	{ -- 21
		RUNLOCOANIMS = none,
		TIRED_UPPERBODY_SPAWN = {
			NOTTIRED = none,
			TIRED = none,
		},
		TIRED_UPPERBODY = none,
		SPRINTLOCOANIMS = none,
	},
	{ -- 21
		WALKSTOP_WAIT = none,
		RUNSTOP = {
			SKID = {
				RUN_TO_IDLE = {
					LOCO = {
						WINTER = none,
						NORMAL = none,
					},
				},
				SPRINT_SLIDE = none,
			},
		},
		RUNSTOP_WAIT = none,
	},
	{ -- 21
		CROUCHIDLE = none,
		CROUCHAIM = {
			TURN = {
				FACINGINTENDED = {
					CCW_SLOW = {
						CCW = none,
						WAIT = none,
						END = none,
					},
					RESET = none,
					FORWARDS = none,
					CW_SLOW = {
						CW = none,
						END = none,
						WAIT = none,
					},
				},
			},
		},
		CROUCHIDLETARGET = none,
	},
	{ -- 21
		CROUCH_OUT_COMBAT = {
			CROUCH_OUT_TARGET = none,
		},
		CROUCH_OUT = none,
	},
	{ -- 21
		CROUCHSTARTCOMBAT = none,
		CROUCHSTART = none,
	},
	{ -- 21
		CROUCHLOCOTARGET = none,
		CROUCHLOCO = {
			CROUCHLOCOANIMS = {
				CROUCHLOCORUN = none,
				CROUCHLOCOBASIC = none,
			},
			RUNCONTROLLER = {
				CROUCHRUN = none,
				CROUCHLOCO = none,
			},
		},
	},
	{ -- 21
		TIRED_UBO = none,
	},
	{ -- 21
		CRAWLSTART = {
			CRAWLCYCLE = {
				CROUCHRELEASE = none,
			},
		},
	},
	{ -- 21
		VTIREDACTIONS = {
			AMBIENTACTIONS_VTIRED = {
				AMBIENTACTIONS_OPP = none,
				AMBIENTACTIONS = {
					AMBIENT_1 = none,
					AMBIENT_2 = none,
					AMBIENT_3 = none,
				},
			},
		},
	},
	{ -- 21
		FACINGINTENDED = {
			CW_SLOW_OLD = {
				CW = none,
				END = none,
				WAIT = none,
			},
			RESET = none,
			CCW_SLOW_FEMALE = {
				CCW = none,
				WAIT = none,
				END = none,
			},
			FORWARDS_ACCURATE = none,
			CCW_SLOW = {
				CCW = none,
				WAIT = none,
				END = none,
			},
			FORWARDS = none,
			CW_SLOW_FEMALE = {
				CW = none,
				END = none,
				WAIT = none,
			},
			CCW_SLOW_OLD = {
				CCW = none,
				WAIT = none,
				END = none,
			},
			CW_SLOW = {
				CW = none,
				END = none,
				WAIT = none,
			},
		},
	},
	{ -- 21
		TIREDACTIONS = {
			AMBIENTACTIONS_TIRED = {
				AMBIENTACTIONS_OPP = none,
				AMBIENTACTIONS = {
					AMBIENT_1 = none,
					AMBIENT_2 = none,
					AMBIENT_3 = none,
				},
			},
		},
	},
	{ -- 21
		AMBIENTACTIONS = {
			AMBIENTACTIONS_GROUPLOAD2 = {
				AMBIENTACTIONS = {
					AMBIENT_9 = none,
					AMBIENT_10 = none,
					AMBIENT_12 = none,
					AMBIENT_11 = none,
					AMBIENT_8 = none,
				},
			},
			AMBIENTACTIONS_GROUPLOAD1 = {
				AMBIENTACTIONS = {
					AMBIENT_4 = none,
					AMBIENT_6 = none,
					AMBIENT_2 = none,
					AMBIENT_1 = none,
					AMBIENT_7 = none,
					AMBIENT_5 = none,
					AMBIENT_3 = none,
				},
			},
			AMBIENTACTIONS_GROUPLOAD3 = {
				AMBIENTACTIONS = {
					ARMSONHIPS = none,
					SCRATCHARSE = none,
					SCRATCHHEAD = none,
					SCRATCHPIT = none,
					STRETCH = none,
				},
			},
		},
		MIRRORIDLE = {
			MIRROR_LOAD = {
				MIRRORACTIONS = {
					MIRRORACTIONS2 = none,
					MIRRORACTIONS3 = none,
					MIRRORACTIONS4 = none,
					MIRRORACTIONS1 = none,
				},
			},
		},
		WARMTHFACTOR = {
			FREEZING = {
				DAMAGE = none,
			},
		},
		AMBIENTSPAWN = {
			AMBIENTSPAWN = {
				OPPS = none,
			},
		},
		IDLESPEECH = {
			WAIT = none,
			SAYSOMETHING = {
				VTIRED = none,
				TIRED = none,
				NORMAL = none,
			},
		},
	},
	{ -- 21
		WALK_SPEEDS = {
			HANDHOLDING = none,
			OLDPED = none,
		},
		WALKSTOP = none,
	},
	{ -- 2
		LID_DEFAULT = none,
		PLATE = none,
		SHIELD = none,
	},
	{ -- 3
		FADEOUT = none,
	},
	{ -- 2
		["4ARMLOW"] = {
			["4ARMLOW_LOOP"] = none,
		},
		SHOULDERBACK = {
			SHOULDERBACK_LOOP = none,
		},
		["4ARMHI"] = {
			["4ARMHI_LOOP"] = none,
		},
		SHOULDER = {
			SHOULDER_LOOP = none,
		},
	},
	{ -- 2
		["4ARMLOW_LOOP"] = none,
	},
	{ -- 2
		SHOULDERBACK_LOOP = none,
	},
	{ -- 2
		["4ARMHI_LOOP"] = none,
	},
	{ -- 2
		SHOULDER_LOOP = none,
	},
	{ -- 2
		SHIN = {
			HEAVYATTACKS = {
				ROUNDHOUSEKICK_L = {
					AXEKICKS = {
						AXEKICK_R = {
							AXEKICKFOLLOWUP = {
								SPIT = {
									AXEKICK_GRAP_GV = none,
									AXEKICK_GRAP_RCV = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		THROATGRAB_GV = none,
		THROATGRAB_RCV = none,
	},
	{ -- 3
		BELLYDOWNGETUP = none,
	},
	{ -- 3
		RIGHTHOOK = {
			LEFTHOOK = {
				RIGHTSTOMACH = none,
			},
		},
	},
	{ -- 2
		TOSPECIAL = none,
	},
	{ -- 3
		GV = none,
		RCV = none,
	},
	{ -- 2
		NORMAL = none,
		ATTACKINTERRUPT = {
			GRABKNEES = none,
			OPPORTUNITYINSERT = none,
		},
	},
	{ -- 2
		HEAVYATTACKS = {
			ROUNDHOUSEKICK_L = {
				AXEKICKS = {
					AXEKICK_R = {
						AXEKICKFOLLOWUP = {
							SPIT = {
								AXEKICK_GRAP_GV = none,
								AXEKICK_GRAP_RCV = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		HEAVYKICK = {
			HEAVYKICKLAND = none,
			INSERTOPPORTUNITY = none,
		},
		SLIDINGPUNCH = none,
	},
	{ -- 4
		FREE = {
			GREASER_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			RUNBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
				},
			},
			SPRINTBASIC = {
				["306PEANUTSPRINT"] = none,
				SPRINTBASIC = none,
			},
			WALKBASIC = {
				WALKBASICWEEN = none,
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					COMBATBASIC = {
						UPPERBODY = {
							MELEE = none,
							STRIKER = none,
						},
					},
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				COMBATSTRAFEIDLE = {
					UPPERBODY = {
						MELEE = {
							IDLE_A = none,
						},
						STRIKER = {
							IDLE_A = none,
						},
					},
				},
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 3
		WAVE = none,
	},
	{ -- 7
		DEJECT2 = none,
		DEJECT1 = none,
	},
	{ -- 6
		GFGREET = {
			GFSOCIALCHOICE = {
				GFSOCIALCHOICELONG = none,
				GFSOCIALCHOICENORM = none,
			},
			GIRLFRIENDSOCIAL = none,
		},
		GIRFRIENDSEE = {
			GIRFRIENDSEEHH = {
				GIRFRIENDATTACKCHOICE = {
					GIRFRIENDATTACKBOY = {
						GIRFRIENDATTACKBOY = none,
						GIRFRIENDATTACKPLAYER = none,
					},
					GIRFRIENDATTACKALLY = none,
					GIRFRIENDATTACKPLAYER = none,
				},
				SFSEESPEECH = {
					THARASS = none,
					COMPLAIN = none,
				},
			},
		},
	},
	{ -- 6
		DISLIKECHOICES = {
			HARASSCOND = {
				STEALOPP = none,
				HARASS = {
					HARASSRANGE = {
						HARASSHIT = {
							HARASSCHOICE = {
								TAUNTAFTER = none,
							},
						},
						HARASSRANGEWEAPON = {
							HARASSRANGEEQUIP = none,
							HARASSRANGEUSE = none,
						},
					},
					HUNT = none,
				},
				TAUNTCHECK = {
					TAUNT = none,
				},
				HUMILIATE = {
					HUMILNODE = none,
					BOOKSTEALEXEC = none,
				},
			},
			TAUNTCHECK = {
				TAUNT = none,
			},
		},
	},
	{ -- 6
		CLOTHINGGIMMICK = {
			CLOTHINGGIMMICKFACE = {
				CLOTHINGGIMMICKSPEECH = {
					GIMMICKLAUGH = none,
					GIMMICKSPEAK = none,
				},
			},
		},
	},
	{ -- 6
		NEWKIDTAUNT = {
			TAUNTPLAYER = none,
		},
	},
	{ -- 6
		BEEFCLEARFLAG = none,
	},
	{ -- 6
		BS1WAIT = {
			BS1RESPONSES = {
				BS1TAUNT = {
					BS1TAUNTBACKDOWN = none,
					BS1HARASS = none,
					BS1TAUNTBACK = none,
				},
			},
		},
	},
	{ -- 6
		BEEFAPPROACH = {
			BEEFRESPONSE1 = none,
		},
	},
	{ -- 12
		SETPROPOBJ = none,
	},
	{ -- 6
		TAKEBIKE = {
			MOUNTBIKE = none,
		},
	},
	{ -- 6
		STEALBOOKSSEEK = {
			STEALBOOKSTEAL = {
				POSTSTEALCHOICES = {
					POSTSTEALTHROWACTION = none,
					POSTSTEALFLEE = none,
				},
			},
		},
	},
	{ -- 6
		USEPRANKFINDTARGET = {
			USEPRANKCHOICES = {
				USEPRANKSEEKPROJECTILE = {
					USEPRANKRANGE = {
						USEPRANKPROJECTILE = none,
						USEPRANKFLEE = {
							USEPRANKFLEENODE = none,
						},
						USEPRANKPLANT = none,
					},
				},
				USEPRANKKICKME = {
					PLANTSIGN = none,
				},
			},
		},
	},
	{ -- 6
		SEEKALARM = {
			USEALARM = none,
		},
	},
	{ -- 6
		SETCAROBJ = none,
	},
	{ -- 6
		HARASSRANGEWEAPON = {
			HARASSRANGEEQUIP = none,
			HARASSRANGEUSE = none,
		},
	},
	{ -- 6
		SEEKTAG = {
			SPRAYTAG = none,
		},
	},
	{ -- 6
		SETPROPOBJ = {
			BREAKPROPEGG = {
				BREAKPROPCLEAR = none,
			},
		},
		SCRIPTEDPROJ = {
			SCRIPTEDPROJTRACK = none,
		},
	},
	{ -- 6
		TARGETEDCHECK = {
			TARGETEDCHOICES = {
				TARGETDISS = none,
				TARGETANGRY = none,
			},
			TARGETEDFRIENDWBALL = none,
			ISALLY = none,
		},
	},
	{ -- 6
		LOOKATTAGGING = {
			TAGSPEECH = none,
		},
	},
	{ -- 6
		SURPRISEDACT = none,
	},
	{ -- 6
		LOOKATHIT = {
			HITHANGOUT = {
				HITHANGOUTCHOICES = {
					LOOKAROUND = {
						LOOKAROUND = none,
						LOOKAROUNDSURP = {
							FLEERUN = none,
						},
						LOOKAROUND2 = none,
					},
					TARGETPLAYERCOMBAT = {
						TARGETPLAYERCOMBATCHOICE = {
							TARGETPLAYERSEQ = none,
							TARGETPLAYERCOMBAT = none,
						},
					},
				},
			},
		},
	},
	{ -- 6
		MYBIKESTOLEN = {
			MYBIKESTOLENACTIONS = {
				MYBIKESTOLENFEAR = none,
				MYBIKESTOLENATTACK = {
					MYBIKESTOLENSPEECH = none,
				},
			},
		},
		BIKESTOLENFACE = none,
	},
	{ -- 6
		VOMITFACE = {
			VOMITCHOICE = {
				VOMITLAUGH = none,
				VOMITSPEAK = none,
				VOMITNOW = {
					VOMITNOW = none,
				},
				VOMITFACE2 = none,
			},
		},
	},
	{ -- 9
		TURNLAUGH = none,
	},
	{ -- 6
		FACEBOYS = {
			BOYSSPEAK = {
				BOYSSPEAKCOOL = none,
				BOYSSPEAKGROSS = none,
			},
		},
	},
	{ -- 9
		FACEBIKECRASH = {
			FACECRASHSPEAK = none,
		},
	},
	{ -- 6
		LOOKATPROP = {
			BREAKPROPSPEECH = none,
		},
	},
	{ -- 6
		LOOKATTAGGING = {
			TAGSPEECH = none,
		},
		TAGGETPISSED = none,
	},
	{ -- 6
		LOOKATFIRING = {
			WEAPONSPEAK = none,
		},
	},
	{ -- 13
		LOOKAT = none,
		FLEEREACTION = none,
	},
	{ -- 6
		BULLYINGSEE = none,
		BULLYLAUGH = none,
	},
	{ -- 6
		RESPONDTAUNT = {
			TAUNTTURN = {
				TAUNTRESPONSES = {
					TAUNTNOTVISIBLE = none,
					TAUNTISVISIBLE = {
						TAUNTAGGROCHECK = {
							TCHOICES = {
								TAUNTBEEF = none,
								TAUNTHARASS = none,
							},
						},
						TAUNTNOTAGGRO = {
							TAUNTFEARCHECK = {
								TAUNTFEARRESPONSE = {
									TAUNTFLEE = none,
								},
							},
							TAUNTNOTHING = {
								TAUNTSHRUG = none,
							},
						},
					},
					TAUNTFIX = none,
				},
			},
			TAUNTSOCIAL = none,
		},
		RESPONDGREET = {
			GREETSOCIAL = none,
		},
	},
	{ -- 6
		ADULTAUTHORITYFIGHT = {
			LOOKATAUHFIGHT = none,
		},
		CHEERFLEE = none,
	},
	{ -- 6
		TURNTOFACE = none,
		JOCKS = none,
		COWDANCESPEAK = {
			COOLSPEAK = none,
			CRAPSPEAK = none,
		},
	},
	{ -- 6
		STIMOPPS = none,
	},
	{ -- 6
		KICKMEREACTIONS = {
			KICKLAUGH = none,
			KICKLOADED = {
				KICKHIM = {
					KICKKICK = none,
				},
			},
			SCRIPTED = {
				KICKSCRIPT = none,
			},
		},
	},
	{ -- 19
		LOOKAT = none,
	},
	{ -- 6
		TVPISSED = none,
	},
	{ -- 7
		TURNTOFACE = {
			RETALIATE = none,
		},
	},
	{ -- 6
		TATTLEREACT = {
			WAIT = none,
		},
	},
	{ -- 6
		SLINGERFEAR = none,
		SLINGEROBJ = {
			STATS = {
				STATSFF = none,
				STATSSNOW = none,
			},
			SLINGERSPEECHEXEC = {
				SLINGERTRAY = none,
				SLINGERSPEECH = none,
			},
		},
		FACEOBJ = none,
	},
	{ -- 6
		CAMERADISLIKE = {
			CAMERADISLIKEACTIONREPEAT = none,
			CAMERADISLIKEACTION = none,
		},
		CAMERALIKE = {
			CAMERALIKEACTION = none,
		},
	},
	{ -- 7
		TURNTOFACE = {
			FINISH = none,
		},
	},
	{ -- 6
		FACERAT = {
			RATREACTIONS = {
				RATSPEECH = {
					RATSPEECHNODE = none,
				},
				RATFLEE = none,
				LOOKAT = none,
			},
		},
	},
	{ -- 6
		MOVETOLURE = {
			FACELURE = {
				ENDLURE = none,
			},
		},
	},
	{ -- 6
		LOOKFIRE = none,
	},
	{ -- 8
		KNOCKOUTTAUNT = none,
	},
	{ -- 6
		CHEERING = {
			CHEERSPEAK = none,
			CHEERDEATH = none,
		},
		ADULTFIGHT = {
			ADULTFIGHTMOVE = {
				FIGTHMOVEAWAY = none,
			},
			ADULTFIGHTFEMALE = {
				LOOKATFIGHT = none,
				AUTHCHECK = {
					HELPYELL = none,
				},
			},
			ADULTFIGHTEXEC = {
				ADULTFIGHWARN = none,
			},
			ADULTFIGHTMALE = {
				LOOKATFIGHT = none,
				AUTHCHECK = {
					HELPYELL = none,
				},
			},
		},
		CHEERLITTLEGIRLS = none,
	},
	{ -- 6
		DISPERSEDOCK = none,
	},
	{ -- 6
		FIREALARMDOCK = {
			FIREALARMSPEECH = {
				ALARMSPEECH = none,
			},
		},
	},
	{ -- 6
		MOVETOTRAP = none,
	},
	{ -- 6
		GIRLNOTICE = {
			GIRLNOTICECHOICES = {
				GIRLNOTICEANIM = {
					GIRLFREAKCHOICES = {
						FREAKHOSTILE = {
							FREAKATTACK = {
								FREAKATTACKTARGET = {
									FREAKATTACKTARGETGO = {
										FREAKATTACKFLEE = none,
									},
									FREAKATTACKTARGETWAIT = none,
								},
							},
							FREAKFLEE = none,
						},
						FREAKFLEE = none,
					},
				},
			},
			SPEAKOPTIONS = {
				DORMFREAKOUT = none,
				REGFREAK = none,
			},
		},
	},
	{ -- 6
		OFFICENOTICE = {
			OFFICENOTICECHOICES = {
				GIRLAUTHORITYNOTICE = none,
			},
		},
	},
	{ -- 6
		HATECHECK = none,
		HATECHECKGIRLTARGET = none,
	},
	{ -- 6
		HATECHECKGIRL = {
			CHECKFORPALS = {
				SEEKHELP = {
					FINDHELP = {
						TELLPAL = none,
					},
				},
			},
			TAUNT = none,
		},
		GIRLFRIENDATTACKED = {
			CHECKFORPALS = {
				SEEKHELP = {
					FINDHELP = {
						TELLPAL = none,
					},
				},
			},
		},
	},
	{ -- 6
		TURNTOFACE = {
			ATTACKCHECK = {
				SEEATTACKER = {
					FEAR = {
						AUTHCHECK = {
							FLEE = none,
							HELPYELL = {
								HELPYELLBIKE = none,
							},
						},
						FLEE = none,
					},
					ATTACKED = none,
					CHICKENS = {
						CHICKENWARN = {
							CHICKENFLEE = {
								TELLAUTHORITY = none,
							},
						},
					},
				},
				HITREACTSOCIAL = none,
				HITREACTSLINGER = none,
				SEEDISLIKED = {
					RETALIATE = none,
				},
				DEAD = none,
				ATTACKSPEECHBANK = {
					ATTACKSPEECH = {
						ATTACKWARNADULT = none,
						ATTACKWARNSPEECH = none,
					},
				},
				LOOKAROUND = none,
				ADOREREACT = {
					ATTITUDEADJUST = none,
				},
				ATTACKFIX = none,
			},
		},
	},
	{ -- 2
		CLOSINGATTACK = none,
	},
	{ -- 7
		PURSUITATTACK = none,
	},
	{ -- 2
		HIT = none,
		DEAD = none,
		ONGROUND = {
			RISINGATTACKS = none,
		},
	},
	{ -- 5
		TETHERLOCO = none,
	},
	{ -- 2
		FAR = none,
		NEAR = none,
		ACCURACYSPAWN = {
			SETUPACCURATE = none,
		},
		THROWFINISH = {
			THROWFINISH = none,
			THROWFINISHINACCURATE = none,
		},
	},
	{ -- 2
		HAPPY = none,
	},
	{ -- 3
		LOW_HEALTH = none,
	},
	{ -- 2
		NEUTRAL = none,
	},
	{ -- 2
		SURPRISE = none,
	},
	{ -- 3
		ANGRY = none,
	},
	{ -- 2
		NPCVSNPC = none,
	},
	{ -- 3
		TARGETANIMLISTEN = none,
		TARGETANIMIDLE = none,
		TARGETANIMTALK = none,
	},
	{ -- 10
		WAIT = none,
	},
	{ -- 3
		WARN = none,
	},
	{ -- 2
		LINE2 = {
			LINE3 = {
				END = none,
			},
		},
	},
	{ -- 2
		CONVINITIATE_CHILD = none,
	},
	{ -- 12
		GIVE_SEEK = {
			GET_OBJECT = none,
		},
		RECEIVE = {
			RECEIVE = {
				GIVE = none,
			},
		},
		GIVE_ATTEMPT_SPEECH = none,
		RECEIVEWAIT = none,
	},
	{ -- 2
		WORKOUT_CHILD = {
			BEGINWORKOUT = {
				RUNINPLACE = {
					STARTRUNNING = {
						ENDRUNNING = none,
					},
				},
				PUSHUP = {
					START = {
						ON_GROUND = {
							BELLYDOWN = {
								LOOP = none,
							},
						},
						END = none,
					},
				},
				JUMPINGJACK = {
					START = {
						LOOP = {
							END = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		C4_3 = {
			C4_4 = {
				C4_4B = {
					C4_5 = none,
				},
			},
		},
	},
	{ -- 2
		FACIAL3 = none,
		FACIAL1 = none,
		FACIAL2 = none,
	},
	{ -- 2
		BOTHHANDS = {
			XYLOPHONE = {
				MISSED = none,
				RIGHT = none,
				HIT = none,
				LEFT = none,
			},
			TIMPANI = {
				MISSED = none,
				HIT = none,
			},
			SNARE = {
				MISSED = none,
				HIT = none,
			},
			COWBELL = {
				MISSED = none,
				HIT = none,
			},
			MARACAS = {
				MISSED = none,
				HIT = none,
			},
		},
		SUCCESS = none,
		STARTANIMATIONS = {
			START2 = none,
			START1 = {
				START1_CHILD = none,
			},
		},
		RIGHT = {
			XYLOPHONE = {
				HITLOW = none,
				HITHIGH = none,
			},
			TIMPANI = {
				HIT = none,
			},
			SNARE = {
				HIT = none,
			},
			COWBELL = {
				HIT = none,
			},
			MARACAS = {
				HIT = none,
			},
		},
		LEFT = {
			XYLOPHONE = {
				HITLOW = none,
				HITHIGH = none,
			},
			TIMPANI = {
				HIT = none,
			},
			SNARE = {
				HIT = none,
			},
			COWBELL = {
				HIT = none,
			},
			MARACAS = {
				HIT = none,
			},
		},
		CUSTOMIDLE = {
			CUSTOMIDLE = none,
		},
		FAILURE = {
			PLAYERFAIL04 = none,
			PLAYERFAIL01 = none,
			PLAYERFAIL03 = none,
			PLAYERFAIL02 = none,
		},
		STICKS = {
			REMOVESTICKS = none,
			TIMPANI = none,
			DRUMSTICKS = none,
			XYLOPHONE = none,
			MARACAS = none,
		},
		CYCLECLEAR = none,
	},
	{ -- 2
		SUCCESSHI2 = none,
		EARNB = none,
		EARNA = none,
		SUCCESSMED1 = none,
		SUCCESSHI1 = none,
		SUCCESSHI3 = none,
	},
	{ -- 2
		XYLOPHONE = {
			MISSED = none,
			RIGHT = none,
			HIT = none,
			LEFT = none,
		},
		TIMPANI = {
			MISSED = none,
			HIT = none,
		},
		SNARE = {
			MISSED = none,
			HIT = none,
		},
		COWBELL = {
			MISSED = none,
			HIT = none,
		},
		MARACAS = {
			MISSED = none,
			HIT = none,
		},
	},
	{ -- 2
		START2 = none,
		START1 = {
			START1_CHILD = none,
		},
	},
	{ -- 4
		XYLOPHONE = {
			HITLOW = none,
			HITHIGH = none,
		},
		TIMPANI = {
			HIT = none,
		},
		SNARE = {
			HIT = none,
		},
		COWBELL = {
			HIT = none,
		},
		MARACAS = {
			HIT = none,
		},
	},
	{ -- 4
		HITLOW = none,
		HITHIGH = none,
	},
	{ -- 2
		CUSTOMIDLE = none,
	},
	{ -- 2
		REMOVESTICKS = none,
		TIMPANI = none,
		DRUMSTICKS = none,
		XYLOPHONE = none,
		MARACAS = none,
	},
	{ -- 2
		GRAPPLE = none,
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		EXECUTENODES = {
			FREE = {
				RUNBASIC = {
					RUNBASIC = none,
					RUNBASICFAT = none,
				},
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						SEXYGIRL = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_A_OPP = none,
													IDLE_D = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
										},
									},
								},
							},
						},
						NERDGIRL = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKA = {
										IDLES = {
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_D = none,
													IDLE_E_OPP = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
											IDLE_E = {
												IDLE_E = {
													IDLE_F_OPP = none,
													IDLE_E = none,
												},
											},
											IDLE_F = {
												IDLE_F = {
													IDLE_A_OPP = none,
													IDLE_F = none,
												},
											},
										},
									},
								},
							},
						},
						CHEERLEAD = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKA = {
										IDLES = {
											IDLE_E = {
												IDLE_E = {
													IDLE_F_OPP = none,
													IDLE_E = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
											IDLE_D = {
												IDLE_D = {
													IDLE_D = none,
													IDLE_E_OPP = none,
												},
											},
											IDLE_C = {
												IDLE_C = {
													IDLE_C = none,
													IDLE_D_OPP = none,
												},
											},
											IDLE_G = {
												IDLE_G = {
													IDLE_A_OPP = none,
													IDLE_G = none,
												},
											},
											IDLE_F = {
												IDLE_F = {
													IDLE_G_OPP = none,
													IDLE_F = none,
												},
											},
										},
									},
								},
							},
						},
						WOMAN = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
						GENERICGIRL = {
							ACTIONS = {
								FACTION_IDLES = {
									BANKB = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKA = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
									BANKC = {
										IDLES = {
											IDLE_C = {
												IDLE_C = {
													IDLE_A_OPP = none,
													IDLE_C = none,
												},
											},
											IDLE_A = {
												IDLE_A = {
													IDLE_B_OPP = none,
													IDLE_A = none,
												},
											},
											IDLE_B = {
												IDLE_B = {
													IDLE_C_OPP = none,
													IDLE_B = none,
												},
											},
										},
									},
								},
							},
						},
					},
				},
				SPRINTBASIC = none,
				WALKBASIC = {
					WALKBASICFAT = none,
					FAT_WALKOVERRIDES = {
						CONTROLLER_NODE = {
							ACTIONS = {
								GENERIC = {
									WALKIDLESEXECUTE = none,
								},
								FACTION_SPECIFIC = {
									FACTION_IDLE2 = none,
									FACTION_IDLE1 = none,
								},
								NOOVERRIDE = none,
							},
						},
					},
					FEMALE_WALKOVERRIDES = {
						CONTROLLER_NODE = {
							ACTIONS = {
								GENERIC = {
									WALKIDLESEXECUTE = none,
								},
								FACTION_SPECIFIC = {
									FACTION_IDLE2 = none,
									SKIPPING = {
										SKIPPING = none,
										BITCH = none,
									},
									FACTION_IDLE1 = none,
								},
								NOOVERRIDE = none,
							},
						},
					},
					WALKBASIC = {
						WALKWEENVAMP = none,
						WALKWEENSKIP = none,
					},
					WALKBASICNERD = none,
					NERD_WALKOVERRIDES = {
						CONTROLLER_NODE = {
							ACTIONS = {
								NOOVERRIDE = none,
								GENERIC = {
									WALKIDLESEXECUTE = none,
								},
							},
						},
					},
				},
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = none,
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = none,
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
		IDLE = none,
		RISINGATTACKS = none,
	},
	{ -- 21
		COMBATIDLE_OUT = none,
		STRAFE = none,
	},
	{ -- 22
		ANIM = none,
		NOANIM = none,
	},
	{ -- 43
		CCW_SLOW = {
			CCW = none,
			WAIT = none,
			END = none,
		},
		RESET = none,
		FORWARDS = none,
		CW_SLOW = {
			CW = none,
			END = none,
			WAIT = none,
		},
	},
	{ -- 21
		COMBATIDLE_OUT = none,
		RUNSTRAFEMODE = {
			STRAFERUNFWD = none,
			STRAFERUNBKW = none,
		},
		IDLE = {
			IDLE_ANIM = {
				ANIM = none,
				SOCIALIZING = none,
			},
		},
		NONCOMBATSTRAFEANIMS = {
			WALKSTOP = none,
		},
	},
	{ -- 21
		COLLAPSE = {
			COLLAPSELOAD = {
				COLLAPSE = none,
				GRAPPLETARGET = none,
			},
			COLLAPSEOFFLADDER = {
				FALL = none,
			},
			COLLAPSEOFFTREEBRANCH = {
				DOWN = {
					DOWN_END = none,
				},
			},
			COLLAPSEOFFTREEHANG = {
				DOWN = none,
			},
		},
	},
	{ -- 21
		RUN = {
			RUN = {
				LOCOTRACKS = {
					DEFAULT = none,
					TURNFAST = none,
				},
			},
		},
		SPRINT = {
			SPRINTBASIC = {
				LOCOTRACKS = {
					DEFAULT = none,
					TURNFAST = none,
				},
			},
		},
	},
	{ -- 21
		SKID = {
			RUN_TO_IDLE = {
				LOCO = {
					WINTER = none,
					NORMAL = none,
				},
			},
			SPRINT_SLIDE = none,
		},
	},
	{ -- 21
		TURN = {
			FACINGINTENDED = {
				CCW_SLOW = {
					CCW = none,
					WAIT = none,
					END = none,
				},
				RESET = none,
				FORWARDS = none,
				CW_SLOW = {
					CW = none,
					END = none,
					WAIT = none,
				},
			},
		},
	},
	{ -- 21
		CROUCH_OUT_TARGET = none,
	},
	{ -- 21
		CROUCHLOCOANIMS = {
			CROUCHLOCORUN = none,
			CROUCHLOCOBASIC = none,
		},
		RUNCONTROLLER = {
			CROUCHRUN = none,
			CROUCHLOCO = none,
		},
	},
	{ -- 21
		CRAWLCYCLE = {
			CROUCHRELEASE = none,
		},
	},
	{ -- 21
		AMBIENTACTIONS_VTIRED = {
			AMBIENTACTIONS_OPP = none,
			AMBIENTACTIONS = {
				AMBIENT_1 = none,
				AMBIENT_2 = none,
				AMBIENT_3 = none,
			},
		},
	},
	{ -- 21
		CW_SLOW_OLD = {
			CW = none,
			END = none,
			WAIT = none,
		},
		RESET = none,
		CCW_SLOW_FEMALE = {
			CCW = none,
			WAIT = none,
			END = none,
		},
		FORWARDS_ACCURATE = none,
		CCW_SLOW = {
			CCW = none,
			WAIT = none,
			END = none,
		},
		FORWARDS = none,
		CW_SLOW_FEMALE = {
			CW = none,
			END = none,
			WAIT = none,
		},
		CCW_SLOW_OLD = {
			CCW = none,
			WAIT = none,
			END = none,
		},
		CW_SLOW = {
			CW = none,
			END = none,
			WAIT = none,
		},
	},
	{ -- 21
		AMBIENTACTIONS_TIRED = {
			AMBIENTACTIONS_OPP = none,
			AMBIENTACTIONS = {
				AMBIENT_1 = none,
				AMBIENT_2 = none,
				AMBIENT_3 = none,
			},
		},
	},
	{ -- 23
		AMBIENTACTIONS = {
			AMBIENT_9 = none,
			AMBIENT_10 = none,
			AMBIENT_12 = none,
			AMBIENT_11 = none,
			AMBIENT_8 = none,
		},
	},
	{ -- 23
		AMBIENTACTIONS = {
			AMBIENT_4 = none,
			AMBIENT_6 = none,
			AMBIENT_2 = none,
			AMBIENT_1 = none,
			AMBIENT_7 = none,
			AMBIENT_5 = none,
			AMBIENT_3 = none,
		},
	},
	{ -- 22
		AMBIENTACTIONS = {
			ARMSONHIPS = none,
			SCRATCHARSE = none,
			SCRATCHHEAD = none,
			SCRATCHPIT = none,
			STRETCH = none,
		},
	},
	{ -- 22
		MIRRORACTIONS = {
			MIRRORACTIONS2 = none,
			MIRRORACTIONS3 = none,
			MIRRORACTIONS4 = none,
			MIRRORACTIONS1 = none,
		},
	},
	{ -- 21
		FREEZING = {
			DAMAGE = none,
		},
	},
	{ -- 21
		AMBIENTSPAWN = {
			OPPS = none,
		},
	},
	{ -- 21
		WAIT = none,
		SAYSOMETHING = {
			VTIRED = none,
			TIRED = none,
			NORMAL = none,
		},
	},
	{ -- 21
		HANDHOLDING = none,
		OLDPED = none,
	},
	{ -- 21
		IDLE_ANIM = {
			ANIM = none,
			SOCIALIZING = none,
		},
	},
	{ -- 21
		COLLAPSELOAD = {
			COLLAPSE = none,
			GRAPPLETARGET = none,
		},
		COLLAPSEOFFLADDER = {
			FALL = none,
		},
		COLLAPSEOFFTREEBRANCH = {
			DOWN = {
				DOWN_END = none,
			},
		},
		COLLAPSEOFFTREEHANG = {
			DOWN = none,
		},
	},
	{ -- 21
		RUN = {
			LOCOTRACKS = {
				DEFAULT = none,
				TURNFAST = none,
			},
		},
	},
	{ -- 21
		SPRINTBASIC = {
			LOCOTRACKS = {
				DEFAULT = none,
				TURNFAST = none,
			},
		},
	},
	{ -- 21
		RUN_TO_IDLE = {
			LOCO = {
				WINTER = none,
				NORMAL = none,
			},
		},
		SPRINT_SLIDE = none,
	},
	{ -- 21
		CROUCHLOCORUN = none,
		CROUCHLOCOBASIC = none,
	},
	{ -- 21
		CROUCHRUN = none,
		CROUCHLOCO = none,
	},
	{ -- 42
		AMBIENTACTIONS_OPP = none,
		AMBIENTACTIONS = {
			AMBIENT_1 = none,
			AMBIENT_2 = none,
			AMBIENT_3 = none,
		},
	},
	{ -- 46
		AMBIENT_1 = none,
		AMBIENT_2 = none,
		AMBIENT_3 = none,
	},
	{ -- 23
		AMBIENT_9 = none,
		AMBIENT_10 = none,
		AMBIENT_12 = none,
		AMBIENT_11 = none,
		AMBIENT_8 = none,
	},
	{ -- 23
		AMBIENT_4 = none,
		AMBIENT_6 = none,
		AMBIENT_2 = none,
		AMBIENT_1 = none,
		AMBIENT_7 = none,
		AMBIENT_5 = none,
		AMBIENT_3 = none,
	},
	{ -- 22
		ARMSONHIPS = none,
		SCRATCHARSE = none,
		SCRATCHHEAD = none,
		SCRATCHPIT = none,
		STRETCH = none,
	},
	{ -- 22
		MIRRORACTIONS2 = none,
		MIRRORACTIONS3 = none,
		MIRRORACTIONS4 = none,
		MIRRORACTIONS1 = none,
	},
	{ -- 21
		DAMAGE = none,
	},
	{ -- 21
		OPPS = none,
	},
	{ -- 21
		VTIRED = none,
		TIRED = none,
		NORMAL = none,
	},
	{ -- 2
		POOLCUE = none,
		WHIP = none,
		STICK_DEFAULT = none,
	},
	{ -- 2
		CHARGED_POKE = none,
	},
	{ -- 2
		TALKING = {
			TALKING02 = none,
			TALKING03 = none,
			TALKING01 = none,
		},
		LISTENING = {
			LISTENING02 = none,
			LISTENING01 = none,
			LISTENING03 = none,
		},
	},
	{ -- 2
		DANCE3 = none,
		DANCE1 = none,
		DANCE2 = none,
		DANCE4 = none,
	},
	{ -- 4
		LIGHTATTACKS = {
			WINDMILL_R = {
				WINDMILL_L = {
					HEAVYATTACKS = {
						SWINGPUNCH_R = none,
					},
				},
			},
		},
	},
	{ -- 3
		HEADBUTT_ANTICCYC = {
			HEADBUTT_RUNCYC = {
				HEADBUTT_SUCCESS = {
					GIVE = none,
					HEADBUTT_SUCCESS_WALL_HIT = {
						HEADBUTT_SUCCESS_WALL_HIT_GIVE = none,
						HEADBUTT_SUCCESS_WALL_HIT_RCV = none,
					},
					RCV = none,
				},
				HEADBUTT_FAIL = {
					HEADBUTT_FAIL = {
						HEADBUTT_DIZZY = none,
					},
				},
			},
		},
	},
	{ -- 4
		FREE = {
			DEFAULT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						FAT = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
						GEN = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							DONOTHING = none,
						},
					},
				},
			},
			RUNBASIC = {
				FAT = none,
				GEN = none,
			},
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					AUTHORITY = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKD = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					ADULT = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					FAT = {
						ACTIONSGIRL = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
					GENERIC = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_C = {
											IDLE_C = {
												IDLE_A_OPP = none,
												IDLE_C = none,
											},
										},
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
			WALKBASIC = {
				FAT = none,
				WALKBASIC = {
					WALKWEEN = none,
				},
				HOBODRUNK = {
					WALKBASIC = none,
				},
			},
			SPRINTBASIC = {
				AUTHORITY = none,
				FAT = none,
				GEN = none,
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = {
					BILLYCLUBCOMBATBASIC = none,
					BATCOMBATBASIC = none,
					COMBATBASIC = none,
				},
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = {
				GREASERCOMBATSTRAFEIDLE = none,
				WEAPONCOMBATSTRAFEIDLE = none,
				PREFECTCOMBATSTRAFEIDLE = none,
				COMBATSTRAFEIDLE = none,
				JOCKCOMBATSTRAFEIDLE = none,
			},
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 21
		ANIM = none,
		SOCIALIZING = none,
	},
	{ -- 21
		COLLAPSE = none,
		GRAPPLETARGET = none,
	},
	{ -- 26
		FALL = none,
	},
	{ -- 21
		DOWN = {
			DOWN_END = none,
		},
	},
	{ -- 30
		DOWN = none,
	},
	{ -- 21
		LOCO = {
			WINTER = none,
			NORMAL = none,
		},
	},
	{ -- 6
		GFSOCIALCHOICE = {
			GFSOCIALCHOICELONG = none,
			GFSOCIALCHOICENORM = none,
		},
		GIRLFRIENDSOCIAL = none,
	},
	{ -- 6
		GIRFRIENDSEEHH = {
			GIRFRIENDATTACKCHOICE = {
				GIRFRIENDATTACKBOY = {
					GIRFRIENDATTACKBOY = none,
					GIRFRIENDATTACKPLAYER = none,
				},
				GIRFRIENDATTACKALLY = none,
				GIRFRIENDATTACKPLAYER = none,
			},
			SFSEESPEECH = {
				THARASS = none,
				COMPLAIN = none,
			},
		},
	},
	{ -- 6
		HARASSCOND = {
			STEALOPP = none,
			HARASS = {
				HARASSRANGE = {
					HARASSHIT = {
						HARASSCHOICE = {
							TAUNTAFTER = none,
						},
					},
					HARASSRANGEWEAPON = {
						HARASSRANGEEQUIP = none,
						HARASSRANGEUSE = none,
					},
				},
				HUNT = none,
			},
			TAUNTCHECK = {
				TAUNT = none,
			},
			HUMILIATE = {
				HUMILNODE = none,
				BOOKSTEALEXEC = none,
			},
		},
		TAUNTCHECK = {
			TAUNT = none,
		},
	},
	{ -- 6
		CLOTHINGGIMMICKFACE = {
			CLOTHINGGIMMICKSPEECH = {
				GIMMICKLAUGH = none,
				GIMMICKSPEAK = none,
			},
		},
	},
	{ -- 6
		BS1RESPONSES = {
			BS1TAUNT = {
				BS1TAUNTBACKDOWN = none,
				BS1HARASS = none,
				BS1TAUNTBACK = none,
			},
		},
	},
	{ -- 6
		BEEFRESPONSE1 = none,
	},
	{ -- 6
		MOUNTBIKE = none,
	},
	{ -- 6
		STEALBOOKSTEAL = {
			POSTSTEALCHOICES = {
				POSTSTEALTHROWACTION = none,
				POSTSTEALFLEE = none,
			},
		},
	},
	{ -- 6
		USEPRANKCHOICES = {
			USEPRANKSEEKPROJECTILE = {
				USEPRANKRANGE = {
					USEPRANKPROJECTILE = none,
					USEPRANKFLEE = {
						USEPRANKFLEENODE = none,
					},
					USEPRANKPLANT = none,
				},
			},
			USEPRANKKICKME = {
				PLANTSIGN = none,
			},
		},
	},
	{ -- 6
		USEALARM = none,
	},
	{ -- 12
		HARASSRANGEEQUIP = none,
		HARASSRANGEUSE = none,
	},
	{ -- 6
		SPRAYTAG = none,
	},
	{ -- 6
		BREAKPROPEGG = {
			BREAKPROPCLEAR = none,
		},
	},
	{ -- 6
		SCRIPTEDPROJTRACK = none,
	},
	{ -- 6
		TARGETEDCHOICES = {
			TARGETDISS = none,
			TARGETANGRY = none,
		},
		TARGETEDFRIENDWBALL = none,
		ISALLY = none,
	},
	{ -- 12
		TAGSPEECH = none,
	},
	{ -- 6
		HITHANGOUT = {
			HITHANGOUTCHOICES = {
				LOOKAROUND = {
					LOOKAROUND = none,
					LOOKAROUNDSURP = {
						FLEERUN = none,
					},
					LOOKAROUND2 = none,
				},
				TARGETPLAYERCOMBAT = {
					TARGETPLAYERCOMBATCHOICE = {
						TARGETPLAYERSEQ = none,
						TARGETPLAYERCOMBAT = none,
					},
				},
			},
		},
	},
	{ -- 6
		MYBIKESTOLENACTIONS = {
			MYBIKESTOLENFEAR = none,
			MYBIKESTOLENATTACK = {
				MYBIKESTOLENSPEECH = none,
			},
		},
	},
	{ -- 6
		VOMITCHOICE = {
			VOMITLAUGH = none,
			VOMITSPEAK = none,
			VOMITNOW = {
				VOMITNOW = none,
			},
			VOMITFACE2 = none,
		},
	},
	{ -- 6
		BOYSSPEAK = {
			BOYSSPEAKCOOL = none,
			BOYSSPEAKGROSS = none,
		},
	},
	{ -- 9
		FACECRASHSPEAK = none,
	},
	{ -- 6
		BREAKPROPSPEECH = none,
	},
	{ -- 6
		WEAPONSPEAK = none,
	},
	{ -- 6
		TAUNTTURN = {
			TAUNTRESPONSES = {
				TAUNTNOTVISIBLE = none,
				TAUNTISVISIBLE = {
					TAUNTAGGROCHECK = {
						TCHOICES = {
							TAUNTBEEF = none,
							TAUNTHARASS = none,
						},
					},
					TAUNTNOTAGGRO = {
						TAUNTFEARCHECK = {
							TAUNTFEARRESPONSE = {
								TAUNTFLEE = none,
							},
						},
						TAUNTNOTHING = {
							TAUNTSHRUG = none,
						},
					},
				},
				TAUNTFIX = none,
			},
		},
		TAUNTSOCIAL = none,
	},
	{ -- 6
		GREETSOCIAL = none,
	},
	{ -- 6
		LOOKATAUHFIGHT = none,
	},
	{ -- 6
		COOLSPEAK = none,
		CRAPSPEAK = none,
	},
	{ -- 6
		KICKLAUGH = none,
		KICKLOADED = {
			KICKHIM = {
				KICKKICK = none,
			},
		},
		SCRIPTED = {
			KICKSCRIPT = none,
		},
	},
	{ -- 6
		STATS = {
			STATSFF = none,
			STATSSNOW = none,
		},
		SLINGERSPEECHEXEC = {
			SLINGERTRAY = none,
			SLINGERSPEECH = none,
		},
	},
	{ -- 6
		CAMERADISLIKEACTIONREPEAT = none,
		CAMERADISLIKEACTION = none,
	},
	{ -- 8
		CAMERALIKEACTION = none,
	},
	{ -- 118
		FINISH = none,
	},
	{ -- 6
		RATREACTIONS = {
			RATSPEECH = {
				RATSPEECHNODE = none,
			},
			RATFLEE = none,
			LOOKAT = none,
		},
	},
	{ -- 6
		FACELURE = {
			ENDLURE = none,
		},
	},
	{ -- 6
		CHEERSPEAK = none,
		CHEERDEATH = none,
	},
	{ -- 6
		ADULTFIGHTMOVE = {
			FIGTHMOVEAWAY = none,
		},
		ADULTFIGHTFEMALE = {
			LOOKATFIGHT = none,
			AUTHCHECK = {
				HELPYELL = none,
			},
		},
		ADULTFIGHTEXEC = {
			ADULTFIGHWARN = none,
		},
		ADULTFIGHTMALE = {
			LOOKATFIGHT = none,
			AUTHCHECK = {
				HELPYELL = none,
			},
		},
	},
	{ -- 6
		FIREALARMSPEECH = {
			ALARMSPEECH = none,
		},
	},
	{ -- 6
		GIRLNOTICECHOICES = {
			GIRLNOTICEANIM = {
				GIRLFREAKCHOICES = {
					FREAKHOSTILE = {
						FREAKATTACK = {
							FREAKATTACKTARGET = {
								FREAKATTACKTARGETGO = {
									FREAKATTACKFLEE = none,
								},
								FREAKATTACKTARGETWAIT = none,
							},
						},
						FREAKFLEE = none,
					},
					FREAKFLEE = none,
				},
			},
		},
		SPEAKOPTIONS = {
			DORMFREAKOUT = none,
			REGFREAK = none,
		},
	},
	{ -- 6
		OFFICENOTICECHOICES = {
			GIRLAUTHORITYNOTICE = none,
		},
	},
	{ -- 6
		CHECKFORPALS = {
			SEEKHELP = {
				FINDHELP = {
					TELLPAL = none,
				},
			},
		},
		TAUNT = none,
	},
	{ -- 6
		CHECKFORPALS = {
			SEEKHELP = {
				FINDHELP = {
					TELLPAL = none,
				},
			},
		},
	},
	{ -- 6
		ATTACKCHECK = {
			SEEATTACKER = {
				FEAR = {
					AUTHCHECK = {
						FLEE = none,
						HELPYELL = {
							HELPYELLBIKE = none,
						},
					},
					FLEE = none,
				},
				ATTACKED = none,
				CHICKENS = {
					CHICKENWARN = {
						CHICKENFLEE = {
							TELLAUTHORITY = none,
						},
					},
				},
			},
			HITREACTSOCIAL = none,
			HITREACTSLINGER = none,
			SEEDISLIKED = {
				RETALIATE = none,
			},
			DEAD = none,
			ATTACKSPEECHBANK = {
				ATTACKSPEECH = {
					ATTACKWARNADULT = none,
					ATTACKWARNSPEECH = none,
				},
			},
			LOOKAROUND = none,
			ADOREREACT = {
				ATTITUDEADJUST = none,
			},
			ATTACKFIX = none,
		},
	},
	{ -- 2
		BLOCK = {
			ATTACKBLOCKED = none,
		},
	},
	{ -- 2
		BOXING = none,
	},
	{ -- 2
		RUNBASIC = none,
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
		},
		WALKBASIC = none,
		SPRINTBASIC = none,
		NERD_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
			},
		},
	},
	{ -- 2
		LOWERBODY_ANIM = none,
	},
	{ -- 2
		FIREACTIONS = {
			CHARGE = {
				RELEASE = {
					RELEASE = {
						DETACH = none,
					},
				},
			},
		},
		AIM = {
			AIMIDLE = {
				DEFAULT = none,
				BASEBALL = none,
			},
		},
	},
	{ -- 3
		START2 = none,
		START1 = {
			START1_CHILD = {
				START1_2 = none,
			},
		},
	},
	{ -- 6
		GRABTUBE = none,
		POURTUBE = {
			POURTUBE = none,
		},
		PUTDOWNTUBE = none,
	},
	{ -- 3
		GRABROD = none,
		PUTDOWNROD = none,
		STIRROD = {
			STIRROD = none,
		},
	},
	{ -- 3
		POURBEAKER = {
			POURBEAKER = none,
		},
		GRABBEAKER = none,
		PUTDOWNBEAKER = none,
	},
	{ -- 3
		GRABPOWDER = none,
		SHAKEPOWDER = {
			SHAKEPOWDER = none,
		},
		PUTDOWNPOWDER = none,
	},
	{ -- 3
		PUTDOWNEYEDROP = none,
		GRABEYEDROP = none,
		DROPEYEDROP = {
			DROPEYEDROP = none,
		},
	},
	{ -- 6
		POURTUBE = none,
	},
	{ -- 3
		TUBES = {
			POURTUBES = none,
			GRABTUBES = none,
			PUTDOWNTUBES = none,
		},
		BURNER = {
			ADJUSTBURNER = none,
		},
	},
	{ -- 3
		CLEANUPHANDS = {
			CLEANUPHANDS_CHILD = none,
		},
		SMOKE = none,
		EXPLODE = none,
	},
	{ -- 2
		C4_4 = {
			C4_4B = {
				C4_5 = none,
			},
		},
	},
	{ -- 2
		C4_2 = none,
	},
	{ -- 3
		CONTROLLER0 = none,
		CONTROLLER2 = none,
	},
	{ -- 4
		MOUNTBIKE = none,
		MOVETOBIKE = none,
	},
	{ -- 2
		JUSTBUSTEDSOMEONE = {
			CLEARBUSTFLAG = {
				OPPOUT = none,
			},
		},
		PUNISHSPEECHBANK = {
			PUNISHSPEECH = {
				DEFAULTWARN = none,
				TAUNTWARN = {
					TAUNTWARNSPEAK = none,
				},
				ATTACKWARN = none,
				TRESPASSWARNING = {
					TRESPASSWARN = none,
				},
				TAGWARNING = {
					TAGWARN = none,
				},
				WEAPONWARNING = {
					WFWARN = none,
				},
				VANDALWARNING = {
					VANDALWARN = none,
				},
				CLASSWARNING = {
					CLASSWARN = none,
					CLASSWARN2 = none,
				},
				CURFEWWARNING = {
					CURFEWWARN = none,
				},
			},
		},
		WARNINGS = {
			CLOTHINGCRIME = {
				CLOTHINGFACE = {
					CLOTHINGGIMMICKSPEAK = none,
				},
			},
			CLASSWARNING = {
				CLASSWARNNOW = none,
			},
		},
		WORKSTIMEXEC = {
			WORKSTIM = none,
		},
		CRIMEREACT = {
			TAGCRIME = {
				LOOKATTAGGING = {
					STATINC = none,
				},
			},
			PROPCRIME = {
				LOOKATPROP = none,
			},
			AUTHTARGET = {
				AUTHTARGETACT = none,
			},
			AUTHDIALOG = {
				AUTHINTIMIDATE = {
					AUTHINTIMIDATEFACE = none,
				},
				AUTHAPOLOGY = {
					APOLOGYCHOICES = {
						WARN = none,
					},
				},
				AUTHGREET = {
					AUTHGREETCHOICES = {
						WAVEBACK = none,
						DISGUISE = none,
						WTF = none,
						COLDSHOULDER = none,
					},
				},
				TAUNTCRIME = {
					TAUNTWARNING = none,
				},
			},
			BIKECRASHEXEC = {
				BIKECRASHAUTH = none,
			},
			FIREALARMCRIME = {
				FIREGET = none,
			},
			WFIRECRIME = {
				LOOKATFIRING = none,
			},
			AUTHCANDY = {
				CANDYEXEC = none,
			},
			AUTHVOMIT = {
				VOMEXEC = none,
			},
			BOYKISS = {
				FACEBOYS = {
					BOYSSPEAK = {
						BOYSSPEAKGROSS = none,
					},
				},
			},
			PEDHITCRIME = {
				LOOKATHIT = none,
			},
			STOLENBIKE = {
				LOOKATTHIEF = none,
			},
			TATTLECRIME = {
				TATTLEREACT = {
					SEEKTATTLE = {
						TCHOICES = {
							TFINDTARGET = none,
							TCONFUSED = none,
						},
					},
				},
			},
			AUTHSURPRISE = none,
			FIGHTBREAKUP = none,
			CAMERATARGET = {
				CAMERADISLIKE = {
					CAMERADISLIKEACTION = none,
				},
				CAMERALIKE = {
					CAMERALIKEACTION = none,
				},
			},
			EXPCRIME = {
				FACEEXP = none,
			},
			LOCKPICKING = {
				LOOKAT = none,
			},
			VEHICLECRIME = {
				LOOKAT = none,
			},
			FIGHTAUTHLOOK = none,
		},
		PUNISHMENT = {
			THREATEN = none,
			PUNISH3 = none,
			PUNISH1 = none,
			PUNISH2 = none,
			WARNING = none,
		},
		PREFECTSWITCH = {
			SWITCHSCHOOL = {
				PREFECTSWITCHDAY = none,
				PREFECTSWITCHNIGHT = none,
			},
			SWITCHMAINMAP = {
				PREFECTSWITCHDAY = none,
				PREFECTSWITCHNIGHT = none,
			},
		},
	},
	{ -- 3
		HEADTRACKONBIKE_FLEEING = {
			WAITING = none,
			TRACKING = none,
		},
	},
	{ -- 3
		GETOFFBIKE = {
			HALTBIKE = {
				DISMOUNTWAIT = none,
			},
		},
		BBRAWL = none,
		BGETONVEHICLE = none,
		BFLEEONPATHOBJECTIVE = none,
		BFOLLOWPATH = none,
		BRACE = {
			BSTOPRACE = none,
		},
		BFLEEONROADOBJECTIVE = none,
		BWANDER = none,
		BFOLLOWFOCUS = none,
		BMOVEOBJECTIVE = none,
		BIDLE = none,
		BFACEOBJECTIVE = none,
		BFLEEOBJECTIVE = none,
	},
	{ -- 3
		FOLLOW = none,
		BIKEAUTHORITYATTACKOBJ = {
			FINDBADDIESBIKEATTACKOBJ = {
				DISMOUNTANDRESPONDATTACKOBJ = none,
			},
		},
		["3_04_FOLLOW"] = none,
		MELEEGETCLOSE = none,
	},
	{ -- 3
		CRIMINAL = {
			BREAKPROPS = {
				FIREATPROP = none,
			},
			HARASSAUTHORITY = {
				FIREATAUTHORITY = none,
			},
		},
		STIMULI = {
			HUMILIATION = {
				TURNLAUGH = none,
			},
			TAGGING = {
				TAGGETPISSED = none,
			},
			SEEBUSTED = {
				LOOKAT = none,
			},
			AUTHORITYFIGHT = {
				CHEERFLEE = none,
			},
			FIGHTNEARBY = {
				RIDETOFIGHT = {
					DISMOUNTCHEER = none,
				},
			},
			BIKECRASH = {
				FACEBIKECRASH = {
					FACECRASHSPEAK = none,
				},
			},
			EXPLOSION = {
				FLEEREACTION = none,
				BIKELOOKAT = none,
			},
		},
		BIKEAUTHORITY = {
			FINDBADDIESONBIKE = none,
		},
		FACTION = {
			FRIENDATTACKED = none,
			ABHORCHECK = none,
			AVERSECHECK = none,
		},
		HITREACT = {
			HITREACTBIKEEXEC = none,
			MYBIKESTOLENACTIONS = {
				MYBIKESTOLENFEAR = none,
				MYBIKESTOLENATTACK = {
					MYBIKESTOLENSPEECH = none,
				},
			},
			HITBYEGG = none,
		},
	},
	{ -- 3
		CONTROLNODE = none,
		BIKECOMBATACTIONS = {
			FACTIONSCAN = none,
			ATTACKACTIONS = {
				MELEE = {
					PUNCH = {
						RIGHT = none,
						LEFT = none,
					},
					WEAPON_TO_BE_DELETED = {
						RIGHT = none,
						LEFT = none,
					},
				},
				RANGEDACTIONS = {
					RANGEDWEAPONEQUIPPED = {
						DEEQUIPRANGEDWEAPON = none,
						FIRE = {
							CHECKLINEOFFIRE = none,
							DEFAULT = none,
						},
					},
					EQUIPRANGEDWEAPON = none,
				},
			},
			ATTACKSPEECH = {
				BIKEATTACKSPEECHNODE = none,
			},
		},
	},
	{ -- 2
		OMAR = {
			PLAYER = {
				OMAR = none,
			},
		},
	},
	{ -- 2
		PLAYER = {
			OMAR = none,
		},
	},
	{ -- 3
		WEAPONWALK = none,
		WEAPONBIKEIDLE = none,
		WEAPONSOCIAL = {
			WEAPONIDLE = none,
			PERFORMINGACTION = none,
		},
		WEAPONCROUCH = none,
		WEAPONRUN = none,
		WEAPONSTRAFE = none,
		WEAPONIDLE = none,
	},
	{ -- 21
		DOWN_END = none,
	},
	{ -- 21
		WINTER = none,
		NORMAL = none,
	},
	{ -- 2
		DEADCLEANUP = none,
	},
	{ -- 3
		GENERIC = none,
	},
	{ -- 5
		PLAY = none,
		LOAD = none,
	},
	{ -- 2
		B_TAUNT_A = {
			["04"] = none,
			["02"] = none,
			["03"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		B_TAUNT_U = {
			["04"] = none,
			["02"] = none,
			["03"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		G_TAUNT_A = {
			["02"] = none,
			["03"] = none,
			["01"] = none,
		},
	},
	{ -- 10
		["02"] = none,
		["03"] = none,
		["01"] = none,
	},
	{ -- 20
		["01"] = none,
	},
	{ -- 72
		["02"] = none,
		["01"] = none,
	},
	{ -- 2
		A_TAUNT_A = {
			["04"] = none,
			["02"] = none,
			["03"] = none,
			["01"] = none,
		},
	},
	{ -- 7
		["04"] = none,
		["02"] = none,
		["03"] = none,
		["01"] = none,
	},
	{ -- 2
		G_WAVE_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 42
		PLAY = none,
	},
	{ -- 2
		DONTHURTSPEECHREGULAR = none,
		DONTHURTSPEECHALLY = none,
	},
	{ -- 2
		INTIMIDATED = {
			WAVE_I = none,
		},
		FRIENDLY = {
			WAVE_F = {
				["01"] = none,
			},
		},
		VERYSCARED = {
			WAVE_S = {
				["01"] = none,
			},
		},
	},
	{ -- 2
		B_WAVE_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		B_WAVE_S = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		N_WAVE_I = none,
	},
	{ -- 2
		N_WAVE_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		INTIMIDATED = {
			FAT_WAVE_I = none,
		},
		FRIENDLY = {
			FAT_WAVE_F = {
				["02"] = none,
				["01"] = none,
			},
		},
		VERYSCARED = {
			FAT_WAVE_S = {
				["02"] = none,
				["01"] = none,
			},
		},
	},
	{ -- 2
		INTIMIDATED = {
			WAVE_I = none,
		},
		FRIENDLY = {
			WAVE_F = {
				["02"] = none,
				["01"] = none,
			},
		},
		VERYSCARED = {
			WAVE_S = {
				["02"] = none,
				["01"] = none,
			},
		},
	},
	{ -- 4
		GIRLLAUGH = none,
		GUY_LAUGH = {
			LAUGH02 = none,
			LAUGH01 = none,
		},
	},
	{ -- 2
		SCARED = {
			PLAY = none,
		},
	},
	{ -- 4
		SOCIALREACTINTIMIDATED = none,
		SOCIALREACTAGGRESSIVE = none,
		SOCIALREACTSCARED = none,
		SOCIALREACTFRIENDLY = none,
	},
	{ -- 2
		KISSREADY = none,
	},
	{ -- 2
		SCARED = none,
		VERYSCARED = none,
	},
	{ -- 4
		INTIMIDATED = {
			PLAY = none,
		},
		FRIENDLY = {
			PLAY = none,
		},
		VERYSCARED = {
			PLAY = none,
		},
	},
	{ -- 4
		UNARMED_LOOP = none,
	},
	{ -- 7
		PERFORMINGACTION = none,
	},
	{ -- 2
		B_DEFEN_S = {
			["02"] = none,
			["01"] = none,
		},
		B_DEFEN_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		OLD_DEFEN_I = {
			["01"] = none,
		},
		OLD_DEFEN_F = {
			["01"] = none,
		},
		OLD_DEFEN_S = {
			["01"] = none,
		},
	},
	{ -- 2
		GEN_DEFEN_I = {
			["02"] = none,
			["01"] = none,
		},
		GEN_DEFEN_F = {
			["02"] = none,
			["01"] = none,
		},
		GEN_DEFEN_S = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		FAT_DEFEN_I = {
			["02"] = none,
			["01"] = none,
		},
		FAT_DEFEN_S = {
			["02"] = none,
			["01"] = none,
		},
		FAT_DEFEN_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		NERD_DEFEN_I = {
			["02"] = none,
			["01"] = none,
		},
		NERD_DEFEN_F = {
			["02"] = none,
			["01"] = none,
		},
		NERD_DEFEN_S = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 4
		WAVE_I = none,
	},
	{ -- 2
		WAVE_F = {
			["01"] = none,
		},
	},
	{ -- 2
		WAVE_S = {
			["01"] = none,
		},
	},
	{ -- 3
		WAVE_S = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		FAT_WAVE_I = none,
	},
	{ -- 2
		FAT_WAVE_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		FAT_WAVE_S = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		WAVE_F = {
			["02"] = none,
			["01"] = none,
		},
	},
	{ -- 2
		["6-1"] = none,
	},
	{ -- 2
		["5-8"] = none,
	},
	{ -- 2
		SUCCESS = {
			GV = {
				END = none,
			},
			RCV = {
				END = none,
			},
			LOADANIMS = none,
		},
	},
	{ -- 5
		SUCCESS = {
			GV = none,
			RCV = none,
			LOADANIMS = none,
		},
	},
	{ -- 5
		GV = none,
		RCV = none,
		LOADANIMS = none,
	},
	{ -- 2
		["6-5"] = none,
		RUSSELL = none,
	},
	{ -- 2
		GV = {
			END = none,
		},
		RCV = {
			END = none,
		},
		LOADANIMS = none,
	},
	{ -- 3
		["1_02B"] = none,
	},
	{ -- 5
		SPAWNS = none,
		ANIMS = {
			DISMISS_02 = none,
			PRAISE_F_01 = none,
			DEFEN_F_01 = none,
			DISMISS_01 = none,
			DEFEN_F_02 = none,
			PRAISE_F_02 = none,
		},
	},
	{ -- 12
		TALK_2 = none,
		TALK_1 = none,
	},
	{ -- 5
		DISMISS_02 = none,
		PRAISE_F_01 = none,
		DEFEN_F_01 = none,
		DISMISS_01 = none,
		DEFEN_F_02 = none,
		PRAISE_F_02 = none,
	},
	{ -- 2
		LOOKAROUND = none,
		LOOKLEFT = none,
		LOOKRIGHT = none,
	},
	{ -- 3
		CHEERROUTINEA_00 = {
			CHEERROUTINEA_01 = {
				CHEERROUTINEA_02 = {
					CHEERROUTINEA_03 = {
						CHEERROUTINEA_04 = {
							CHEERROUTINEA_05 = none,
						},
					},
				},
			},
		},
	},
	{ -- 5
		RELEASEGROUP_CHILD = none,
	},
	{ -- 2
		SIT_END = none,
	},
	{ -- 3
		CHARGE = none,
		IDLE = none,
		GROUNDKICK = {
			GROUNDKICKPROJECTILE = none,
			GROUNDKICKEMPTY = none,
		},
	},
	{ -- 5
		CROSS = none,
	},
	{ -- 2
		KISSEND_RCV = none,
		KISSEND_GIVE = none,
	},
	{ -- 2
		THROWSTART = {
			THROWFINISH = none,
		},
	},
	{ -- 2
		IDLELOOP = none,
		TAUNTS = {
			TAUNT_B = none,
			TAUNT_A = none,
			TAUNT_C = none,
		},
	},
	{ -- 2
		GUARDDOGLOOPEXIT = none,
	},
	{ -- 5
		START = {
			ON_GROUND = {
				BELLYDOWN = {
					LOOP = none,
				},
			},
			END = none,
		},
	},
	{ -- 3
		STARTRUNNING = {
			ENDRUNNING = none,
		},
	},
	{ -- 3
		START = {
			LOOP = {
				END = none,
			},
		},
	},
	{ -- 4
		WEAPONATTACH = none,
		WEAPONDETACH = none,
	},
	{ -- 2
		PULL_IN_HEAVY = {
			GIVE = {
				TARGETORIENTATION = {
					FRONT = none,
					REAR = none,
				},
			},
			RCV = {
				FRONT = none,
				REAR = none,
			},
		},
	},
	{ -- 2
		REMOVEWEAPONS = none,
	},
	{ -- 2
		VOMIT = {
			VOMIT2 = {
				VOMIT3 = {
					VOMITSTUN = none,
				},
			},
		},
		LOAD = none,
		GAGSOUND = {
			FEMALE = none,
			MALE = none,
		},
	},
	{ -- 2
		DONTGETHURT = none,
		BOOHOO = none,
	},
	{ -- 3
		COWER_CYCLE = {
			COWER_END = none,
		},
	},
	{ -- 5
		LAUGH02 = none,
		LAUGH01 = none,
	},
	{ -- 4
		CATCHBALL = {
			CATCHMISS = none,
			CATCHSUCCESS = none,
		},
	},
	{ -- 2
		TREADWATER = none,
	},
	{ -- 2
		SPECTATORANIM2 = none,
		SPECTATORANIM1 = none,
		SPECTATORANIM3 = none,
	},
	{ -- 2
		SPECTATORANIM2 = none,
		SPECTATORDONOTHING = none,
		SPECTATORANIM1 = none,
		SPECTATORANIM3 = none,
	},
	{ -- 10
		RESET = none,
	},
	{ -- 3
		SIT_TALK_B = none,
		SIT_TALK_C = none,
		SIT_TALK_A = none,
		SIT_LAUGH = none,
	},
	{ -- 2
		SIT_END1 = none,
		SIT_END2 = none,
	},
	{ -- 2
		RELEASEANIMGROUP = {
			RELEASEGROUP = none,
		},
		GRAPPLEATTEMPT = {
			GRAPPLESUCCESS = {
				PULL_IN_HEAVY = {
					HELD = none,
					HOLD_IDLE = {
						GIVE = none,
						GRAPPLEBREAK = {
							BREAK_RCV = none,
							BREAK_GIVE = none,
						},
						RCV = none,
					},
					HOLD = none,
				},
				GRAPPLERCVWAIT = none,
			},
		},
		LOAD_ANIMATION = {
			TELL_OFF_CHILD = none,
		},
	},
	{ -- 2
		HELD = none,
		HOLD = none,
	},
	{ -- 3
		COWER_END = none,
	},
	{ -- 2
		SCENGREETBOYANIM = none,
	},
	{ -- 2
		SCENARIOTALKANIM = none,
	},
	{ -- 3
		OPPORTUNITYINSERT = none,
	},
	{ -- 4
		BREAKER_RIGHT = none,
		BREAKER = none,
		BREAKER_LEFT = none,
	},
	{ -- 3
		RUNBASIC = {
			RUNBASIC = none,
			RUNBASICFAT = none,
		},
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				SEXYGIRL = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
				},
				NERDGIRL = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_D = none,
											IDLE_E_OPP = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
									IDLE_E = {
										IDLE_E = {
											IDLE_F_OPP = none,
											IDLE_E = none,
										},
									},
									IDLE_F = {
										IDLE_F = {
											IDLE_A_OPP = none,
											IDLE_F = none,
										},
									},
								},
							},
						},
					},
				},
				CHEERLEAD = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKA = {
								IDLES = {
									IDLE_E = {
										IDLE_E = {
											IDLE_F_OPP = none,
											IDLE_E = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_D = none,
											IDLE_E_OPP = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
									IDLE_G = {
										IDLE_G = {
											IDLE_A_OPP = none,
											IDLE_G = none,
										},
									},
									IDLE_F = {
										IDLE_F = {
											IDLE_G_OPP = none,
											IDLE_F = none,
										},
									},
								},
							},
						},
					},
				},
				WOMAN = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
				GENERICGIRL = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		SPRINTBASIC = none,
		WALKBASIC = {
			WALKBASICFAT = none,
			FAT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			FEMALE_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							SKIPPING = {
								SKIPPING = none,
								BITCH = none,
							},
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			WALKBASIC = {
				WALKWEENVAMP = none,
				WALKWEENSKIP = none,
			},
			WALKBASICNERD = none,
			NERD_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						NOOVERRIDE = none,
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		CHECKINAIR = {
			INAIR = none,
		},
		UPDATETURN = none,
	},
	{ -- 2
		INAIR = none,
	},
	{ -- 2
		SPEECH3 = none,
		SPEECH = none,
		SPEECH2 = none,
	},
	{ -- 4
		CLEAROBJECTIVE = none,
	},
	{ -- 2
		PROPATTACKSPROJECTILE = {
			RANGEDWEAPONFIRINGPATTERNS = {
				APPLE = none,
				FOOTBALL = none,
				JOKECANDY = none,
				WFTBOMB = none,
				BANANA = none,
				BOSS = {
					TED = none,
				},
				DART = {
					CLEAROBJECTIVES = none,
				},
				BALL = none,
				POTATOGUN = none,
				BOTTLEROCKET = none,
				EGG = none,
				GARBPICK = none,
				MARBLE = none,
				KICKSIGN = none,
				TRAY = none,
				SLINGSHOT = none,
				ITCHINGPOWDER = none,
				STINKBOMB = none,
				SCHOOLHOUSE = none,
				BAGMARBLES = none,
				FOUNTAIN = none,
				DEADRAT = none,
				CHERRYBOMB = none,
				BRICK = none,
				PLANTPOT = none,
				WDISH = none,
				SNOWBALL = none,
				BASEBALL = none,
			},
		},
		PROPATTACKSMELEE = {
			PROPATTACKSHIGH = none,
			PROPATTACKSLOW = none,
		},
	},
	{ -- 12
		CALLBACK = none,
	},
	{ -- 13
		GET_OBJECT = none,
	},
	{ -- 13
		RECEIVE = {
			GIVE = none,
		},
	},
	{ -- 3
		SPOTTEDDELAY = none,
		LOLASPOTTED = none,
	},
	{ -- 2
		SMOKELOOP = {
			SMOKELOOPB = none,
		},
	},
	{ -- 2
		GIVE = none,
		SCRIPTCALLBACK = none,
	},
	{ -- 2
		SPOTTED = {
			SPOTTEDDELAY = none,
			LOLASPOTTED = none,
		},
		SEEKBREAK_RCV = none,
	},
	{ -- 2
		WALL_IDLE = {
			WALL_SMOKE_START = {
				WALL_SMOKE_IDLE = {
					WALL_SMOKE_A = none,
					WALL_SMOKE_B = none,
					WALL_SMOKE_C = none,
				},
			},
			WALL_END = none,
		},
	},
	{ -- 3
		GIVE_WAIT = none,
	},
	{ -- 2
		SPEECH4 = none,
		SPEECH1 = none,
		SPEECH3 = none,
		SPEECH2 = none,
	},
	{ -- 4
		THROW = none,
	},
	{ -- 2
		TURN = none,
	},
	{ -- 2
		DEFAULT = none,
		EGG = none,
	},
	{ -- 2
		EGG = none,
	},
	{ -- 6
		THROWFINISH = none,
	},
	{ -- 2
		SLIDETURN180SNAP = none,
	},
	{ -- 3
		TALK3 = none,
		TALK4 = none,
		TALK1 = none,
		TALK2 = none,
	},
	{ -- 2
		DOACHEER = none,
		CHOOSESTANDANIM = {
			FAST = none,
			SLOW = none,
			NORMAL = none,
			VSLOW = none,
			VFAST = none,
		},
	},
	{ -- 2
		FAST = none,
		SLOW = none,
		NORMAL = none,
		VSLOW = none,
		VFAST = none,
	},
	{ -- 3
		PLAYERSIT_CHILD = none,
		PLAYERSTAND = {
			VICTORY = none,
		},
	},
	{ -- 3
		C7_2 = {
			C7_3 = {
				C7_4 = {
					C7_5 = {
						C7_6 = {
							C7_7 = {
								C7_8 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 3
		C7_3 = {
			C7_4 = {
				C7_5 = {
					C7_6 = {
						C7_7 = {
							C7_8 = none,
						},
					},
				},
			},
		},
	},
	{ -- 3
		C7_4 = {
			C7_5 = {
				C7_6 = {
					C7_7 = {
						C7_8 = none,
					},
				},
			},
		},
	},
	{ -- 4
		PLAYERVICTORY03 = none,
		PLAYERVICTORY02 = none,
		UNLOCKS = {
			SUCCESSHI2 = none,
			SUCCESSMED1 = none,
			SUCCESSHI1 = none,
			SUCCESSHI3 = none,
		},
		PLAYERVICTORY01 = none,
	},
	{ -- 2
		C7_2 = {
			C7_3 = {
				C7_4 = none,
			},
		},
	},
	{ -- 4
		PREFECT = {
			PREFECT01 = none,
		},
		CONSTANTINOS = {
			C02 = none,
			C01 = none,
		},
		PLAYER = none,
	},
	{ -- 2
		C7_3 = {
			C7_4 = none,
		},
	},
	{ -- 3
		DIALOGUE = {
			RETURNCAMERA = none,
		},
	},
	{ -- 3
		RETURNCAMERA = none,
	},
	{ -- 2
		CHEERROUTINEA = {
			CHEERROUTINEA_00 = {
				CHEERROUTINEA_01 = {
					CHEERROUTINEA_02 = {
						CHEERROUTINEA_03 = {
							CHEERROUTINEA_04 = {
								CHEERROUTINEA_05 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 8
		LAUNCH = none,
	},
	{ -- 2
		MISSION = none,
	},
	{ -- 3
		LOOKATHIT = none,
	},
	{ -- 3
		LOOKATFIRING = none,
	},
	{ -- 2
		GRAPPLESUCCESS = {
			PULL_IN_HEAVY = {
				HELD = none,
				HOLD = none,
				GRAPPLEBREAK = {
					BREAK_RCV = none,
					BREAK_GIVE = none,
				},
			},
			GRAPPLERCVWAIT = none,
		},
	},
	{ -- 6
		ANIM02 = none,
		ANIM01 = none,
		ANIM03 = none,
		ANIM04 = none,
	},
	{ -- 2
		SPEECHCHANCE = {
			SEESOMETHINGCOOL = none,
		},
	},
	{ -- 2
		ANIM01 = none,
		ANIM03 = none,
		ANIM02 = none,
	},
	{ -- 2
		STAND = none,
	},
	{ -- 2
		KISS = {
			KISS_RCV = none,
			KISS_GIV = none,
		},
	},
	{ -- 2
		GENERIC = none,
		["1_02B"] = none,
	},
	{ -- 2
		FRISBEE = none,
		BALL = none,
		BANANA = none,
		POOBAG = none,
		["2HANDED"] = none,
		WEAPONIDLE = none,
	},
	{ -- 3
		SETUPBBALL = none,
	},
	{ -- 2
		CHARGE = {
			RELEASE = none,
		},
	},
	{ -- 2
		SETUPACCURATE = none,
	},
	{ -- 2
		THROWFINISH = none,
		THROWFINISHINACCURATE = none,
	},
	{ -- 2
		GIVE = {
			GIVE = none,
			RECEIVE = none,
		},
		GIVE_ATTEMPT = {
			GIVEINITIATE = {
				GIVE_SEEK = none,
				RECEIVEWAIT = none,
			},
			LOADWAIT = none,
		},
		EXECUTES = {
			ANIMS = {
				RECEIVE = none,
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			SPEECH = {
				RECEIVE = none,
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			MODELS = {
				GIVE = none,
				RECEIVE = none,
				SEEK = none,
			},
			WEAPONREMOVAL = {
				REMOVEALLWEAPONS = none,
			},
		},
	},
	{ -- 34
		GENERIC = {
			WALKIDLESEXECUTE = none,
		},
		FACTION_SPECIFIC = {
			FACTION_IDLE2 = none,
			FACTION_IDLE1 = none,
		},
		NOOVERRIDE = none,
	},
	{ -- 5
		ACTIONS = {
			ACTIONBRIDGE = none,
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKD = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		COMBAT = {
			COMBATBASIC = {
				UPPERBODY = {
					GRAPPLER = none,
					STRIKER = none,
				},
			},
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = {
			COMBATSTRAFEIDLE = {
				IDLESPAWN = {
					GRAPPLER = {
						IDLE_A = none,
						IDLE_B = none,
						IDLE_D = none,
						IDLE_C = none,
					},
					STRIKER = {
						IDLE_C = none,
						IDLE_A = none,
						IDLE_B = none,
					},
				},
			},
			WEAPONCOMBATSTRAFEIDLE = none,
		},
	},
	{ -- 2
		HOOK1LAND = none,
	},
	{ -- 3
		PICKUPSNOWBALL = none,
	},
	{ -- 2
		SCRIPTBREAK = none,
		SWALKAWAY = none,
		SCRIPTGRAPPLEBREAK = none,
		STRAPPED = none,
		SATTACK = none,
		SFLEE = none,
	},
	{ -- 2
		STEALTHPROPLOOKAROUND = none,
		STEALTHRESPONSE = {
			ACQUIRENEWTARGET = none,
			REMOVETARGET = none,
		},
	},
	{ -- 3
		COMBATWEAPONLOCO = none,
		COMBATLOCO = none,
	},
	{ -- 2
		MASCOT = {
			SPECIAL = none,
		},
	},
	{ -- 2
		ATTACKWARNCLEAR = none,
		ATTACKWARN = none,
	},
	{ -- 2
		WAITFORTARGETTAUNT = none,
		WAITFORTARGETEXIT = none,
	},
	{ -- 2
		REMOVEFLASHLIGHT = none,
		FOLLOWPATH = none,
		FACEOBJECTIVE = none,
		USEPROP = {
			USEPROPAMBIENT = {
				STARTROUTETOPROP = {
					PROPEXITEXEC = none,
					ACQUIREPROP = {
						WAITFORPROP = none,
						ACQUIRETHEPROP = {
							OPPFOODFIGHT = none,
							OPPTVSIT = none,
						},
					},
				},
			},
			USEPROPOBJ = none,
		},
		POIPOINT = {
			HANGOUT = {
				HANGOUTTALK = {
					HANGOUTTALKANIM = none,
					HANGOUTTALKSEQ = none,
				},
				HANGOUTSTUDENT = none,
				STOPHANGOUT = {
					EXITHANGTALK = none,
					EXITHANGTURF = none,
					EXITNEWKID = none,
					EXITHANG = none,
				},
				HANGOUTADULT = none,
			},
			SITTING = {
				SITWEAPON = {
					WEAPONCLEAR = none,
				},
				SITTING = {
					MOVETOSITSPOT = {
						SITDOWN = none,
						CLEARPOI = none,
					},
				},
				SITADULT = {
					MOVETOSITADULT = {
						SITDOWNADULT = none,
					},
				},
			},
			SPECTATOR = {
				MOVETOSPECTACLE = {
					STOPSPECTACLEEARLY = none,
					STOPSPECTACLE = none,
				},
			},
			SYNCTOPOI = {
				SYNCTOPOI = {
					STRAFETO = none,
					MOVETO = none,
					ORIENTONLY = none,
				},
			},
			SCENARIO = {
				SCENARIOEND = {
					SCENARIOENDNODE = none,
				},
				SCENARIOSEEK = {
					OPENSPEECH = {
						OPENSPEECHNODE = none,
					},
					SCENARIOOPEN = {
						SCENARIOWAIT = {
							SCENARIODIALOG = {
								SCENARIOACCEPTED = {
									SCENARIOOPTIONS = {
										SCENARIOOBJECTIVE = {
											WAITFOROBJECTIVE = {
												OBJECTIVEOPTIONS = {
													OBJCOMPLETED = {
														OBJSCENARIOEND = none,
													},
													OBJNOTCOMPLETE = none,
												},
											},
										},
										SCENARIOGIFT = {
											WAITFORGIFT = {
												GETGIFT = {
													GIFTSCENARIOEND = none,
													OBJNOTCOMPLETE = none,
												},
											},
										},
									},
									WAITTOSPEAK = none,
								},
							},
						},
					},
				},
				INSTREETBS = {
					GETBACKONTHEDANGSIDEWALK = none,
				},
				SCENARIOLOVEWAIT = {
					SCENARIOWAITFORPLAYER = none,
				},
			},
		},
		FLEEOBJECTIVE = {
			FLEEOBJECTIVE = none,
			FLEEOBJECTIVEWIMP = none,
		},
		STEALBIKE = {
			MOUNTBIKE = none,
			MOVETOBIKE = none,
		},
		EQUIPFLASHLIGHT = none,
		ROOFTOPATTACKER = {
			ROOFTOPOFFENSE = {
				OFFSENSE = none,
			},
			ROOFTOPSTOP = none,
		},
		SPECIFICOBJECTIVES = {
			USESPUDCANNON = {
				DEFAULT = none,
				PREFIREWAIT = {
					FIRE = {
						WAITFORPLAYERTOGETUP = none,
						POSTFIREWAIT = none,
					},
				},
			},
		},
		MOVEOBJECTIVE = none,
		FOLLOWFOCUS = none,
		GETONBIKE = {
			MOVETOCAR = {
				CLEAROBJECTIVE = none,
			},
			MOUNTCAR = none,
			MOVETOBIKE = none,
			MOUNTBIKE = none,
		},
		WANDER = {
			WANDER = none,
			WANDERRAIN = {
				WANDERRAINEXEC = none,
			},
		},
		PLAYCATCH = {
			FINDBALL = {
				PICKUPBALL = none,
			},
			PLAYCATCHIDLE = none,
			WAITINGFORTHROW = {
				FACETARGET = {
					BALLTHROWN = {
						CATCHBALL = {
							CATCHMISS = none,
							CATCHSUCCESS = none,
						},
					},
				},
			},
			HAVEBALL = {
				FACETARGET = {
					THROW = none,
				},
			},
			FINDBALLPLAYER = none,
		},
		IDLE = none,
		DOCK = none,
		EXITVEHICLE = none,
	},
	{ -- 2
		CHEERINGOPP = none,
	},
	{ -- 2
		COWEROPP = none,
	},
	{ -- 2
		DIALOGOPP = none,
	},
	{ -- 2
		SPECTATOROPP = none,
	},
	{ -- 2
		AUTHORITYGRABOPP = none,
	},
	{ -- 2
		KNOCKOUTTAUNTOPP = none,
	},
	{ -- 2
		REACTIONOPP = none,
	},
	{ -- 2
		ALLYOPP = none,
	},
	{ -- 2
		HANDLESTUCK = none,
	},
	{ -- 2
		HARASSOPP = none,
	},
	{ -- 2
		ATTACKWARNINGOPP = none,
	},
	{ -- 2
		SITOPP = none,
	},
	{ -- 2
		SCENARIOOPP = none,
	},
	{ -- 2
		EVADEPROJECTILE = {
			EVADEPROJECTILE = none,
		},
		EVADEGRENADE = {
			EVADEGRENADE = none,
		},
	},
	{ -- 2
		AUTHORITYFIGHTSTIMCREATE = none,
	},
	{ -- 4
		COUNTER = none,
	},
	{ -- 4
		EVADECOUNTER = none,
		EVADEBACK = none,
	},
	{ -- 3
		AUTHORITY = {
			PICKUP = none,
		},
		ADULTS = {
			PICKUP = none,
		},
		TOUGH = {
			PICKUP = none,
		},
		WIMPS = {
			PICKUP = none,
		},
		PICKUPACTION = {
			PICKUPWEAPON = none,
		},
	},
	{ -- 8
		APPLE = none,
		FOOTBALL = none,
		JOKECANDY = none,
		WFTBOMB = none,
		BANANA = none,
		BOSS = {
			TED = none,
		},
		DART = {
			CLEAROBJECTIVES = none,
		},
		BALL = none,
		POTATOGUN = none,
		BOTTLEROCKET = none,
		EGG = none,
		GARBPICK = none,
		MARBLE = none,
		KICKSIGN = none,
		TRAY = none,
		SLINGSHOT = none,
		ITCHINGPOWDER = none,
		STINKBOMB = none,
		SCHOOLHOUSE = none,
		BAGMARBLES = none,
		FOUNTAIN = none,
		DEADRAT = none,
		CHERRYBOMB = none,
		BRICK = none,
		PLANTPOT = none,
		WDISH = none,
		SNOWBALL = none,
		BASEBALL = none,
	},
	{ -- 4
		PROPATTACKSHIGH = none,
		PROPATTACKSLOW = none,
	},
	{ -- 2
		RUNNINGATTACK = {
			RUNNINGATTACKCALL = none,
		},
	},
	{ -- 2
		FEMALEFLEE = none,
	},
	{ -- 3
		EQUIPWEAPON = none,
	},
	{ -- 2
		PUTDOWNUMBRELLA = none,
	},
	{ -- 2
		FREE = {
			FAT_WALKOVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONS = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
				},
			},
			RUNBASIC = none,
			SPRINTBASIC = none,
			WALKBASIC = none,
			IDLE_OVERRIDES = {
				CONTROLLER_NODE = {
					ACTIONSGIRL = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		LOCOMOTIONOVERRIDE = {
			COMBAT = {
				COMBATBASIC = none,
				STRAFEIDLE = none,
			},
			COMBATSTRAFEIDLE = none,
		},
		CUSTOMACTIONOPS = {
			CUSTOMACTIONOPS = none,
		},
	},
	{ -- 4
		WALKBASIC = none,
		RUNBASIC = none,
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
					},
				},
			},
		},
		DROPOUT_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
			},
		},
		SPRINTBASIC = none,
	},
	{ -- 17
		BILLYCLUBCOMBATBASIC = none,
		BATCOMBATBASIC = none,
		COMBATBASIC = none,
	},
	{ -- 3
		PUNCH1 = {
			PUNCH2 = {
				HEAVYATTACKS = {
					PUNCH3 = none,
				},
			},
		},
	},
	{ -- 4
		GIVEINITIATE = {
			GIVE_SEEK = {
				SEEKENTITY = none,
				GIVE_WAIT = {
					FAIL = none,
					COLLISION = none,
				},
			},
			RECEIVEWAIT = none,
		},
		LOADWAIT = none,
	},
	{ -- 8
		REMOVEALLWEAPONS = none,
	},
	{ -- 2
		LINE2 = {
			LINE3 = {
				LINE4 = {
					LINE5 = {
						LINE6 = {
							END = none,
						},
					},
				},
			},
		},
	},
	{ -- 2
		PINKYIDLE_END = none,
	},
	{ -- 3
		JIMMY02 = none,
		JIMMY01 = none,
	},
	{ -- 2
		NONCOMBATSTRAFEANIMS = none,
	},
	{ -- 2
		WEAPONWALK = none,
		WEAPONCROUCH = none,
		WEAPONIDLE = none,
		WEAPONSTRAFE = none,
		ONTREE = {
			IDLE = none,
		},
		WEAPONRUN = none,
		WEAPONBIKEIDLE = none,
		WEAPONSOCIAL = {
			WEAPONIDLE = none,
			PERFORMINGACTION = none,
		},
	},
	{ -- 2
		["4_06_MARBLED"] = none,
	},
	{ -- 2
		BEGINWORKOUT = {
			RUNINPLACE = {
				STARTRUNNING = {
					ENDRUNNING = none,
				},
			},
			PUSHUP = {
				START = {
					ON_GROUND = {
						BELLYDOWN = {
							LOOP = none,
						},
					},
					END = none,
				},
			},
			JUMPINGJACK = {
				START = {
					LOOP = {
						END = none,
					},
				},
			},
		},
	},
	{ -- 2
		VOMIT2 = {
			VOMIT3 = {
				VOMITSTUN = none,
			},
		},
	},
	{ -- 2
		GRAPPLESUCCESS = {
			PULL_IN_HEAVY = {
				HELD = none,
				DOBUSTEDANIMS = {
					GETHIT1 = none,
					GETHIT2 = none,
				},
				HOLD = none,
				BRUTEANIMATION = {
					BEHARSH = none,
				},
				DOCOPANIMATIONS = {
					COP3 = none,
					COP1 = none,
					COP2 = none,
					COP4 = none,
				},
			},
			GRAPPLERCVWAIT = none,
		},
	},
	{ -- 2
		RANGEDWEAPONACTIONS = {
			RANGEDWEAPONACTIONSOTHERS = {
				PREFIRERANGEDWEAPON = {
					RANGEDWEAPONFIRINGPATTERNS = {
						APPLE = none,
						FOOTBALL = none,
						JOKECANDY = none,
						WFTBOMB = none,
						BANANA = none,
						BOSS = {
							TED = none,
						},
						DART = {
							CLEAROBJECTIVES = none,
						},
						BALL = none,
						POTATOGUN = none,
						BOTTLEROCKET = none,
						EGG = none,
						GARBPICK = none,
						MARBLE = none,
						KICKSIGN = none,
						TRAY = none,
						SLINGSHOT = none,
						ITCHINGPOWDER = none,
						STINKBOMB = none,
						SCHOOLHOUSE = none,
						BAGMARBLES = none,
						FOUNTAIN = none,
						DEADRAT = none,
						CHERRYBOMB = none,
						BRICK = none,
						PLANTPOT = none,
						WDISH = none,
						SNOWBALL = none,
						BASEBALL = none,
					},
				},
			},
			AMMOCHECK = {
				DEEQUIPWEAPON = none,
			},
		},
		RANGEDWEAPONCHECK = {
			OUTOFRANGE = {
				DEEQUIPPROJECTILEWEAPON = none,
			},
		},
	},
	{ -- 2
		USEPROPAMBIENT = {
			STARTROUTETOPROP = {
				PROPEXITEXEC = none,
				ACQUIREPROP = {
					WAITFORPROP = none,
					ACQUIRETHEPROP = {
						OPPFOODFIGHT = none,
						OPPTVSIT = none,
					},
				},
			},
		},
		USEPROPOBJ = none,
	},
	{ -- 3
		HANGOUT = {
			HANGOUTTALK = {
				HANGOUTTALKANIM = none,
				HANGOUTTALKSEQ = none,
			},
			HANGOUTSTUDENT = none,
			STOPHANGOUT = {
				EXITHANGTALK = none,
				EXITHANGTURF = none,
				EXITNEWKID = none,
				EXITHANG = none,
			},
			HANGOUTADULT = none,
		},
		SITTING = {
			SITWEAPON = {
				WEAPONCLEAR = none,
			},
			SITTING = {
				MOVETOSITSPOT = {
					SITDOWN = none,
					CLEARPOI = none,
				},
			},
			SITADULT = {
				MOVETOSITADULT = {
					SITDOWNADULT = none,
				},
			},
		},
		SPECTATOR = {
			MOVETOSPECTACLE = {
				STOPSPECTACLEEARLY = none,
				STOPSPECTACLE = none,
			},
		},
		SYNCTOPOI = {
			SYNCTOPOI = {
				STRAFETO = none,
				MOVETO = none,
				ORIENTONLY = none,
			},
		},
		SCENARIO = {
			SCENARIOEND = {
				SCENARIOENDNODE = none,
			},
			SCENARIOSEEK = {
				OPENSPEECH = {
					OPENSPEECHNODE = none,
				},
				SCENARIOOPEN = {
					SCENARIOWAIT = {
						SCENARIODIALOG = {
							SCENARIOACCEPTED = {
								SCENARIOOPTIONS = {
									SCENARIOOBJECTIVE = {
										WAITFOROBJECTIVE = {
											OBJECTIVEOPTIONS = {
												OBJCOMPLETED = {
													OBJSCENARIOEND = none,
												},
												OBJNOTCOMPLETE = none,
											},
										},
									},
									SCENARIOGIFT = {
										WAITFORGIFT = {
											GETGIFT = {
												GIFTSCENARIOEND = none,
												OBJNOTCOMPLETE = none,
											},
										},
									},
								},
								WAITTOSPEAK = none,
							},
						},
					},
				},
			},
			INSTREETBS = {
				GETBACKONTHEDANGSIDEWALK = none,
			},
			SCENARIOLOVEWAIT = {
				SCENARIOWAITFORPLAYER = none,
			},
		},
	},
	{ -- 2
		FLEEOBJECTIVE = none,
		FLEEOBJECTIVEWIMP = none,
	},
	{ -- 3
		ROOFTOPOFFENSE = {
			OFFSENSE = none,
		},
		ROOFTOPSTOP = none,
	},
	{ -- 2
		USESPUDCANNON = {
			DEFAULT = none,
			PREFIREWAIT = {
				FIRE = {
					WAITFORPLAYERTOGETUP = none,
					POSTFIREWAIT = none,
				},
			},
		},
	},
	{ -- 2
		MOVETOCAR = {
			CLEAROBJECTIVE = none,
		},
		MOUNTCAR = none,
		MOVETOBIKE = none,
		MOUNTBIKE = none,
	},
	{ -- 2
		WANDER = none,
		WANDERRAIN = {
			WANDERRAINEXEC = none,
		},
	},
	{ -- 2
		FINDBALL = {
			PICKUPBALL = none,
		},
		PLAYCATCHIDLE = none,
		WAITINGFORTHROW = {
			FACETARGET = {
				BALLTHROWN = {
					CATCHBALL = {
						CATCHMISS = none,
						CATCHSUCCESS = none,
					},
				},
			},
		},
		HAVEBALL = {
			FACETARGET = {
				THROW = none,
			},
		},
		FINDBALLPLAYER = none,
	},
	{ -- 2
		CLIMBLADDEROBJECTIVE = none,
		JUMPOBJECTIVE = none,
	},
	{ -- 2
		ACQUIRENEWTARGET = none,
		REMOVETARGET = none,
	},
	{ -- 6
		GFSOCIALCHOICELONG = none,
		GFSOCIALCHOICENORM = none,
	},
	{ -- 6
		GIRFRIENDATTACKCHOICE = {
			GIRFRIENDATTACKBOY = {
				GIRFRIENDATTACKBOY = none,
				GIRFRIENDATTACKPLAYER = none,
			},
			GIRFRIENDATTACKALLY = none,
			GIRFRIENDATTACKPLAYER = none,
		},
		SFSEESPEECH = {
			THARASS = none,
			COMPLAIN = none,
		},
	},
	{ -- 6
		STEALOPP = none,
		HARASS = {
			HARASSRANGE = {
				HARASSHIT = {
					HARASSCHOICE = {
						TAUNTAFTER = none,
					},
				},
				HARASSRANGEWEAPON = {
					HARASSRANGEEQUIP = none,
					HARASSRANGEUSE = none,
				},
			},
			HUNT = none,
		},
		TAUNTCHECK = {
			TAUNT = none,
		},
		HUMILIATE = {
			HUMILNODE = none,
			BOOKSTEALEXEC = none,
		},
	},
	{ -- 6
		CLOTHINGGIMMICKSPEECH = {
			GIMMICKLAUGH = none,
			GIMMICKSPEAK = none,
		},
	},
	{ -- 6
		BS1TAUNT = {
			BS1TAUNTBACKDOWN = none,
			BS1HARASS = none,
			BS1TAUNTBACK = none,
		},
	},
	{ -- 6
		POSTSTEALCHOICES = {
			POSTSTEALTHROWACTION = none,
			POSTSTEALFLEE = none,
		},
	},
	{ -- 6
		USEPRANKSEEKPROJECTILE = {
			USEPRANKRANGE = {
				USEPRANKPROJECTILE = none,
				USEPRANKFLEE = {
					USEPRANKFLEENODE = none,
				},
				USEPRANKPLANT = none,
			},
		},
		USEPRANKKICKME = {
			PLANTSIGN = none,
		},
	},
	{ -- 6
		BREAKPROPCLEAR = none,
	},
	{ -- 6
		TARGETDISS = none,
		TARGETANGRY = none,
	},
	{ -- 6
		HITHANGOUTCHOICES = {
			LOOKAROUND = {
				LOOKAROUND = none,
				LOOKAROUNDSURP = {
					FLEERUN = none,
				},
				LOOKAROUND2 = none,
			},
			TARGETPLAYERCOMBAT = {
				TARGETPLAYERCOMBATCHOICE = {
					TARGETPLAYERSEQ = none,
					TARGETPLAYERCOMBAT = none,
				},
			},
		},
	},
	{ -- 9
		MYBIKESTOLENFEAR = none,
		MYBIKESTOLENATTACK = {
			MYBIKESTOLENSPEECH = none,
		},
	},
	{ -- 6
		VOMITLAUGH = none,
		VOMITSPEAK = none,
		VOMITNOW = {
			VOMITNOW = none,
		},
		VOMITFACE2 = none,
	},
	{ -- 6
		BOYSSPEAKCOOL = none,
		BOYSSPEAKGROSS = none,
	},
	{ -- 6
		TAUNTRESPONSES = {
			TAUNTNOTVISIBLE = none,
			TAUNTISVISIBLE = {
				TAUNTAGGROCHECK = {
					TCHOICES = {
						TAUNTBEEF = none,
						TAUNTHARASS = none,
					},
				},
				TAUNTNOTAGGRO = {
					TAUNTFEARCHECK = {
						TAUNTFEARRESPONSE = {
							TAUNTFLEE = none,
						},
					},
					TAUNTNOTHING = {
						TAUNTSHRUG = none,
					},
				},
			},
			TAUNTFIX = none,
		},
	},
	{ -- 6
		KICKHIM = {
			KICKKICK = none,
		},
	},
	{ -- 6
		KICKSCRIPT = none,
	},
	{ -- 6
		STATSFF = none,
		STATSSNOW = none,
	},
	{ -- 6
		SLINGERTRAY = none,
		SLINGERSPEECH = none,
	},
	{ -- 6
		RATSPEECH = {
			RATSPEECHNODE = none,
		},
		RATFLEE = none,
		LOOKAT = none,
	},
	{ -- 6
		ENDLURE = none,
	},
	{ -- 6
		FIGTHMOVEAWAY = none,
	},
	{ -- 12
		LOOKATFIGHT = none,
		AUTHCHECK = {
			HELPYELL = none,
		},
	},
	{ -- 6
		ADULTFIGHWARN = none,
	},
	{ -- 12
		HELPYELL = none,
	},
	{ -- 6
		ALARMSPEECH = none,
	},
	{ -- 6
		GIRLNOTICEANIM = {
			GIRLFREAKCHOICES = {
				FREAKHOSTILE = {
					FREAKATTACK = {
						FREAKATTACKTARGET = {
							FREAKATTACKTARGETGO = {
								FREAKATTACKFLEE = none,
							},
							FREAKATTACKTARGETWAIT = none,
						},
					},
					FREAKFLEE = none,
				},
				FREAKFLEE = none,
			},
		},
	},
	{ -- 6
		DORMFREAKOUT = none,
		REGFREAK = none,
	},
	{ -- 6
		GIRLAUTHORITYNOTICE = none,
	},
	{ -- 12
		SEEKHELP = {
			FINDHELP = {
				TELLPAL = none,
			},
		},
	},
	{ -- 12
		FINDHELP = {
			TELLPAL = none,
		},
	},
	{ -- 6
		SEEATTACKER = {
			FEAR = {
				AUTHCHECK = {
					FLEE = none,
					HELPYELL = {
						HELPYELLBIKE = none,
					},
				},
				FLEE = none,
			},
			ATTACKED = none,
			CHICKENS = {
				CHICKENWARN = {
					CHICKENFLEE = {
						TELLAUTHORITY = none,
					},
				},
			},
		},
		HITREACTSOCIAL = none,
		HITREACTSLINGER = none,
		SEEDISLIKED = {
			RETALIATE = none,
		},
		DEAD = none,
		ATTACKSPEECHBANK = {
			ATTACKSPEECH = {
				ATTACKWARNADULT = none,
				ATTACKWARNSPEECH = none,
			},
		},
		LOOKAROUND = none,
		ADOREREACT = {
			ATTITUDEADJUST = none,
		},
		ATTACKFIX = none,
	},
	{ -- 2
		TIMEOUT_CHILD = none,
	},
	{ -- 2
		AWMAN = none,
		TAUNTEDCHOICES = {
			DONOTHING = none,
			COMBATT = none,
		},
	},
	{ -- 2
		FEAREXIT = none,
		TAUNTEDCHOICES = {
			DONOTHING = none,
			COMBATT = none,
		},
	},
	{ -- 2
		CLEARSTIMFLAGNOW = none,
	},
	{ -- 4
		PROJECTILECOUNTER = none,
	},
	{ -- 2
		GRAPPLECONTROL = {
			WAITING = none,
			RECEIVER = none,
			GIVER = {
				TANDEM = {
					ATTACKRIGHTSACQUIRE = none,
					RELEASETANDEM = none,
				},
				GIVER = none,
			},
		},
	},
	{ -- 3
		CHARGE_COUNTERATTACK = {
			COUNTERATTACK = none,
		},
	},
	{ -- 4
		HIT = none,
		PROJECTILEHIT = none,
	},
	{ -- 2
		PROPATTACKSPROJECTILE = {
			RANGEDWEAPONFIRINGPATTERNS = {
				APPLE = none,
				FOOTBALL = none,
				JOKECANDY = none,
				WFTBOMB = none,
				BANANA = none,
				BOSS = {
					TED = none,
				},
				DART = {
					CLEAROBJECTIVES = none,
				},
				BALL = none,
				POTATOGUN = none,
				BOTTLEROCKET = none,
				EGG = none,
				GARBPICK = none,
				MARBLE = none,
				KICKSIGN = none,
				TRAY = none,
				SLINGSHOT = none,
				ITCHINGPOWDER = none,
				STINKBOMB = none,
				SCHOOLHOUSE = none,
				BAGMARBLES = none,
				FOUNTAIN = none,
				DEADRAT = none,
				CHERRYBOMB = none,
				BRICK = none,
				PLANTPOT = none,
				WDISH = none,
				SNOWBALL = none,
				BASEBALL = none,
			},
		},
		PROPATTACKSMELEE = {
			PROPATTACKSHIGH = none,
			PROPATTACKSLOW = none,
		},
		PROPATTACKSMELEEWEAPON = {
			PROPATTACKSMELEEWEAPON = none,
		},
	},
	{ -- 2
		BREAKPROP = {
			ATTACKVEHICLEEND = none,
		},
	},
	{ -- 3
		DEFAULT_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					NOOVERRIDE = none,
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
				},
			},
		},
		RUNBASIC = none,
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
					},
				},
			},
		},
		WALKBASIC = {
			WALKBASIC = {
				WALKWEEN = none,
			},
		},
		SPRINTBASIC = {
			RUSSELL6_03 = none,
			SPRINTBASIC = none,
		},
	},
	{ -- 2
		WINDMILL_R = {
			WINDMILL_L = none,
		},
	},
	{ -- 6
		SWINGPUNCH_R = none,
	},
	{ -- 2
		FIRESWITCH_IDLE = none,
		FIRESWITCH_OPEN = none,
	},
	{ -- 2
		BARKLOOP = none,
	},
	{ -- 5
		PLAYER02 = none,
		PLAYER01 = none,
	},
	{ -- 2
		SIT_CONVB = none,
		SIT_CONVA = none,
		SIT_CONVC = none,
	},
	{ -- 2
		SMOKELOOPB = none,
	},
	{ -- 2
		CHARGELOOP = none,
	},
	{ -- 3
		CHEERROUTINEA_01 = {
			CHEERROUTINEA_02 = {
				CHEERROUTINEA_03 = {
					CHEERROUTINEA_04 = {
						CHEERROUTINEA_05 = none,
					},
				},
			},
		},
	},
	{ -- 2
		KNEEL_IDLE = none,
	},
	{ -- 5
		ON_GROUND = {
			BELLYDOWN = {
				LOOP = none,
			},
		},
		END = none,
	},
	{ -- 5
		BELLYDOWN = {
			LOOP = none,
		},
	},
	{ -- 4
		TURNTOFACE = {
			ATTACKCHECK = {
				SEEATTACKER = {
					FEAR = {
						AUTHCHECK = {
							FLEE = none,
							HELPYELL = none,
						},
						FLEE = none,
					},
					ATTACKED = none,
					CHICKENS = {
						CHICKENWARN = {
							CHICKENFLEE = {
								TELLAUTHORITY = none,
							},
						},
					},
				},
				SEEDISLIKED = {
					RETALIATE = none,
				},
				DEGRADEFACTION = {
					DEGRADEFACTIONEXEC = none,
				},
				LOOKAROUND = none,
				REACTTEXT = {
					HELPTEXT1 = none,
					TATTLETEXT1 = none,
				},
				ATTACKFIX = none,
			},
		},
	},
	{ -- 3
		RUNNINGATTACK = {
			TIRED = none,
			RUNNINGATTACKCALL = none,
		},
	},
	{ -- 3
		HEADBUTT_RUNCYC = {
			HEADBUTT_SUCCESS = {
				GIVE = none,
				HEADBUTT_SUCCESS_WALL_HIT = {
					HEADBUTT_SUCCESS_WALL_HIT_GIVE = none,
					HEADBUTT_SUCCESS_WALL_HIT_RCV = none,
				},
				RCV = none,
			},
			HEADBUTT_FAIL = {
				HEADBUTT_FAIL = {
					HEADBUTT_DIZZY = none,
				},
			},
		},
	},
	{ -- 3
		STAYDOWN = none,
	},
	{ -- 2
		RUSSELL01 = none,
	},
	{ -- 3
		PLAYER01 = none,
		PLAYER03 = none,
		PLAYER02 = none,
	},
	{ -- 2
		BLANK = none,
	},
	{ -- 2
		LOCOMOTION = {
			COMBAT = {
				SPINECONTROL = {
					AUTHORITY = none,
					DEFAULT = none,
				},
				CHEERSTRAFE = {
					CHEERUPPERBODY = {
						CHEERUPPER3 = none,
						CHEERUPPER2 = none,
						CHEERUPPER1 = none,
					},
				},
				STRAFEBASE = {
					STRAFEBASIC = {
						STRAFEBASICLOCOOPP = none,
					},
				},
				CLOSERANGESTRAFE = none,
				STRAFEIDLE = {
					NEEDSACCURATEHEADING = none,
				},
				LONGRANGESTRAFE = none,
			},
			CROUCH = {
				CROUCHLOCORUN = none,
				CROUCHLOCO = none,
				CROUCHIDLE = {
					CROUCHRELEASE = none,
				},
			},
			HANDHOLDING = {
				GIRL = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				OLD = {
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				GUY = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
				FAT = {
					RUN = none,
					IDLE = none,
					WALK = {
						LOCO = {
							ISALLYFOLLOWER = none,
							HASALLYFOLLOWER = none,
						},
					},
				},
			},
			CROUCHACTIONOPPSBASE = none,
			CROUCHACTIONOPPS = none,
			FREE = {
				RUN = none,
				SPRINT = {
					TIRED = {
						TIREDSPEECH = none,
					},
					SPRINTSLOW = none,
					SPRINT = none,
					SPRINTGESTURE = {
						SPRINTGESTURE = {
							SHAKEFIST = {
								SHAKEFISTSPEECH = {
									SHAKEFISTSB = none,
									SHAKEFISTSPEECHADULT = {
										SHAKEFISTSB1 = none,
										SHAKEFISTSB2 = none,
									},
								},
							},
						},
					},
				},
				WALK = none,
				IDLE = {
					SPINECONTROL = {
						IDLE = none,
					},
					IDLE_CHECK = {
						IDLE_REGULAR = none,
						IDLE_SOCIAL = {
							GENERICS = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							NERDS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							AUTHORITY = {
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
							},
							UBO_CHECKS = {
								UBO_EXECUTE = none,
							},
							OLD = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							TOUGHFACTIONS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEUNFRIENDLY = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							GIRLS = {
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEDISMISSIVE = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
							FAT = {
								FAIL = none,
								SOCIALIDLEFRIENDLY = none,
								SOCIALIDLEINTIMIDATED = none,
								SOCIALIDLEAGGRESSIVE = none,
								SOCIALIDLESCARED = none,
							},
						},
						IDLE_STEALTH = none,
					},
				},
			},
			ACTIONOPPS = none,
		},
		EXECUTENODES = {
			FREE = {
				GREASER_WALKOVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							GENERIC = {
								WALKIDLESEXECUTE = none,
							},
							FACTION_SPECIFIC = {
								FACTION_IDLE2 = none,
								FACTION_IDLE1 = none,
							},
							NOOVERRIDE = none,
						},
					},
				},
				RUNBASIC = none,
				IDLE_OVERRIDES = {
					CONTROLLER_NODE = {
						ACTIONS = {
							FACTION_IDLES = {
								BANKB = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKD = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKA = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
								BANKC = {
									IDLES = {
										IDLE_A = {
											IDLE_A = {
												IDLE_B_OPP = none,
												IDLE_A = none,
											},
										},
										IDLE_B = {
											IDLE_B = {
												IDLE_C_OPP = none,
												IDLE_B = none,
											},
										},
										IDLE_D = {
											IDLE_D = {
												IDLE_A_OPP = none,
												IDLE_D = none,
											},
										},
										IDLE_C = {
											IDLE_C = {
												IDLE_C = none,
												IDLE_D_OPP = none,
											},
										},
									},
								},
							},
						},
					},
				},
				SPRINTBASIC = {
					["306PEANUTSPRINT"] = none,
					SPRINTBASIC = none,
				},
				WALKBASIC = {
					WALKBASICWEEN = none,
				},
			},
			LOCOMOTIONOVERRIDE = {
				COMBAT = {
					COMBATBASIC = {
						COMBATBASIC = {
							UPPERBODY = {
								MELEE = none,
								STRIKER = none,
							},
						},
					},
					STRAFEIDLE = none,
				},
				COMBATSTRAFEIDLE = {
					COMBATSTRAFEIDLE = {
						UPPERBODY = {
							MELEE = {
								IDLE_A = none,
							},
							STRIKER = {
								IDLE_A = none,
							},
						},
					},
				},
			},
			CUSTOMACTIONOPS = {
				CUSTOMACTIONOPS = none,
			},
		},
		IDLE = none,
		RISINGATTACKS = none,
	},
	{ -- 2
		AMBIENT_IDLE_3 = none,
		AMBIENT_IDLE_5 = none,
		AMBIENT_IDLE_1 = none,
		WAIT = none,
		AMBIENT_IDLE_2 = none,
		AMBIENT_CLAPPING = none,
		AMBIENT_IDLE_4 = none,
		AMBIENT_IDLE_6 = none,
	},
	{ -- 2
		ENTRYPOINT = {
			LAUGH = none,
			INSULT = none,
			DISMISS = none,
			WAVE = none,
			STEPS = {
				SEQUENCED = {
					WAIT = none,
				},
			},
		},
	},
	{ -- 2
		INTERACT = none,
	},
	{ -- 2
		LEAN = none,
	},
	{ -- 2
		SECSTART = {
			SECCONT = {
				SECEND = none,
			},
		},
	},
	{ -- 2
		SECCONT = {
			SECEND = none,
		},
	},
	{ -- 9
		CONTROLLER_NODE = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKD = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 5
		["306PEANUTSPRINT"] = none,
		SPRINTBASIC = none,
	},
	{ -- 5
		WALKBASICWEEN = none,
	},
	{ -- 4
		COMBAT = {
			COMBATBASIC = {
				COMBATBASIC = {
					UPPERBODY = {
						MELEE = none,
						STRIKER = none,
					},
				},
			},
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = {
			COMBATSTRAFEIDLE = {
				UPPERBODY = {
					MELEE = {
						IDLE_A = none,
					},
					STRIKER = {
						IDLE_A = none,
					},
				},
			},
		},
	},
	{ -- 2
		GROUNDPUNCH = none,
	},
	{ -- 2
		HEAVYKICKLAND = none,
		INSERTOPPORTUNITY = none,
	},
	{ -- 3
		LEFTHOOK = {
			RIGHTSTOMACH = none,
		},
	},
	{ -- 2
		ANIMATION = none,
		DRIVER = none,
	},
	{ -- 2
		COWER_START = {
			COWER_CYCLE = none,
		},
	},
	{ -- 2
		["3_02_12"] = {
			CALLBACK = none,
		},
	},
	{ -- 2
		IDLE = {
			HITS = {
				BACK = {
					BACK = none,
					BACKHIT = {
						ACTIONREQUEST = none,
					},
				},
				RIGHT = {
					RIGHT = none,
					RIGHTHIT = {
						ACTIONREQUEST = none,
					},
				},
				LEFT = {
					LEFT = none,
					LEFTHIT = {
						ACTIONREQUEST = none,
					},
				},
				FRONT = {
					FRONT = none,
					FRONTHIT = {
						ACTIONREQUEST = none,
					},
				},
				FRONTLEFT = {
					FRONTLEFTHIT = {
						ACTIONREQUEST = none,
					},
					FRONTLEFT = none,
				},
				BACKLEFT = {
					BACKLEFTHIT = {
						ACTIONREQUEST = none,
					},
					BACKLEFT = none,
				},
				FRONTRIGHT = {
					FRONTRIGHT = none,
					FRONTRIGHTHIT = {
						ACTIONREQUEST = none,
					},
				},
				BACKRIGHT = {
					BACKRIGHTHIT = {
						ACTIONREQUEST = none,
					},
					BACKRIGHT = none,
				},
			},
		},
	},
	{ -- 2
		HITS = {
			BACK = {
				BACK = none,
				BACKHIT = {
					ACTIONREQUEST = none,
				},
			},
			RIGHT = {
				RIGHT = none,
				RIGHTHIT = {
					ACTIONREQUEST = none,
				},
			},
			LEFT = {
				LEFT = none,
				LEFTHIT = {
					ACTIONREQUEST = none,
				},
			},
			FRONT = {
				FRONT = none,
				FRONTHIT = {
					ACTIONREQUEST = none,
				},
			},
			FRONTLEFT = {
				FRONTLEFTHIT = {
					ACTIONREQUEST = none,
				},
				FRONTLEFT = none,
			},
			BACKLEFT = {
				BACKLEFTHIT = {
					ACTIONREQUEST = none,
				},
				BACKLEFT = none,
			},
			FRONTRIGHT = {
				FRONTRIGHT = none,
				FRONTRIGHTHIT = {
					ACTIONREQUEST = none,
				},
			},
			BACKRIGHT = {
				BACKRIGHTHIT = {
					ACTIONREQUEST = none,
				},
				BACKRIGHT = none,
			},
		},
	},
	{ -- 2
		TALKING02 = none,
		TALKING03 = none,
		TALKING01 = none,
	},
	{ -- 2
		LISTENING02 = none,
		LISTENING01 = none,
		LISTENING03 = none,
	},
	{ -- 2
		C8_2 = {
			C8_3 = {
				C8_4 = none,
			},
		},
	},
	{ -- 4
		PREFECT01 = none,
	},
	{ -- 4
		C02 = none,
		C01 = none,
	},
	{ -- 2
		C8_3 = {
			C8_4 = none,
		},
	},
	{ -- 3
		C8_2 = {
			C8_3 = {
				C8_4 = {
					C8_5 = {
						C8_6 = {
							C8_7 = {
								C8_8 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 3
		C8_3 = {
			C8_4 = {
				C8_5 = {
					C8_6 = {
						C8_7 = {
							C8_8 = none,
						},
					},
				},
			},
		},
	},
	{ -- 3
		C8_4 = {
			C8_5 = {
				C8_6 = {
					C8_7 = {
						C8_8 = none,
					},
				},
			},
		},
	},
	{ -- 2
		MGCLO_05 = {
			MGCLO_06 = {
				MGCLO_07 = {
					MGCLO_08 = {
						MGCLO_09 = {
							MGCLO_10 = {
								MGCLO_11 = {
									MGCLO_12 = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		MGCLO_06 = {
			MGCLO_07 = {
				MGCLO_08 = {
					MGCLO_09 = {
						MGCLO_10 = {
							MGCLO_11 = {
								MGCLO_12 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 9
		DIE = none,
	},
	{ -- 2
		UTILS = {
			PEDMAKESAFE = none,
			PEDRESET = none,
		},
		POPENSIDE = {
			PEDPROPACTIONS = {
				STARTOPEN = {
					SLIDEOPEN = {
						SUCCESS = none,
						FAILURE = none,
					},
				},
			},
			CLOSED = {
				NOTUSEABLE = {
					BEINGLIFTED = {
						HANDLESOUNDCALLS = {
							DOORMOVING = none,
							DOORONGROUNDFIRSTTIME = none,
							DOORONGROUND = none,
						},
					},
				},
			},
			BASE = none,
			CLOSE = {
				CLOSING = {
					USEABLE = none,
					NOTUSEABLE = {
						PROPOPENED = none,
					},
				},
			},
		},
		POPENUP = {
			PEDPROPACTIONS = {
				SQUAT = {
					LIFTOPEN = {
						SUCCESS = none,
						FAILURE = none,
					},
				},
			},
			BASE = none,
			CLOSED = {
				NOTUSEABLE = {
					BEINGLIFTED = {
						HANDLESOUNDCALLS = {
							DOORMOVING = none,
							DOORONGROUNDFIRSTTIME = none,
							DOORONGROUND = none,
						},
					},
				},
			},
			BASEWITHCOLLISSIONON = none,
			CLOSE = {
				CLOSING = {
					NOTUSEABLE = {
						PROPCLOSED = {
							CLOSEDIDLE = none,
						},
						OPENIDLE = none,
						PROPOPENED = none,
					},
				},
			},
		},
		HUD = {
			LIFTSTRUGGLEON = none,
			PUSHSTRUGGLEOFF = none,
			PUSHSTRUGGLEON = none,
		},
	},
	{ -- 3
		STOP = none,
	},
	{ -- 4
		PROPOPENED = none,
	},
	{ -- 2
		GETUPC = none,
	},
	{ -- 2
		GREASERS02 = none,
		GREASERS01 = none,
	},
	{ -- 19
		GIVE_SEEK = none,
		RECEIVEWAIT = none,
	},
	{ -- 4
		ANIMS = {
			RECEIVE = none,
			GIVE = none,
			GIVEWAIT = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
		SPEECH = {
			RECEIVE = none,
			GIVE = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
		MODELS = {
			GIVE = none,
			RECEIVE = none,
			SEEK = none,
		},
		WEAPONREMOVAL = {
			REMOVEALLWEAPONS = none,
		},
	},
	{ -- 3
		DISENGAGE = none,
	},
	{ -- 5
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKD = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_D = none,
								IDLE_E_OPP = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
						IDLE_E = {
							IDLE_E = {
								IDLE_A_OPP = none,
								IDLE_E = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		GIVE = {
			GIVEPACKAGE_3_09 = {
				WAIT = none,
				GIVE_ATTEMPT = {
					GIVE_SEEK = {
						GET_OBJECT = none,
					},
					RECEIVE = {
						RECEIVE = {
							GIVE = none,
						},
					},
					GIVE_ATTEMPT_SPEECH = none,
					RECEIVEWAIT = none,
				},
			},
		},
	},
	{ -- 2
		GIVEPACKAGE_3_09 = {
			WAIT = none,
			GIVE_ATTEMPT = {
				GIVE_SEEK = {
					GET_OBJECT = none,
				},
				RECEIVE = {
					RECEIVE = {
						GIVE = none,
					},
				},
				GIVE_ATTEMPT_SPEECH = none,
				RECEIVEWAIT = none,
			},
		},
	},
	{ -- 2
		PICKUPSLING = {
			VICTORY = none,
		},
	},
	{ -- 2
		BREATHE_WAIT = {
			BREATHE = none,
		},
	},
	{ -- 2
		BREATHE = none,
	},
	{ -- 2
		SUCCESS = none,
	},
	{ -- 2
		ONESHOT = none,
	},
	{ -- 3
		HITRIGHT = none,
		HITMID = none,
		HITLEFT = none,
		HIT = none,
	},
	{ -- 2
		MOUNTHEADGIVE = none,
		MOUNTFEETGIVE = none,
		MOUNTLEFTGIVE = none,
		MOUNTRIGHTGIVE = none,
	},
	{ -- 2
		DIFFICULTY = {
			HARD = none,
			MEDIUM = none,
			EASY = none,
		},
		PLAYONTARGET = none,
	},
	{ -- 2
		TEACHER = none,
		ORDERLY = none,
		PREFECTS = none,
		COP = none,
	},
	{ -- 4
		GIVE = none,
		STANCETRANSITIONOPP = none,
	},
	{ -- 2
		LIGHT = {
			GIVE = none,
			RCV = {
				DIE = none,
			},
		},
		HEAVY = {
			GIVE = none,
			RCV = none,
		},
	},
	{ -- 3
		GIVE = none,
		RCV = {
			DIE = none,
		},
	},
	{ -- 3
		BODYSLAMREVERSAL = none,
	},
	{ -- 6
		GIVE = none,
		RCV = {
			JOINTDRIVERS = none,
		},
	},
	{ -- 2
		HARD = none,
		MEDIUM = none,
		EASY = none,
	},
	{ -- 18
		GIVE = {
			JOINTDRIVERS = none,
		},
		RCV = none,
	},
	{ -- 2
		RCV = none,
	},
	{ -- 2
		ESCAPEPARAMETRIC = {
			ESCAPE = {
				GIVE = none,
				RCV = {
					JOINTDRIVERS = none,
				},
			},
			RCV = {
				JOINTDRIVERS = none,
			},
			GIVE = {
				RIGHT = {
					IDLE = none,
				},
				DIFFICULTY = {
					DEFAULT = none,
				},
				LEFT = {
					IDLE = none,
				},
			},
		},
	},
	{ -- 2
		DIFFICULTY = {
			ADULT = none,
			JOINTDRIVERS = none,
			HARD = none,
			EASY = none,
		},
	},
	{ -- 2
		ADULT = none,
		JOINTDRIVERS = none,
		HARD = none,
		EASY = none,
	},
	{ -- 4
		GIVE = {
			AUTOFACETARGET = none,
		},
		RCV = none,
	},
	{ -- 4
		AUTOFACETARGET = none,
	},
	{ -- 2
		CAM_BUS1 = none,
	},
	{ -- 2
		CAM_BUS_CLS = none,
	},
	{ -- 3
		REVERSAL = none,
	},
	{ -- 7
		LOOP = none,
	},
	{ -- 2
		TURN = {
			GIVE = none,
			RCV = none,
			TURN_END = {
				GIVE = {
					JOINTDRIVERS = none,
				},
				RCV = none,
			},
		},
	},
	{ -- 2
		GIVE = none,
		RCV = none,
		TURN_END = {
			GIVE = {
				JOINTDRIVERS = none,
			},
			RCV = none,
		},
	},
	{ -- 2
		AUTOREVERSALOPPS = none,
		GRAPPLEREVERSALOPPS = none,
		STRIKEREVERSALOPPS = none,
	},
	{ -- 2
		GUTPUNCH = none,
		TANDEM = none,
		PUNCH = none,
		KNEE = none,
	},
	{ -- 2
		DIRECTIONALPUSH = none,
	},
	{ -- 3
		GIVE = {
			TARGETORIENTATION = {
				FRONT = {
					JOINTDRIVERS = none,
				},
				REAR = {
					JOINTDRIVERS = none,
				},
			},
		},
		RCV = {
			FRONT = none,
			REAR = none,
		},
	},
	{ -- 2
		DISMOUNT = none,
		KNEEDROP = none,
		FACEPUNCH = none,
	},
	{ -- 3
		CHARGE = {
			GIVE = {
				JOINTDRIVERS = none,
			},
			RELEASE = {
				LIGHT = {
					GIVE = {
						JOINTDRIVERS = none,
					},
					RCV = none,
				},
				HEAVY = {
					GIVE = {
						JOINTDRIVERS = none,
					},
					RCV = none,
				},
			},
			RCV = none,
		},
	},
	{ -- 3
		GIVE = {
			JOINTDRIVERS = none,
		},
		RELEASE = {
			LIGHT = {
				GIVE = {
					JOINTDRIVERS = none,
				},
				RCV = none,
			},
			HEAVY = {
				GIVE = {
					JOINTDRIVERS = none,
				},
				RCV = none,
			},
		},
		RCV = none,
	},
	{ -- 3
		LIGHT = {
			GIVE = {
				JOINTDRIVERS = none,
			},
			RCV = none,
		},
		HEAVY = {
			GIVE = {
				JOINTDRIVERS = none,
			},
			RCV = none,
		},
	},
	{ -- 4
		GIVE = {
			FALL = none,
		},
	},
	{ -- 2
		DETERMINESPEED = {
			RUN = none,
			WALK = none,
			SPRINT = none,
		},
	},
	{ -- 2
		GRAPPLE = none,
		STRIKES = none,
	},
	{ -- 2
		GRAPPLES = {
			GIVE = {
				TARGETORIENTATION = {
					FRONT = {
						JOINTDRIVERS = none,
					},
					REAR = {
						JOINTDRIVERS = none,
					},
				},
			},
			RCV = {
				FRONT = none,
				REAR = none,
			},
		},
	},
	{ -- 3
		TARGETORIENTATION = {
			FRONT = {
				JOINTDRIVERS = none,
			},
			REAR = {
				JOINTDRIVERS = none,
			},
		},
	},
	{ -- 2
		ONVEHICLE = none,
		DEFAULT = none,
	},
	{ -- 2
		STRIKES = none,
	},
	{ -- 3
		WALL_SMOKE_START = {
			WALL_SMOKE_IDLE = {
				WALL_SMOKE_IDLE_CHILD = {
					WALL_SMOKE_A = none,
					WALL_SMOKE_B = none,
				},
			},
		},
	},
	{ -- 2
		HEAVY1 = none,
	},
	{ -- 3
		CROSS_CHARGED = none,
	},
	{ -- 3
		GUTPUNCH_CHARGED = none,
	},
	{ -- 6
		HEAVY_PUNCH2 = none,
	},
	{ -- 3
		HOOK_CHARGED = none,
	},
	{ -- 2
		UNBLOCKABLE = {
			HEAVY_PUNCH2 = none,
		},
		HEAVYATTACKS = {
			UPPERCUT_CHARGED = none,
		},
		UPPERCUT = {
			UPPERCUTFF = none,
		},
	},
	{ -- 2
		IDLE = none,
		STRAFE = none,
	},
	{ -- 3
		LOCO = none,
	},
	{ -- 2
		AMBIENTSPAWN = {
			AMBIENTSPAWN = none,
		},
		AMBIENTACTIONS = {
			AMBIENTACTIONS_TIRED = {
				AMBIENTACTIONS = {
					AMBIENT_1 = none,
					AMBIENT_2 = none,
					AMBIENT_3 = none,
				},
			},
		},
	},
	{ -- 2
		COLLAPSE = none,
	},
	{ -- 4
		GIVE_SEEK = {
			SEEKENTITY = none,
			GIVE_WAIT = {
				FAIL = none,
				COLLISION = none,
			},
		},
		RECEIVEWAIT = none,
	},
	{ -- 2
		PEDMAKESAFE = none,
		PEDRESET = none,
	},
	{ -- 2
		PEDPROPACTIONS = {
			STARTOPEN = {
				SLIDEOPEN = {
					SUCCESS = none,
					FAILURE = none,
				},
			},
		},
		CLOSED = {
			NOTUSEABLE = {
				BEINGLIFTED = {
					HANDLESOUNDCALLS = {
						DOORMOVING = none,
						DOORONGROUNDFIRSTTIME = none,
						DOORONGROUND = none,
					},
				},
			},
		},
		BASE = none,
		CLOSE = {
			CLOSING = {
				USEABLE = none,
				NOTUSEABLE = {
					PROPOPENED = none,
				},
			},
		},
	},
	{ -- 2
		PEDPROPACTIONS = {
			SQUAT = {
				LIFTOPEN = {
					SUCCESS = none,
					FAILURE = none,
				},
			},
		},
		BASE = none,
		CLOSED = {
			NOTUSEABLE = {
				BEINGLIFTED = {
					HANDLESOUNDCALLS = {
						DOORMOVING = none,
						DOORONGROUNDFIRSTTIME = none,
						DOORONGROUND = none,
					},
				},
			},
		},
		BASEWITHCOLLISSIONON = none,
		CLOSE = {
			CLOSING = {
				NOTUSEABLE = {
					PROPCLOSED = {
						CLOSEDIDLE = none,
					},
					OPENIDLE = none,
					PROPOPENED = none,
				},
			},
		},
	},
	{ -- 2
		LIFTSTRUGGLEON = none,
		PUSHSTRUGGLEOFF = none,
		PUSHSTRUGGLEON = none,
	},
	{ -- 2
		LAUNCHSCRIPT = none,
	},
	{ -- 8
		DEFAULT_WALKOVERRIDES = {
			CONTROLLER_NODE = {
				ACTIONS = {
					FAT = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						FACTION_SPECIFIC = {
							FACTION_IDLE2 = none,
							FACTION_IDLE1 = none,
						},
						NOOVERRIDE = none,
					},
					GEN = {
						GENERIC = {
							WALKIDLESEXECUTE = none,
						},
						DONOTHING = none,
					},
				},
			},
		},
		RUNBASIC = {
			FAT = none,
			GEN = none,
		},
		IDLE_OVERRIDES = {
			CONTROLLER_NODE = {
				AUTHORITY = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKD = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
				ADULT = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
				FAT = {
					ACTIONSGIRL = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
									IDLE_D = {
										IDLE_D = {
											IDLE_A_OPP = none,
											IDLE_D = none,
										},
									},
									IDLE_C = {
										IDLE_C = {
											IDLE_C = none,
											IDLE_D_OPP = none,
										},
									},
								},
							},
						},
					},
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
				GENERIC = {
					ACTIONS = {
						FACTION_IDLES = {
							BANKB = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKA = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
							BANKC = {
								IDLES = {
									IDLE_C = {
										IDLE_C = {
											IDLE_A_OPP = none,
											IDLE_C = none,
										},
									},
									IDLE_A = {
										IDLE_A = {
											IDLE_B_OPP = none,
											IDLE_A = none,
										},
									},
									IDLE_B = {
										IDLE_B = {
											IDLE_C_OPP = none,
											IDLE_B = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
		WALKBASIC = {
			FAT = none,
			WALKBASIC = {
				WALKWEEN = none,
			},
			HOBODRUNK = {
				WALKBASIC = none,
			},
		},
		SPRINTBASIC = {
			AUTHORITY = none,
			FAT = none,
			GEN = none,
		},
	},
	{ -- 2
		COUNTER = {
			COUNTER = none,
		},
	},
	{ -- 9
		CONTROLLER_NODE = {
			ACTIONS = {
				NOOVERRIDE = none,
				GENERIC = {
					WALKIDLESEXECUTE = none,
				},
			},
		},
	},
	{ -- 3
		NOOVERRIDE = none,
		FACTION_SPECIFIC = {
			FACTION_IDLE1 = none,
			FACTION_IDLE2 = none,
			FACTION_IDLE3 = none,
		},
	},
	{ -- 2
		ANIMS = {
			RECEIVE = none,
			GIVE = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
		SPEECH = {
			RECEIVE = none,
			GIVE = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
		MODELS = {
			GIVE = none,
			RECEIVE = none,
			SEEK = none,
		},
		WEAPONREMOVAL = {
			REMOVEALLWEAPONS = none,
		},
	},
	{ -- 2
		C9_2 = {
			C9_3 = {
				C9_4 = none,
			},
		},
	},
	{ -- 2
		C9_3 = {
			C9_4 = none,
		},
	},
	{ -- 3
		C9_2 = {
			C9_3 = {
				C9_4 = {
					C9_5 = {
						C9_6 = {
							C9_7 = {
								C9_8 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 3
		C9_3 = {
			C9_4 = {
				C9_5 = {
					C9_6 = {
						C9_7 = {
							C9_8 = none,
						},
					},
				},
			},
		},
	},
	{ -- 3
		C9_4 = {
			C9_5 = {
				C9_6 = {
					C9_7 = {
						C9_8 = none,
					},
				},
			},
		},
	},
	{ -- 8
		CONTROLLER_NODE = {
			ACTIONS = {
				FAT = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					FACTION_SPECIFIC = {
						FACTION_IDLE2 = none,
						FACTION_IDLE1 = none,
					},
					NOOVERRIDE = none,
				},
				GEN = {
					GENERIC = {
						WALKIDLESEXECUTE = none,
					},
					DONOTHING = none,
				},
			},
		},
	},
	{ -- 8
		FAT = none,
		GEN = none,
	},
	{ -- 8
		CONTROLLER_NODE = {
			AUTHORITY = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKD = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
			ADULT = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
			FAT = {
				ACTIONSGIRL = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
								IDLE_D = {
									IDLE_D = {
										IDLE_A_OPP = none,
										IDLE_D = none,
									},
								},
								IDLE_C = {
									IDLE_C = {
										IDLE_C = none,
										IDLE_D_OPP = none,
									},
								},
							},
						},
					},
				},
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
			GENERIC = {
				ACTIONS = {
					FACTION_IDLES = {
						BANKB = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKA = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
						BANKC = {
							IDLES = {
								IDLE_C = {
									IDLE_C = {
										IDLE_A_OPP = none,
										IDLE_C = none,
									},
								},
								IDLE_A = {
									IDLE_A = {
										IDLE_B_OPP = none,
										IDLE_A = none,
									},
								},
								IDLE_B = {
									IDLE_B = {
										IDLE_C_OPP = none,
										IDLE_B = none,
									},
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 8
		FAT = none,
		WALKBASIC = {
			WALKWEEN = none,
		},
		HOBODRUNK = {
			WALKBASIC = none,
		},
	},
	{ -- 8
		AUTHORITY = none,
		FAT = none,
		GEN = none,
	},
	{ -- 9
		ACTIONS = {
			NOOVERRIDE = none,
			GENERIC = {
				WALKIDLESEXECUTE = none,
			},
		},
	},
	{ -- 13
		WALKWEEN = none,
	},
	{ -- 4
		COMBAT = {
			COMBATBASIC = none,
			STRAFEIDLE = none,
		},
		COMBATSTRAFEIDLE = {
			PREFECT = none,
			COMBATSTRAFEIDLE = none,
		},
	},
	{ -- 3
		SLOPPYCROSS = none,
	},
	{ -- 4
		GROUNDKICKPROJECTILE = none,
		GROUNDKICKEMPTY = none,
	},
	{ -- 3
		FRONT = {
			DEFAULT = none,
		},
		REAR = {
			DEFAULT = none,
		},
	},
	{ -- 2
		SLIDE = none,
	},
	{ -- 2
		RIGHT = none,
		LEFT = none,
		STRAIGHT = none,
	},
	{ -- 2
		LINE3 = {
			END = none,
		},
	},
	{ -- 18
		CAMERA02 = none,
		CAMERA01 = none,
	},
	{ -- 5
		RELEASE_CAM = none,
	},
	{ -- 2
		CAMERA_01 = none,
		CAMERA_03 = none,
		CAMERA_02 = none,
	},
	{ -- 6
		CAMERA_01 = none,
		CAMERA_04 = none,
		CAMERA_03 = none,
		CAMERA_02 = none,
	},
	{ -- 2
		KISS_CAMERAS_RANDOM_FAIL = none,
		ONFLATGROUND = {
			FARCAM02 = none,
			FARCAM03 = none,
			FARCAM01 = none,
		},
		ONSLOPE = {
			NEARCAMERA03 = none,
			NEARCAMERA01 = none,
			NEARCAMERA02 = none,
		},
	},
	{ -- 4
		FARCAM02 = none,
		FARCAM03 = none,
		FARCAM01 = none,
	},
	{ -- 4
		NEARCAMERA03 = none,
		NEARCAMERA01 = none,
		NEARCAMERA02 = none,
	},
	{ -- 9
		NOOVERRIDE = none,
		GENERIC = {
			WALKIDLESEXECUTE = none,
		},
	},
	{ -- 4
		CONTROLLER_NODE = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKD = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 4
		WALKBASIC = {
			WALKWEEN = none,
		},
	},
	{ -- 3
		RUSSELL6_03 = none,
		SPRINTBASIC = none,
	},
	{ -- 4
		DEFAULT = none,
		RUSSELL = none,
	},
	{ -- 3
		COLLISION = {
			DEFAULT = none,
			RUSSELL = none,
		},
	},
	{ -- 5
		FACTION_IDLES = {
			BANKB = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
			BANKD = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
			BANKA = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_D = none,
							IDLE_E_OPP = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
					IDLE_E = {
						IDLE_E = {
							IDLE_A_OPP = none,
							IDLE_E = none,
						},
					},
				},
			},
			BANKC = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
		},
	},
	{ -- 6
		SWING3 = none,
	},
	{ -- 9
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKD = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 4
		COMBATBASIC = {
			COMBATBASIC = {
				UPPERBODY = {
					MELEE = none,
					STRIKER = none,
				},
			},
		},
		STRAFEIDLE = none,
	},
	{ -- 4
		COMBATSTRAFEIDLE = {
			UPPERBODY = {
				MELEE = {
					IDLE_A = none,
				},
				STRIKER = {
					IDLE_A = none,
				},
			},
		},
	},
	{ -- 3
		RIGHTSTOMACH = none,
	},
	{ -- 2
		GRABKNEES = none,
		OPPORTUNITYINSERT = none,
	},
	{ -- 2
		GRAPPLE = none,
		COUNTER = none,
	},
	{ -- 8
		ACTIONS = {
			FAT = {
				GENERIC = {
					WALKIDLESEXECUTE = none,
				},
				FACTION_SPECIFIC = {
					FACTION_IDLE2 = none,
					FACTION_IDLE1 = none,
				},
				NOOVERRIDE = none,
			},
			GEN = {
				GENERIC = {
					WALKIDLESEXECUTE = none,
				},
				DONOTHING = none,
			},
		},
	},
	{ -- 8
		AUTHORITY = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKD = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
				},
			},
		},
		ADULT = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
				},
			},
		},
		FAT = {
			ACTIONSGIRL = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
							IDLE_D = {
								IDLE_D = {
									IDLE_A_OPP = none,
									IDLE_D = none,
								},
							},
							IDLE_C = {
								IDLE_C = {
									IDLE_C = none,
									IDLE_D_OPP = none,
								},
							},
						},
					},
				},
			},
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
				},
			},
		},
		GENERIC = {
			ACTIONS = {
				FACTION_IDLES = {
					BANKB = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKA = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
					BANKC = {
						IDLES = {
							IDLE_C = {
								IDLE_C = {
									IDLE_A_OPP = none,
									IDLE_C = none,
								},
							},
							IDLE_A = {
								IDLE_A = {
									IDLE_B_OPP = none,
									IDLE_A = none,
								},
							},
							IDLE_B = {
								IDLE_B = {
									IDLE_C_OPP = none,
									IDLE_B = none,
								},
							},
						},
					},
				},
			},
		},
	},
	{ -- 4
		PREFECT = none,
		COMBATSTRAFEIDLE = none,
	},
	{ -- 2
		STARTGAME = none,
	},
	{ -- 2
		TEDDYBEAR = none,
		WEAPONIDLE = none,
	},
	{ -- 5
		WAITFADE = none,
	},
	{ -- 2
		CELEBRATE3 = none,
		CELEBRATE1 = none,
	},
	{ -- 3
		MASCOTDANCE = {
			IDLE = none,
		},
	},
	{ -- 9
		OVERRIDE = none,
	},
	{ -- 3
		GIVEEXECUTE = none,
	},
	{ -- 2
		RUNSTART = {
			WEAKPED = none,
		},
	},
	{ -- 11
		SUCCESS = {
			GV = {
				END = none,
			},
			RCV = {
				END = none,
			},
			LOAD = none,
		},
	},
	{ -- 11
		GV = {
			END = none,
		},
		RCV = {
			END = none,
		},
		LOAD = none,
	},
	{ -- 2
		END = {
			HUMILIATEFLEE = none,
			MISSION = none,
		},
	},
	{ -- 2
		HUMILIATEFLEE = none,
		MISSION = none,
	},
	{ -- 3
		VICTIM = {
			PLAYER = none,
		},
	},
	{ -- 2
		APPLE = none,
		SNOWBALL = none,
		WBALLOON = none,
		STINKBOMB = none,
		EGG = none,
	},
	{ -- 2
		APOLOGIZE = none,
	},
	{ -- 2
		WHATSUP = none,
	},
	{ -- 2
		PICKKISS = {
			PICKKISS_SPECIAL = none,
			PICKKISS_F = none,
			PICKKISS_B3A = none,
			PICKKISS_2 = {
				PICKKISS_B2B = none,
				PICKKISS_B2A = none,
				PICKKISS_2 = none,
			},
			PICKKISS_3 = none,
			PICKKISS_B3B = none,
			PICKKISS_1 = none,
			PICKKISS_4 = none,
		},
		PRESPEECH = {
			PRESPEECH = none,
		},
	},
	{ -- 2
		PLAYEREND = none,
	},
	{ -- 2
		BOY1 = none,
		BOY2 = none,
		FAT = none,
		DEFAULT = none,
	},
	{ -- 2
		DEFAULT = none,
		SPECIALKISS = {
			SPECIAL = none,
			MASCOT = none,
		},
	},
	{ -- 14
		KISS_RCV = none,
		KISS_GIVE = none,
	},
	{ -- 2
		PINKYBEAR = none,
	},
	{ -- 2
		KISS_RCV = none,
		KISS_GIVE = {
			["1_02B"] = none,
		},
	},
	{ -- 2
		GIVEHEALTH = none,
	},
	{ -- 2
		FUCKYOU_WEAPON = none,
		FUCKYOUSPECIALBOOST = none,
		FUCKYOU_UNARMED = none,
	},
	{ -- 2
		RUNJUMP = {
			PICKLAUNCH = {
				COMPRESSLEFT = {
					JUMP = {
						LAND = {
							LAND = {
								LOCOBASIC = none,
							},
							LAND_STILL = {
								RESET = none,
							},
						},
					},
				},
				COMPRESSRIGHT = {
					JUMP = {
						LAND = {
							LAND = {
								LOCOBASIC = none,
							},
							LAND_STILL = {
								RESET = none,
							},
						},
					},
				},
			},
		},
		FALLING = {
			FALL_OLD = {
				BELLYUP = {
					AIRSTATE = {
						FALL_LAND = {
							FALL_DAMAGE_LAND = none,
						},
					},
				},
				BELLYDOWN = {
					AIRSTATE = {
						FALL_LAND = {
							FALL_DAMAGE_LAND = none,
						},
					},
				},
				FALL = {
					FALLINGHITGROUND = none,
					FALL_FLAIL = {
						FALL_LAND_SPLAT = {
							SPLAT_DIE = {
								DIE = none,
							},
							SPLAT = none,
						},
						FALL_LAND = none,
						FALL_DAMAGE = {
							LAND = none,
						},
					},
				},
			},
			LAND = {
				SPLAT_DIE = {
					DIE = none,
				},
				FALL_LAND = none,
				SPLAT = none,
				FALL_LAND_NO_DAMAGE = none,
			},
			FALL = {
				FALLING = {
					FALL_NO_DAMAGE = none,
					FALL_DAMAGE = {
						FALL = none,
						FALL_FLAIL = none,
					},
				},
				BELLYDOWN = {
					AIRSTATE = {
						FALL_LAND = {
							FALL_DAMAGE_LAND = none,
						},
					},
				},
				BELLYUP = {
					AIRSTATE = {
						FALL_LAND = {
							FALL_DAMAGE_LAND = none,
						},
					},
				},
			},
		},
		EXECUTENODES = {
			ANIMUPDATE = none,
		},
		RAIL = {
			RAILINTERACT = none,
		},
		IDLEJUMP = {
			IDLEJUMP = none,
			CLIMB_1M = {
				SHAREDCLIMB = none,
			},
			CLIMB_ACTIONS = {
				["6FOOTWALLLANDEARLY"] = none,
				["6FOOTWALLFALL"] = none,
				WALLSTAND = none,
			},
			["CLIMB_2-25M"] = none,
			["CLIMB_1-5M"] = {
				SHAREDCLIMB = none,
			},
		},
		SPRINTJUMP = {
			PICKLAUNCH = {
				COMPRESSLEFT = {
					JUMP = {
						LAND = {
							LAND = {
								SPEEDRUN = none,
							},
							LAND_STILL = {
								RESET = none,
							},
						},
					},
				},
				COMPRESSRIGHT = {
					JUMP = {
						LAND = {
							LAND = {
								SPEEDRUN = none,
							},
							LAND_STILL = {
								RESET = none,
							},
						},
					},
				},
			},
		},
		GENERICEXECUTE = {
			SETUPBBALL = none,
		},
		FALLINGOPPS = {
			FALLINGOPPSBASE = none,
		},
		JUMPOPS = {
			PLAYERUNINTERRUPTIBLE = none,
		},
	},
	{ -- 2
		HEAVYATTACKS = {
			GROUNDKICK = {
				GROUNDKICKCHARGED = {
					GKFF = none,
					COLLISION = {
						RATPED = none,
						PED = none,
					},
				},
				GROUNDKICK = {
					COLLISION = {
						RATPED = none,
						PED = none,
					},
				},
			},
		},
		LIGHTATTACKS_OLD = {
			GROUNDSTOMP1 = {
				GKFF = none,
				GROUNDSTOMP2 = {
					GKFF = none,
					GROUNDSTOMP3 = {
						GKFF = none,
					},
				},
			},
		},
	},
	{ -- 2
		LIGHTGROUNDKICK_OLD = none,
		GROUNDKICK = none,
	},
	{ -- 2
		RUNSHOULDER = {
			RUNSHOULDERFF = none,
			RUNSHOULDERBACKTORUN = none,
		},
		RUNPUNCH = {
			RUNPUNCHFF = none,
			RUNPUNCHBACKTORUN = none,
		},
	},
	{ -- 2
		JAB_CHARGED = none,
		STUNPUNCH = none,
	},
	{ -- 2
		LEGKICKRELEASEMAX = none,
	},
	{ -- 3
		JACKIEKICKLAND = none,
	},
	{ -- 2
		HIGHKICK2 = none,
	},
	{ -- 3
		UPPERCUT_CHARGED = none,
	},
	{ -- 3
		UPPERCUTFF = none,
	},
	{ -- 12
		GIVE = {
			GIVE = none,
			RECEIVE = none,
		},
		GIVE_ATTEMPT = {
			GIVEINITIATE = {
				GIVE_SEEK = none,
				RECEIVEWAIT = none,
			},
			LOADWAIT = none,
		},
		EXECUTES = {
			SPEECH = {
				RECEIVE = none,
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			MODELS = {
				GIVE = none,
				RECEIVE = none,
				SEEK = none,
			},
			ANIMS = {
				RECEIVE = none,
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
		},
	},
	{ -- 12
		SPEECH = {
			RECEIVE = none,
			GIVE = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
		MODELS = {
			GIVE = none,
			RECEIVE = none,
			SEEK = none,
		},
		ANIMS = {
			RECEIVE = none,
			GIVE = none,
			SEEK = none,
			RECEIVEWAIT = none,
		},
	},
	{ -- 2
		NONE = none,
		RUSSELL_102B = none,
	},
	{ -- 2
		GIVE_SEEK = {
			SEEKENTITY = none,
			GIVE_WAIT = none,
			SWITCHEROO = none,
		},
		RECEIVEWAIT = none,
	},
	{ -- 2
		SWITCHEROO2 = {
			DELETEBEAR = none,
		},
	},
	{ -- 2
		FEMALE = none,
	},
	{ -- 2
		KISS_RCV = none,
		KISS_GIV = none,
	},
	{ -- 3
		APOLOGY_DEFAULT = none,
		APOLOGY_GIRL = none,
	},
	{ -- 2
		TAUNT_DEFAULT = none,
	},
	{ -- 3
		VS_WIMP = none,
		VS_TOUGH = none,
	},
	{ -- 2
		HELPOUT = none,
	},
	{ -- 2
		EVERYONE = {
			CHECKALL = {
				JOCKS = none,
				GREASERS = none,
				BULLIES = none,
				TOWNIES = none,
				NERDS = none,
				TEACHERS = none,
				PREPS = none,
				PREFECTS = none,
				COPS = none,
			},
		},
	},
	{ -- 2
		CHECKALL = {
			JOCKS = none,
			GREASERS = none,
			BULLIES = none,
			TOWNIES = none,
			NERDS = none,
			TEACHERS = none,
			PREPS = none,
			PREFECTS = none,
			COPS = none,
		},
	},
	{ -- 8
		FAT = {
			GENERIC = {
				WALKIDLESEXECUTE = none,
			},
			FACTION_SPECIFIC = {
				FACTION_IDLE2 = none,
				FACTION_IDLE1 = none,
			},
			NOOVERRIDE = none,
		},
		GEN = {
			GENERIC = {
				WALKIDLESEXECUTE = none,
			},
			DONOTHING = none,
		},
	},
	{ -- 8
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKD = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 22
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 10
		ACTIONSGIRL = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
			},
		},
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 32
		FACTION_IDLES = {
			BANKB = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
			BANKA = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
			BANKC = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
		},
	},
	{ -- 4
		WINDMILL_R = {
			WINDMILL_L = {
				HEAVYATTACKS = {
					SWINGPUNCH_R = none,
				},
			},
		},
	},
	{ -- 4
		WINDMILL_L = {
			HEAVYATTACKS = {
				SWINGPUNCH_R = none,
			},
		},
	},
	{ -- 3
		START = none,
	},
	{ -- 6
		DOWN = none,
		UP = none,
	},
	{ -- 2
		COWER_CYCLE = none,
	},
	{ -- 2
		SPECIAL = none,
		COMBATLOCO = none,
		WAIT = none,
	},
	{ -- 4
		ATTACKCHECK = {
			SEEATTACKER = {
				FEAR = {
					AUTHCHECK = {
						FLEE = none,
						HELPYELL = none,
					},
					FLEE = none,
				},
				ATTACKED = none,
				CHICKENS = {
					CHICKENWARN = {
						CHICKENFLEE = {
							TELLAUTHORITY = none,
						},
					},
				},
			},
			SEEDISLIKED = {
				RETALIATE = none,
			},
			DEGRADEFACTION = {
				DEGRADEFACTIONEXEC = none,
			},
			LOOKAROUND = none,
			REACTTEXT = {
				HELPTEXT1 = none,
				TATTLETEXT1 = none,
			},
			ATTACKFIX = none,
		},
	},
	{ -- 2
		ATTACKBLOCKED = none,
	},
	{ -- 2
		RUNNINGATTACKCALL = none,
	},
	{ -- 2
		RECOVERING = none,
	},
	{ -- 2
		LAUGH = none,
		INSULT = none,
		DISMISS = none,
		WAVE = none,
		STEPS = {
			SEQUENCED = {
				WAIT = none,
			},
		},
	},
	{ -- 2
		MOVETO = {
			WEEE = {
				CYCLE = none,
			},
		},
	},
	{ -- 2
		WEEE = {
			CYCLE = none,
		},
	},
	{ -- 4
		ACTIONS = {
			FACTION_IDLES = {
				BANKB = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKD = {
					IDLES = {
						IDLE_C = {
							IDLE_C = {
								IDLE_A_OPP = none,
								IDLE_C = none,
							},
						},
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
					},
				},
				BANKA = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
				BANKC = {
					IDLES = {
						IDLE_A = {
							IDLE_A = {
								IDLE_B_OPP = none,
								IDLE_A = none,
							},
						},
						IDLE_B = {
							IDLE_B = {
								IDLE_C_OPP = none,
								IDLE_B = none,
							},
						},
						IDLE_D = {
							IDLE_D = {
								IDLE_A_OPP = none,
								IDLE_D = none,
							},
						},
						IDLE_C = {
							IDLE_C = {
								IDLE_C = none,
								IDLE_D_OPP = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		WINDMILL_L = none,
	},
	{ -- 2
		STARTANIMATIONS = {
			START2 = none,
			START1 = {
				START1_CHILD = {
					START1_2 = none,
				},
			},
		},
		RIGHT = {
			TAPBEAKER = {
				TAPBEAKER = {
					TAPBEAKER = none,
				},
				GRABBEAKER = none,
			},
			BEAKER = {
				POURBEAKER = {
					POURBEAKER = none,
				},
				GRABBEAKER = none,
				PUTDOWNBEAKER = none,
			},
			LIFTBEAKER = {
				STUDYTUBE = {
					STUDYTUBE = none,
				},
				GRABBEAKER = none,
			},
			TUBE = {
				GRABTUBE = none,
				POURTUBE = {
					POURTUBE = none,
				},
				PUTDOWNTUBE = none,
			},
			ROD = {
				GRABROD = none,
				PUTDOWNROD = none,
				STIRROD = {
					STIRROD = none,
				},
			},
			TURNONGAS = {
				GRABBURNER = none,
				ONBURNER = {
					ONBURNER = none,
				},
			},
		},
		SABOTAGE = {
			SABOTAGE = {
				SABOTAGE = none,
			},
			SCOLD = {
				SCOLD = none,
			},
			VICTIM = {
				VICTIM = none,
			},
		},
		LEFT = {
			STRIKEMATCH = {
				STRIKEMATCH = {
					STRIKEMATCH = none,
				},
				GRABMATCH = none,
			},
			POWDER = {
				GRABPOWDER = none,
				SHAKEPOWDER = {
					SHAKEPOWDER = none,
				},
				PUTDOWNPOWDER = none,
			},
			TUBE = {
				GRABTUBE = none,
				POURTUBE = {
					POURTUBE = none,
				},
				PUTDOWNTUBE = none,
			},
			DROPCHEM = {
				GRABCHEM = none,
				DROPCHEM = {
					DROPCHEM = none,
				},
			},
			LIFTTUBE = {
				GRABTUBE = none,
				STUDYTUBE = {
					STUDYTUBE = none,
				},
			},
			TAPBEAKER = {
				TAPBEAKER = {
					TAPBEAKER = none,
				},
				GRABBEAKER = none,
			},
			TURNDOWNGAS = {
				OFFBURNER = {
					OFFBURNER = none,
				},
				GRABBURNER = none,
			},
			EYEDROP = {
				PUTDOWNEYEDROP = none,
				GRABEYEDROP = none,
				DROPEYEDROP = {
					DROPEYEDROP = none,
				},
			},
		},
		CUSTOMIDLE = none,
		SMOKEFACE = none,
		BOTHMISC = {
			TUBES = {
				POURTUBES = none,
				GRABTUBES = none,
				PUTDOWNTUBES = none,
			},
			BURNER = {
				ADJUSTBURNER = none,
			},
		},
		REACT = {
			CLEANUPHANDS = {
				CLEANUPHANDS_CHILD = none,
			},
			SMOKE = none,
			EXPLODE = none,
		},
		CYCLECLEAR = none,
		PICKUPTORCH = {
			APPLYTORCH = none,
		},
	},
	{ -- 2
		FASTLOOK = none,
		SLOWLOOK = none,
		DOUBLETAKE = none,
	},
	{ -- 3
		START1_CHILD = {
			START1_2 = none,
		},
	},
	{ -- 2
		TAPBEAKER = {
			TAPBEAKER = {
				TAPBEAKER = none,
			},
			GRABBEAKER = none,
		},
		BEAKER = {
			POURBEAKER = {
				POURBEAKER = none,
			},
			GRABBEAKER = none,
			PUTDOWNBEAKER = none,
		},
		LIFTBEAKER = {
			STUDYTUBE = {
				STUDYTUBE = none,
			},
			GRABBEAKER = none,
		},
		TUBE = {
			GRABTUBE = none,
			POURTUBE = {
				POURTUBE = none,
			},
			PUTDOWNTUBE = none,
		},
		ROD = {
			GRABROD = none,
			PUTDOWNROD = none,
			STIRROD = {
				STIRROD = none,
			},
		},
		TURNONGAS = {
			GRABBURNER = none,
			ONBURNER = {
				ONBURNER = none,
			},
		},
	},
	{ -- 2
		SABOTAGE = {
			SABOTAGE = none,
		},
		SCOLD = {
			SCOLD = none,
		},
		VICTIM = {
			VICTIM = none,
		},
	},
	{ -- 2
		STRIKEMATCH = {
			STRIKEMATCH = {
				STRIKEMATCH = none,
			},
			GRABMATCH = none,
		},
		POWDER = {
			GRABPOWDER = none,
			SHAKEPOWDER = {
				SHAKEPOWDER = none,
			},
			PUTDOWNPOWDER = none,
		},
		TUBE = {
			GRABTUBE = none,
			POURTUBE = {
				POURTUBE = none,
			},
			PUTDOWNTUBE = none,
		},
		DROPCHEM = {
			GRABCHEM = none,
			DROPCHEM = {
				DROPCHEM = none,
			},
		},
		LIFTTUBE = {
			GRABTUBE = none,
			STUDYTUBE = {
				STUDYTUBE = none,
			},
		},
		TAPBEAKER = {
			TAPBEAKER = {
				TAPBEAKER = none,
			},
			GRABBEAKER = none,
		},
		TURNDOWNGAS = {
			OFFBURNER = {
				OFFBURNER = none,
			},
			GRABBURNER = none,
		},
		EYEDROP = {
			PUTDOWNEYEDROP = none,
			GRABEYEDROP = none,
			DROPEYEDROP = {
				DROPEYEDROP = none,
			},
		},
	},
	{ -- 3
		POURTUBES = none,
		GRABTUBES = none,
		PUTDOWNTUBES = none,
	},
	{ -- 3
		ADJUSTBURNER = none,
	},
	{ -- 252
		ACTIVE = {
			RUN = {
				FAIL = none,
				SUCCEED = none,
			},
		},
	},
	{ -- 253
		RUN = {
			FAIL = none,
			SUCCEED = none,
		},
	},
	{ -- 329
		FAIL = none,
		SUCCEED = none,
	},
	{ -- 2
		ACTIVE = {
			RUN = {
				FAIL = none,
				SUCCEED = none,
			},
			SECONDSTAGE = none,
			FIRSTSTAGE = none,
		},
	},
	{ -- 2
		RUN = {
			FAIL = none,
			SUCCEED = none,
		},
		SECONDSTAGE = none,
		FIRSTSTAGE = none,
	},
	{ -- 52
		ACTIVE = {
			FINISH = none,
		},
	},
	{ -- 31
		ACTIVE = {
			ACTIVE2 = {
				FINISH = none,
			},
		},
	},
	{ -- 32
		ACTIVE2 = {
			FINISH = none,
		},
	},
	{ -- 3
		ACTIVE = {
			ACTIVE2 = {
				ACTIVE3 = {
					ACTIVE4 = {
						FINISH = none,
					},
				},
			},
		},
	},
	{ -- 10
		ACTIVE = {
			ACTIVE2 = {
				ACTIVE3 = {
					FINISH = none,
				},
			},
		},
	},
	{ -- 11
		ACTIVE2 = {
			ACTIVE3 = {
				FINISH = none,
			},
		},
	},
	{ -- 11
		ACTIVE3 = {
			FINISH = none,
		},
	},
	{ -- 3
		ACTIVE2 = {
			ACTIVE3 = {
				ACTIVE4 = {
					FINISH = none,
				},
			},
		},
	},
	{ -- 3
		ACTIVE3 = {
			ACTIVE4 = {
				FINISH = none,
			},
		},
	},
	{ -- 4
		ACTIVE4 = {
			FINISH = none,
		},
	},
	{ -- 6
		ACTIVE = {
			FAIL = none,
			RUN = {
				FAIL = none,
				SUCCEED = none,
			},
		},
	},
	{ -- 6
		FAIL = none,
		RUN = {
			FAIL = none,
			SUCCEED = none,
		},
	},
	{ -- 68
		ACTIVE = {
			RUN = {
				FAIL = none,
				SUCCEED = none,
			},
			MISSED = none,
		},
	},
	{ -- 68
		RUN = {
			FAIL = none,
			SUCCEED = none,
		},
		MISSED = none,
	},
	{ -- 2
		HOLDSIT = none,
	},
	{ -- 2
		DARBY = none,
	},
	{ -- 2
		IDLE = {
			GOUP = {
				END = none,
			},
		},
	},
	{ -- 2
		GOUP = {
			END = none,
		},
	},
	{ -- 2
		HOWEVER = {
			LEGKICKSTART = {
				LEGKICKRELEASEMAX = {
					END = none,
				},
			},
		},
	},
	{ -- 2
		LEGKICKSTART = {
			LEGKICKRELEASEMAX = {
				END = none,
			},
		},
	},
	{ -- 5
		NERD_FEMALE = none,
		GEN_MALE = none,
		FAT = none,
		NERD_MALE = none,
		GEN_FEMALE = none,
	},
	{ -- 2
		PICKKISS_SPECIAL = none,
		PICKKISS_F = none,
		PICKKISS_B3A = none,
		PICKKISS_2 = {
			PICKKISS_B2B = none,
			PICKKISS_B2A = none,
			PICKKISS_2 = none,
		},
		PICKKISS_3 = none,
		PICKKISS_B3B = none,
		PICKKISS_1 = none,
		PICKKISS_4 = none,
	},
	{ -- 2
		PRESPEECH = none,
	},
	{ -- 2
		SPECIAL = none,
		MASCOT = none,
	},
	{ -- 2
		ENOUGHCASH = {
			GIVEHEALTH = {
				LAUNCHMINIGAME = {
					PXARCDE = none,
					PXARCDO = none,
					PXARCSL = none,
					PXARC3D = none,
					PXARCSU = none,
					PXARCGG = none,
					PXARCMF = none,
					PXARCFS = none,
				},
			},
		},
	},
	{ -- 2
		GIVEHEALTH = {
			LAUNCHMINIGAME = {
				PXARCDE = none,
				PXARCDO = none,
				PXARCSL = none,
				PXARC3D = none,
				PXARCSU = none,
				PXARCGG = none,
				PXARCMF = none,
				PXARCFS = none,
			},
		},
	},
	{ -- 4
		CONTROLLER2 = none,
	},
	{ -- 2
		ESCAPE = {
			GIVE = none,
			RCV = {
				JOINTDRIVERS = none,
			},
		},
		RCV = {
			JOINTDRIVERS = none,
		},
		GIVE = {
			RIGHT = {
				IDLE = none,
			},
			DIFFICULTY = {
				DEFAULT = none,
			},
			LEFT = {
				IDLE = none,
			},
		},
	},
	{ -- 2
		GIVE = {
			TARGETORIENTATION = {
				FRONT = none,
				REAR = none,
			},
		},
		RCV = {
			FRONT = none,
			REAR = none,
		},
	},
	{ -- 4
		SEEKENTITY = none,
		GIVE_WAIT = {
			FAIL = none,
			COLLISION = none,
		},
	},
	{ -- 2
		WAITFORANIMS = none,
		WEEE = {
			CYCLE = {
				OUT = none,
			},
		},
	},
	{ -- 2
		CYCLE = {
			OUT = none,
		},
	},
	{ -- 2
		["15MWALL"] = none,
		["2MWALL"] = none,
		["1MWALL"] = none,
	},
	{ -- 2
		CM_2 = {
			CM_3 = {
				CM_4 = none,
			},
		},
	},
	{ -- 3
		CM_2 = {
			CM_3 = {
				CM_4 = {
					CM_5 = {
						CM_6 = {
							CM_7 = {
								CM_8 = none,
							},
						},
					},
				},
			},
		},
	},
	{ -- 2
		CM_3 = {
			CM_4 = none,
		},
	},
	{ -- 3
		CM_3 = {
			CM_4 = {
				CM_5 = {
					CM_6 = {
						CM_7 = {
							CM_8 = none,
						},
					},
				},
			},
		},
	},
	{ -- 3
		CM_4 = {
			CM_5 = {
				CM_6 = {
					CM_7 = {
						CM_8 = none,
					},
				},
			},
		},
	},
	{ -- 3
		GREET = {
			WAIT = none,
			WAVE = none,
		},
		FOLLOWPATH = none,
		WANDER = none,
		IDLE = none,
	},
	{ -- 3
		PROJECTILE = none,
		COWER = none,
		FLEE = none,
		HANDTOHAND = none,
	},
	{ -- 3
		MOVEOBJECTIVE = none,
		H2HATTACKOBJ = none,
		RANGEATTACKOBJ = none,
		FACEOBJECTIVE = none,
	},
	{ -- 3
		PREFPUNISH2 = none,
		PREFPUNISH1 = none,
	},
	{ -- 3
		COPPUNISH2 = none,
		COPPUNISH1 = none,
	},
	{ -- 3
		WAIT = none,
		WAVE = none,
	},
	{ -- 2
		COMBAT = {
			PROJECTILE = none,
			COWER = none,
			FLEE = none,
			HANDTOHAND = none,
		},
		OBJECTIVES = {
			MOVEOBJECTIVE = none,
			H2HATTACKOBJ = none,
			RANGEATTACKOBJ = none,
			FACEOBJECTIVE = none,
		},
		WORK = {
			PREFECT = {
				PREFPUNISH2 = none,
				PREFPUNISH1 = none,
			},
			COP = {
				COPPUNISH2 = none,
				COPPUNISH1 = none,
			},
			TEACHER = {
				WARNING = none,
			},
		},
		CONTROLLER = {
			CONTROLLER2 = none,
		},
	},
	{ -- 2
		TAUNT_B = none,
		TAUNT_A = none,
		TAUNT_C = none,
	},
	{ -- 3
		WAITING = none,
		TRACKING = none,
	},
	{ -- 3
		HALTBIKE = {
			DISMOUNTWAIT = none,
		},
	},
	{ -- 3
		BSTOPRACE = none,
	},
	{ -- 3
		FINDBADDIESBIKEATTACKOBJ = {
			DISMOUNTANDRESPONDATTACKOBJ = none,
		},
	},
	{ -- 3
		BREAKPROPS = {
			FIREATPROP = none,
		},
		HARASSAUTHORITY = {
			FIREATAUTHORITY = none,
		},
	},
	{ -- 3
		HUMILIATION = {
			TURNLAUGH = none,
		},
		TAGGING = {
			TAGGETPISSED = none,
		},
		SEEBUSTED = {
			LOOKAT = none,
		},
		AUTHORITYFIGHT = {
			CHEERFLEE = none,
		},
		FIGHTNEARBY = {
			RIDETOFIGHT = {
				DISMOUNTCHEER = none,
			},
		},
		BIKECRASH = {
			FACEBIKECRASH = {
				FACECRASHSPEAK = none,
			},
		},
		EXPLOSION = {
			FLEEREACTION = none,
			BIKELOOKAT = none,
		},
	},
	{ -- 3
		FINDBADDIESONBIKE = none,
	},
	{ -- 3
		FRIENDATTACKED = none,
		ABHORCHECK = none,
		AVERSECHECK = none,
	},
	{ -- 3
		HITREACTBIKEEXEC = none,
		MYBIKESTOLENACTIONS = {
			MYBIKESTOLENFEAR = none,
			MYBIKESTOLENATTACK = {
				MYBIKESTOLENSPEECH = none,
			},
		},
		HITBYEGG = none,
	},
	{ -- 3
		FACTIONSCAN = none,
		ATTACKACTIONS = {
			MELEE = {
				PUNCH = {
					RIGHT = none,
					LEFT = none,
				},
				WEAPON_TO_BE_DELETED = {
					RIGHT = none,
					LEFT = none,
				},
			},
			RANGEDACTIONS = {
				RANGEDWEAPONEQUIPPED = {
					DEEQUIPRANGEDWEAPON = none,
					FIRE = {
						CHECKLINEOFFIRE = none,
						DEFAULT = none,
					},
				},
				EQUIPRANGEDWEAPON = none,
			},
		},
		ATTACKSPEECH = {
			BIKEATTACKSPEECHNODE = none,
		},
	},
	{ -- 3
		HANGOUTTALK = {
			HANGOUTTALKANIM = none,
			HANGOUTTALKSEQ = none,
		},
		HANGOUTSTUDENT = none,
		STOPHANGOUT = {
			EXITHANGTALK = none,
			EXITHANGTURF = none,
			EXITNEWKID = none,
			EXITHANG = none,
		},
		HANGOUTADULT = none,
	},
	{ -- 3
		SITWEAPON = {
			WEAPONCLEAR = none,
		},
		SITTING = {
			MOVETOSITSPOT = {
				SITDOWN = none,
				CLEARPOI = none,
			},
		},
		SITADULT = {
			MOVETOSITADULT = {
				SITDOWNADULT = none,
			},
		},
	},
	{ -- 3
		MOVETOSPECTACLE = {
			STOPSPECTACLEEARLY = none,
			STOPSPECTACLE = none,
		},
	},
	{ -- 3
		SYNCTOPOI = {
			STRAFETO = none,
			MOVETO = none,
			ORIENTONLY = none,
		},
	},
	{ -- 3
		SCENARIOEND = {
			SCENARIOENDNODE = none,
		},
		SCENARIOSEEK = {
			OPENSPEECH = {
				OPENSPEECHNODE = none,
			},
			SCENARIOOPEN = {
				SCENARIOWAIT = {
					SCENARIODIALOG = {
						SCENARIOACCEPTED = {
							SCENARIOOPTIONS = {
								SCENARIOOBJECTIVE = {
									WAITFOROBJECTIVE = {
										OBJECTIVEOPTIONS = {
											OBJCOMPLETED = {
												OBJSCENARIOEND = none,
											},
											OBJNOTCOMPLETE = none,
										},
									},
								},
								SCENARIOGIFT = {
									WAITFORGIFT = {
										GETGIFT = {
											GIFTSCENARIOEND = none,
											OBJNOTCOMPLETE = none,
										},
									},
								},
							},
							WAITTOSPEAK = none,
						},
					},
				},
			},
		},
		INSTREETBS = {
			GETBACKONTHEDANGSIDEWALK = none,
		},
		SCENARIOLOVEWAIT = {
			SCENARIOWAITFORPLAYER = none,
		},
	},
	{ -- 3
		OFFSENSE = none,
	},
	{ -- 3
		PICKUPBALL = none,
	},
	{ -- 2
		RANGEDWEAPONACTIONSOTHERS = {
			PREFIRERANGEDWEAPON = {
				RANGEDWEAPONFIRINGPATTERNS = {
					APPLE = none,
					FOOTBALL = none,
					JOKECANDY = none,
					WFTBOMB = none,
					BANANA = none,
					BOSS = {
						TED = none,
					},
					DART = {
						CLEAROBJECTIVES = none,
					},
					BALL = none,
					POTATOGUN = none,
					BOTTLEROCKET = none,
					EGG = none,
					GARBPICK = none,
					MARBLE = none,
					KICKSIGN = none,
					TRAY = none,
					SLINGSHOT = none,
					ITCHINGPOWDER = none,
					STINKBOMB = none,
					SCHOOLHOUSE = none,
					BAGMARBLES = none,
					FOUNTAIN = none,
					DEADRAT = none,
					CHERRYBOMB = none,
					BRICK = none,
					PLANTPOT = none,
					WDISH = none,
					SNOWBALL = none,
					BASEBALL = none,
				},
			},
		},
		AMMOCHECK = {
			DEEQUIPWEAPON = none,
		},
	},
	{ -- 2
		OUTOFRANGE = {
			DEEQUIPPROJECTILEWEAPON = none,
		},
	},
	{ -- 2
		INVESTIGATEAREA = {
			INVESTIGATEAREALOOK = {
				INVESTIGATEAREACONFUSED = none,
			},
		},
	},
	{ -- 2
		INVESTIGATEAREALOOK = {
			INVESTIGATEAREACONFUSED = none,
		},
	},
	{ -- 2
		NOTIFYONFOOTSTEPS = none,
		NOTIFYONSTIMULUS = none,
		NOTIFYONSIGHT = none,
	},
	{ -- 4
		WEAPONCLEAR = none,
	},
	{ -- 4
		MOVETOSITADULT = {
			SITDOWNADULT = none,
		},
	},
	{ -- 3
		ATTACKVEHICLEEND = none,
	},
	{ -- 45
		SOCIALOPPS = none,
	},
	{ -- 2
		EVADEPROJECTILE = none,
	},
	{ -- 2
		EVADEGRENADE = none,
	},
	{ -- 6
		GIRFRIENDATTACKBOY = {
			GIRFRIENDATTACKBOY = none,
			GIRFRIENDATTACKPLAYER = none,
		},
		GIRFRIENDATTACKALLY = none,
		GIRFRIENDATTACKPLAYER = none,
	},
	{ -- 6
		THARASS = none,
		COMPLAIN = none,
	},
	{ -- 6
		HARASSRANGE = {
			HARASSHIT = {
				HARASSCHOICE = {
					TAUNTAFTER = none,
				},
			},
			HARASSRANGEWEAPON = {
				HARASSRANGEEQUIP = none,
				HARASSRANGEUSE = none,
			},
		},
		HUNT = none,
	},
	{ -- 6
		HUMILNODE = none,
		BOOKSTEALEXEC = none,
	},
	{ -- 6
		GIMMICKLAUGH = none,
		GIMMICKSPEAK = none,
	},
	{ -- 6
		BS1TAUNTBACKDOWN = none,
		BS1HARASS = none,
		BS1TAUNTBACK = none,
	},
	{ -- 6
		POSTSTEALTHROWACTION = none,
		POSTSTEALFLEE = none,
	},
	{ -- 6
		USEPRANKRANGE = {
			USEPRANKPROJECTILE = none,
			USEPRANKFLEE = {
				USEPRANKFLEENODE = none,
			},
			USEPRANKPLANT = none,
		},
	},
	{ -- 6
		PLANTSIGN = none,
	},
	{ -- 6
		LOOKAROUND = {
			LOOKAROUND = none,
			LOOKAROUNDSURP = {
				FLEERUN = none,
			},
			LOOKAROUND2 = none,
		},
		TARGETPLAYERCOMBAT = {
			TARGETPLAYERCOMBATCHOICE = {
				TARGETPLAYERSEQ = none,
				TARGETPLAYERCOMBAT = none,
			},
		},
	},
	{ -- 9
		MYBIKESTOLENSPEECH = none,
	},
	{ -- 6
		VOMITNOW = none,
	},
	{ -- 6
		TAUNTNOTVISIBLE = none,
		TAUNTISVISIBLE = {
			TAUNTAGGROCHECK = {
				TCHOICES = {
					TAUNTBEEF = none,
					TAUNTHARASS = none,
				},
			},
			TAUNTNOTAGGRO = {
				TAUNTFEARCHECK = {
					TAUNTFEARRESPONSE = {
						TAUNTFLEE = none,
					},
				},
				TAUNTNOTHING = {
					TAUNTSHRUG = none,
				},
			},
		},
		TAUNTFIX = none,
	},
	{ -- 6
		KICKKICK = none,
	},
	{ -- 6
		RATSPEECHNODE = none,
	},
	{ -- 6
		GIRLFREAKCHOICES = {
			FREAKHOSTILE = {
				FREAKATTACK = {
					FREAKATTACKTARGET = {
						FREAKATTACKTARGETGO = {
							FREAKATTACKFLEE = none,
						},
						FREAKATTACKTARGETWAIT = none,
					},
				},
				FREAKFLEE = none,
			},
			FREAKFLEE = none,
		},
	},
	{ -- 12
		TELLPAL = none,
	},
	{ -- 6
		FEAR = {
			AUTHCHECK = {
				FLEE = none,
				HELPYELL = {
					HELPYELLBIKE = none,
				},
			},
			FLEE = none,
		},
		ATTACKED = none,
		CHICKENS = {
			CHICKENWARN = {
				CHICKENFLEE = {
					TELLAUTHORITY = none,
				},
			},
		},
	},
	{ -- 6
		ATTACKSPEECH = {
			ATTACKWARNADULT = none,
			ATTACKWARNSPEECH = none,
		},
	},
	{ -- 6
		ATTITUDEADJUST = none,
	},
	{ -- 4
		DONOTHING = none,
		COMBATT = none,
	},
	{ -- 8
		TED = none,
	},
	{ -- 2
		PROPATTACKSMELEEWEAPON = none,
	},
	{ -- 3
		TIRED = none,
		RUNNINGATTACKCALL = none,
	},
	{ -- 2
		WAITING = none,
		RECEIVER = none,
		GIVER = {
			TANDEM = {
				ATTACKRIGHTSACQUIRE = none,
				RELEASETANDEM = none,
			},
			GIVER = none,
		},
	},
	{ -- 2
		CLEARBUSTFLAG = {
			OPPOUT = none,
		},
	},
	{ -- 2
		PUNISHSPEECH = {
			DEFAULTWARN = none,
			TAUNTWARN = {
				TAUNTWARNSPEAK = none,
			},
			ATTACKWARN = none,
			TRESPASSWARNING = {
				TRESPASSWARN = none,
			},
			TAGWARNING = {
				TAGWARN = none,
			},
			WEAPONWARNING = {
				WFWARN = none,
			},
			VANDALWARNING = {
				VANDALWARN = none,
			},
			CLASSWARNING = {
				CLASSWARN = none,
				CLASSWARN2 = none,
			},
			CURFEWWARNING = {
				CURFEWWARN = none,
			},
		},
	},
	{ -- 2
		CLOTHINGCRIME = {
			CLOTHINGFACE = {
				CLOTHINGGIMMICKSPEAK = none,
			},
		},
		CLASSWARNING = {
			CLASSWARNNOW = none,
		},
	},
	{ -- 2
		WORKSTIM = none,
	},
	{ -- 2
		TAGCRIME = {
			LOOKATTAGGING = {
				STATINC = none,
			},
		},
		PROPCRIME = {
			LOOKATPROP = none,
		},
		AUTHTARGET = {
			AUTHTARGETACT = none,
		},
		AUTHDIALOG = {
			AUTHINTIMIDATE = {
				AUTHINTIMIDATEFACE = none,
			},
			AUTHAPOLOGY = {
				APOLOGYCHOICES = {
					WARN = none,
				},
			},
			AUTHGREET = {
				AUTHGREETCHOICES = {
					WAVEBACK = none,
					DISGUISE = none,
					WTF = none,
					COLDSHOULDER = none,
				},
			},
			TAUNTCRIME = {
				TAUNTWARNING = none,
			},
		},
		BIKECRASHEXEC = {
			BIKECRASHAUTH = none,
		},
		FIREALARMCRIME = {
			FIREGET = none,
		},
		WFIRECRIME = {
			LOOKATFIRING = none,
		},
		AUTHCANDY = {
			CANDYEXEC = none,
		},
		AUTHVOMIT = {
			VOMEXEC = none,
		},
		BOYKISS = {
			FACEBOYS = {
				BOYSSPEAK = {
					BOYSSPEAKGROSS = none,
				},
			},
		},
		PEDHITCRIME = {
			LOOKATHIT = none,
		},
		STOLENBIKE = {
			LOOKATTHIEF = none,
		},
		TATTLECRIME = {
			TATTLEREACT = {
				SEEKTATTLE = {
					TCHOICES = {
						TFINDTARGET = none,
						TCONFUSED = none,
					},
				},
			},
		},
		AUTHSURPRISE = none,
		FIGHTBREAKUP = none,
		CAMERATARGET = {
			CAMERADISLIKE = {
				CAMERADISLIKEACTION = none,
			},
			CAMERALIKE = {
				CAMERALIKEACTION = none,
			},
		},
		EXPCRIME = {
			FACEEXP = none,
		},
		LOCKPICKING = {
			LOOKAT = none,
		},
		VEHICLECRIME = {
			LOOKAT = none,
		},
		FIGHTAUTHLOOK = none,
	},
	{ -- 2
		THREATEN = none,
		PUNISH3 = none,
		PUNISH1 = none,
		PUNISH2 = none,
		WARNING = none,
	},
	{ -- 2
		SWITCHSCHOOL = {
			PREFECTSWITCHDAY = none,
			PREFECTSWITCHNIGHT = none,
		},
		SWITCHMAINMAP = {
			PREFECTSWITCHDAY = none,
			PREFECTSWITCHNIGHT = none,
		},
	},
	{ -- 2
		LEFTHANDLEAD = {
			ATTACHEDALLYLOCO = none,
			ATTACHEDALLYLOCO_BIG = none,
		},
		RIGHTHANDLEAD = {
			ATTACHEDALLYLOCO = none,
			ATTACHEDALLYLOCO_BIG = none,
		},
	},
	{ -- 4
		ATTACHEDALLYLOCO = none,
		ATTACHEDALLYLOCO_BIG = none,
	},
	{ -- 2
		FEARTARGETEDSPEECH = {
			FEARTARGETEDSPEECH2 = none,
			FEARTARGETEDSPEECH1 = none,
		},
	},
	{ -- 2
		ALLYFEARACTIONDAMAGEREBELDISMISS = none,
	},
	{ -- 2
		ALLYCHEERING = {
			CHEERSPEAK = none,
		},
		ALLYCHEERMOVE = none,
	},
	{ -- 2
		FEARTARGETEDSPEECH2 = none,
		FEARTARGETEDSPEECH1 = none,
	},
	{ -- 3
		CHEERSPEAK = none,
	},
	{ -- 8
		GENERIC = {
			WALKIDLESEXECUTE = none,
		},
		DONOTHING = none,
	},
	{ -- 8
		FACTION_IDLES = {
			BANKB = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
			BANKD = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
			BANKA = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
			BANKC = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
		},
	},
	{ -- 32
		BANKB = {
			IDLES = {
				IDLE_C = {
					IDLE_C = {
						IDLE_A_OPP = none,
						IDLE_C = none,
					},
				},
				IDLE_A = {
					IDLE_A = {
						IDLE_B_OPP = none,
						IDLE_A = none,
					},
				},
				IDLE_B = {
					IDLE_B = {
						IDLE_C_OPP = none,
						IDLE_B = none,
					},
				},
			},
		},
		BANKA = {
			IDLES = {
				IDLE_C = {
					IDLE_C = {
						IDLE_A_OPP = none,
						IDLE_C = none,
					},
				},
				IDLE_A = {
					IDLE_A = {
						IDLE_B_OPP = none,
						IDLE_A = none,
					},
				},
				IDLE_B = {
					IDLE_B = {
						IDLE_C_OPP = none,
						IDLE_B = none,
					},
				},
			},
		},
		BANKC = {
			IDLES = {
				IDLE_C = {
					IDLE_C = {
						IDLE_A_OPP = none,
						IDLE_C = none,
					},
				},
				IDLE_A = {
					IDLE_A = {
						IDLE_B_OPP = none,
						IDLE_A = none,
					},
				},
				IDLE_B = {
					IDLE_B = {
						IDLE_C_OPP = none,
						IDLE_B = none,
					},
				},
			},
		},
	},
	{ -- 10
		FACTION_IDLES = {
			BANKB = {
				IDLES = {
					IDLE_C = {
						IDLE_C = {
							IDLE_A_OPP = none,
							IDLE_C = none,
						},
					},
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
				},
			},
			BANKA = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
			BANKC = {
				IDLES = {
					IDLE_A = {
						IDLE_A = {
							IDLE_B_OPP = none,
							IDLE_A = none,
						},
					},
					IDLE_B = {
						IDLE_B = {
							IDLE_C_OPP = none,
							IDLE_B = none,
						},
					},
					IDLE_D = {
						IDLE_D = {
							IDLE_A_OPP = none,
							IDLE_D = none,
						},
					},
					IDLE_C = {
						IDLE_C = {
							IDLE_C = none,
							IDLE_D_OPP = none,
						},
					},
				},
			},
		},
	},
	{ -- 159
		IDLES = {
			IDLE_C = {
				IDLE_C = {
					IDLE_A_OPP = none,
					IDLE_C = none,
				},
			},
			IDLE_A = {
				IDLE_A = {
					IDLE_B_OPP = none,
					IDLE_A = none,
				},
			},
			IDLE_B = {
				IDLE_B = {
					IDLE_C_OPP = none,
					IDLE_B = none,
				},
			},
		},
	},
	{ -- 159
		IDLE_C = {
			IDLE_C = {
				IDLE_A_OPP = none,
				IDLE_C = none,
			},
		},
		IDLE_A = {
			IDLE_A = {
				IDLE_B_OPP = none,
				IDLE_A = none,
			},
		},
		IDLE_B = {
			IDLE_B = {
				IDLE_C_OPP = none,
				IDLE_B = none,
			},
		},
	},
	{ -- 159
		IDLE_C = {
			IDLE_A_OPP = none,
			IDLE_C = none,
		},
	},
	{ -- 273
		IDLE_A = {
			IDLE_B_OPP = none,
			IDLE_A = none,
		},
	},
	{ -- 273
		IDLE_B = {
			IDLE_C_OPP = none,
			IDLE_B = none,
		},
	},
	{ -- 159
		IDLE_A_OPP = none,
		IDLE_C = none,
	},
	{ -- 273
		IDLE_B_OPP = none,
		IDLE_A = none,
	},
	{ -- 273
		IDLE_C_OPP = none,
		IDLE_B = none,
	},
	{ -- 7
		LINE = none,
	},
	{ -- 3
		START = {
			CHOICE = {
				LINE = {
					END = none,
				},
			},
		},
	},
	{ -- 3
		CHOICE = {
			LINE = {
				END = none,
			},
		},
	},
	{ -- 4
		LINE = {
			END = none,
		},
	},
	{ -- 2
		START = {
			START = {
				LINE = {
					START = none,
				},
			},
		},
	},
	{ -- 2
		START = {
			LINE = {
				START = none,
			},
		},
	},
}
GLOBAL = {
	P_GRAPPLER_A = {
		DEFENSE = {
			EVADE = {
				EVADECOUNTER = none,
				EVADEBACK = COMMON[1],
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[3],
			IDLE = {
				IDLECRICKET = none,
				IDLE = none,
			},
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					UNBLOCKABLE = COMMON[5],
					HEAVYATTACKS = {
						RIGHTCROSS = {
							LEFTDOWN = none,
						},
					},
					LIGHTATTACKS = {
						LEFTJABHEAD = {
							LEFTJABBODY = none,
						},
					},
				},
			},
			MEDIUM = {
				TAUNTS = COMMON[6],
				STRIKES = {
					KICK = {
						KICKTAUNT = none,
					},
				},
			},
			NONCOMBATACTIONS = COMMON[7],
		},
	},
	GS_MALE_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[8],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				LIGHTATTACKS = COMMON[9],
				HEAVYATTACKS = COMMON[10],
			},
		},
	},
	BOSS_DARBY = {
		DEFENSE = {
			EVADE = {
				EVADEDUCK = {
					HEAVYATTACKS = {
						EVADEDUCKPUNCH = {
							HAPPYDARBY = none,
						},
					},
				},
				EVADERIGHT = {
					HEAVYATTACKS = {
						EVADELEFTPUNCH_LAND = none,
						EVADELEFTPUNCH = none,
					},
				},
				EVADELEFT = {
					HEAVYATTACKS = {
						EVADERIGHTPUNCH = none,
						EVADERIGHTPUNCH_LAND = none,
					},
				},
			},
			BLOCK = COMMON[11],
		},
		OFFENSE = {
			RUNNINGATTACKS = {
				HEAVYATTACKS = {
					RUNPUNCHBACKTORUN = none,
				},
			},
			SHORT = {
				GRAPPLES = {
					CATCH_THROW = COMMON[12],
					HEAVYATTACKS = {
						CATCH_THROW = {
							FINISHER = none,
						},
					},
				},
				DASHTOUPPERCUT = none,
				STRIKES = {
					UNBLOCKABLE = COMMON[5],
					HEAVYATTACKS = {
						HOOK2 = COMMON[14],
					},
					LIGHTATTACKS = {
						LEFTHOOK = COMMON[15],
						LEFTJAB = COMMON[16],
					},
				},
			},
			SPECIAL = {
				DASH = {
					DASH = {
						UPPERCUT = {
							SHORTDARBY = none,
						},
						DASHTIRED = COMMON[17],
					},
				},
				HEAVYATTACKS = {
					POWERPUNCHLEFT = none,
					HEAVYDARBY = none,
					POWERPUNCHRIGHT = none,
				},
				EXECUTENODES = COMMON[18],
			},
			MEDIUM = {
				MEDIUM = {
					DASHTOUPPERCUT = none,
					WEAVE = COMMON[19],
					HEAVYATTACKS = COMMON[20],
				},
			},
			NONCOMBATACTIONS = COMMON[7],
		},
		SPECIAL = {
			THROW = COMMON[21],
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = {
				BLOCKPROJECTILES = none,
				FREE = COMMON[26],
				CUSTOMACTIONOPS = COMMON[27],
				LOCOMOTIONOVERRIDE = COMMON[28],
			},
		},
	},
	DBAI = {
		AIROOT = {
			RECEIVING = {
				RECEIVINGIDLE = {
					GOTLEAD = none,
					MISSED = none,
					GOTLEADPASSTHROW = none,
				},
			},
			REFEREE = {
				IDLE = {
					FACETARGET = none,
					GAMEOVERREACT = none,
					TETHERLOCO = none,
					PEDOUTREACT = none,
				},
			},
			ERRORNOAI = none,
			LEAD = {
				LEADERROR = none,
				FIRSTTEAM = {
					CTRL = {
						RETURNTOAREA = {
							["2AREAEND"] = none,
							["2AREAWBALL"] = none,
						},
						CHECKAREA = {
							ENEMYAREA = none,
						},
					},
					SIDECTRL = COMMON[29],
				},
				SECONDTEAM = {
					DEBUGCONTROLLER = {
						DEBUGCTRL = none,
						SIDEDEBUGCTRL = {
							NOBALL = {
								FINISHNOBALL = none,
							},
						},
					},
					AICONTROLLER = {
						RETURNTOAREA = COMMON[29],
						AICTRL = none,
						SIDEAICTRL = COMMON[29],
					},
				},
			},
			SUPPORT = COMMON[30],
			GAMEOVER = {
				GAMEOVER = none,
				PLAYERTEAM = {
					PLAYERTEAMWIN = none,
					PLAYERTEAMLOOSE = none,
				},
				OTHERTEAM = {
					OTHERTEAMWIN = none,
					OTHERTEAMLOOSE = none,
				},
			},
			SIDELINES = {
				SIDELINEIDLE = none,
			},
			PAUSED = {
				PAUSEIDLE = none,
			},
			GETBALL = {
				SIDELINESGETBALL = {
					GETBALLMISSED = none,
					GETBALLFINISH = none,
				},
				INGAMEGETBALL = none,
			},
			BEFORESTART = {
				BEFORESTART = none,
			},
			SELECTED = {
				SIDESELECTED = none,
				SELECTEDIN = none,
			},
		},
	},
	DTCARNIE = {
		PURCHASE = COMMON[31],
		NOROOM = COMMON[32],
		BROKE = COMMON[33],
		START = COMMON[34],
		STOCK = COMMON[35],
		CANCEL = COMMON[36],
		BROWSE = COMMON[32],
	},
	NEMESIS = {
		DEFENSE = {
			EVADE = {
				BACK = none,
				GARYSPECIALOVERRIDE = none,
				RIGHT = COMMON[37],
				LEFT = COMMON[38],
			},
			EVADEATTACK = {
				BACK = none,
				GARYSPECIALOVERRIDE = none,
				EVADEATTACKS = {
					RIGHTPUNCH = none,
					LEFTPUNCH = none,
					BACKPUNCH = none,
				},
				RIGHT = none,
				LEFT = none,
			},
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GARYSPECIALOVERRIDE = none,
				STRIKES = {
					LIGHTATTACKS = {
						JAB = {
							HEAVYATTACKS = {
								SUPERUPPERCUT = {
									KNEE = none,
								},
							},
						},
						LEFTHOOK = {
							RIGHTCROSS = {
								HEAVYATTACKS = {
									HEAVYPUNCH2 = none,
								},
							},
						},
					},
					HEAVYATTACKS = {
						HEAVYPUNCH2 = COMMON[39],
						HEAVYPUNCH1 = COMMON[39],
					},
				},
			},
			GROUNDATTACKS = {
				GROUNDATTACKS = {
					GROUNDMOUNT = COMMON[40],
					LIGHTATTACKS = COMMON[41],
				},
				GARYSPECIALOVERRIDE = none,
			},
			MEDIUM = {
				GARYSPECIALOVERRIDE = none,
				STRIKES = {
					LIGHTATTACKS = {
						OVERHANDR = {
							HEAVYATTACKS = {
								KNEE = COMMON[39],
							},
						},
					},
					HEAVYATTACKS = COMMON[42],
				},
			},
			GRAPPLES = {
				GARYSPECIALOVERRIDE = none,
				GRAPPLEATTEMPT = none,
			},
		},
		SPECIAL = {
			GARYSPECIALGRAPPLE_OLD = {
				SCRIPTEXECUTE = COMMON[43],
				POWERBOMB = {
					GIVE = none,
					RCV = COMMON[44],
				},
				RUNNINGTAKEDOWN = {
					TAKEDOWN_MISS = COMMON[45],
					GRAPPLEATTEMPT = COMMON[45],
				},
			},
			CROUCH = {
				STAND = none,
				CROUCH = none,
			},
			RAILING_GRAB = {
				["6B_HOLD"] = {
					GIVE = none,
					RCV = {
						SETPOS = COMMON[47],
					},
					HOLD_CYCLE = {
						ESCAPEPARAMETRIC = {
							ESCAPE = COMMON[48],
							RCV = none,
							GIVE = COMMON[47],
						},
						GIVE = {
							SPEECH = COMMON[47],
						},
						RCV = none,
						BUSTED = COMMON[48],
					},
				},
				FORCEMOVE = none,
			},
			GARYSPECIALGRAPPLE = {
				CHARGE = {
					CHARGELOCO = none,
					TAKEDOWN = {
						BACK = COMMON[48],
						FRONT = COMMON[49],
						RCV_WAIT = none,
						FALL = {
							GIVE = COMMON[50],
							RCV = COMMON[50],
						},
					},
				},
				PREATTACKANIMATION = none,
				SCRIPTEXECUTE = COMMON[43],
			},
			THROW = COMMON[21],
			LADDERKICK = none,
			WHEELBARROWINTERACT = none,
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			BLOCKPROJECTILES = none,
			EXECUTENODES = COMMON[63],
			IDLE = none,
			RISINGATTACKS = none,
		},
	},
	JBROOM = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = COMMON[65],
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					SWING = {
						BONK = {
							BONKFF = none,
						},
						SWINGFF = none,
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	["2_07_GORD"] = {
		DEFENSE = {
			EVADE = {
				EVADECOUNTER = {
					HEAVYATTACKS = COMMON[66],
				},
				EVADEBACK = none,
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				COMBAT = {
					LONGRANGESTRAFE = none,
					CHEERSTRAFE = none,
					STRAFEBASE = COMMON[54],
					STRAFEIDLE = none,
					CLOSERANGESTRAFE = none,
				},
				FREE = {
					RUN = none,
					SPRINT = {
						SPRINT = none,
						TIRED = none,
						SPECIALSPRINTTROPHY = {
							SPRINTTROPHY = none,
							SPRINTBASIC = none,
						},
					},
					WALK = none,
					IDLE = {
						IDLE_CHECK = {
							IDLE_REGULAR = COMMON[68],
							IDLE_SOCIAL = {
								GENERICS = COMMON[69],
								UBO_CHECKS = COMMON[70],
								NERDS = COMMON[69],
								TOUGHFACTIONS = COMMON[71],
								GIRLS = COMMON[72],
								AUTHORITY = COMMON[73],
							},
							IDLE_STEALTH = none,
						},
					},
				},
				ACTIONOPPS = none,
			},
			EXECUTENODES = COMMON[74],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				P_COOPPUNCH = {
					BODYPUNCHES = {
						BODYPUNCHLEFT = {
							BODYPUNCHRIGHT = none,
						},
					},
				},
				STRIKES = COMMON[75],
			},
			MEDIUM = COMMON[76],
		},
	},
	GRAFFITICLEANUP = {
		TOSSBRUSH = {
			TOSS = none,
		},
	},
	G_GRAPPLER_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = {
				FREE = COMMON[81],
				LOCOMOTIONOVERRIDE = COMMON[82],
				CUSTOMACTIONOPS = COMMON[27],
			},
		},
		OFFENSE = {
			GROUNDATTACK = COMMON[40],
			RUNNINGATTACKS = none,
			MEDIUM = {
				STRIKES = {
					HEAVYATTACKS = COMMON[83],
				},
			},
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					HEAVYATTACKS = {
						RIGHTHOOK = COMMON[84],
						BOOTKICK = none,
					},
				},
			},
		},
	},
	WRESTLINGNPC = {
		DEFENSE = COMMON[10],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = {
				FREE = COMMON[87],
				LOCOMOTIONOVERRIDE = COMMON[82],
				CUSTOMACTIONOPS = COMMON[27],
			},
		},
		OFFENSE = {
			MEDIUM = {
				GRAPPLES = COMMON[89],
			},
			SHORT = {
				GRAPPLES = COMMON[4],
			},
		},
	},
	J_DAMON = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[93],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = {
					TAKEDOWN = none,
				},
			},
			EXECUTENODES = COMMON[18],
			MEDIUM = {
				GRAPPLES = {
					GRAPPLESATTEMPT = {
						TAKEDOWN = {
							POWERSWING = COMMON[48],
							RCV = none,
							GIVE = none,
						},
					},
				},
			},
			SPECIALSTART = {
				STARTRUN = {
					RUNNING = {
						DASHTIRED = COMMON[17],
					},
				},
			},
		},
	},
	PREPHOUSE = {
		OPENFOYEURDOOR = {
			DOANIM = none,
			CALLSCRIPT = none,
		},
		BIFKICKOUT = {
			SHAKEHEAD = none,
		},
		TAUNT = COMMON[94],
		OPENSECONDFLOORDOOR = {
			DOANIM = none,
		},
	},
	TESTSTART = {
		OPEN = {
			CLOSE = none,
		},
	},
	["2_R03_CONV"] = {
		INTRONIS = {
			M_2_R03_04 = none,
			M_2_R03_01 = none,
			M_2_R03_02 = none,
			M_2_R03_03 = none,
		},
		M_2_R03_01 = {
			M_2_R03_02 = {
				M_2_R03_03 = {
					M_2_R03_04 = COMMON[95],
				},
			},
		},
		ANIMATIONS = {
			THANKYOU = none,
		},
		LOADANIMS = none,
	},
	ANIMSAVE = {
		PEDPROPSACTIONS = {
			SAVE = none,
		},
		BASE = none,
		NOTUSEABLE = {
			SHOWINMISSION = none,
			INMISSION = none,
		},
	},
	ZOEAI = {
		COMBAT = COMMON[96],
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[98],
		COMBATACTIONS = {
			DEFENSE = COMMON[99],
			DUMMY = none,
			OFFENSE = COMMON[100],
			COUNTERATTACK = COMMON[101],
		},
		AMBIENT = COMMON[102],
	},
	["404CONV"] = {
		PLYRCONV = {
			PLAYERSTART = {
				CARNY = {
					CARNYNEXT = {
						PLAYER = {
							PLAYERNEXT = {
								CARNY = {
									CARNYNEXT = {
										PLAYER = COMMON[103],
									},
								},
							},
						},
					},
				},
			},
		},
		TAKE = none,
		FACEPLAYER = COMMON[104],
		MAZELOOKAROUND = none,
		GIVE = none,
		JOCKCONV = {
			CARNYSTART = {
				JOCK = COMMON[103],
			},
		},
		QUICKIDLE = COMMON[105],
		THREATEN = none,
		USEMONITOR = none,
		IDLE = none,
		NERDS = {
			DANCE1 = none,
			DANCE2 = none,
		},
		IDLEQUICK = none,
	},
	DO_MELEE_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[106],
		OFFENSE = COMMON[107],
	},
	["2_03CNV"] = {
		ANIMATIONS = {
			LOCK_PICKING = COMMON[108],
			TADREBUFF = none,
		},
	},
	NPC_AMBIENT = {
		TELL_OFF = {
			GRAPPLEATTEMPT = COMMON[109],
		},
		CRAPS = {
			CRAPS_EXECUTE = {
				CRAPS = {
					CRAPS_IDLE_1 = {
						CRAPSTHROW_1 = none,
					},
				},
			},
		},
		WALL_LEAN = {
			WALL_START = {
				WALL_IDLE = {
					WALL_SMOKE_START = COMMON[110],
				},
				WALL_END = none,
			},
		},
		DRUNK = {
			DRUNK_2 = none,
			DRUNK_1 = none,
		},
		PANHANDLING = {
			PANHANDLE_EXECUTE = {
				PANHANDLE = {
					PANHANDLE_1 = {
						PANHANDLE_1 = none,
					},
				},
			},
		},
		SITTING_DOWN = {
			SIT_START = {
				SIT_IDLE = {
					SIT_TALK = {
						SIT_TALK_A = none,
						SIT_TALK_B = none,
						SIT_TALK_C = none,
					},
					SIT_SMOKE_START = {
						SIT_SMOKE_IDLE = {
							SIT_SMOKE_A = none,
							WALL_SMOKE_STUB = none,
							SIT_SMOKE_B = none,
						},
					},
				},
				SIT_END = none,
			},
		},
		KISS_ME_BABY = COMMON[111],
		BATHROOM = {
			STOPBATHROOM = none,
			BATHROOM_2 = none,
			BATHROOM_3 = none,
			RELEASEANIMGROUP = COMMON[112],
			BATHROOM_4 = none,
			BATHROOM_1 = none,
			LOAD_ANIMATION = {
				DRUNK = none,
			},
		},
		DANCING = {
			DANCING_EXECUTE = {
				DANCING = {
					DANCING_IDLE_2 = {
						DANCING_2 = none,
					},
					DANCING_IDLE_1 = {
						DANCING_1 = none,
					},
				},
			},
		},
		CAFETERIA = {
			EATING_2 = none,
			EATING_1 = none,
		},
		CUDDLE = COMMON[111],
	},
	DB_PED = {
		LOCOANIMATIONS = {
			DB_RUNLOCO = none,
			DB_STRAFELOCO = none,
			RUNLOCO = none,
			DB_STRAFE_2LOCO = none,
			SPEEDRUNLOCO = none,
		},
		WITHDODGEBALL = {
			IDLE = {
				ALL = COMMON[30],
			},
			JUMPACTIONS = {
				VERTJUMP = {
					VERTJUMPTHROWS = {
						VERTPASS = COMMON[114],
						VERTJUMPTHROW2 = none,
					},
				},
				FWDRUNNINGJUMP = {
					FWDRUNNINGJUMPTHROWS = {
						FWDRUNNINGJUMPTHROWS3 = none,
						FWDRUNNINGJUMPTHROWS2 = none,
						FWDRUNNINGJUMPPASS = COMMON[114],
					},
				},
			},
			EXECUTENODES = {
				DODGESTRAFEBASIC = none,
				TODEFAULT = {
					DEEQUIP = none,
				},
				ACTIONOPPSBASE = none,
				DODGELOCOBASIC = none,
				SPEEDRUNLOCOBASIC = none,
				CHANGEPLAYER = none,
			},
			TAUNTS = {
				TAKEIT = none,
				YOU = none,
			},
			THROWACTIONS = {
				DROPTHROWSTART = none,
				RUNTHROW = {
					RUNTHROWPLAYER = none,
					RUNTHROW = none,
				},
				PASS = COMMON[114],
				ONETIMER = COMMON[117],
				THROWSTART = COMMON[117],
				SPECIALTHROWS = {
					PLAYER = COMMON[119],
					JOCKS = COMMON[119],
					GREASERS = COMMON[119],
					PREPS = COMMON[119],
				},
				DB_STATS = {
					THROW_STATS = none,
				},
			},
			LOCOMOTION_MOVE = {
				DODGESTRAFE = none,
			},
		},
		WITHOUTDODGEBALL = {
			LOCOFILEREF = {
				RUNSTRAFEMODE = COMMON[120],
				IDLE = {
					NOBALL = {
						ENEMYHASBALL = COMMON[121],
						TEAMHASBALL = COMMON[121],
					},
					BALLIDLE = none,
				},
				STRAFE = {
					STRAFEBASIC = none,
				},
			},
			WHISTLEGAMEOVER = none,
			WITHOUTBALLACTIONS = {
				WITHOUTBALLACTIONS = {
					ACTIONS = {
						SQUARE = {
							CHANGEPLAYERACTIONS = {
								CHANGEPLAYER = none,
								CHANGEPLAYERAI = none,
							},
						},
						PICKUPACTIONS = {
							PICKUP = {
								WEAPONSTEAL = {
									PLAYER_WINNING = {
										GIVE = COMMON[123],
										RCV = none,
									},
									GIVE = none,
									SHAREDTRACKS = none,
									JOINTDRIVER = none,
									RELEASEWEAPON = none,
									NPC_WINNING = {
										GIVE = none,
										RCV = COMMON[123],
									},
									RCV = none,
									STEAL = COMMON[125],
								},
								COLLISION = none,
								CHANGEPLAYEREXECUTE = {
									DESTROYEXTRABALLS = none,
									CHANGEPLAYEREXECUTE = none,
								},
							},
						},
						CIRCLE = {
							DEFENCEACTION = {
								DIVEROLLRIGHT = none,
								DUCK = {
									DUCKFINISH = none,
								},
								DIVEROLLFWD = none,
								DIVEROLLLEFT = none,
								DIVEROLLBACK = none,
							},
						},
						WAITFORPASSTHROW = {
							CATCHMISS = none,
							CATCHPASSTHROW = none,
						},
						CROSS = {
							CATCH = {
								CATCH = COMMON[126],
								CATCHTHEPASS = COMMON[126],
								NOCATCH = {
									CATCHMISS = none,
								},
								CATCHHARD = COMMON[126],
							},
						},
					},
				},
			},
			IDLEACTIONS = {
				IDLECONTROLLER = {
					TAUNTS = {
						DB_TAUNT2 = none,
						TAUNT2 = none,
						TAUNT1 = none,
						DB_TAUNT3 = none,
						DB_TAUNT4 = none,
						DB_TAUNT1 = none,
					},
					TAUNTSPEECH = {
						WEGREAT = none,
						YOUSUCK = none,
					},
				},
			},
			DB_TARGETCONTROL = {
				SIDELINENOTARGET = none,
				INGAMETARGETLEAD = none,
				INGAMETARGETBALL = none,
				SIDELINETARGETBALL = none,
			},
		},
	},
	["2_02_NIS"] = {
		OWNERGIVE = none,
		PLAYERTAKE = none,
		RESTORE = none,
	},
	TESTCONV_2PED = COMMON[127],
	CHADAI = {
		COMBAT = COMMON[96],
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[98],
		COMBATACTIONS = {
			DEFENSE = COMMON[99],
			POSTHIT = {
				ONGROUND = COMMON[139],
			},
			COUNTERATTACK = COMMON[101],
			OFFENSE = COMMON[100],
		},
		AMBIENT = COMMON[102],
	},
	AI_SITTEST = {
		IDLE = none,
		SEEK = {
			GETSTARTPOS = {
				TOSTART = none,
			},
			GETSEATPOS = {
				TOSEAT = none,
			},
		},
		SIT = {
			STARTSITTING = {
				ACTIONS = {
					SIT = none,
				},
			},
			STAND = none,
		},
	},
	BBGUN = {
		BBGUN = {
			IDLE = {
				SHOOTACTIONS = {
					SHOOT = COMMON[143],
				},
			},
		},
	},
	JOHNNYAI = {
		ONBIKE = COMMON[144],
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[145],
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				FINDWEAPON = COMMON[147],
				GROUNDATTACK = COMMON[148],
				TAUNT = COMMON[149],
				RUNNINGATTACKS = COMMON[150],
				BLOCK = COMMON[151],
				POSTHIT = COMMON[152],
				COMBATSPEECH = COMMON[153],
				RANGEDWEAPONCHECK = COMMON[154],
				OFFENSE = {
					MELEEACTIONS = {
						LONG = COMMON[155],
						MEDIUM = COMMON[156],
						SPECIAL = COMMON[157],
						SHORT = COMMON[158],
					},
				},
				COUNTERATTACK = COMMON[101],
			},
		},
		COMBAT = {
			ACTIVECOMBAT = {
				GUARDLOCO = none,
				SPECIAL = COMMON[159],
				WAITFORTARGETLOCO = COMMON[160],
				COMBATLOCO = none,
			},
		},
		AMBIENT = COMMON[102],
	},
	WRESTLINGACT = {
		ATTACKS = {
			GRAPPLES = {
				GRAPPLES = {
					BACKGRAPPLES = {
						CHOKE = {
							GRAPPLESUCCESS = COMMON[48],
						},
					},
					GRAPPLEATTEMPT = none,
					RUNNINGTAKEDOWN = none,
				},
			},
			GROUNDMOUNT = {
				MOUNTACTION = {
					COLLISION = none,
					EXECUTENODES = {
						MOUNTS = {
							MOUNTHEADGIVE = none,
							MOUNTFEETGIVE = none,
							MOUNTLEFTGIVE = none,
							RCV = none,
							MOUNTRIGHTGIVE = none,
						},
					},
				},
			},
		},
		DIALOGUE = {
			PED_REACT = none,
		},
		DEFAULT_KEY = {
			EXECUTENODES = {
				ACTIONOPPSCOMBAT = none,
				COMBATLOCOBASIC = none,
				ACTIONOPPSBASE = none,
				SNAPIDLE = none,
				STRAFELOCOBASIC = none,
				ACTIONOPPS = none,
			},
			LOCOMOTION_MOVE = {
				COMBATLOCO = {
					STRAFEMOVE = {
						STRAFE = none,
						COMBATSTRAFE = none,
					},
					STRAFEIDLE = {
						COMBATSTRAFEIDLE = none,
						STRAFEIDLE = none,
					},
				},
			},
		},
	},
	CHAPTER3TRANS = {
		TALKING = COMMON[161],
		JIMMYBYE = none,
	},
	WATERPIPE = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = {
			ANIMATIONS = {
				WEAPONWALK = COMMON[163],
				WEAPONBIKEIDLE = none,
				WEAPONSOCIAL = COMMON[164],
				WEAPONCROUCH = none,
				WEAPONRUN = none,
				WEAPONSTRAFE = {
					NOBLOCK = none,
					BLOCK = none,
				},
				WEAPONIDLE = COMMON[163],
			},
			GLOBALLOCO = COMMON[165],
		},
		ACTIONS = {
			ATTACKS = {
				PIPEBLOCKS = {
					BLOCKPROJECTILES = none,
					BLOCKHITS = {
						HITSLIGHT = none,
						CLASH_INIT = {
							CLASH = {
								PLAYER_WINNING = COMMON[48],
								GIVE = none,
								EFFECTSSPAWN = {
									WEAPONFX = none,
								},
								NPC_WINNING = COMMON[48],
								RCV = none,
								WINATTACK = COMMON[48],
							},
						},
					},
				},
				HEAVYATTACKS = {
					EXECUTEBANK = {
						CHECKPIPEDAMAGE = {
							CHECKWEAPONDAMAGE = {
								MUSTBEDROPPED = none,
							},
						},
						UNINTERRUPTIBLETOGGLE = {
							PLAYERNOPIPEORSHIELD = none,
						},
					},
					SWING1 = {
						RELEASE = {
							UNBLOCKABLE = {
								UNDERHANDSWING = none,
							},
							SWING1_CHARGE = none,
							SWING1 = {
								SWING1LAND = none,
								OPPORTUNITYINSERT = none,
							},
						},
						SWING2 = {
							RELEASE = {
								SWING2_CHARGE = none,
								UNBLOCKABLE = {
									VERTICALSWING = {
										VERTICALSWINGLAND = none,
										OPPORTUNITYINSERT = none,
									},
								},
								SWING2 = none,
							},
						},
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	WFIREEXT = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = COMMON[166],
		ACTIONS = {
			ATTACKS = {
				SPLITBODY = {
					CONTROLLER = {
						SPINECONTROLHACK = none,
						AUTOAIM = COMMON[167],
						UPPERBODY = {
							OBSTRUCTION_CHECK = {
								IDLE = COMMON[168],
							},
							FIREACTIONS = {
								FIRE = {
									PRIMARY = {
										FIRE = {
											SPRAYFRONTRUN_RELEASE = none,
										},
										WEAPONSPAWNS = {
											FIRESEQUENCE = {
												AUTOFIRE1 = {
													AUTOFIRE2 = none,
												},
											},
											FIREEXTANIMS = {
												SPRAYFIRE1_10 = none,
												SPRAY = none,
												SPRAYFIRE = none,
												SPRAYFIREOFFSET = none,
											},
										},
									},
								},
							},
							AIM = {
								INTOAIM = {
									AIMIDLE = COMMON[169],
									DEFAULT = none,
									CROUCH = none,
								},
							},
						},
					},
					WAIT = none,
				},
				HEAVYATTACKS = COMMON[170],
			},
		},
		DEFAULT_KEY = none,
	},
	BOSS_RUSSELL = {
		RUSSELTALK = {
			RUSSELATTACKTEXT = {
				RUSSELTALK = none,
			},
		},
		DEFENSE = {
			EVADE = COMMON[171],
			BLOCK = none,
		},
		EXECUTENODES = {
			UNINTERUPTABLE = {
				UNINTERUPTABLE = none,
				STOPUNINTERUPTABLE = none,
			},
		},
		OFFENSE = {
			GROUNDATTACK = {
				GROUNDSTOMP1 = none,
				STARTGROUNDSTOMP = {
					GROUNDSTOMP1 = none,
				},
			},
			RUNNINGATTACKS = none,
			COMBATTAUNT = COMMON[172],
			MEDIUM = {
				OHDEAR = none,
				STRIKES = COMMON[173],
			},
			SPECIAL = {
				INVINCIBLE = {
					HEADBUTT = COMMON[174],
					BARSERKGRAPPLE = {
						BARSERKGRAPPLE_ANTIC = {
							BARSERKGRAPPLE_RUNCYC = {
								BARSERKTIRED = COMMON[17],
								BARSERKGRAPPLE_SUCCESS = COMMON[48],
								BARSERKGRAPPLEMOVES = {
									BOSTONCRAB = {
										GIVE = none,
										RCV = {
											BOSTONCRABCYC = {
												GIVE = {
													DAMAGETARGETSPAWN = {
														DAMAGETARGET = none,
													},
												},
												RCV = {
													BOSTONCRABESCAPE = {
														ESCAPEPARAMETRIC = {
															GIVE = none,
															RCV = {
																DAMAGETARGETSPAWN = {
																	DAMAGETARGET = none,
																	NODAMAGE = none,
																},
															},
														},
														ESCAPEFINISH = COMMON[48],
													},
													BOSTONCRABFINISH = COMMON[48],
												},
											},
										},
									},
									POWERBOMB = none,
									GRAPPLERCVWAIT = none,
								},
							},
						},
					},
				},
				EXECUTENODES = {
					BARSERKGRAPPLE_LOCO = none,
					HEADBUTT_LOCO = none,
				},
			},
			LONG = {
				LONGCHOOSE = {
					GOTOSPECIAL = COMMON[175],
					GOTOTAUNT = {
						SPECIAL = none,
						GOTOTAUNT = none,
					},
				},
			},
			SHORT = {
				GRAPPLES = COMMON[176],
				STRIKES = COMMON[173],
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				COMBAT = {
					LONGRANGESTRAFE = {
						LONGRANGESTRAFE = none,
					},
					CHEERSTRAFE = none,
					STRAFEBASE = COMMON[54],
					STRAFEIDLE = none,
					CLOSERANGESTRAFE = none,
				},
				CROUCH = COMMON[23],
				FREE = {
					RUN = none,
					SPRINT = {
						SPRINT = none,
						TIRED = none,
						SPRINTGESTURE = {
							SPRINTGESTURE = {
								SHAKEFIST = none,
							},
						},
					},
					WALK = none,
					IDLE = COMMON[180],
				},
				CROUCHACTIONOPPS = none,
				CROUCHACTIONOPPSBASE = none,
				ACTIONOPPS = none,
			},
			EXECUTENODES = {
				BLOCKPROJECTILES = none,
				FREE = {
					RUNBASIC = {
						RUNBASIC = none,
						RUNANGRY = none,
					},
					SPRINTBASIC = {
						SPRINTANGRY = none,
						SPRINTBASIC = none,
					},
					WALKBASIC = {
						WALKANGRY = none,
						WALKBASIC = none,
					},
				},
				CUSTOMACTIONOPS = {
					CUSTOMACTIONOPS = none,
					BLOCKEXTINGUISHER = {
						BLOCKEXTINGUISHER_RCV = none,
					},
				},
				LOCOMOTIONOVERRIDE = {
					COMBAT = {
						COMBATBASIC = {
							COMBATBASIC = none,
							COMBATANGRY = none,
						},
						STRAFEIDLE = none,
					},
					COMBATSTRAFEIDLE = {
						COMBATANGRYIDLE = none,
						COMBATSTRAFEIDLE = none,
					},
				},
			},
			IDLE = none,
			RISINGATTACKS = COMMON[181],
		},
	},
	NORTON = {
		DEFENSE = {
			EVADE = COMMON[171],
			TIRED = {
				TIREDANIM = none,
			},
			BLOCK = none,
		},
		EXECUTENODES = {
			SPLIT_BODY_HITS = COMMON[183],
		},
		OFFENSE = {
			GROUNDATTACK = COMMON[41],
			SHORT = COMMON[184],
			MEDIUM = {
				UNBLOCKABLE = {
					POWERSWING = none,
				},
			},
			BREAKPROP = COMMON[185],
			COMBATTAUNT = COMMON[172],
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				COMBAT = {
					STRAFEBASE = COMMON[54],
					STRAFEIDLE = none,
					CLOSERANGESTRAFE = none,
				},
				CROUCH = COMMON[23],
				FREE = {
					RUN = none,
					SPRINT = {
						SPRINT = none,
					},
					WALK = none,
					IDLE = COMMON[180],
				},
				CROUCHACTIONOPPS = none,
				CROUCHACTIONOPPSBASE = none,
				ACTIONOPPS = none,
			},
			IDLE = none,
			EXECUTENODES = {
				FREE = {
					RUNBASIC = COMMON[187],
					SPRINTBASIC = {
						SPRINTBASIC = none,
					},
					WALKBASIC = COMMON[188],
				},
				LOCOMOTIONOVERRIDE = {
					COMBAT = {
						COMBATBASIC = {
							COMBATBASIC = none,
						},
						STRAFEIDLE = none,
					},
					COMBATSTRAFEIDLE = COMMON[189],
				},
				CUSTOMACTIONOPS = COMMON[27],
			},
		},
	},
	IDLE_OVERRIDES = {
		GENERIC_STANDING_OVERRIDES = {
			UNARMED = {
				LEFTARM_ACTIONS = COMMON[190],
				BOTHARMS_ACTIONS = COMMON[191],
				LOOKAROUND_IDLES = COMMON[192],
				RIGHTARM_ACTIONS = COMMON[193],
			},
			STEALTHPEDS = {
				STEALTHPEDS_CONTROLLER = {
					STEALTHACTIONS = {
						LOOKAROUND_IDLES = COMMON[192],
						CURFEW = COMMON[194],
					},
				},
			},
		},
	},
	COASTER = {
		RIDEME = none,
		NOTUSEABLE = {
			LOOP = none,
			ADDPEDS = none,
			SHUTDOWN = none,
			INIT = none,
			PAUSE = none,
			ANIMATEPINKY = none,
		},
	},
	GIVEWFTBOMB = {
		GIVE = COMMON[195],
		GIVE_ATTEMPT = COMMON[196],
		EXECUTES = {
			SPEECH = COMMON[197],
			MODELS = COMMON[198],
			ANIMS = {
				RECEIVE = {
					RECEIVEIDLE = none,
				},
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
		},
	},
	["5_07B"] = {
		["507B_GATE"] = COMMON[199],
		["507B_BARRICADE"] = {
			ZOESTART = COMMON[200],
		},
		["507B_INTRO"] = {
			ZOESTART = {
				ZOE = {
					PLAYER = {
						ZOE = {
							PLAYER = {
								ZOE = COMMON[201],
							},
						},
					},
				},
			},
		},
		["5_07B_REDSTAR_GATE"] = COMMON[202],
	},
	["3_XM"] = {
		ANIMS = {
			RESTART = none,
			SHAKEFIST = none,
		},
	},
	DO_EDGAR = {
		DEFENSE = {
			EVADE = {
				DROPTOFLOOR = none,
				DROPANDCOUNTER = {
					UNBLOCKABLE2 = {
						DUCKCHARGE = {
							OPPORTUNITYINSERT = none,
							DUCKCHARGEHIT = none,
						},
					},
				},
			},
		},
		DEFAULT_KEY = COMMON[106],
		OFFENSE = {
			SPECIAL = none,
			SHORT = COMMON[205],
		},
	},
	GOKART = {
		ANIMATIONS = {
			OUTOFCARFAIL = none,
		},
	},
	DTGENERAL = {
		OLD_STUFF = none,
		BROWSE = COMMON[32],
		PURCHASE = COMMON[31],
		NOROOM = COMMON[32],
		BROKE = COMMON[33],
		STOCK = COMMON[35],
		CANCEL = COMMON[36],
		START = COMMON[34],
	},
	AI_FIGHTTUTORIAL = {
		COMBAT = {
			ACTIVECOMBAT = {
				WAIT = none,
				SPECIAL = none,
				WAITFORTARGETLOCO = COMMON[160],
				COMBATLOCO = none,
			},
		},
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = {
			HITREACT = {
				HITREACTWAIT = {
					TURNTOFACE = {
						ATTACKCHECK = {
							SEEATTACKER = {
								ATTACKED = none,
								FEAR = COMMON[207],
							},
							SEEDISLIKED = COMMON[208],
							DEGRADEFACTION = COMMON[209],
							LOOKAROUND = none,
							REACTTEXT = COMMON[210],
							ATTACKFIX = none,
						},
					},
				},
			},
			PUNISHMENTPOINTS = COMMON[211],
		},
		COMBATACTIONS = {
			CONTROLNODE = none,
			COMBATACTIONS = {
				TAUNT = COMMON[149],
				BLOCK = COMMON[99],
				POSTHIT = {
					HIT = none,
					DEAD = none,
					ONGROUND = none,
				},
				COUNTERATTACK = COMMON[101],
				OFFENSE = {
					MELEEACTIONS = {
						LONG = COMMON[155],
						SHORT = COMMON[107],
						MEDIUM = COMMON[156],
					},
				},
			},
		},
		AMBIENT = COMMON[102],
	},
	SHOOTINGGALLERY = {
		MGSGMISSIONSTART = none,
		MGSGCONVSTART = {
			MGSG01 = {
				MGSG01 = COMMON[212],
			},
		},
	},
	["2_S05"] = {
		ANIMS = {
			DRINK = {
				PUKE = {
					VOMIT = {
						VOMIT2 = {
							VOMIT3 = {
								VOMITSTUN = COMMON[213],
							},
						},
					},
					LOAD = none,
					GAGSOUND = COMMON[214],
				},
				DRINK = {
					DRINK2 = none,
				},
			},
			EATCANDY = none,
			DATEACTIONS = {
				GETUP = COMMON[215],
				SITTING = none,
				EXECUTES = {
					LOCOPED = COMMON[216],
					SYNCTOPROP = {
						MOVETO = {
							ORIENTONLY = {
								FINALBIT = none,
							},
						},
					},
					STRAFETOPROP = {
						STRAFE = none,
					},
					LOCO = COMMON[216],
				},
				DRINKCOFFEE = none,
				DRUGCOFFEE = none,
				PROPINTERACT = none,
				WOBBLE = {
					WOBBLE2 = none,
				},
			},
			HOBORUMMAGE = none,
			SIT = none,
			DISTURB = {
				NERDDISTURB = {
					NERDGAWK2 = {
						NERDGAWK3 = {
							NERDGAWK4 = COMMON[217],
						},
					},
				},
				GAWK = {
					GAWK2 = none,
				},
				WALL_SMOKE = COMMON[218],
				GREASERDISTURB = {
					DISTURB2 = {
						DISTURB3 = {
							DISTURB4 = COMMON[217],
						},
					},
				},
				MASCOTDANCE = none,
				PUTOUTCIGEND = COMMON[219],
			},
			IDLE = none,
			LAUNCH = none,
			CONVERSATION = {
				BREAKOUT = none,
				HATTRICKSTART = none,
				SPEECHBANK = {
					HAT2 = none,
					HAT3 = none,
					HAT1 = none,
					CHEMREPLY = none,
				},
			},
			BREAK = none,
		},
		["2_S05_EDNAINTRO"] = {
			["2_S05_EDNAINTRO_CHILD"] = none,
		},
		["2_S05_EDNAEND"] = {
			["2_S05_EDNAEND"] = none,
		},
		["2_S05_EDNAMIDDLE"] = {
			["2_S05_EDNAMIDDLE02"] = none,
		},
	},
	PRIOFF = {
		TARGETANIMATIONS = {
			TARGETBREATHE = none,
			TARGETPOINT = none,
			TARGETYELL = none,
			TARGETGESTURE = {
				TARGETGESTURE = none,
			},
		},
		PRINCIPALDIALOGUE = {
			DIALOGUE01 = {
				DIALOGUE02 = {
					DIALOGUE03 = {
						DIALOGUE04 = {
							DIALOGUE05 = COMMON[95],
						},
					},
				},
			},
		},
		JIMMY = COMMON[220],
	},
	["1_10_ANIMS"] = {
		PLAYER = {
			KNOCKBACK = none,
		},
		GARY = {
			POINTATSWITCH = none,
			KEYPICKUP = none,
			DOORLOCK = {
				GARYUNLOCKDOOR = none,
				RELEASE = none,
			},
		},
	},
	TRAININGPLAYER = {
		ATTACKS = {
			EXECUTENODES = COMMON[221],
			GRAPPLES = {
				GRAPPLES = {
					GRAPPLEATTEMPT = none,
					RUNNINGTAKEDOWN = none,
				},
				CHECK_DESELECT = none,
			},
			GROUNDATTACKS = {
				GROUNDATTACKS = COMMON[222],
				BALLGROUNDATTACKS = COMMON[223],
				PROPATTACKS = {
					FLOWERSTOMP = none,
					GROUNDKICK = none,
				},
			},
			STRIKES = {
				RUNNINGATTACKS = COMMON[224],
				LIGHTATTACKS = {
					CHECK_DESELECT = none,
					EXECUTEBANK = COMMON[225],
					LEFT1 = {
						RELEASE = COMMON[226],
						RIGHT2 = {
							RELEASE = COMMON[227],
							LEFT3 = {
								RELEASE = COMMON[228],
								RIGHT4 = {
									RELEASE = COMMON[229],
									LEFT5 = COMMON[230],
								},
							},
						},
					},
				},
			},
		},
		DEFAULT = {
			LOCOMOTION = COMMON[231],
			DEFAULT = none,
			FULLBODYACTIONOPPS = none,
		},
		JUMPACTIONS = COMMON[232],
	},
	["6_02GDORM"] = {
		ANIMS = {
			NORTONSWING = {
				INITIALIZE = {
					ATTACK_PILLAR_IN = {
						ATTACK_PILLAR_OUT = {
							ATTACK_PILLAR_WAIT = none,
						},
					},
				},
			},
			EMPTY = none,
			SPRAY = {
				SPRAY_A = {
					SPRAY_B = none,
				},
				SPRAY_BIG_1 = none,
			},
		},
	},
	["2_S04"] = {
		ANIM = {
			MELVINCHEERS = {
				CHEER1 = COMMON[233],
			},
			ATTACHMARBLES = {
				MARBLETHROW = none,
			},
			NERDCHEER = {
				CHEER2 = none,
				CHEER1 = none,
				OPTBACK = none,
			},
			NERDTEASED = {
				TEASED = none,
				ENDTEASED = COMMON[95],
			},
			MELVINSOCIAL = {
				MISSINGSHEETS = {
					REJECT = none,
				},
				HASALLSHEETS = {
					RECEIVEGIFT = {
						ACCEPT = {
							CHEER1 = {
								CHEER2 = {
									CHEER3 = {
										CHEER4 = none,
									},
								},
							},
						},
					},
				},
				GIVEMONEY = none,
			},
			HIDING = COMMON[234],
			OLD_BULLYWALL_SMOKE = {
				WALL_START = {
					WALL_IDLE = {
						WALL_SMOKE_START = COMMON[110],
						WALL_SMOKE_OPPS = none,
					},
				},
				WALKTOWALL = none,
				ENDSMOKE = COMMON[95],
			},
			LAUGH = none,
			ROCHAMBEAUNIS = {
				TRENTRULES = none,
				TRENTGREET = none,
				JIMMYTHATSTUPID = none,
				TROYATTACKS = none,
				JIMMYLINE1 = none,
			},
			ROCHAMBEAU = COMMON[236],
			BULLYWALL_SMOKE = COMMON[237],
			BULLYTAUNT = none,
			PLAYERGIVE = none,
			BULLYNERDTEASE = {
				ENDTEASE = COMMON[95],
				TEASE = none,
			},
		},
		HUD = {
			STRUGGLEON = none,
			STRUGGLEOFF = none,
			RGETUPON = none,
		},
		CONV = {
			ROCHAMBEAUNIS = {
				PED0_IDLE = none,
				LOADANIMS = none,
				PLAYER = {
					TRENTL1 = {
						TRENTRULES = {
							PLAYERTHATSTUPID = COMMON[95],
						},
					},
				},
				PED1_IDLE = COMMON[238],
				CONVINITIATE = none,
			},
		},
	},
	NORTONAI = {
		COMBAT = COMMON[239],
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[145],
		COMBATACTIONS = {
			CONTROLNODE = none,
			COMBATACTIONS = {
				TIRED = COMMON[17],
				EVADE = COMMON[1],
				GROUNDATTACK = COMMON[148],
				OFFENSE = {
					MELEEACTIONS = {
						SHORT = COMMON[107],
					},
				},
				TAUNT = COMMON[149],
				COUNTERATTACK = COMMON[101],
				POSTHIT = {
					INCAPACITATED = COMMON[241],
					GRAPPLED = COMMON[242],
				},
				PROPSMASH = COMMON[185],
			},
		},
		AMBIENT = COMMON[102],
	},
	TAD = COMMON[243],
	TE_SECRETARY = {
		DEFENSE = COMMON[244],
		OFFENSE = {
			SHORT = {
				GRAPPLES = {
					GIVE = none,
					GRAPPLEATTEMPT = none,
				},
				HEAVYATTACKS = COMMON[236],
			},
		},
		EXECUTES = {
			DEATH = {
				KILLPLAYER = none,
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = {
					RUNBASIC = COMMON[187],
					IDLE_OVERRIDES = {
						CONTROLLER_NODE = {
							ACTIONS = {
								GENERIC = COMMON[246],
								FACTION_SPECIFIC = COMMON[247],
								NOOVERRIDE = none,
							},
						},
					},
					SPRINTBASIC = none,
					WALKBASIC = {
						WALKBASIC = none,
						FEMALE_WALKOVERRIDES = {
							CONTROLLER_NODE = {
								ACTIONS = {
									GENERIC = COMMON[248],
									FACTION_SPECIFIC = {
										FACTION_IDLE2 = none,
										SKIPPING = {
											BITCH = none,
										},
										FACTION_IDLE1 = none,
									},
									NOOVERRIDE = none,
								},
							},
						},
					},
				},
				LOCOMOTIONOVERRIDE = COMMON[82],
				CUSTOMACTIONOPS = COMMON[27],
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
	},
	VEHICLES = {
		BIKES = {
			FRONTMANUAL = {
				TRICKS = {
					FRONTMANUALEND = none,
					WHIPLASH = none,
				},
				DISMOUNT = COMMON[249],
				END = COMMON[250],
			},
			EXECUTENODES = {
				FALLOFFBASE = COMMON[251],
				REFJOINTDRIVERS = COMMON[252],
				SOUND = {
					AIR = none,
				},
				ATTACKS = {
					BAT = COMMON[253],
					GRAPTHORWLEFT = COMMON[254],
					BIKEJACKING = {
						RIGHT = COMMON[255],
						SHOVE = none,
						LEFT = COMMON[255],
					},
					PUNCH = {
						PUNCHLEFTREL = none,
						PUNCHRIGHTREL = none,
						PUNCHRIGHTEXT = none,
						PUNCHLEFTEXT = none,
					},
					LEADPIPE = COMMON[253],
					GRAPTHORW = COMMON[254],
				},
				SPRINT = none,
				HOLDBARS = {
					HOLDBARSBIKE = none,
					HOLDBARSSCOOTER = none,
				},
				HOLDWEAPONHACK = none,
			},
			BACKMANUAL = {
				TRICKS = {
					BACKMANUALEND = none,
					BMAN_BARSPIN_ATTACK = {
						BMAN_BARSPIN_CYCLE = none,
					},
				},
				DISMOUNT = COMMON[249],
				END = COMMON[250],
			},
			MOVETOVEHICLE = {
				ATBIKERHS = {
					NOTUPRIGHT = {
						PULLUPBIKE = {
							PULLUPBIKERIGHT = none,
						},
						PICKUPBIKE = {
							PICKUPBIKERIGHT = none,
						},
					},
					ATBIKERHS_FAILED = none,
					BIKEUPRIGHT = {
						JACKINGIT = COMMON[259],
						WEAPONCHECK = COMMON[260],
						GETINVEHICLE = {
							BASE = COMMON[261],
							RIGHTHANDSIDE = none,
						},
					},
				},
				ATBIKELHS = {
					NOTUPRIGHT = {
						PULLUPBIKE = {
							PULLUPBIKELEFT = none,
						},
						PICKUPBIKE = {
							PICKUPBIKELEFT = none,
						},
					},
					BIKEUPRIGHT = {
						JACKINGIT = COMMON[262],
						WEAPONCHECK = COMMON[260],
						GETINVEHICLE = {
							BASE = COMMON[261],
							LEFTHANDSIDE = none,
						},
					},
					ATBIKELHS_FAILED = none,
				},
				MOVETOVEHICLELHS = COMMON[264],
				MOVETOVEHICLERHS = COMMON[264],
				JACKBIKELHS = COMMON[262],
				JACKBIKERHS = COMMON[259],
			},
			VEHICLES_RIDE = {
				RIDE = {
					TURN = {
						TURNLEFT = none,
						TURNRIGHT = none,
						POWERSLIDETURN = COMMON[267],
					},
					COAST = {
						SEATED = {
							HIGHSEAT = COMMON[268],
							LOWSEAT = COMMON[268],
						},
						STANDCOAST = none,
					},
					NONCOAST = {
						LINEAR = {
							SPRINT = none,
							PEDAL = {
								REGULAR = COMMON[269],
								BOOST = {
									BOOST = none,
								},
							},
							WALKBACK = COMMON[269],
						},
						STAND = {
							HIGHSEAT = {
								STANDTURN = COMMON[270],
								CELEBRATIONS = COMMON[271],
								AMBIENTEXECUTE = {
									AMBIENT = {
										WAIT = none,
										AMBIENT_IDLE_2 = none,
										AMBIENT_IDLE_1 = none,
									},
								},
							},
							STANDOPS = {
								HALT = none,
							},
							LOWSEAT = {
								CELEBRATIONS = COMMON[271],
								STANDTURN = COMMON[270],
								AMBIENTEXECUTE = {
									AMBIENT = {
										AMBIENT_IDLE_3 = none,
										AMBIENT_IDLE_1 = none,
										WAIT = none,
										AMBIENT_IDLE_2 = none,
										AMBIENT_IDLE_4 = none,
									},
								},
								ONMARK = COMMON[273],
							},
						},
						BREAK = none,
					},
					["2.07"] = {
						JUSTINCHEERS = {
							CHEER = none,
							RIDECHEER = none,
						},
					},
				},
				AIR = {
					FLOAT = none,
					POSTTRICKFLOAT = none,
					POSTLANDFLOAT = none,
				},
				NOTONBIKE = COMMON[274],
			},
			HIT = {
				FALLOFF = {
					CHECKFRONTHITCOLLISION = COMMON[275],
					HITHARDLEFT = none,
					CHECKBACKHITCOLLISION = COMMON[276],
					HITHARDRIGHT = none,
					HITHEADUPSIDEDOWN = {
						HITHEAD = {
							FALLOFFBASE = COMMON[251],
						},
					},
				},
				DAMAGEHANDLE = {
					DAMAGECALL = none,
					DAMAGEEXECUTES = {
						JOHNNYVDAMAGE = none,
						STANDARDDAMAGE = none,
						PROJECTILEDAMAGE = none,
					},
				},
				RIDEON = {
					STINKBOMBFALSE = {
						STINKBOMB = {
							HITFRONT = none,
							STINKSPEECH = COMMON[277],
							STINKYLOCOHIGH = none,
							STINKYLOCOLOW = none,
						},
					},
					EGG = COMMON[278],
					IMPACT = COMMON[279],
				},
				AIR = COMMON[280],
				FALLOFFNOCLEARANCE = COMMON[281],
			},
			GROUND = {
				CROUCH = {
					SPEEDCROUCHHIGH = COMMON[282],
					HOP = {
						HIGHHOP = {
							HIGHHOPSPEECH = COMMON[283],
							BUNNYHOP_LAND = none,
						},
						MEDIUMHOP = COMMON[284],
						LOWHOP = COMMON[285],
					},
					SPEEDCROUCH = COMMON[282],
				},
				MANUAL = {
					INTOBACKMANUAL = {
						STARTBACKMANUAL = {
							DOBACKMANUAL = {
								PEDDLE = none,
							},
							INPUTCHECK = none,
						},
					},
					INTOFRONTMANUAL = {
						DOFRONTMANUAL = {
							INPUTCHECK = none,
							DOFRONTMANUAL_CHILD = {
								BALANCE = none,
								MANUALNUDGE = none,
							},
						},
					},
				},
				ATTACKS = {
					BAT = {
						PUNCHRIGHT = {
							SWINGRIGHTEXEC = none,
						},
						PUNCHLEFT = {
							SWINGLEFTEXEC = none,
						},
						EXECUTENODES = COMMON[286],
					},
					NEWSPAPER = {
						R1 = {
							THROWRIGHT = {
								WEAPONFIRE = {
									FAIL = none,
									TARGET = none,
								},
							},
							THROWLEFT = {
								WEAPONFIRE = {
									TARGET = none,
								},
							},
						},
					},
					PUNCH = {
						PUNCHRIGHT = COMMON[287],
						PUNCHLEFT = COMMON[287],
						EXECUTENODES = COMMON[286],
					},
					THROW = {
						THROW_SPAWN = {
							THROW = {
								SETCHARGE = COMMON[290],
								FIRE = {
									DROPBOMB = none,
									DIRECTIONALFIRE = COMMON[291],
									RELEASE = {
										ANIM = COMMON[292],
										DETACHWEAPON = none,
									},
								},
							},
						},
						THROW = none,
						GETFOCUS = none,
						THROWOPS = {
							WEAPONFX = {
								CHERRYB = none,
							},
						},
					},
					ATTACKOPS = {
						SOUND = none,
					},
				},
				DISMOUNT = COMMON[293],
				EVADE = {
					BLOCKPROJECTILESBIKE = none,
				},
				WEAPONSELECTSPAWN = {
					ACTIONS = {
						PUTAWAY = none,
						WEAPONCHECK = {
							PUTAWAY = none,
							DROPNONINV = COMMON[263],
						},
						SELECT = {
							PUTAWAY = COMMON[294],
							GET = COMMON[294],
							DROPNONINV = {
								DROPACTIONS = {
									DROPDIRECT = none,
								},
							},
						},
						OTHER = none,
					},
					FOCUSWEAPON = none,
				},
			},
			SCRIPTCALLS = {
				["3B_JOHNNYVINCENT"] = {
					MAGNETIZED = {
						ONBIKE = none,
						STANDUP = COMMON[295],
						ONFOOT = none,
					},
				},
				RACEVICTORY = none,
				["3_02_BAIT"] = {
					GORD = none,
					JOHNNY = COMMON[296],
				},
			},
			TEST = {
				ANIMLOAD = none,
				JV_MAGNATIZED = COMMON[295],
				CYCLE = none,
			},
			AIR = {
				THROW = {
					OTHER = {
						THROWRIGHT = none,
						THROWLEFT = none,
					},
					NEWSPAPER = {
						NPTHROWLEFT = none,
						NPTHROWRIGHT = none,
						THROWNEWSPAPER_2PART = {
							DIRECTION = {
								RIGHT = none,
								BEHIND = none,
								LEFT = none,
							},
						},
					},
				},
				CROUCH = {
					SPEEDCROUCHHIGH = none,
					HOP = {
						HIGHHOP = COMMON[284],
						MEDIUMHOP = COMMON[284],
						LOWHOP = COMMON[285],
					},
					SPEEDCROUCH = none,
				},
			},
			SPAWNBANK = {
				INCREASECOMBO = {
					AVERAGE = COMMON[297],
					MANUALBONUS = COMMON[297],
					HARD = COMMON[297],
					EASY = COMMON[297],
					INSANE = COMMON[297],
				},
			},
		},
		FPPASSENGER = {
			FPPASSENGER3RDPERSONATREST = none,
			FPPASSENGERGETON = none,
			FPPASSENGER3RDPERSON = none,
			CLEAROBJECTIVE = none,
		},
		CARS = {
			VEHICLES_CARRIDE = {
				RIDE = {
					TRUCK = COMMON[299],
					SUV = COMMON[299],
					MOWER = COMMON[302],
					["GO-KART"] = COMMON[302],
					SEDAN = COMMON[299],
					INCARTRGGER = {
						STOPGAS = {
							STOPGASSTOP = {
								STOPGASWAIT = {
									STOPGASDRIVE = none,
								},
							},
						},
					},
				},
			},
			EXECUTENODES = {
				GOKARTFAILURE = {
					FAILURE = none,
				},
				GRAPTHORWLEFT = COMMON[305],
				GOKARTVICTORY = COMMON[306],
				GRAPTHORW = COMMON[305],
			},
			CARGROUND = {
				DISMOUNT = {
					COMETOSTOP = none,
					GETOFF = {
						["GO-KART"] = {
							PASSENGER = none,
							DRIVER = COMMON[307],
						},
						ARCADERACECAR = none,
						BASE = {
							GETOFF = none,
						},
						MOWER = {
							DRIVER = COMMON[307],
						},
						TRUCK = COMMON[308],
						SEDAN = COMMON[308],
						SUV = COMMON[308],
					},
					TRYTOGETOUT = none,
				},
			},
			MOVETOVEHICLE = {
				MOVETOVEHICLERHS = COMMON[310],
				ATCAR = {
					GETINVEHICLE = {
						CHECK_DESELECT = none,
						BASE = {
							GETONASPASSENGER = none,
							GETONASDRIVER = none,
						},
						RIGHTHANDSIDE = COMMON[311],
						LEFTHANDSIDE = COMMON[311],
					},
				},
				MOVETOVEHICLELHS = COMMON[310],
			},
			HITS = {
				MOWER = {
					RIDEON = {
						IMPACT = COMMON[279],
					},
					ONMOWER = {
						DAMAGEHANDLES = {
							PLAYER = none,
							DEFAULT = none,
						},
						BASE = none,
					},
				},
				GOKART = {
					HITRIGHT = none,
					HITLEFT = none,
					DEAD = {
						DEAD = none,
					},
					HITBASE = {
						HITBASE = {
							DAMAGEHANDLE = {
								DEFAULT = none,
								PLAYERPROJECTILES = none,
							},
						},
					},
					HITFRONTBACK = none,
				},
			},
		},
		SCOOTER = {
			VEHICLES_RIDE = {
				SCOOTERPUNISH = {
					SCOOTERPUNISHSTIM = none,
				},
				RIDE = COMMON[315],
				AIR = {
					FLOAT = none,
					AIROPPS = COMMON[249],
				},
				NOTONBIKE = COMMON[274],
			},
			HIT = {
				FALLOFF = {
					CHECKFRONTHITCOLLISION = COMMON[275],
					CHECKBACKHITCOLLISION = COMMON[276],
					HITHARDRIGHT = none,
					HITHARDLEFT = none,
				},
				RIDEON = {
					STINKBOMB = COMMON[316],
					IMPACT = COMMON[279],
				},
				AIR = COMMON[280],
				FALLOFFNOCLEARANCE = COMMON[281],
			},
			EXECUTENODES = {
				ATTACKS = {
					PUNCHRIGHTEXEC = none,
					PUNCHLEFTEXEC = none,
					GRAPTHORWLEFT = COMMON[319],
					GRAPTHORW = COMMON[319],
				},
				PUNCHTRANSITIONOUT = COMMON[289],
			},
			HITSAVED = {
				HITINTHEAIR = COMMON[317],
				DOGBITE = none,
				HITFRONT = COMMON[317],
			},
			GROUND = {
				ATTACKS = {
					THROW = {
						GETREADY = {
							FIRE = {
								DROPBOMB = none,
								DIRECTIONALFIRE = COMMON[291],
								RELEASE = {
									ANIM = COMMON[292],
									DETACHWEAPON = none,
									TURNOFFTARGET = {
										TURNOFFTARGET = none,
									},
								},
							},
						},
						THROWOPS = {
							WEAPONFIRE = {
								DEFAULT = none,
								CHERRYB = none,
							},
						},
						GETFOCUS = none,
					},
					PUNCH = {
						PUNCHLEFTCHARGE = {
							PUNCHLEFTCHARGEATTACK = {
								PUNCHLEFTCHARGEATTACKPARTIAL = COMMON[321],
								PUNCHLEFTCHARGEATTACKFULL = COMMON[321],
							},
						},
						PUNCHRIGHTCHARGE = {
							PUNCHRIGHTCHARGEATTACK = {
								PUNCHRIGHTCHARGEATTACKPARTIAL = COMMON[323],
								PUNCHRIGHTCHARGEATTACKFULL = COMMON[323],
							},
						},
					},
				},
				DISMOUNT = COMMON[293],
			},
			MOVETOVEHICLE = {
				MOVETOVEHICLELHS = COMMON[310],
				MOVETOVEHICLERHS = COMMON[310],
				JACKBIKELHS = COMMON[262],
				ATBIKE = {
					JACKINGIT = {
						BIKEJACKLEFT = none,
						BIKEJACKRIGHT = none,
					},
					PICKUPBIKE = COMMON[326],
					GETINVEHICLE = COMMON[327],
				},
				JACKBIKERHS = COMMON[259],
			},
		},
		MOTORCYCLE = {
			VEHICLES_RIDE = {
				RIDE = {
					JOINTDRIVERS = {
						JUSTRIGHT = none,
						BOTHARMS = none,
					},
					RIDE_SPAWN = none,
					RIDE_UBO = {
						NONE = none,
						CHASING = {
							CHASING_02 = none,
							CHASING_01 = none,
							CHASING_03 = none,
						},
					},
					RIDE = COMMON[315],
					ACTIONOPPS = {
						ACTIONOPPS_MOTORBIKE = none,
					},
				},
			},
			HIT = {
				RIDEON = {
					HITRIGHT = none,
					HITFRONT = none,
					HITLEFT = none,
					HITBACK = none,
				},
			},
			EXECUTENODES = {
				ATTACKS = none,
			},
			MOVETOVEHICLE = {
				ATBIKE = {
					JACKINGIT = {
						BIKEJACKLEFT = {
							BIKEJACKLEFTRCV = none,
						},
						BIKEJACKRIGHT = {
							BIKEJACKRIGHTRCV = none,
						},
					},
					PICKUPBIKE = COMMON[326],
					GETINVEHICLE = COMMON[327],
				},
				MOVETOVEHICLERHS = COMMON[329],
				MOVETOVEHICLELHS = COMMON[329],
			},
			GROUND = {
				ATTACKS = none,
				DISMOUNT = {
					GETOFF = {
						GETOFFVEHICLESTILL_SLOWDOWN = COMMON[331],
					},
				},
			},
		},
		SKATEBOARD = {
			LOCOMOTION = {
				HANDLEDOORS = COMMON[332],
				WAIT = none,
				KICKBALLSPAWN = COMMON[333],
				GETOFF = {
					GETOFFGOOFY = {
						BAILOUTGOOFY = none,
					},
					POSTGETOFF = {
						SPRINT = none,
						IDLE = none,
						SWIMMING = none,
					},
					GETOFF = {
						BAILOUT = none,
					},
					GETOFF_ATTACK = {
						PUNCH = none,
						SHOULDERCHARGE = none,
					},
				},
				RIDE = {
					BRAKE = {
						BRAKEENDRELEASE = none,
						BRAKEEND = {
							BRAKEEND_PUMPGOOFY = {
								BRAKEEND_PUMPGOOFY2 = none,
							},
							BRAKEEND_PUMPGOOFYALT = {
								BRAKEEND_PUMPGOOFYALT2 = none,
							},
						},
					},
					PUMP = {
						PUMP2 = none,
					},
					ANCHOREDTOVEHICLE = none,
					COAST = {
						LOCOMOTIONS = {
							MOVING = none,
							STILLGOOFY = COMMON[334],
							STILL = COMMON[334],
						},
					},
					CHARGEJUMP = {
						LANDINGGOOFY = none,
						RAIL = none,
						AIRGRABGOOFY = {
							AIRGRABRELEASEGOOFY = none,
						},
						AIRGRAB = {
							AIRGRABRELEASE = none,
						},
						ALISPEECH = COMMON[283],
						ALIHIGH = none,
						ALIGOOFY = none,
						LANDING = none,
						ALIHIGHGOOFY = none,
						ALI = none,
					},
					POWERSLIDE = none,
					BRAKEGOOFY = {
						BRAKEGOOFYENDRELEASE = none,
						BRAKEGOOFYEND = {
							BRAKEEND_PUMPALT = {
								BRAKEEND_PUMPALT2 = none,
							},
							BRAKEEND_PUMP = {
								BRAKEEND_PUMP2 = none,
							},
						},
					},
					PUMPGOOFY = {
						PUMPGOOFY2 = none,
					},
					HITSTAIRS = {
						HITSTAIRS = COMMON[336],
						HITSTAIRSGOOFY = COMMON[336],
					},
				},
				BOARDINHAND = {
					GETON = COMMON[338],
					IDLE = {
						DASH = COMMON[338],
						EXITSKATEBOARD = none,
						IDLE = {
							TIRED_UPPERBODY = none,
						},
						EXITSKATEBOARDCOMBAT = none,
						EXITSKATEBOARDJUMP = none,
					},
					RUNLOCO = none,
				},
			},
		},
	},
	HITTREE = {
		STANDING = {
			BASE = {
				HITBASESTANDING = none,
				HITBASESTANDINGPROJECTILE = {
					LOCOSPAWN = none,
				},
				HITBASEBELLYUPPROJECTILE = none,
				HITBASEBELLYUP_WALL_HIT = none,
				HITBASE = {
					DETACHCHERRYB = none,
					SOCKETRESET = none,
				},
				DROPWEAPONEASY = {
					DROPWEAPONGLOBAL = none,
				},
				HITBASESTANDING_WALL_HIT = none,
				HITBASEBELLYDOWN_WALL_HIT = none,
				WEAPON_OVERRIDES = {
					RIGHTHAND = none,
					ONSKATEBOARD = {
						ONSKATEBOARD = none,
					},
					BALL = none,
					WTRAY = none,
					SLINGSHOT = none,
					MELEE = none,
					GUN = none,
				},
				HITBASEBELLYDOWN = none,
				HITBASEBELLYUP = none,
				HITBASEPROJECTILE = {
					DAMAGEHANDLE = {
						ISPLAYER = none,
						DEFAULT = none,
						BOOM_HEADSHOT = {
							DEFAULT = none,
							SLINGSHOT = none,
						},
					},
				},
				DROPWEAPON = {
					UBO_EXECUTE = none,
					DROPWEAPONGLOBAL = none,
				},
				HITBASEBELLYDOWNPROJECTILE = none,
			},
			BLOCKHITS = COMMON[339],
			MELEE = {
				GENERIC = {
					STRAIGHT = {
						HEAVY1_CHARGED = COMMON[340],
						HEAVY1 = {
							FRONT = {
								SMALLCHAR = none,
								LARGECHAR = none,
							},
							REAR = none,
						},
						HEADHEAVY4 = COMMON[320],
						HEADHEAVY3 = COMMON[341],
						HEADHEAVY = COMMON[342],
						HEADHEAVY5 = COMMON[343],
						HEAVY2 = COMMON[340],
						HEADHEAVY2 = COMMON[320],
						HEAVYSTRAIGHT2 = {
							FRONT = {
								HITHEAVY2 = none,
							},
							REAR = none,
						},
						HEADCROSS = COMMON[345],
						HEADJAB = COMMON[345],
					},
					RIGHT = {
						HEADRIGHTSTUN = COMMON[343],
						HEADRIGHT = COMMON[342],
					},
					LEFT = {
						HEADHOOK = COMMON[347],
						HEADLEFT = COMMON[342],
					},
					BODY = {
						BODYSHOTUP = COMMON[342],
						BODYSHOTDOWN = COMMON[347],
						BODYSHOTRIB3 = COMMON[320],
						BODYSHOTRIB1 = COMMON[347],
						BODYSHOTRIB2 = COMMON[320],
					},
					FLOAT = {
						FHUPPERCUT = COMMON[348],
						HEADUPPERCUT = COMMON[348],
						AXEHANDLE = COMMON[347],
						FHDOOR = COMMON[348],
					},
					WEAPONS = {
						HEADWEAPONHARD = COMMON[341],
						HEADWEAPONLIGHT = COMMON[347],
						HEADWEAPONNORMAL = COMMON[347],
					},
					KNOCKDOWN = {
						HEAD_FALL = COMMON[341],
						HVYLEFTFALL = COMMON[320],
						KNOCKDOWN = {
							FRONT = {
								LIGHTCHARACTER = none,
								HEAVYCHARACTER = COMMON[320],
							},
							REAR = none,
						},
						FRONTKNOCKDOWNHARD = COMMON[342],
						KD_FALL = COMMON[320],
					},
					STUNNED = {
						HEADSTUN = {
							STUN = {
								STUNCYCLE = {
									STUNNED = {
										STUNEXIT = none,
										PLAYERSTRUGGLE = none,
									},
								},
								FRONT = none,
								REAR = none,
							},
							STUNFAIL = COMMON[347],
						},
						STUMBLE = COMMON[347],
						BODYSTUN = {
							STUN = {
								STUNCYCLE = {
									STUNNED = {
										PLAYERSTRUGGLE = none,
									},
								},
								FRONT = none,
								REAR = none,
							},
							STUNFAIL = COMMON[347],
						},
					},
					LEG = {
						TRIPHARASS = {
							DEFAULT = none,
							FALLDOWN = COMMON[351],
						},
						LEG_FRONT_L_FALL = {
							FRONT = {
								FRONT = COMMON[352],
							},
							REAR = none,
						},
						LEG_FRONT_L_HARD = COMMON[342],
						LEG_FRONT_L = COMMON[351],
					},
				},
				BOXING = {
					BOXJAB = COMMON[347],
					BOXCROSS = COMMON[347],
					BOXRSPECIAL = COMMON[347],
					BOXLEFTHOOK = COMMON[347],
					GUT = COMMON[347],
					BOXRIGHTHOOK = COMMON[347],
					BOXLSPECIAL = COMMON[347],
				},
				KNOCKDOWNOVERRIDE = {
					HEADROLLR = COMMON[347],
					HEADUPPERCUT = COMMON[347],
					RUNATTACKH = COMMON[347],
					LEG_FRONT_L_FALL = COMMON[347],
				},
				DEFAULT = {
					DEFAULT = none,
					FRONT = none,
					REAR = none,
				},
				UNIQUE = {
					JKICK = COMMON[341],
					SHOVE = {
						GIRL = {
							SHOVED_D = COMMON[353],
							SHOVED_A = COMMON[353],
							SHOVED_S = COMMON[353],
							SHOVED_F = COMMON[353],
						},
						AUTHORITY = {
							SHOVED_A = COMMON[353],
							SHOVED_U = COMMON[353],
							SHOVED_F = COMMON[353],
						},
						SHOVE_SFX = {
							SHOVE_SFX_CHILD = none,
						},
						GENERIC = COMMON[354],
						DEFAULT = COMMON[355],
						NERD = COMMON[354],
						BULLY = {
							SHOVED_S = COMMON[353],
							SHOVED_U = COMMON[353],
							SHOVED_A = COMMON[353],
							SHOVED_F = COMMON[353],
						},
					},
					RUNATTACKH = COMMON[356],
					BELLHIT = {
						BELLHIT = none,
					},
					HAMMERSWING = COMMON[347],
					TANDEMHIT = {
						TANDEMHIT = none,
					},
					DOGBITE = COMMON[347],
					CARRUNOVER = COMMON[320],
					RUNATTACKL = {
						DEFAULT = COMMON[347],
						SMALL = COMMON[347],
					},
					DAMAGEFROMBURNINGFIRE = {
						SK8BOARD = none,
						WEAPON_LEFT = none,
						DEFAULT = none,
						WEAPON_RIGHT = none,
					},
					FRIENDLYHIT = COMMON[356],
					NULL = none,
					BIKERUNOVER = COMMON[320],
					MASCOTHEADBUTT = COMMON[347],
					SACKED = {
						ON_GROUND = none,
						FRONT = COMMON[352],
						REAR = none,
					},
					SLIGHTBUMP = {
						DEFAULT = COMMON[355],
					},
					HEADROLLR = COMMON[347],
					ROCHAMBEAU = {
						KICKEDFRONT = {
							SACKEDOUT = {
								PARAMETRICSTRUGGLE = {
									STRUGGLEPASS = none,
									STRUGGLEFAILONGROUND = {
										FAILONGROUND = {
											GETUPEND = none,
										},
									},
								},
							},
						},
					},
					NERDFLAIL = COMMON[347],
					SPRAYCAN = {
						DEFAULT = {
							BLINDEDCYCLE = COMMON[283],
						},
					},
				},
			},
			POSTHIT = {
				STANDING = {
					DEAD = {
						COLLAPSE = {
							COLLAPSE_B = COMMON[352],
							COLLAPSE_A = COMMON[352],
						},
						BOXINGSTUN = {
							STUNCONTROL = {
								STUN = {
									HIT = {
										NORMALHIT = none,
									},
								},
								KNOCKOUTHIT = {
									KNOCKOUTHIT = none,
								},
								RECOVER = none,
							},
						},
					},
				},
				BELLYUP = {
					ON_GROUND = none,
					ONGROUNDBOUNCE = {
						BOUNCELEGSUP_L = none,
						CAMGROUNDSHAKE = none,
						BOUNCELEGSUP_S = none,
						BOUNCESMALL = none,
						BOUNCELEGSUP = none,
					},
					BELLYUPGETUP = {
						BELLYUPGETUPGETUP = none,
						BELLYUPGETUPTURN180 = none,
					},
					DEAD = {
						KOREACTIONS = {
							GENERIC = none,
							LEFTLEG = none,
							RIGHTLEG = none,
							FACE = none,
							GROIN = none,
							MID = none,
						},
					},
				},
				BREAKFALL = {
					BELLYUP = COMMON[357],
					BELLYDOWN = COMMON[357],
				},
				BELLYDOWN = {
					ON_GROUND = none,
					BELLYDOWNGETUP = {
						BELLYDOWNGETUP = none,
						BELLYDOWNGETUPTURN180 = none,
					},
					DEAD = {
						KOREACTIONS = {
							DEATH = none,
							WRITHE = none,
						},
					},
					ONGROUNDBOUNCE = {
						BACKBOUNCESMALL = none,
						CAMGROUNDSHAKE = none,
						BACKBOUNCEFLOAT = none,
						BACKBOUNCESMALLNOFX = none,
					},
				},
				SITONWALL = {
					GETUP = COMMON[357],
					DOWNONGROUND = {
						SIT = none,
						DEAD = none,
					},
				},
			},
			RANGED = {
				DEFAULTPROJECTILE = {
					LEGS = {
						RIGHT = COMMON[358],
						LEFT = COMMON[358],
					},
					HEAD = {
						FRONT = {
							MEDIUM = none,
							SNOWBALL = none,
							DEFAULT = none,
							EGG = none,
							KNOCKDOWN = none,
						},
						REAR = {
							DEFAULT_LEFT = none,
							MEDIUM = none,
							SNOWBALL = none,
							RIGHT = none,
							KNOCKDOWN = none,
							EGG = none,
						},
					},
					TORSO = {
						FRONT = {
							SLINGSHOT_CHARGED = none,
							MEDIUM = none,
							SPUD = none,
							DEFAULT = none,
						},
						REAR = {
							SLINGSHOT_CHARGED = none,
							MEDIUM = none,
							SPUD = none,
							RIGHT = none,
							LEFT_DEFAULT = none,
						},
					},
					NADS_ASS = {
						FRONT = COMMON[359],
						REAR = COMMON[359],
					},
				},
				RBANDBALL = {
					FRONT = COMMON[360],
					REAR = COMMON[360],
				},
				ITCHINGPOWDER = {
					NOTABLETOBEITCHED = none,
					DEFAULT = {
						ITCHCYCLE = {
							ITCHCYCLESPAWN = none,
						},
					},
				},
				PVASE_PROJ = {
					VASEFRONT = none,
					VASEREAR = none,
				},
				BOMB = {
					FOUNTAIN = {
						DAZE = {
							STUNNED = none,
						},
						KNOCKDOWN2 = none,
						KNOCKDOWN = none,
						KNOCKDOWN3 = COMMON[213],
					},
					CHERRY = none,
					STINK_TRAP = none,
					BOTTLEROCKET = {
						STANDING = {
							POSTHIT = {
								POSTHITSTUN = none,
								UPPERBODY = {
									BANGSTND_TAP = none,
									BANGSTND_STUN = none,
									BANGSTND_DEAF = none,
								},
							},
						},
						CROUCHING = {
							POSTHIT = {
								POSTHITSTUN = {
									CROUCHEND = none,
								},
								UPPERBODY = {
									FLASHBANG_DEAF = none,
									BANGCRCH_LOOK = none,
									BANGCRCH_DEAF = none,
								},
							},
						},
					},
					STINKY = {
						STINKY = {
							STINKYSTAT = none,
							STINKSPEECH = COMMON[277],
						},
						STINKYLOCO = {
							RESETFPCAM = none,
							RUNCOLLISION = {
								ON = none,
								OFF = none,
							},
						},
					},
				},
				HOTSTEAM = COMMON[348],
				DODGEBALL = {
					DODGEBALL = none,
				},
				MARBLES = {
					HIT_LEG_FRONT_R_FALL = none,
					HIT_LEG_FRONT_L_FALL = {
						MARBLESSTAT = none,
					},
				},
				FIRE_EXTINGUISHER = {
					FIREEXTING = {
						RESETFPCAM = none,
					},
				},
				BANANAPEEL = {
					SLIPFALL_1 = none,
				},
			},
			WALLHITS = {
				FRONT = COMMON[361],
				BREAKFALL = COMMON[347],
				SKATEBOARDWALLHIT = {
					GOOFY = {
						FRONT = {
							TOHITSTAIRS = none,
							SPLAT = {
								DEFAULT = none,
								KNOCKDOWN = COMMON[357],
							},
						},
					},
					REGULAR = {
						FRONT = {
							TOHITSTAIRS = none,
							SPLAT = {
								DEFAULT = none,
								KNOCKDOWN = none,
							},
						},
					},
				},
				REAR = COMMON[362],
			},
		},
		SFX = {
			LIGHTHITS = COMMON[214],
			SCRPAINREATION = COMMON[363],
			HEAVYHITS = {
				FEMALE = none,
				MALE = none,
				FUNHOUSE = none,
			},
			KNOCKOUTS = COMMON[214],
			PAINREATION = COMMON[363],
		},
		SWIMMINGHITS = {
			SWIMMING = {
				HITRIGHT = none,
				EXECUTENODES = {
					LOCALTREADWATER = none,
				},
				HITLEFT = none,
				STINKY = COMMON[316],
				DEAD = {
					SINK = {
						DROWN = none,
					},
				},
			},
		},
		BASE = {
			DEADCLEANUP = {
				DEADTEXT = none,
				DEADSPEECH = {
					DEADSPEECHEXEC = none,
				},
			},
			HITTREEBASE = {
				RAT = COMMON[364],
				DEFAULT = {
					SWIMMING = none,
					FIREEXTINGUISHER = {
						GRAPPLEIMMUNITY = none,
						IMMUNE = none,
						HIT = none,
					},
					DEFAULT = none,
					MOUNT = {
						GIVE = none,
						RCV = none,
						FILTER = none,
					},
					ITCHVIRUS = none,
					ON_GROUND = {
						ON_GROUND = none,
						FILTER = none,
					},
					TANDEMGRAPPLE_ACTIVE = none,
					MARBLES = {
						IMMUNE = none,
						HIT = none,
						FILTER = none,
					},
					SITONWALL = none,
					BALANCEBEAM = none,
					UNINTERRUPTIBLE = {
						UNINTERRUPTABLE = {
							UNINTERRUPABLE_HITS = {
								HIT = COMMON[365],
							},
						},
						FILTER = none,
					},
				},
				VEHICLE = {
					ONBIKE = {
						ONBIKE = none,
						STINKBOMB = COMMON[366],
						FALLOFFFILTER = none,
					},
					INCAR = none,
					ONSCOOTER = {
						STINKBOMB = COMMON[366],
						ONSCOOTER = none,
					},
				},
				DOG = COMMON[364],
			},
		},
		HITTREE_TEST = {
			HITREACT_REAR = none,
			HITREACT_FRONT = none,
		},
		HITLOCO = {
			NOHITLOCO = none,
			LOCO = {
				HITLOCO = none,
				HITSTRAFE = none,
			},
		},
		GROUNDANDWALLHITS = {
			ON_GROUND = {
				BELLYUP = {
					ROLLAWAY = none,
					DEFAULT = none,
					GROUNDHITHEAVY = {
						GROUNDHITHEAVY = none,
					},
				},
				BACKGROUNDHIT = {
					ROLLAWAY = none,
					BACKGROUNDHIT = none,
				},
			},
			SITONWALL = {
				DEFAULT = {
					ONGROUND = none,
				},
			},
		},
		HUMILIATED = {
			SKIP_TEST = COMMON[367],
		},
		KNOCKOUTS = {
			STUMBLE = none,
			EXECUTENODES = {
				FORCEFEEDBACK = {
					LIGHTATTACKS = none,
					HEAVYATTACKS = none,
					MEDIUMATTACKS = none,
				},
				KOBASE = {
					RELEASETARGET = none,
				},
			},
			BOXINGSPECIALKO = {
				BOXINGSPEICALKO = {
					KNOCKOUTDIFFICULTY = {
						MEDIUM = none,
						IMPOSSIBLE = none,
						HARD = none,
						EASY = none,
					},
					KNOCKOUT = {
						KNOCKOUTDEAD = none,
						KNOCKOUTRECOVER = none,
					},
				},
			},
			REAR = COMMON[346],
			ON_GROUND = COMMON[368],
			PROJECTILE = {
				LEGS = {
					RIGHT = {
						HIT_LEG_FRONT_R_FALL = none,
					},
					LEFT = {
						HIT_LEG_FRONT_L_FALL = none,
					},
				},
				CHEST = {
					BACK = {
						SPUDGUN = none,
						HIT_BACK_FALL_HARD = none,
					},
					FRONT = {
						FINISH_GUT = {
							DOWNONGROUND = none,
						},
						SPUDGUN = none,
					},
				},
				NADS = {
					BACK = {
						HIT_BACK_FALL_NORMAL = none,
					},
					FRONT = {
						GROIN_KICK_VIC = none,
					},
				},
				HEAD = {
					BACK = {
						HIT_HEAD_WEAPON_HARD = none,
					},
					FRONT = {
						KO_COLLAPSE = none,
					},
				},
				EXECUTENODES = {
					COLLAPSE_HITS = COMMON[183],
				},
			},
			FRONT = {
				KD_KICK_HEAVY = none,
				KD_LEFT_HEAVY2 = none,
				LEG = COMMON[352],
				KO_COLLAPSE = COMMON[352],
				HIT_HEAD_WEAPON_HARD = none,
				FINISH_GUT = COMMON[352],
				EXECUTEBANK = {
					COLLAPSEHITS = {
						HIT = {
							HIT_OTHER = none,
							HIT_RIGHT = none,
							HIT_LEFT = none,
							HIT_HEAVY_1 = none,
						},
						NOHIT = none,
					},
				},
				KD_UPPERCUT = none,
				KD_LEFT_HEAVY = none,
				KD_DROP = none,
				KD_DROP_DEFAULT = none,
				KD_SPIN = COMMON[352],
			},
			ONBACKOFBIKE = none,
		},
	},
	C6 = {
		ANIMATIONS = {
			SUCCESS = none,
			CYCLECLEAR = none,
			TOOLS = {
				TORCH = {
					PUTDOWNTORCH = none,
					TORCHFAIL = none,
					PICKUPTORCH = COMMON[370],
				},
				RATCHETWHEEL = {
					PUTDOWNRATCHET = none,
					RATCHETFAIL = none,
					PICKUPRATCHET = {
						APPLYRATCHET = none,
					},
				},
				TIGHTENSPOKE = {
					PUTDOWNTIGHTENER = none,
					PICKUPTIGHTENER = {
						APPLYTIGHTENER = none,
					},
					TIGHTENERFAIL = none,
				},
				OIL = {
					PICKUPOIL = {
						APPLYOIL = none,
					},
					OILFAIL = none,
					PUTDOWNOIL = none,
				},
			},
			ANIMATIONS_CHILD = none,
			CUSTOMIDLE = none,
			UNLOCKS = COMMON[371],
			REACT = {
				CLEANUPHANDS = COMMON[372],
			},
			NOTOOLS = {
				TURNCRANK = {
					TURNCRANK_FAIL = {
						TURNCRANK_FAIL_REAL = {
							STOP_CRANK = none,
						},
					},
					TURNCRANK_FAIL_UNUSED = none,
					TURNCRANK_LOOP = {
						TURNCRANK_LOOPNOSOUND = none,
					},
				},
				SPINWHEEL = {
					SPINWHEEL_LOOP = none,
					SPINWHEELPLAYER_LOOP = none,
					SPINWHEEL_FAIL = {
						SPINWHEEL_FAIL_REAL = {
							STOP_WHEEL = none,
						},
					},
					SPINWHEEL_FAIL_OLD = none,
				},
			},
			FAILURE = COMMON[373],
		},
		UNUSED = none,
		PEDUNDERHOOD = {
			PEDUNDERHOOD_CHILD = none,
		},
		C6_POISONEFFECT2 = {
			C6_POISONEFFECT2INTRO = {
				C6_POISONEFFECT2CYCLE = {
					C6_POISONEFFECT2OUTRO = none,
				},
			},
		},
		C6_INTRO = {
			C6_2 = {
				C6_3 = {
					C6_4 = {
						C6_5 = {
							C6_6 = none,
						},
					},
				},
			},
		},
		SHOPBIKEANIMATIONS = {
			SPINWHEEL = none,
			TIGHTENSPOKE = none,
			IDLE = none,
			TURNCRANK = none,
		},
		CLEAR = none,
		GO = none,
	},
	GIVE2G2 = {
		GIVE = COMMON[374],
		GIVE_ATTEMPT = COMMON[375],
		EXECUTES = {
			SPEECH = COMMON[376],
			MODELS = COMMON[198],
			ANIMS = COMMON[377],
		},
	},
	BAT = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = COMMON[65],
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					COLLISIONEXECUTES = {
						LIGHT2 = COMMON[380],
						HEAVY = COMMON[380],
						LIGHT = COMMON[380],
						FORCEFEEDBACK = {
							FF144 = none,
							FF120 = none,
							FF160 = none,
						},
					},
					SWING1 = {
						RELEASE = {
							UNBLOCKABLE = COMMON[381],
							SWING1 = none,
						},
						SWING2 = {
							RELEASE = {
								UNBLOCKABLE = COMMON[381],
								SWING2 = none,
							},
						},
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	SPRAYCOMBOS = {
		CROSS = {
			FAIL = {
				FAIL_LARGETAG = none,
				FAIL_SMALLTAG = none,
				FAIL_MEDIUMTAG = none,
			},
			SUCCESS = {
				PREPMED = {
					INVALIDTAGSIZE = none,
					MOVETOTAG = {
						PREPMED_CHOICE1 = none,
						PREPMED_CHOICE5 = none,
						PREPMED_CHOICE2 = none,
						PREPMED_CHOICE6 = none,
						PREPMED_CHOICE3 = none,
						PREPMED_CHOICE7 = none,
						PREPMED_CHOICE4 = none,
					},
				},
				SUCCESSANIMATION = {
					ANIMATION = {
						DISPLAYTAG = none,
					},
					VANDALISMANIMATION = {
						ANIM2 = {
							ANIMSUCCESS = none,
						},
					},
				},
				VANDALISMTAG = {
					INVALIDTAGSIZE = none,
					MOVETOTAG = {
						VANDAL_CHOICE2 = none,
						VANDAL_CHOICE5 = none,
						VANDAL_CHOICE3 = none,
						VANDAL_CHOICE6 = none,
						VANDAL_CHOICE1 = none,
						VANDAL_CHOICE4 = none,
						VANDAL_CHOICE7 = none,
					},
				},
				NERDMED = {
					INVALIDTAGSIZE = none,
					MOVETOTAG = {
						NERDMED_CHOICE3 = none,
						NERDMED_CHOICE4 = none,
						NERDMED_CHOICE2 = none,
						NERDMED_CHOICE6 = none,
						NERDMED_CHOICE1 = none,
						NERDMED_CHOICE7 = none,
						NERDMED_CHOICE5 = none,
					},
				},
				JOCKMED = {
					INVALIDTAGSIZE = none,
					MOVETOTAG = {
						JOCKMED_CHOICE1 = none,
						JOCKMED_CHOICE7 = none,
						JOCKMED_CHOICE4 = none,
						JOCKMED_CHOICE2 = none,
						JOCKMED_CHOICE3 = none,
						JOCKMED_CHOICE6 = none,
						JOCKMED_CHOICE5 = none,
					},
				},
				GREASERMED = {
					INVALIDTAGSIZE = none,
					MOVETOTAG = {
						GREASERMED_CHOICE1 = none,
						GREASERMED_CHOICE6 = none,
						GREASERMED_CHOICE3 = none,
						GREASERMED_CHOICE5 = none,
						GREASERMED_CHOICE2 = none,
						GREASERMED_CHOICE7 = none,
						GREASERMED_CHOICE4 = none,
					},
				},
			},
		},
	},
	GS_FEMALE_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[382],
			IDLE = {
				GENERIC = none,
				ADULT = none,
				NERD = none,
				SEXY = none,
				CHEER = {
					CHEER6 = none,
					CHEER2 = none,
					CHEER4 = none,
					CHEER1 = none,
					CHEER7 = none,
					CHEER5 = none,
					CHEER3 = none,
				},
			},
			RISINGATTACKS = none,
		},
		OFFENSE = {
			SHORT = {
				GIRLFIGHT = none,
				STRIKES = COMMON[383],
				ZOE = COMMON[384],
			},
		},
	},
	GENERIC = {
		GENERICWALLSMOKING = COMMON[237],
		GENKISSING = COMMON[111],
		GENCOPFRISK = COMMON[388],
		GENSTANDTALKING = COMMON[389],
		GENERICBATHROOMMIRROR = COMMON[390],
		GENERICIDLE = COMMON[30],
		GENKISSINGHEAVY = COMMON[111],
		GENKISSINGMEDIUM = COMMON[111],
		GENKISSINGLIGHT = COMMON[393],
		GENCUDDLE = COMMON[111],
	},
	["5_10"] = {
		NISEDGAR = {
			EDGAR = {
				EDGAR01 = none,
			},
			JIMMY = COMMON[220],
		},
		ANIMS = none,
	},
	SPECIAL_ITEMS = {
		DEFAULT_KEY = {
			EDGARSHIELD = {
				WEAPONWALK = none,
				WEAPONSTRAFE = none,
				SPAWNSTUFF = {
					EDGARSHIELDBLOCKS = {
						BLOCKHITS = {
							PLAYERSHIELDDAMAGEC = {
								SHIELDDAMAGE = {
									CHSHIELDDESTROYED = none,
								},
							},
							BLOCK = none,
							PLAYERSHIELDDAMAGE = {
								SHIELDDAMAGE = {
									CHSHIELDC = none,
									CHSHIELDDESTROYED = none,
									CHSHIELDB = none,
								},
							},
						},
					},
					INVINCIBLE = COMMON[395],
				},
				ATTACKS = {
					PLAYER = {
						INVINCIBLE = {
							CHARGEATTACK = {
								CHARGEATTACK_ANTICSTART = {
									CHARGEATTACK_FAIL = {
										CHARGEATTACK_FAIL = none,
									},
									CHARGEATTACK_RUNCYC = none,
									CHARGEATTACK_LOCO = none,
									CHARGEATTACK_SUCCESS = none,
								},
							},
						},
						HEAVYATTACKS = {
							SWING = none,
						},
					},
					NPC_ATTACKS = {
						SHORT = COMMON[396],
					},
				},
				WEAPONRUN = none,
				WEAPONCROUCH = none,
				WEAPONIDLE = none,
			},
		},
	},
	SLEDGEHAMMER = {
		FULLBODYACTIONOPPS = {
			NORTONUNINTERRUPTABLE = {
				UNINTERRUPTABLE = none,
			},
		},
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = {
			ANIMATIONS = COMMON[378],
			CUSTOMLOCO = {
				LOCOMOTION = {
					SPRINTDEPLETE = COMMON[397],
					COMBAT = {
						COMBATTRANSITION = {
							COMBATIDLE_OUT = COMMON[398],
							COMBATSTART = COMMON[398],
						},
						DEFAULT = COMMON[399],
						EXECNODES = COMMON[400],
						["0_BLOCK_0"] = COMMON[401],
					},
					SOCIAL = COMMON[402],
					OFFSETCAM = {
						OFFSETCAM_WEAPON = {
							COMBATSTRAFE = none,
							COMBATIDLE = COMMON[105],
						},
						OFFSETCAM_LOCO = none,
					},
					RUN = {
						RUN = {
							RUNCONTROLLER = {
								RUN = {
									RUN = COMMON[403],
									RUNTIRED = none,
								},
								SPRINT = {
									SPRINTTIRED = none,
									SPRINTBASIC = COMMON[403],
								},
							},
						},
						TIRED_STOP = none,
						NEWLOCOANIMS = {
							RUNLOCOANIMS = none,
							TIREDSPRINTLOCOANIMS = none,
							TIRED_UPPERBODY_SPAWN = COMMON[405],
							TIRED_UPPERBODY = none,
							SPRINTLOCOANIMS = none,
						},
						RUNSTOP = {
							SKIDOPP_WAIT = none,
							RUNSTOP = {
								SKID = {
									RUN_TO_IDLE = none,
									SPRINT_SLIDE = COMMON[406],
								},
							},
							RUNSTOP_WAIT = none,
						},
						RUNSTART = COMMON[407],
					},
					IDLE = {
						VTIRED = {
							VTIREDACTIONS = {
								AMBIENTACTIONS_VTIRED = COMMON[408],
							},
						},
						FEMALE = none,
						TURN = {
							FACINGINTENDED = {
								CCW_SLOW = COMMON[409],
								RESET = none,
								FORWARDS = none,
								CCW_SLOW_FEMALE = COMMON[409],
								CW_SLOW_FEMALE = COMMON[410],
								CW_SLOW = COMMON[410],
							},
						},
						EXHAUSTED = none,
						TIRED = {
							TIREDACTIONS = COMMON[411],
						},
						IDLE = {
							REGULARIDLEANIMATION = {
								AMBIENTACTIONS = COMMON[412],
								AMBIENTSPAWN = COMMON[413],
								MIRRORIDLE = COMMON[414],
							},
						},
					},
					LOCOMOTIONEXECUTES = {
						WALKBASICGREASER = none,
						CROUCHLOCOTARGET = none,
						NONCOMBATSTRAFE = {
							NC_LOCO = {
								IDLE = none,
								NONCOMBATSTRAFEANIMS = COMMON[415],
							},
						},
						STRAFELOCOBASIC = {
							NORTON = none,
							NOSTEERING = none,
							STEERING = none,
						},
						STRAFELOCOBASICANIMS = COMMON[416],
						RUN_STARTLOCO = COMMON[404],
						WALK_STARTLOCO = none,
						TIRED_UPPERBODY = none,
						WALKBASIC = none,
						EXHAUSTED_COLLAPSE = COMMON[417],
					},
					WALK = {
						TIRED = COMMON[418],
						NORTON = COMMON[419],
						NOTTIRED = COMMON[419],
						SNEAK = COMMON[420],
					},
				},
			},
		},
		ACTIONS = {
			ATTACKS = {
				PLAYER = COMMON[184],
				HEAVYATTACKS = {
					UNBLOCKABLE = {
						SWING2 = none,
						EXECUTENODES = COMMON[17],
						POWERSWING = none,
						SWING1 = none,
					},
				},
			},
			NORTONSPECIFIC = {
				GROUNDATTACK = none,
				EVADEINTERRUPT = none,
				COMBATTAUNT = none,
				BREAKPROP = none,
			},
		},
		DEFAULT_KEY = none,
	},
	DBHIT = {
		ERROR = none,
		BASE = {
			STANDING = {
				HITBASEONGROUNDBACK = none,
				NONMELEE = {
					DODGEBALLREAR = {
						HITDEFAULT = none,
					},
					DODGEBALLFRONT = {
						HITHARD = none,
						HITEASY = none,
						HITNOCATCH = none,
						HITDEFAULT = none,
					},
				},
				SHOVED = COMMON[355],
				HITBASE = none,
				HITTREEERROR2 = none,
				HITBASEONGROUNDFRONT = none,
				POSTHIT = {
					BELLYDOWNGETUP = none,
					ONGROUNDFRONT = {
						LIEONBACKGETUP = none,
					},
				},
			},
		},
		SPECIAL = {
			SPECMETERINCRSM = {
				INCREASESM = none,
			},
			SPECMETERINCRMD = {
				INCREASEMD = none,
			},
			SPECMETERDRAIN = {
				INCREASEDRAIN = none,
			},
			SPECMETERINCRLG = {
				INCREASELG = none,
			},
		},
		START = {
			HITTREEBASE = none,
		},
	},
	["3_S10"] = {
		CONV3S10 = {
			DARBYSTART = {
				DARBYNEXT = COMMON[421],
			},
		},
		STRTMSSN = {
			STARTMISSION = none,
		},
		ENDMISSN = {
			DARBYSTART = COMMON[421],
		},
		NISEND = {
			GREASER1 = {
				GREASER1_01 = none,
			},
			GREASER2 = {
				GREASER2_01 = none,
			},
		},
		PREPTALK = none,
		JHNYCONV = {
			JOHNNYSTART = {
				PLAYERRESPONSE = {
					JOHNNY = {
						JOHNNYEND = none,
					},
				},
			},
		},
	},
	J_TED = {
		TEDTHROW = {
			THROWSTART_TED = none,
		},
		OFFENSE = COMMON[423],
		DEFENSE = {
			BLOCK = COMMON[11],
		},
		INVINCIBLE = COMMON[395],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				BLOCKPROJECTILES = none,
				FREE = COMMON[425],
				CUSTOMACTIONOPS = COMMON[27],
				LOCOMOTIONOVERRIDE = COMMON[426],
			},
			IDLE = COMMON[427],
			RISINGATTACKS = none,
		},
	},
	["3_S11"] = {
		["3_S11_STAND_TALKING"] = COMMON[389],
		["3_S11_O_P_STRUGGLE"] = {
			["3_S11_O_STRUGGLE_IDLE"] = {
				["3_S11_O_STRUGGLE_BREAK"] = none,
			},
			["3_S11_P_STRUGGLE_IDLE"] = {
				["3_S11_P_STRUGGLE_BREAK"] = none,
			},
		},
		["3_S11_ASYLUM_GATE_NIS"] = {
			["3_S11_ASYLUM_GATE_NIS_1_1"] = {
				["3_S11_ASYLUM_GATE_NIS_2_1"] = {
					["3_S11_ASYLUM_GATE_NIS_3_1"] = none,
				},
			},
		},
		["3_S11_GET_BOTTLE"] = COMMON[429],
		["3_S11_DROP_OUT"] = {
			["3_S11_DROP_OUT_1_1"] = {
				["3_S11_DROP_OUT_2_1"] = {
					["3_S11_DROP_OUT_3_1"] = {
						["3_S11_DROP_OUT_4_1"] = {
							["3_S11_DROP_OUT_5_1"] = none,
						},
					},
				},
			},
		},
		["3_S11_SHOVE_BANK"] = {
			["3_S11_SHOVE_BACK"] = none,
			["3_S11_PATIENT_GET_UP"] = none,
			["3_S11_SHOVE"] = none,
			["3_S11_PATIENT_FALL"] = none,
		},
		["3_S11_STAND_SMOKE"] = {
			WALL_SMOKE = {
				WALL_START = {
					WALL_IDLE = {
						WALL_SMOKE_START = {
							WALL_SMOKE_IDLE = COMMON[430],
						},
					},
				},
				WALKTOWALL = none,
			},
		},
		NIS_ANIMATIONS = {
			PLAYER = COMMON[431],
			MS_PHILLIPS = {
				MS_PHILLIPS03 = none,
				MS_PHILLIPS02 = none,
				MS_PHILLIPS01 = none,
			},
			OUTRO = {
				PLAYER = COMMON[431],
				GALLOWAY = COMMON[432],
				PHILLIPS = {
					PHILLIPS01 = none,
				},
			},
		},
		["3_S11_FIRESWITCH"] = COMMON[433],
	},
	["5_07A"] = {
		BLANK = none,
		["5_07A_REDSTAR_GATE"] = {
			ZOESTART = none,
		},
		NIS = {
			PLAYER = {
				PLAYER_CHILD = none,
				PLAYER03 = none,
				PLAYER01 = none,
				PLAYER02 = none,
			},
			RUSSELL = COMMON[434],
			RECRUITRUSSELL = {
				GARAGE = {
					GARAGECLOSED = none,
					GARAGEOPENS = none,
				},
				JIMMY = {
					JIMMYKNOCK = none,
				},
			},
			GATE = {
				GATESTANDING = none,
				GATEEXPLODES = none,
				GATEDESTROYED = none,
			},
			ZOE = {
				ZOE01 = none,
				ZOE03 = none,
				ZOE02 = none,
			},
		},
		["507A_PLAYERZOE"] = {
			ZOESTART = {
				PLAYER = {
					ZOE = {
						PLAYER = COMMON[435],
					},
				},
			},
		},
		["5_07_AFTER_POWER"] = COMMON[202],
		TALKING = {
			ZOETALK = none,
			PLAYERTALK = none,
		},
		ZOEDISTRACT = {
			ZOEDISTRACT05 = none,
			ZOEDISTRACT03 = none,
			SPEECHEXECUTES = {
				SPEECH03 = none,
				SPEECHEMPTY = none,
				SPEECH02 = none,
				SPEECH01 = none,
			},
			ZOEDISTRACTWAIT = none,
			ZOEDISTRACT01 = none,
			ZOEDISTRACT02 = none,
			ZOEDISTRACT04 = none,
		},
	},
	["2_02_MALLPEDS"] = {
		WARMINGHANDSLOOP = {
			TALKING4 = none,
			TALKING7 = none,
			LISTEN2 = none,
			TALKING5 = none,
			TALKING3 = none,
			LISTEN3 = none,
			WARMINGHANDS = none,
			LISTEN4 = none,
			TALKING6 = none,
		},
		GENSTANDTALKING = {
			TALKINGLOOPS = {
				TALKING4 = none,
				TALKING7 = none,
				LISTEN2 = none,
				TALKING5 = none,
				TALKING3 = none,
				LISTEN3 = none,
				LISTEN4 = none,
				TALKING6 = none,
			},
		},
	},
	["3_01A"] = {
		ANIMS = none,
		SNOWBALL = {
			INITIALIZE = none,
			GIVEBALL = COMMON[437],
			SNOWBALL = {
				CONTROLLER = COMMON[438],
			},
			REMOVEBALL = COMMON[439],
		},
	},
	DARTSAI = {
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				BREAKPROP = {
					PROPATTACKSPROJECTILE = {
						DART = COMMON[440],
					},
				},
			},
		},
		PROPS = COMMON[185],
	},
	NIS_3_S03_GIVEVAN = COMMON[441],
	["4_S12_CONV"] = {
		["4_S12_SUCCESS"] = {
			["4_S12_SUC01"] = {
				["4_S12_SUC02"] = {
					["4_S12_SUC03"] = {
						["4_S12_SUC04"] = {
							["4_S12_SUC05"] = {
								["4_S12_SUC06"] = COMMON[442],
							},
						},
					},
				},
			},
		},
		["4_S12_DELIVERY"] = {
			["4_S12_INIT"] = {
				F_POSSESSIONBRANCH = {
					F_DELIVERYBRANCH02 = {
						["4_S12_DELIVERDRESS"] = COMMON[443],
						["4_S12_DELIVERNECKLACE"] = COMMON[443],
						["4_S12_INCREMENTDELIVERY"] = none,
					},
					F_DELIVERYBRANCH01 = {
						["4_S12_NONECKLACE"] = none,
						["4_S12_NODRESS"] = none,
						["4_S12_NOPERFUME"] = none,
					},
				},
			},
		},
		["4_S12_INTRO"] = {
			["4_S12_01"] = {
				["4_S12_02"] = {
					["4_S12_03"] = {
						["4_S12_MENU"] = {
							["4_S12_NO"] = {
								["4_S12_NEG"] = COMMON[442],
							},
							["4_S12_YES"] = {
								["4_S12_POS"] = {
									["4_S12_LAUNCH"] = none,
								},
							},
						},
					},
				},
			},
		},
		["4_S12_FAIL"] = {
			["4_S12_FAIL01"] = {
				["4_S12_FAIL02"] = COMMON[442],
			},
		},
	},
	CV_MALE_A = {
		DEFENSE = COMMON[444],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[445],
			IDLE = {
				FATIDLE = none,
				GENERIC = none,
			},
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = COMMON[446],
		},
	},
	["2_09_PETER_CV"] = {
		RUNMISSION = none,
	},
	MBP_2_R03 = {
		EXECUTE = {
			IDLEBYPEDTYPE = COMMON[447],
			HITBYPEDTYPE = COMMON[214],
			WAITBYPEDTYPE = {
				FEMALE = {
					AMBIENT2 = none,
					AMBIENT1 = none,
				},
				MALE = none,
			},
		},
		REACTION = {
			PHIT = none,
			PHITOLD = COMMON[214],
		},
		PWAIT = {
			PWAVE = none,
		},
		PIDLE = none,
	},
	WRESTLING = {
		WRESTLING1 = COMMON[448],
		WRESTLING3 = COMMON[448],
		WRESTLING2 = COMMON[448],
	},
	SODAMACH = {
		DISENGAGE = COMMON[215],
		PEDPROPSACTIONS = {
			IDLE = {
				RANDOMPOP = {
					RANDOMPOP = none,
					RANDOMPOP_FAIL = none,
				},
				ACTIONS = {
					KICK = none,
					INSERTMONEY = {
						HUDEXECUTE = none,
					},
					INSERTMONEYNPC = none,
					INSERTMONEYOBJ = none,
				},
			},
			HASSODA = {
				ACTIONS = {
					PICKUPSODAANDDRINK = {
						PICKUPSODA = {
							SPLURT = none,
							DRINK = {
								SPEECH = none,
								GIVEHEALTH = {
									PLAYER = none,
									NPC = none,
								},
							},
						},
					},
				},
			},
			HASMONEY = {
				ACTIONS = {
					SELECTSODANPC = none,
					SELECTSODA = none,
				},
			},
		},
		IDLE = none,
		HASSODA = none,
		HASMONEY = none,
	},
	TO_SIAMESE = {
		DEFENSE = none,
		OFFENSE = {
			SHORT = {
				STRIKES = COMMON[383],
				ZOE = COMMON[384],
			},
		},
		SIAMESETWINSLOAD = {
			SIAMESETWINSLOAD_CHILD = none,
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				RUNBASIC = COMMON[451],
				IDLE = none,
				WALKBASIC = {
					WALK = none,
				},
			},
			RISINGATTACKS = none,
		},
		SIAMESETWINS = {
			SIAMESETWINSB = none,
			SIAMESETWINSC = none,
			SIAMESETWINSE = none,
			SIAMESETWINSA = none,
			EXECUTES = {
				SPEECH = none,
				SPEECH2 = none,
			},
			SIAMESETWINSD = none,
		},
	},
	GLOBALSBANK = {
		GLOBALS = {
			OTHERPICKUPS = {
				PCHEALTH = none,
				PCSPEC = none,
				FRAFFYCAN = none,
			},
			AIBUTES = {
				["5_B"] = none,
				["3_B_ONLOOKERS"] = none,
				["3_B"] = none,
				["1_09"] = none,
				["4_05C"] = none,
				BOXING = none,
				RUSSELL = none,
				["4_B2"] = none,
				["1_02"] = none,
				["4_B1"] = none,
			},
			VEHICLECAMSHOTS = {
				MOPED = none,
				REGULAR = none,
				REGULARTARGET = none,
				JUNKYARDCHASE = none,
				FORMULAKART = none,
				PAPERROUTE = none,
				FLY = none,
				ARCADERACECAR = none,
				TEST = none,
				GOKART = none,
				LAWNMOWER = none,
			},
			ITEMS = {
				VALENTINE = none,
				XMASGIFT = none,
				CLWNSHOE = none,
				DOLLAR = none,
				ALGIEJAC = none,
				CLWNPANT = none,
				MOPED = none,
				DPE_SNOWMAN = none,
				WEIRDHAT = none,
				RACER = none,
				W_DIARYPU = none,
				BBAGBOTTLE_INV = none,
				DPE_STYROTOMB = none,
				MTNBIKE = none,
				TICKET = none,
				COMIC = none,
				COMICBK = none,
				LABNOTES = none,
				OLDMEAT = none,
				ADDBOOK = none,
				TEXTBOOK = none,
				KEYCARD = none,
				SEXDRESS = none,
				BOLTCUTPU = none,
				DEVILHORN = none,
				BEA_DIARY = none,
				LIPSTICK = none,
				GEEKCARD = none,
				RETRO = none,
				ADMISTICKET = none,
				NEWKEY = none,
				BEADBRAC = none,
				BANBIKE = none,
				PENNY = none,
				FLOWERGIFT = none,
				STPDSHRT = none,
				OLADBIKE = none,
				PACKAGE = none,
				CRAPBMX = none,
				SUPERGLUE = none,
				PAPERSTACK = none,
				POSTCAR = none,
				RAZOR = none,
				TEACHNOTE = none,
				CANAHAT = none,
				CHARSHEET = none,
				UNDIE = none,
				DPE_PUMPKIN = none,
				ORDERLY = none,
				TADKEY = none,
				LOLAKEYS = none,
				BIGWATCH = none,
				DRUGBAG = none,
				CRAB = none,
				CLOWNWIG = none,
				NPEARL = none,
				FLOWERBUND = none,
				RUBBAND = none,
				CUSTOMBIKE = none,
				LAUNDBAG = none,
				PERFUME = none,
				WATCH = none,
				BUNCHOFPANTIES = none,
				BMXRACE = none,
				TEDDYBEAR = none,
				AQUABIKE = none,
				DRUGBTTL = none,
				RADIO = none,
				POSTBAND = none,
				DOSSIER = none,
				BUNCHOFPHOTOS = none,
				CHOCBOX = none,
				SCOOTER = none,
				ANGELBAND = none,
				BIKE = none,
			},
			STIMULI = {
				THEFT = none,
				FOLLOW = none,
				TAGGING = none,
				LAUGHAT = none,
				FALARM_BROADCAST = none,
				GRAPPLEDAMAGE = none,
				DOORCLOSED = none,
				BIKESTOLEN = none,
				PEDDAMAGE = none,
				BEGFROM = none,
				TVSTIM = none,
				GREETSTIM = none,
				FIGHTCHEERING = none,
				CONVSTIM = none,
				DOOROPENED = none,
				GIFT = none,
				TARGETEDSTIM = none,
				ANGRYWITH = none,
				POOREXCUSE = none,
				BOOBYTRAP = none,
				EXPLOSION = none,
				BULLYING = none,
				COMBATTAUNT = none,
				FIREALARM = none,
				DISMISSIVE = none,
				KICKMESIGN = none,
				MEATSTIM = none,
				CURFEW = none,
				IDLECHATTER = none,
				TRAPPED = none,
				TAGNERD = none,
				CAMERATARGET = none,
				NOHELMET = none,
				DEADRAT = none,
				FIREWORKLURE = none,
				COMBATAPOLOGY = none,
				TIMEOUT = none,
				WARN = none,
				ALLYOFFER = none,
				TAGPREPPY = none,
				SUPERTAUNT = none,
				SURPRISE = none,
				BREAKANDENTER = none,
				BIKECRASH = none,
				PROPBROKEN = none,
				BUSTEDSTIM = none,
				PROJECTILE = none,
				APOLOGIZETO = none,
				TRESPASSING = none,
				BOYSKISSING = none,
				GLASSBROKEN = none,
				WEAPONFIRED = none,
				BANNEDWEAPON = none,
				PUKE = none,
				TATTLESTIM = none,
				COWDANCE = none,
				LOCKPICKING = none,
				MISCONDUCT = none,
				GOODEXCUSE = none,
				JOKECANDY = none,
				MAKEOUT = none,
				OBSTUCTING = none,
				SCRIPTBREAK = none,
				TAUNTSTIM = none,
				TAGGREASER = none,
				FLOODING = none,
				INTIMIDATE = none,
				FIREEXT = none,
				DEATHSTIM = none,
				COWERFROM = none,
				FOODFIGHT = none,
				TAGJOCK = none,
				VEHICLEHIT = none,
				HUMILIATIONSTIM = none,
				COWDANCESUCCESS = none,
				STAY = none,
				LATEFORCLASS = none,
				FETCH = none,
				BUMPSTIM = none,
				GOODBYE = none,
				FIGHTAUTHORITY = none,
				FLATTER = none,
				COWDANCEFAIL = none,
				SKIPPINGCLASS = none,
				CATCHPROJECTILE = none,
			},
			WEAPONS = {
				INFO = {
					APPLE = none,
					NERDBOOKSD = none,
					BANANA = none,
					NEWSROLL = none,
					CHEM_STIR = none,
					W_TPROLL = none,
					WHATVASE = none,
					WTRPIPED = none,
					JBROOM = none,
					WHATSVASE = none,
					CHERRYB_ONBIKE = none,
					DEVILFORK = none,
					FIREEXTING = none,
					STINKBOMB = none,
					MONKEYWRENCH = none,
					WFTBALL = none,
					BAT = none,
					TWOBYFOUR = none,
					LID = none,
					PPLANT_PROJ = none,
					KICKME = none,
					BOLTCUTTERS = none,
					POTATO = none,
					WTRPIPE = none,
					SPUDG = none,
					YARDSTICK = none,
					CHSHIELDA = none,
					SNOWBALL = none,
					CIGARETTE = none,
					FLOWERBUND = none,
					SLEDGEHAMMER = none,
					WTRPIPEC = none,
					W_DIARY = none,
					PLANTPOT = none,
					WORANGE = none,
					SNWBALLB = none,
					MARBBAG = none,
					NERDBOOKS = none,
					TROPHY = none,
					SK8BOARD = none,
					PVASE_PROJ = none,
					SPRAYCAN = none,
					WFRISBEE = none,
					WMALLET = none,
					LEADPIPE = none,
					BROCKET = none,
					EGGPROJ = none,
					MGDICE = none,
					RBANDBALL = none,
					BAT_DMG = none,
					FLASK = none,
					WCAMERA = none,
					BAGMRBLS = none,
					["2HANDSTICK"] = none,
					NERDBOOKSE = none,
					POMPOM = none,
					WGASCAN = none,
					CRICKET_DMG = none,
					POOBAG = none,
					POLO = none,
					JBROOM_DMG = none,
					BBAGBOTTLE = none,
					SUPERMARBLE = none,
					BBGUN = none,
					BRICK = none,
					W_GARBBIN = none,
					SSWHIP = none,
					AMMO_SCATTER = none,
					BROCKETLAUNCHER = none,
					W_PGUN = none,
					UMBRELLA = none,
					PSHEILD = none,
					SUPERSLING = none,
					CHERRYB = none,
					MARBLE = none,
					STWINS_BAD = none,
					W_DEADRAT = none,
					CHSHIELDB = none,
					SLINGSHOT = none,
					POOLCUE = none,
					ANIFOOTY = none,
					SNOWSHWL = none,
					TWOBYFOUR_DMG = none,
					PAINTGUN = none,
					W_ITCH = none,
					NERDBOOKSB = none,
					CHSHIELDC = none,
					DETONATOR = none,
					W_FLASHLIGHT = none,
					ANIBBALL = none,
					WBALLOON = none,
					DEC_PLATE = none,
					CRICKET = none,
					EYEDROP = none,
					PINKYWAND = none,
					SOCBALL = none,
					WDIGCAM = none,
					CHEMICAL = none,
					GARBPICK = none,
					TEDDYBEAR = none,
					WTRAY = none,
					YARDSTICK_DMG = none,
					WDISH = none,
					DODGEBALL = none,
					WFTBOMB = none,
					NERDBOOKSC = none,
					WTRPIPEB = none,
					SUPERSPUDG = none,
					W_FOUNTAIN = none,
					BASEBALL = none,
				},
				CROSSHAIRS = {
					SUPERSLINGNOTARGET = none,
					ALTERNATE = none,
					BBGUNNOTARGET = none,
					DEFAULT = none,
					DEFAULTTARGET = none,
					SPUDCANNONNOTARGET = none,
					MELEETARGET = none,
					FOLLOWCAM = none,
					MELEENOTARGET = none,
					SUPERSLINGTARGET = none,
					WEAPONNOTARGET = none,
					WEAPONTARGET = none,
					BBGUNTARGET = none,
					SPUDCANNONTARGET = none,
				},
				PROJECTILES = {
					BBALLHOOPINACCURATE = none,
					BANANA = none,
					NEWSROLL = none,
					BASEBALLPROJ = none,
					CANDY = none,
					SNOWBALL = none,
					CHERRYBNOTIMER = none,
					CHKNLEG = none,
					MUD = none,
					GARBPICK = none,
					STINKBOMB = none,
					ITCH_PROJ = none,
					WFTBALL = none,
					SPUDCANNON = none,
					BRICK_GARY = none,
					PEEPATCH = none,
					CHEMICAL_EXPLOSIVE = none,
					DUNKBALL = none,
					POTATO = none,
					WFTBOMB = none,
					DBALL_FAST = none,
					CIGARETTE = none,
					BBALLHOOP = none,
					APPLEPROJ = none,
					CHERRYB = none,
					DEADRAT = none,
					WTRAY_TOSS = none,
					WFRISBEE = none,
					BROCKET = none,
					EGGPROJ = none,
					DROPBALL = none,
					RBANDBALL = none,
					POOBAG = none,
					DROPCHERRYB = none,
					WFTBALL_TED = none,
					MARBLESBOUNCE = none,
					DROPWB = none,
					POISON_CLOUD_PLANT = none,
					FIRE_INV = none,
					BOOK_TOSS = none,
					SNWBALLB = none,
					SUPERMARBLE = none,
					AMMO_SCATTER = none,
					FOUNTAIN = none,
					DBALL_PASS = none,
					MARBLES = none,
					SOCBALL = none,
					WHATVASE_PROJ = none,
					ANIFOOTY = none,
					BALLOONPROJ = none,
					WHATSVASE_PROJ = none,
					LID_TOSS = none,
					ANIBBALL = none,
					BBGUNMARBLE = none,
					DBALL_REG = none,
					REMOTE_CHERRYB = none,
					PVASE_PROJ_TOSS = none,
					DBALL_UNBLOCKABLE = none,
					DROPBANANA = none,
					MEAT = none,
					MARBLE = none,
					PLATE_TOSS = none,
					BRICK = none,
					SHOUSE = none,
					THROWN_BOTTLE = none,
					TPROLL = none,
					PPLANT_PROJ_TOSS = none,
					DBALL_STRONG = none,
					PLANTPOT_TOSS = none,
					ARCADERACEROCKET = none,
					POISON_CLOUD = none,
				},
			},
			FIGHTING = {
				TO_BARBERPOOR = none,
				GRH1A_VANCE_WEEN = none,
				GRH3A_RICKY = none,
				TO_BUSINESS4 = none,
				TO_ASYLUMPATIENT = none,
				TE_ASSYLUM = none,
				GENERICWRESTLER = none,
				JKH1_DAMON_WEEN = none,
				PRH3A_PARKER_WEEN = none,
				JKH1_DAMON = none,
				TO_BARBERRICH = none,
				DOH1A_OTTO = none,
				NDH1A_ALGERNON = none,
				TO_FIREMAN = none,
				TO_HOBO = none,
				GRH1_LEFTY = none,
				JKH3A_BO = none,
				GN_SKINNYBBOY = none,
				JKTED_FB = none,
				TO_BIKEOWNER = none,
				JKH2_DAN = none,
				PLAYER_MASCOT = none,
				GN_FATGIRL = none,
				GRH2A_HAL = none,
				TO_BUSINESS3 = none,
				TO_RICHM3 = none,
				TO_COMIC = none,
				TE_JANITOR = none,
				NDH1_FATTYWRESTLE = none,
				PLAYER = none,
				PRH3A_PARKER_OBOX = none,
				GN_BULLY01 = none,
				TO_RICHM2 = none,
				GN_BULLY04 = none,
				PRH2_BRYCE = none,
				JK2ND_JURI = none,
				TO_BUSINESS1 = none,
				DOH2A_LEON = none,
				NDH3A_DONALD_WEEN = none,
				NDH2_THAD = none,
				TO_MAILMAN = none,
				TE_PRINCIPAL = none,
				GN_HISPANICBOY = none,
				TO_HANDY = none,
				DOH1_DUNCAN = none,
				PRH3_JUSTIN = none,
				JKGIRL_MANDY = none,
				PR2ND_BIF_OBOX = none,
				PRGIRL_PINKY = none,
				TO_TATTOOIST = none,
				TO_MOTELOWNER = none,
				GN_BULLY02 = none,
				TO_CARNYMIDGET = none,
				PRH2A_CHAD = none,
				JKH3_CASEY_WEEN = none,
				TO_GROCERYCLERK = none,
				TE_MATHTEACHER = none,
				TO_RICHW2 = none,
				TE_HALLMONITOR = none,
				GN_SEXYGIRL = none,
				GN_ASIANGIRL_WEEN = none,
				GN_ASIANGIRL = none,
				NEMESIS_WEEN = none,
				GN_LITTLEGIRL_2 = none,
				NDH3_BUCKY = none,
				TO_CSOWNER_3 = none,
				TE_SECRETARY = none,
				GN_GREEKBOY = none,
				PETER = none,
				PFH1_SETH = none,
				GRGIRL_LOLA = none,
				PFLEAD_KARL = none,
				DOLEAD_EDGAR = none,
				JKKIRBY_FB = none,
				TE_CHEMISTRY = none,
				JKLEAD_TED = none,
				GN_BULLY06 = none,
				JKH3_CASEY = none,
				TO_BUSINESSW2 = none,
				GN_WHITEBOY = none,
				TO_POORWOMAN = none,
				DOLEAD_RUSSELL = none,
				GN_LITTLEBLKGIRL = none,
				DO2ND_OMAR = none,
				TE_ART = none,
				NDH2_THAD_WEEN = none,
				GRLEAD_JOHNNY = none,
				TO_GROCERYOWNER = none,
				GN_FATBOY = none,
				GN_BOY01 = none,
				JKH1A_KIRBY = none,
				PETER_WEEN = none,
				PRH1_GORD = none,
				GN_BOY02 = none,
				NDGIRL_BEATRICE = none,
				PLAYER_WEEN = none,
				TO_ORDERLY = none,
				PF2ND_MAX = none,
				TO_BUSINESS2 = none,
				PRH2A_CHAD_OBOX = none,
				DOH2_JERRY = none,
				GRGIRL_LOLAUW = none,
				GRH3_LUCKY_WEEN = none,
				DOH3A_GURNEY = none,
				PRGIRL_PINKYUW = none,
				GRH1A_VANCE = none,
				ND2ND_MELVIN = none,
				PRH1A_TAD = none,
				TO_FIREOWNER = none,
				GN_BOY02_WEEN = none,
				TE_BIOLOGY = none,
				TO_POORMAN2 = none,
				TE_HISTORY = none,
				GN_HBOY_WEEN = none,
				PR2ND_BIF = none,
				JKH2A_LUIS = none,
				PRH3_JUSTIN_OBOX = none,
				NDH1_FATTY = none,
				TO_COP = none,
				DOG_PITBULL = none,
				GR2ND_PEANUT = none,
				PRH3A_PARKER = none,
				GN_BULLY03 = none,
				PRGIRL_PARIS = none,
				TE_LIBRARIAN = none,
				JKH1_DAMON_FB = none,
				TO_RECORD = none,
				PLAYER_OBOX = none,
				JKDAN_FB = none,
				GRH3_LUCKY = none,
				NDH2A_CORNELIUS = none,
				TO_CARNY01 = none,
				DOGIRL_ZOEUW = none,
				TE_CAFETERIA = none,
				TE_ENGLISH = none,
				GN_BULLY05 = none,
				TO_CSOWNER_2 = none,
				TE_GYMTEACHER = none,
				PLAYER_OWRES = none,
				TO_ASSOCIATE = none,
				NDH3A_DONALD = none,
				JK_LUISWRESTLE = none,
				TO_INDUSTRIAL = none,
				GN_LITTLEGIRL_3 = none,
				GN_BULLY01_WEEN = none,
				TO_CARNIE_FEMALE = none,
				TO_OLDMAN2 = none,
				TE_AUTOSHOP = none,
				NDGIRL_BEATRICEUW = none,
				PRH2_BRYCE_OBOX = none,
				PRGIRL_PINKY_WEEN = none,
				GN_WHITEBOY_WEEN = none,
				GN_LITTLEBLKBOY = none,
				TO_CARNY02 = none,
				NEMESIS_GARY = none,
				TO_BUSINESSW1 = none,
				DOG_PITBULL3 = none,
				NDLEAD_EARNEST = none,
				DOG_PITBULL2 = none,
				DO_HENRY_ASSYLUM = none,
				GRH2_NORTON = none,
				PFH2_EDWARD = none,
				TO_ORDERLY2 = none,
				JKGIRL_MANDYUW = none,
				TO_RICHW1 = none,
				TO_COP2 = none,
				TE_NURSE = none,
				TO_RICHM1 = none,
				PRLEAD_DARBY = none,
				TO_FMIDGET = none,
				DOGIRL_ZOE = none,
				DOH3_HENRY = none,
			},
			FOLLOWCAM3SHOTS = {
				FIGHT = none,
				["1_B_X"] = none,
				WATER = none,
				LIBRARYCAM = none,
				["4B1"] = none,
				VEHICLE = none,
				SKATEBOARD = none,
				SKATEBOARDOUTSIDE = none,
				CROUCHOUTSIDE = none,
				REGULAR = none,
				REGULAROUTSIDE = none,
				WATERPUZZLECAM = none,
				FIGHTOUTSIDE = none,
				["4B2"] = none,
				CROUCH = none,
			},
			OFFSETCAMSHOTS = {
				RAIL_SLIDE_L = none,
				LOCKERCAM = none,
				RAIL_SLIDE_R = none,
				IN_TREE_NOWEAPON = none,
				GRAPHITICAM = none,
				["3RD_NO_CROSSHAIR"] = none,
				OPENLOCKERCAM = none,
				CHERRYB = none,
				STEALTHPROP = none,
				["3RD_GEN_CROSSHAIR"] = none,
				STEALTHPROPPORTAPOO = none,
				STEALTHPROPARMOIR = none,
				SPUDCANNON = none,
				SPUDCANNONZOOM = none,
				IN_TREE = none,
				STEALTHPROPLOCKER = none,
				BALLTOSSCAM = none,
				BASEBALL = none,
			},
			DODGEBALLAI = {
				PERSONALITYPROFILES = {
					DEFAULT = none,
					AGGRESSIVE = none,
					TIMID = none,
				},
				DIFFICULTYPROFILES = {
					["1"] = none,
					["3"] = none,
					["2"] = none,
					["5"] = none,
					["4"] = none,
					PLAYER = none,
				},
			},
			TIMECYCLE = {
				TIMEPERIODS = {
					CURFEW_TIRED = none,
					EARLYCLASS = none,
					LATECLASSWARNING = none,
					MORNING = none,
					LUNCH = none,
					CURFEW_MORETIRED = none,
					CURFEW_TOOTIRED = none,
					LATECLASS = none,
					EARLYCLASSWARNING = none,
					EVENING = none,
					CURFEW_SLIGHTLYTIRED = none,
					AFTERNOON = none,
				},
			},
			FIRSTPERSONCAMSHOTS = {
				REGULAR = none,
			},
			CINEMATIC = {
				SHOTS = {
					GRAP_BL_LOW = none,
					GRAP_FL_LOW = none,
					CRAWL_CAM_ALT = none,
					TL_CLIMB_CAM_BR = none,
					RSHOULDER = none,
					NOOGIE_SPIT_CAM_2 = none,
					CONV_MEDIUM_L = none,
					SOCIAL_KISS3_CAM_1 = none,
					TRIP_KID_CAM_2 = none,
					TL_CLIMB_CAM_B = none,
					GRAP_FL_MED = none,
					GRAPPLE_BEARHUG_CAM_2 = none,
					CONV_CLOSE_R = none,
					NOOGIE_SPIT_CAM_1 = none,
					GRAPPLE_BEARHUG_CAM_1 = none,
					WEAPONSTRUGGLE02 = none,
					WEAPONSTRUGGLE03 = none,
					DRIFT = none,
					WAKE_CAM_2 = none,
					WEAPONSTRUGGLE01 = none,
					LSIDE = none,
					SOCIAL_KISSF_CAM_1 = none,
					RSIDE = none,
					GRAP_FL_WED = none,
					STORE = none,
					GRAP_BL_WED = none,
					GRAP_BR_LOW = none,
					BOXING_KO = none,
					TRIP_BIGKID_CAM_1 = none,
					GRAP_FL_HIGH = none,
					GRAP_BR_MED = none,
					SOCIAL_KISSF_CAM_3 = none,
					RUSSELL_CAM_HEADBUTT_RUN = none,
					WAKE_CAM = none,
					CRAWL_CAM = none,
					DEAD_LEG_CAM_2 = none,
					HIT_SELF_CAM_1 = none,
					TL_CLIMB_CAM_BL = none,
					WEDGIE_CAM_2 = none,
					TEST1 = none,
					RUSSELL_CAM_02 = none,
					GRAP_FR_WED = none,
					PEE_CAM_1 = none,
					LOW_UP = none,
					PREFECT_CAM_T = none,
					TOILET_DUNK_CAM = none,
					CRAWL_CAM_SIDE = none,
					SOCIAL_KISS3_CAM_2 = none,
					INDIAN_BURN_CAM_1 = none,
					CONV_FAR_L = none,
					LSHOULDER = none,
					CONV_CLOSE_L = none,
					INDIAN_BURN_CAM_2 = none,
					PREFECT_CAM_L = none,
					DEAD_ARM_CAM_2 = none,
					SOCIAL_KISS1_CAM_2 = none,
					RUSSELL_CAM_WALL_HIT_R = none,
					PEE_CAM_2 = none,
					SOCIAL_KISS1_CAM_1 = none,
					GRAP_BL_HIGH = none,
					COP_CAM_PIN = none,
					LOW_UP_02 = none,
					FACE = none,
					SLAP_CAM_1 = none,
					SOCIAL_KISS2_CAM_1 = none,
					COP_CAM_WALK_EXIT_L = none,
					FACESIDEMOVING = none,
					WEDGIE_CAM_1 = none,
					GRAP_FR_ARM = none,
					FACECLOSE = none,
					DEAD_ARM_CAM_1 = none,
					BIKE_CAM = none,
					ORDERLY_CAM_F = none,
					RUSSELL_CAM_WALL_HIT_L = none,
					BEHIND = none,
					CLIMB_CAM_B = none,
					CONV_MEDIUM_R = none,
					GRAP_BL_MED = none,
					CLIMB_CAM_BR = none,
					PISSING_CAM = none,
					SLAP_CAM_2 = none,
					EAR_GRAB_CAM_1 = none,
					COP_CAM_WALK_EXIT_R = none,
					GRAP_BR_WED = none,
					DEAD_LEG_CAM_1 = none,
					TESTDRIFT = none,
					HANDCRUSH_CAM_2 = none,
					HIT_SELF_CAM_2 = none,
					GAME_CAM_F = none,
					NOSE_CAM_1 = none,
					SOCIAL_KISSF_CAM_4 = none,
					SOCIAL_KISS2_CAM_2 = none,
					TEST2 = none,
					SOCIAL_KISSF_CAM_2 = none,
					GRAP_FL_ARM = none,
					EAR_GRAB_CAM_2 = none,
					NOSE_CAM_2 = none,
					RUSSELL_CAM_01 = none,
					RUSSELL_CAM_CLOSE = none,
					SOCIAL_KISS4_CAM_2 = none,
					PREFECT_CAM_B = none,
					GRAP_BR_HIGH = none,
					TRIP_BIGKID_CAM_2 = none,
					RAIL_SLIDE_CAM = none,
					SOCIAL_KISS4_CAM_1 = none,
					TESTDRIFT3 = none,
					TEST3 = none,
					TESTDRIFT2 = none,
					CLIMB_CAM_BL = none,
					GRAP_BL_ARM = none,
					TRIP_KID_CAM_1 = none,
					HANDCRUSH_CAM_1 = none,
					GRAP_FR_HIGH = none,
					GRAP_FR_MED = none,
					PREFECT_CAM_R = none,
					GRAP_FR_LOW = none,
					RUSSELL_INTRO_01 = none,
					GRAP_BR_ARM = none,
					ORDERLY_CAM_L = none,
					BOXING_KO_2 = none,
					WEAPONSTRUGGLE04 = none,
				},
				SHOTGROUPS = {
					RUSSELL_WALL_ALTS = none,
					GRAPPLE_ARM_ALTS = none,
					ORDERLY_ALTS = none,
					HIT_SELF_ALTS = none,
					GRAPPLE_WEAPONSTRUGGLE_ALTS = none,
					CLIMB_F_ALTS = none,
					GRAP_MED_ALTS = none,
					GRAPPLE_BEARHUG_ALTS = none,
					DEAD_LEG_ALTS = none,
					SOCIAL_KISS2_ALTS = none,
					EAR_GRAB_ALTS = none,
					PREFECT_ALTS = none,
					SLAP_ALTS = none,
					RUSSELL_PB_ALTS = none,
					CLIMB_ALTS = none,
					TRIP_BIG_KID_ALTS = none,
					NOSE_ALTS = none,
					DEAD_ARM_ALTS = none,
					GRAPPLE_WEDGE_ALTS = none,
					RAIL_CAM_E3FIX_ALTS = none,
					PEE_ALTS = none,
					BOXING_KO_ALTS = none,
					WEDGIE_ALTS = none,
					NOOGIE_SPIT_ALTS = none,
					TEST = none,
					COP_WALK_ALTS = none,
					INDIAN_BURN_ALTS = none,
					SOCIAL_KISS3_ALTS = none,
					CRAWL_CAM_ALTS = none,
					SOCIAL_KISSF_ALTS = none,
					SOCIAL_KISS4_ALTS = none,
					SOCIAL_KISS1_ALTS = none,
					TL_CLIMB_ALTS = none,
					GRAPPLE_ALTS = none,
					TRIP_KID_ALTS = none,
					CONV = none,
					HANDCRUSH_ALTS = none,
				},
			},
			PICKUPDATA = {
				BRICKBUTE = none,
				AMBIENTDROPCLEANUP = none,
				FOODFIGHTBUTES = none,
				EGGSBUTE = none,
				DEFAULT = none,
				CLAKE_TESTBUTE = none,
				SNOWBALLBUTE = none,
				PERMANENTBUTES = none,
				SUPERSLINGBUTE = none,
				["1_08_STINKBOMBS"] = none,
				SPUDGUNBUTE = none,
				BAGMRBLSBUTE = none,
				SPRAYCANBUTE = none,
				PERMANENTMISSION = none,
				ITCHPOWDERBUTE = none,
				PERMANENTBUTESWITHCLEANUP = none,
				CHERRYBBUTE = none,
				BROCKETBUTE = none,
				WORLDPICKUP = none,
				HEALTHBUTE = none,
				PAPERSTACKBUTE = none,
				DAMAGED_WEAPON = none,
				HEALTHBUTE25 = none,
				PERMANENT2MINRESPAWN = none,
				STINKBOMBBUTE = none,
			},
			ARCADERACECAMERASHOTS = {
				DESERTOPSCAM = none,
			},
			FIGHTCAMSHOTS = {
				REGULARINSIDE = none,
				BOXINGCAM = none,
				["4B1"] = none,
				SOCIALOUTSIDE = none,
				SOCIALINSIDE = none,
				REGULAROUTSIDE = none,
				WRESTLING = none,
				["4B2"] = none,
				["1_B_X"] = none,
			},
			SPINECONTROL = {
				ONBIKE = none,
				STRUGGLERIGHT = none,
				MELEE = none,
				GUN = none,
				HEADTRACK = none,
				WEAPONOFFSET = none,
				SLINGSHOT = none,
				NC_LOOK = none,
				BOXINGMELEE = none,
				IDLEOFFSETCAM = none,
				GRAPPLE = none,
				BLOCK = none,
				STRUGGLELEFT = none,
				OLDPEOPLE = none,
				IDLE = none,
				LOCO = none,
				THROWN = none,
			},
			PUNISHMENT = {
				THEFT = none,
				BUMPED = none,
				GRAPPLEADULTNORMAL = none,
				WEAPONFIREDSEEN = none,
				INTIMIDATELITTLEKIDS = none,
				BREAKINGCURFEW = none,
				BREAKENTER = none,
				KOAUTH = none,
				SEENATTACKAUTHORITYNORMAL = none,
				DRESSCODE = none,
				INTIMIDATEAUTHORITY = none,
				YELLFORHELP = none,
				RATPUNISHMENT = none,
				BULLYLITTLEKID = none,
				INTIMIDATESTUDENT = none,
				OBSTRUCTING = none,
				LOCKPICKING = none,
				SEENFIREALARM = none,
				GIRLSDORM = none,
				COMBATTAUNTAUTH = none,
				GRAPPLESTUDENTNORMAL = none,
				GRAPPLEAUTHORITYNORMAL = none,
				TAGCRIME = none,
				BULLYSTUDENT = none,
				SEENATTACKSTUDENTNORMAL = none,
				TAUNTAUTHORITY = none,
				GRAPPLEGIRLNORMAL = none,
				INTIMIDATEADULT = none,
				SEENATTACKGIRLNORMAL = none,
				BULLYGIRLS = none,
				CURFEW = none,
				TRESPASSING = none,
				SEENATTACKLITTLEKIDS = none,
				WEAPONCARRIED = none,
				BULLYADULT = none,
				SKIPPINGCLASS = none,
				SEENATTACKADULTLNORMAL = none,
				TARGETAUTH = none,
				NOHELMET = none,
				STEALBIKE = none,
				LATEFORCLASS = none,
				ESCAPE = none,
				MISCONDUCT = none,
				SEENBREAKPROPNORMAL = none,
				HITVEHICLE = none,
				BULLYAUTHORITY = none,
				INTIMIDATEGIRL = none,
				SEENBREAKGLASSNORMAL = none,
				GRAPPLELITTLEKIDS = none,
			},
			DODGEBALLPHYSICS = {
				REGULARBALL = none,
				STINKBOMB = none,
				WFTBALL_TED = none,
				WFTBALL = none,
				REMOTECHERRYBOMB = none,
				BASEBALLTOSS = none,
				BOUNCYBALL = none,
				SOFT = none,
				BASKETBALL = none,
				CHERRYBOMB = none,
				BROCKET = none,
			},
			PROPS = {
				INFO = {
					STABLE = none,
					DEFAULT = none,
					PROXIES = {
						PXBDRAIL = none,
						PXBENCH1 = none,
						PXLAD4M = none,
						PXPLANTR = none,
						PXSINKG = none,
						PXCDISH = none,
						PXGATCLR = none,
						PXCRAPPY = none,
						PXCTRLBX = none,
						PXLAD5M = none,
						PXTAGLRG = none,
						PXCSHLD = none,
						ARCADES = {
							PXARC3DS = none,
							PXARCDE = none,
							PXARCDO = none,
							PXARCSL = none,
							PXARCMF = none,
							PXARCSU = none,
							PXARCGG = none,
							PXARC3D = none,
							PXARCFS = none,
						},
						PXSTEAM = none,
						PXBED = none,
						PXGARB = none,
						PXSHIELD = none,
						PXLAD10M = none,
						PXWTRFTN = none,
						PXLAD3M = none,
						PXSINK = none,
						PXTREL5M = none,
						PXLAD12M = none,
						PXPRAIL = none,
						PXFRALM = none,
						PXTRE6MB = none,
						PXDORMTV = none,
						PXSHWER = none,
						PXTARGET = none,
						PXBUSSTP = none,
						PXLAD7M = none,
						PX2DSIGN = none,
						PXBIGTAG = none,
						PXCRICKT = none,
						PXAPPLE = none,
						PXURNAL = none,
						PXDISH = none,
						PXFIREEX = none,
						PXWTRP = none,
						PXDORLOK = none,
						PXTREE6M = none,
						PXSPAG = none,
						PXMASH = none,
						PXBRVLT = none,
						PXFRAFFY = none,
						PXSITSTL = none,
						PXTAGMED = none,
						PXTOILEG = none,
						PXTOILET = none,
						PXPOISON = none,
						PXTRAY = none,
						PXBKCASE = none,
						PXTREL10M = none,
						PXGBEDR = none,
						PXMRAIL = none,
						PXBUNSEN = none,
						PXSITCHR = none,
						PXGBED = none,
						PXTAGSML = none,
					},
					FLBPAINT = none,
					CABNTLOK = none,
					AGYMLGHT = none,
					X_TEDY = none,
					X_SLEIGH = none,
					TOOLBOX = none,
					FMCNTRL = none,
					DUNKBTTN = none,
					MPOSTD = none,
					TADSHUD = none,
					ANIBROOM = none,
					SGTARGP = none,
					FGOBLIN = none,
					SGTARGJ = none,
					REEPER = none,
					ANIMSAVE = none,
					POKERTBL = none,
					SGTARGA = none,
					X_CHAIR = none,
					BRSWITCH = none,
					SGTARGR = none,
					FLAGA = none,
					GNOMEA = none,
					CRATEBRK = none,
					FLBTABLE = none,
					SGTARGO = none,
					LOCKERS = {
						LCKRGYMA = none,
						NLOCK01A = none,
						NLOCK02B = none,
						NLOCK01B = none,
						NLOCK03B = none,
						LCKRGYMM = none,
						LCKRGYMB = none,
					},
					X_CCANE = none,
					X_CAS1 = none,
					MPOSTB = none,
					ASYBARS = none,
					COASTER = none,
					SCOBSDR = none,
					TRNCARC = none,
					FLBLADER = none,
					SAVEB = none,
					RMAILBOX = none,
					DEFAULTPROXY = none,
					CLADDERA = none,
					SGTARGT = none,
					FERRIS = none,
					SGTARGL = none,
					SNOWWALL = none,
					LIFEGRD = none,
					JPHOTO = none,
					BARRELLAD = none,
					DRBRACE = none,
					PROPPEDS = {
						CARNI02 = none,
						CARNI01 = none,
						CARNI03 = none,
					},
					EXTWIND = none,
					FUNROCKS = none,
					SCBELL = none,
					TRANSFMR = none,
					SGTARGN = none,
					HSDINGER = none,
					DUFFBAG = none,
					DUNKSEAT = none,
					KEYSWTCH = none,
					OBSMOTOR = none,
					TRNCARB = none,
					PCHAIR = none,
					SGTARGC = none,
					DDUVET = none,
					X_CAS3 = none,
					SGTARGH = none,
					ANIDICE = none,
					NERDBAR1 = none,
					SNOWMND = none,
					FUNMINER = none,
					BOLDROLL = none,
					SGTARGM = none,
					FLBBOOK = none,
					SCGRDOOR = none,
					RSGRDOOR = none,
					X_CAS2 = none,
					PORTAPOO = none,
					SCFERN = none,
					ARMOIR = none,
					FORTTELL = none,
					ASYSWTCH = none,
					SC_CREST = none,
					FUNCURTN = none,
					GHOSTDRS = none,
					SGTARGD = none,
					PVASE = none,
					FMTRAPSW = none,
					SGTARGK = none,
					SNOWMAN = none,
					BMXGATE = none,
					MPOSTA = none,
					WHEELBRL = none,
					TSGATE = none,
					DOORS = {
						ASYDOORS = none,
						SCGATE = none,
						CLOTHESD = none,
						TADDOORR = none,
						CELLDOOR = none,
						TADDOORL = none,
						RIDEGATE = none,
						FDOORC = none,
						DOORSTR1 = none,
						ESCDOORL = none,
						INDDOOR = none,
						BRDOOR = none,
						BUSDOORS = none,
						TADGATES = none,
						ESCDOORR = none,
						FMDOOR = none,
						DRPDOOR = none,
						FMTRAPDR = none,
						PREPDOOR = none,
						STALDOOR = none,
						SCDOOR = none,
						TSGATE = none,
						FDOOR = none,
						FUNTEETH = none,
						BDRDOORL = none,
						FDOORB = none,
						TENNDOOR = none,
						GRDOORR = none,
						BIKEGAR = none,
						CARNCURT = none,
					},
					WPCANNON = none,
					MPOSTC = none,
					NLOCKR = none,
					SGTARGS = none,
					VFLYTRAP = none,
					FGHOST = none,
					TRNCARA = none,
					TREEFALL = none,
					OBSDOOR = none,
					SGTARGG = none,
					SCBANPIL = none,
					WPTURRET = none,
					TRACKSW = none,
					ARMOR = none,
					SGTARGQ = none,
					PPLANT = none,
					SGTARGE = none,
					HALLWIND = none,
					SBARELS1 = none,
					SGTARGB = none,
					ANIGLOBE = none,
					GARBCANA = none,
					X_CNDL = none,
					SGTARGI = none,
					BOXROPES = none,
					FUNCART = none,
					SCAFFOLD = none,
					SGTARGF = none,
					GYMHOOP = none,
					PDOORBRK = none,
					TGKFLAG = none,
					SQUID = none,
					DUMPSTER = none,
					ANIPILLO = none,
					GYMWLAD = none,
					SCFOUNT = none,
				},
				PICKUPLISTS = {
					PICKUPLISTGCANLID = none,
					POPMACHINECASH = none,
					PICKUPLIST1 = none,
					PICKUPLISTMAILBOX = none,
					PICKUPLISTCRATE = none,
					PICKUPLISTCRATESPRAYCAN = none,
					PICKUPLISTWOOD = none,
					PICKUPLISTCRATESPUDGUNS = none,
					PICKUPLISTPOKERTABLE = none,
					PICKUPLISTSFLOWERS = none,
					PICKUPLISTCRATEBROCKETS = none,
					PICKUPLISTMONEY = none,
					PICKUPLISTCRATEHEALTH = none,
					PICKUPLISTMAILBOXSPRAYCAN = none,
					PICKUPLISTWOODMONEY = none,
				},
			},
		},
	},
	NEW = {
		ANIMATIONS = {
			PLAYANIMATIONCYCLIC = none,
			BREAKCYCLICANIMATION = none,
		},
		CUTSCENE = {
			STARTCUT = {
				FINALTEXT = {
					ENDCUT = none,
				},
			},
		},
	},
	J_STRIKER_A = {
		DEFENSE = none,
		OFFENSE = COMMON[423],
		INVINCIBLE = COMMON[395],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[93],
			IDLE = COMMON[427],
			RISINGATTACKS = none,
		},
	},
	P_STRIKER_A = {
		DEFENSE = {
			EVADE = {
				EVADECOUNTER = {
					LIGHTATTACKS = COMMON[66],
				},
				EVADEBACK = none,
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[74],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = COMMON[75],
			},
			MEDIUM = COMMON[76],
		},
	},
	N_STRIKER_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[464],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = COMMON[465],
					HEAVYATTACKS = {
						FATSLAP = {
							ASSTHRUST = none,
						},
					},
				},
			},
		},
	},
	DO_GRAPPLER_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[466],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = COMMON[467],
			OLDMEDIUM = {
				OLDBIKEGRAP = COMMON[468],
			},
		},
	},
	DOOR = {
		DOORFUNCTIONS = {
			OPENING = {
				ASYDOORS = none,
				FDOORB = none,
				DEFAULT = none,
				CELLDOOR = none,
				SCGATE6_02 = none,
				FUNTEETH = none,
				EXTWIND = none,
				PORTAPOO = none,
				ARMOIR = none,
				BUSDOORS = none,
				TADGATES = none,
				SCDOOR = none,
				FMDOOR = none,
				ESCDOORR = none,
				STALDOOR = none,
				FMTRAPDR = none,
				CARNGATE = none,
				INDDOOR = none,
				SCGATE = none,
				BDRDOORL = none,
				ESCDOORL = none,
				BRDOOR = none,
				DOORSTR1 = none,
				BIKEGAR = none,
				CARNCURT = none,
			},
			KICK = {
				DEFAULT = none,
				SCDOOR = none,
				FMDOOR = none,
				ESCDOORR = none,
				DOORSTR1 = none,
				INDDOOR = none,
				ESCDOORL = none,
				PORTAPOO = none,
				BDRDOORL = none,
				STALDOOR = none,
			},
			CLOSING = {
				ASYDOORS = none,
				SCGATE = none,
				DEFAULT = none,
				CELLDOOR = none,
				FMDOOR = none,
				EXTWIND = none,
				PORTAPOO = none,
				ARMOIR = none,
				DOORSTR1 = none,
				BUSDOORS = none,
				TADGATES = none,
				ESCDOORL = none,
				CLOSESOUNDS = {
					ASYDOORS = none,
					FDOORB = none,
					DEFAULT = none,
					BRDOOR = none,
					EXTWIND = none,
					PORTAPOO = none,
					ARMOIR = none,
					BUSDOORS = none,
					TADGATES = none,
					FMTRAPDR = none,
					STALDOOR = none,
					SCDOOR = none,
					CARNGATE = none,
					TSGATE = COMMON[469],
					SCGATE = none,
					BDRDOORL = none,
					ESCDOORR = none,
					ESCDOORL = none,
					DOORSTR1 = none,
					BIKEGAR = none,
					CARNCURT = none,
				},
				ESCDOORR = none,
				FMTRAPDR = none,
				INDDOOR = none,
				STALDOOR = none,
				SCDOOR = none,
				IMMEDIATE = none,
				BRDOOR = none,
				FDOORB = none,
				TSGATE = COMMON[469],
				BDRDOORL = none,
				FUNTEETH = none,
				CARNGATE = none,
				BIKEGAR = none,
				CARNCURT = none,
			},
		},
		DOOR_CAMERAS = {
			DT_TBMX_LEAVE = COMMON[470],
			DT_CARNCURT02 = COMMON[470],
			DOORNAME3CAM = COMMON[471],
			DT_TSCHOOL_LIBRARYL = COMMON[471],
			DT_ASYLUM_EXITL = COMMON[470],
			DT_ISCHOOL_FRONTDOORL = COMMON[471],
			DT_TSCHOOL_BOYSDORML = COMMON[471],
			DT_ICLOTHP_DOORL = COMMON[470],
			DT_TRICH_GENSHOPDOOR = COMMON[472],
			DT_TPOOR_SAFEGREASER = COMMON[472],
			DT_ISCHOOL_BACKDOORRIGHT = COMMON[470],
			DT_CARNCURT01 = COMMON[471],
			DT_TSCHOOL_SCHOOLLEFTBACKDOOR = COMMON[471],
			DT_PREPTOMAIN = COMMON[470],
			DT_ISAFEJOCK_DOORL = COMMON[470],
			DT_FREAKSHOW_ENTRANCE = COMMON[470],
			DT_INDOOR_TATTOOSHOP = COMMON[471],
			DT_POOL_DOORL = COMMON[470],
			DT_INDOOR_WHOUSEFRONT = COMMON[472],
			DT_TSCHOOL_GIRLSDORML = COMMON[471],
			DT_GDORM_DOORL = COMMON[470],
			DT_ICOMSHP_DOOR = COMMON[470],
			DT_IGROCERY_DOOR = COMMON[470],
			DT_JANITOR_MAINEXIT = COMMON[470],
			DT_ICLOTHR_DOORL = COMMON[470],
			DT_WHOUSE_ROOF = COMMON[470],
			DT_TPOOR_BARBER = COMMON[471],
			DT_ICOMSHP_BASEMENT = COMMON[470],
			DT_TSCHOOL_POOLL = COMMON[471],
			DT_LIBRARYEXITR = COMMON[470],
			DT_TSCHOOL_SCHOOLSIDEDOORL = COMMON[471],
			DOORNAME1CAM = COMMON[470],
			DT_GDORM_DOORLEXIT = COMMON[470],
			DT_DORMEXITDOORL = COMMON[470],
			DT_INDOOR_WHOUSEROOF = COMMON[471],
			DT_WHOUSE_FRONT = COMMON[470],
			DT_TSCHOOL_PREPPYL = COMMON[471],
			DT_ISCHOOL_FRONTDOORRIGHT = COMMON[470],
			DT_TRICH_BARBERDOOR = COMMON[472],
			DT_SALON_EXIT = COMMON[470],
			DT_TPOOR_BMX = COMMON[471],
			DT_ASYLUM_FRONT_DOOR = COMMON[471],
			DT_TBUSINESS_BARBER = COMMON[471],
			DT_ISAFEPREP_DOORL = COMMON[470],
			DT_TRICH_CLOTHRICHDOOR = COMMON[472],
			DEFAULT = {
				FMDOOR = none,
				DOORSTR1 = none,
				ESCDOORL = none,
				INDDOOR = none,
				SCDOOR = none,
				TADDOORL = none,
			},
			DT_FREAKENTRANCE = COMMON[471],
			DT_TRICH_BIKESHOPDOOR = COMMON[471],
			DT_ISCHOOL_BACKDOORLEFT = COMMON[470],
			DT_TSCHOOL_AUTOSHOPL = COMMON[471],
			DT_TRICH_BOXINGDOOR01 = COMMON[472],
			DT_ISAFEDROP_DOORL = COMMON[470],
			DT_TRICH_SAFEPREP = COMMON[471],
			DT_PHAIR_DOORL = COMMON[470],
			DT_TBUSINES_BIKESHOPDOOR = COMMON[471],
			DT_TBUSINES_COMICSHOPDOOR = COMMON[471],
			DT_TBUSINES_GENSHOP2DOOR = COMMON[471],
			DT_TSCHOOL_SCHOOLRIGHTFRONTDOOR = COMMON[471],
			DT_TIND_SAFEDROP = COMMON[471],
			DT_ISCHOOL_JANITOR = COMMON[472],
			DT_TSCHOOL_SCHOOLRIGHTBACKDOOR = COMMON[471],
			DT_JANITOR_SCHOOLEXIT = COMMON[470],
			DT_TBUSINES_SAFENERD = COMMON[472],
			DT_TSCHOOL_GYML = COMMON[471],
			DT_IBOXING_DOORL = COMMON[470],
			DT_GYM_DOORL = COMMON[470],
			DT_FREAKSHOW_EXIT = COMMON[470],
			DT_TBUSINES_GENSHOP1DOOR = COMMON[471],
			DT_ISAFEGRSR_DOORL = COMMON[470],
			DT_TSCHOOL_SCHOOLFRONTDOORL = COMMON[471],
			DT_TBUSINES_CLOTHDOOR = COMMON[471],
			DT_IBKSHOP_DOOR = COMMON[470],
			DT_TSCHOOL_SAFEJOCK = COMMON[471],
			DT_BARBER_EXIT = COMMON[470],
		},
		NOTUSEABLE = {
			OPENED = {
				IMMEDIATE = none,
			},
			OPENPARAMETRIC = {
				HANDLESOUNDCALLS = {
					IDLE = none,
					OPENSOUNDS = {
						ASYDOORS = none,
						FDOORB = none,
						ESCDOORR2B = none,
						DEFAULT = none,
						CELLDOOR = none,
						RIDEGATE = none,
						EXTWIND = none,
						ESCDOORL = none,
						BUSDOORS = none,
						STALDOOR = none,
						SCDOOR = none,
						ESCDOORL2B = none,
						FMDOOR = none,
						BDRDOORL = none,
						ESCDOORR = none,
						INDDOOR = none,
						DOORSTR1 = none,
						BIKEGAR = none,
						CARNCURT = none,
					},
				},
			},
		},
		PEDPROPSACTIONS = {
			USINGDOORSPAWNER = none,
			USINGDOOR = none,
			RUNBEFOREANDAFTERUSINGDOOR = COMMON[473],
			RUNAFTERUSINGDOOR = none,
			EXECUTES = {
				SKATEBOARDUNEQUIP = none,
				LOCOSPAWNS = {
					DEFAULT = none,
					GUN = none,
				},
			},
			AFTERUSINGDOOR = none,
			USINGDOORSPAWNERRUN = none,
			BEFOREANDAFTERUSINGDOOR = COMMON[473],
			OLDIDLE = none,
			RUNUSINGDOOR = none,
			ACTIONS = {
				ACTIVATEDOORKICK = {
					ACTIVATEDOORKICK = {
						WEAPONUPPERBODYANIMS = {
							BALLS = none,
							SNOWSHOVEL = none,
							DEFAULT = none,
							GUN = none,
							NOOVERRIDE = none,
							SHIELD = none,
							FIREEXTINGUISHER = none,
							TWOHAND_THROW = none,
							TEDDYBEAR = none,
						},
					},
					KICKDOORCHECK = {
						KICKDOORANIM = {
							REGULARDOOR = none,
							BUTTONDOOR = none,
							GATEDOOR = none,
						},
					},
				},
				STIMULUS = {
					OPENING = none,
					CLOSING = none,
				},
				ACTIVATEBYPED = none,
				ACTIVATE = {
					CHECKDOOR = {
						REGULARDOOR = none,
						BUTTONDOOR = {
							SYNC = none,
							OPEN = none,
						},
						GATEDOOR = {
							SYNC = none,
							OPEN = {
								OPENANIM = none,
							},
							GATEDOORNOTCLEAROFPEDS = none,
						},
					},
				},
			},
			DISENGAGE = COMMON[215],
		},
		CLOSED = COMMON[30],
		EXECUTES = {
			DEFAULTOPENING = none,
			DEFAULTCLOSING = none,
			["6_02_OPENING"] = none,
		},
		CLOSEANDLOCK = none,
	},
	["1_02B"] = {
		PREFECTEDWARDWARN = COMMON[475],
		EMPTY = none,
		CRYING = {
			CRYLOOP = none,
		},
		CARDIDLE = {
			GEEKCARDINITIALIZE = {
				GEEKCARDIDLE = {
					GEEKCARDLOOKAROUND = none,
				},
			},
		},
		ANIMS = {
			GIVE = none,
			GARYSHOVE = {
				GIVE = COMMON[476],
				RCV = {
					ALGIERESPONSE = COMMON[477],
				},
			},
		},
		VICTORY = COMMON[306],
		EATCHOCOLATES = {
			EAT = COMMON[478],
		},
		CONSTANTINOSIDLE = {
			DAMAGE = none,
			DEFAULT_KEY = none,
			LOAD = {
				SETUPCONSTANTINOS = none,
			},
		},
	},
	TAGS = {
		PEDPROPSACTIONS = {
			NOCAN_MESSAGE = none,
			PERFORMTAG = {
				PEDDRAWMEDTAG = {
					TAGSUCCESS = none,
				},
				DRAWMEDTAG = {
					PARAMETRICTAGGING = {
						FINISHED = {
							TAGSPEECH = {
								SPEECHNODE = none,
							},
						},
						FAILURE = none,
						SPAWN = {
							WAITING = {
								TIMEOUT = none,
								RESTARTPAINTING = none,
							},
							PAINTING = none,
						},
					},
				},
			},
			DISENGAGE = {
				DISENGAGEPLAYER = none,
			},
			ISPLAYER = none,
			EQUIPSPRAYCAN = {
				REMOVEOLDWEAPON = none,
				EQUIPSPRAYCAN = none,
			},
			EXECUTES = {
				IDLECANSHAKE = none,
			},
			ISPED = {
				STREAMWEAPON = none,
				SYNC = none,
				EQUIPSPRAYCAN = none,
			},
		},
		USEABLE = none,
		NOTUSEABLE = {
			TAGGED = {
				TAGGED = none,
				EXECUTES = {
					TAGDEFAULTS = none,
				},
				CLEANUP = {
					CLEAN = none,
					ENDSPAWN = none,
					DONTCLEAN = none,
				},
			},
		},
	},
	FIREEXT = {
		PEDPROPSACTIONS = {
			REQUESTWEAPON = none,
			THERE = {
				IDLE = none,
				ACTIONS = {
					TAKEIT = none,
				},
				REQUESTWEAPON_WAIT = none,
			},
			DISENGAGE = COMMON[215],
		},
		THERE = none,
		NOTUSEABLE = none,
	},
	TESTCONV_2PEDA = {
		LOADANIMS = none,
		LINE1 = COMMON[479],
	},
	["3_01C"] = {
		FLOWER = COMMON[480],
		FAIRY = COMMON[480],
	},
	SLINGSHOT = {
		SLINGSHOT = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = COMMON[481],
			ACTIONS = {
				CONTROLLER = {
					SPINECONTROLHACK = none,
					UPPERBODY = {
						OBSTRUCTION_CHECK = COMMON[482],
						FIREACTIONS = {
							CHARGE = {
								RELEASE = {
									RELEASE = {
										FIRE = {
											SUPERSLINGSHOT = {
												FIRESOUND = COMMON[483],
											},
											SLINGSHOT = none,
										},
									},
								},
								CHARGE_HOLD = none,
							},
						},
						AIM = COMMON[484],
					},
				},
				WAIT = none,
			},
			DEFAULT_KEY = none,
		},
	},
	["1_S01"] = {
		["1_S01_STAND_TALKING"] = {
			TALKINGLOOPS = {
				TALKING4 = none,
				TALKING7 = none,
				LISTEN2 = none,
				TALKING5 = none,
				TALKING3 = none,
				TALKING2 = none,
				LISTEN3 = none,
				FAT = COMMON[485],
				LISTEN1 = none,
				LISTEN4 = none,
				TALKING1 = none,
				TALKING6 = none,
			},
		},
		["1_S01_GET_BOTTLE"] = COMMON[429],
		CLEARNODE = none,
		CAMERA = {
			GIVE = none,
			RECEIVE = none,
			SETPROP = none,
		},
		["1_S01_BATHROOM"] = {
			["1_S01_BATHROOM_LOOP"] = {
				["1_S01_BATHROOM_2"] = none,
				["1_S01_BATHROOM_1"] = none,
				["1_S01_BATHROOM_3"] = none,
			},
		},
		OPENLOCKER = {
			WAITINSIDE = none,
		},
		ANIMATIONS = {
			RECEIVE = none,
			GIVE = none,
			GIVE_B = {
				GIVEMISSPHILLIPS1_S01 = COMMON[486],
			},
			SETPROP = none,
		},
		ART_TEACHER_OFFENSE = {
			SHORT = {
				GRAPPLES = {
					GIVE = {
						EARGRAB = COMMON[487],
					},
				},
				HEAVYATTACKS = COMMON[236],
			},
		},
		SUCCESS = {
			CONT = none,
		},
	},
	N_RANGED_A = {
		DEFENSE = COMMON[488],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[489],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = COMMON[465],
					HEAVYATTACKS = COMMON[491],
				},
			},
			MEDIUM = {
				STRIKES = COMMON[492],
			},
		},
	},
	PUNCHBAGAI = COMMON[30],
	ANIMATION = {
		STOPANDLOOK = none,
	},
	CRAZY_BASIC = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = {
					CRAZY_WALKOVERRIDES = COMMON[493],
					RUNBASIC = none,
					WALKBASIC = none,
					SPRINTBASIC = none,
					IDLE_OVERRIDES = COMMON[493],
				},
				LOCOMOTIONOVERRIDE = {
					COMBAT = COMMON[88],
					COMBATSTRAFEIDLE = none,
					FREE = {
						RUNBASIC = none,
						SPEEDRUNBASIC = none,
						WALKBASIC = {
							WEAPONWALKBASIC = none,
							WALKBASIC = none,
						},
					},
				},
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			MEDIUM = {
				GRAPPLESNEW = COMMON[468],
			},
			SHORT = {
				SHORT = COMMON[496],
			},
		},
	},
	IRISHWHIP = {
		GIVE = {
			GIVERELEASE = none,
		},
		RCV = {
			RCVRUNRELEASE = none,
		},
	},
	GUN = {
		GUN = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = COMMON[166],
			ACTIONS = {
				CONTROLLER = {
					SPINECONTROLHACK = none,
					UPPERBODY = {
						OBSTRUCTION_CHECK = COMMON[482],
						FIREACTIONS = {
							POISONSPRAY = {
								POISONANIMS = {
									SPRAY = none,
								},
								FIRE = none,
								SPRAYFRONTRUN_OLD = {
									BACKUP = none,
									SPRAYFRONTRUN_RELEASE = none,
									SPRAYFRONTRUN2 = none,
								},
								FIRESEQUENCE = {
									SPRAYFRONTRUN = {
										SPRAYFRONTRUN2 = none,
									},
									WEEDKILLERSPRAY = {
										WEEDKILLERSPRAY2 = none,
									},
								},
							},
							SPUDG = {
								CHARGE = none,
								RELEASE = {
									FIRE = {
										PRIMARY = {
											FIRE = COMMON[143],
										},
									},
									RELOAD = {
										CROUCHRELOAD = none,
										RELOAD = none,
									},
									DRYFIRE = COMMON[506],
								},
							},
							BROCKET = {
								CHARGE = none,
								RELEASE = {
									FIRE = {
										PRIMARY = {
											HANDLEROCKETS = {
												REMOVE2ND = none,
												REMOVE1ST = none,
												REMOVELAST = none,
											},
											FIRE = none,
										},
									},
									RELOAD = {
										CROUCHRELOAD = none,
										RELOAD = none,
										ADDROCKETS = {
											DETACHALLHACK = none,
											AMMO2 = none,
											AMMO1 = none,
											AMMO3 = none,
										},
									},
									DRYFIRE = COMMON[506],
								},
							},
						},
						AIM = COMMON[484],
					},
				},
				WAIT = {
					TREEIDLE = none,
				},
				ATTACKS = {
					HEAVYATTACKS = COMMON[170],
				},
			},
			DEFAULT_KEY = none,
		},
	},
	REFCOUNTING = {
		KISS_ME_BABY = {
			RELEASEANIMGROUP = COMMON[112],
			GRAPPLEATTEMPT = {
				GRAPPLESUCCESS = {
					PULL_IN_HEAVY = {
						HELD = none,
						HOLD_IDLE = {
							GIVE = none,
							GRAPPLEBREAK = {
								BREAK_RCV = {
									RELEASEGROUPFAKE = none,
								},
								BREAK_GIVE = none,
							},
							RCV = none,
						},
						HOLD = none,
					},
					GRAPPLERCVWAIT = none,
				},
			},
			LOAD_ANIMATION = COMMON[510],
		},
	},
	["5_G5"] = {
		LOST = COMMON[511],
		SUCCESS = none,
		EMPTY = none,
		FAILURE = COMMON[373],
		NIS_ANIMS = {
			ZOE = {
				ZOE_01 = none,
				ZOE_02 = none,
				ZOE_03 = none,
				ZOE_04 = none,
			},
			JIMMY = COMMON[512],
		},
		ZOEFAILURE = none,
		["5_G5_BEGIN"] = {
			LOADANIMS = none,
			PLAYERIDLE = none,
			ZOEIDLE = {
				ZOEIDLE_END = none,
			},
			LINE1 = {
				LINE2 = {
					LINE3 = {
						LINE4 = {
							LINE5 = COMMON[95],
						},
					},
				},
			},
			CONVINITIATE = none,
		},
	},
	["5_04"] = {
		UNCONSCIOUS = {
			GIRL = none,
			BOY = {
				ONBELLY = none,
				ONBACK = none,
			},
		},
		CONSCIOUS = {
			GETUP = {
				GETUPFROMBACK = none,
				GETUPFROMBELLY = none,
			},
			LOOKAROUND = {
				WHATTHE = none,
			},
			IDLE = {
				IDLE_GIRL = none,
				IDLE_BOY = none,
			},
		},
	},
	WEAPONS = {
		PICKUPACTIONS = {
			PICKUP = {
				PICKUPPROP = {
					PICKUPACT = {
						PICKUPPROPHACK = none,
						PICKUPSTATS = {
							ANIBBALL = none,
						},
					},
					PICKUPACT2H = none,
				},
			},
			PICKUPSNOWBALL = {
				REMOVEOLDWEAPON = none,
				PICKUPWEAPON = {
					PICKUPWEAPON = {
						ATTACHWEAPON = {
							LOADSTUFF = none,
							ATTACHWEAPON = none,
						},
					},
					LOADANIMATIONGROUP = none,
				},
			},
			PICKUPCANDY = {
				LOOKDOWN = {
					PICKUPCANDYACT = {
						PICKUPCANDYEAT = none,
					},
				},
			},
			PICKUPGARBAGE = {
				CANPICKUP = COMMON[513],
				GOUP = none,
			},
			CATCHPROJECTILE = {
				PICKUPWEAPONWAIT = COMMON[130],
			},
		},
		WEAPONOBJECTDAMAGE = {
			CHECKWEAPONDAMAGE = {
				PLAYDAMAGESOUND = {
					DEFAULT = none,
					YARDSTICK = none,
				},
			},
		},
		NEEDINIT = {
			WEAPONINIT = {
				NOWEAPON = COMMON[514],
				PROJECTILEWEAPONS = {
					SLINGSHOT = COMMON[514],
					FIREEXTING = COMMON[514],
					W_PGUN = COMMON[514],
					SUPERSLING = COMMON[514],
					SPRAYCAN = COMMON[514],
					POTATOGUN = COMMON[514],
					BOTTLEROCKET = COMMON[514],
					BBGUN = COMMON[514],
				},
				MELEE = {
					JBROOM = COMMON[515],
					EDGARSHIELD = {
						LID = none,
					},
					WTRAY = {
						WTRAY_INIT = none,
						WTRAY_SCATTER = none,
					},
					DEFAULT = none,
					RESETUMBRELLA = none,
					SETINFO = none,
					OTHERMELEE = {
						PINKYWAND = none,
						POOLCUE = none,
						YARDSTICK = none,
						DEVILFORK = none,
						SSWHIP = none,
						BOLTCUTTERS = none,
						BAGBOTTLE = none,
						WRENCH = none,
					},
					BATWEAPONS = {
						LEADPIPE = none,
						["2X4"] = none,
						POLO = none,
						CRICKET = none,
						BASEBALL = none,
					},
					NERDBOOKS = {
						BOOKSCATTER = none,
						BOOKINIT = none,
					},
					WATERPIPE = {
						WATERPIPE = none,
					},
					SHIELDWEAPONS = {
						LID = none,
						DEFAULT = none,
					},
					FLASHLIGHT = none,
					BOLTCUTTERS_ZOE = {
						BOLTCUTTERS = none,
					},
					SLEDGE = COMMON[515],
				},
				SPECIAL = {
					WCAMERASETINFO = none,
					MUD = none,
					TEDDYBEAR = none,
					SKATEBOARD = none,
				},
				THROWN_BIKE = {
					DEFAULT = none,
					CHERRYANDSTINK = none,
					NEWSPAPER = none,
				},
				THROWN = {
					BOTTLE = none,
					CHERRYANDSTINK = none,
					UNDERHAND = none,
					BANANA = {
						BANANA = none,
						PEELED = none,
					},
					FIREWORKS = none,
					BRICK = none,
					DEADRAT = none,
					SMALLBALL = none,
					BALL = {
						BBALL_RESET = none,
					},
					WBALLOON = none,
					WFTBOMB = none,
					VASE = none,
					DEFAULT = none,
				},
			},
		},
		SELECTACTIONS = {
			WEAPONSELECT = {
				FORCEDESIREDWEAPON = COMMON[351],
				DESELECT = {
					DROPDIRECT = {
						PUTAWAY = {
							RIGHT = none,
							DEFAULT = none,
							LEFT = none,
						},
						DROPNONINV = {
							DROP = COMMON[516],
							DROPVIAPROJECTILE = COMMON[516],
							DETACH = none,
						},
					},
					SPAWNLOCO = none,
				},
				EXECUTENODES = {
					SPECIAL_INIT = {
						SPUDZ = none,
						BOTTLLEROCKET = {
							INITROCKETS = {
								DETACHALLHACK = none,
								INITROCKETS = none,
								AMMO1 = none,
								AMMO2 = none,
								AMMO3 = none,
							},
						},
					},
					TIRED_UPPERBODY = none,
				},
				SELECT = {
					DEFAULT = {
						ANIMS = {
							SK8BOARD = none,
							BALL = none,
							DEFAULT = none,
							GUN = none,
						},
					},
					EXECUTEBANK = {
						AUTOFIRECHECK = none,
					},
				},
				SELECTACTIONERROR = none,
			},
		},
	},
	["3_04"] = {
		["3_04_CONV"] = none,
		["3_04_ANIM"] = {
			OUTROEARNEST = {
				OUTROEARNEST01 = {
					OUTROEARNEST02 = none,
				},
			},
			NERDSCARED = {
				SCARED_03 = none,
				SCARED_04 = none,
				CORNELIUS1 = none,
				SCARED_01 = none,
				SCARED_02 = none,
				SCARED_05 = none,
			},
			NORTON = {
				NORTON01 = none,
			},
			GARYINTRO = {
				GARY1 = none,
			},
			JOHNNYIDLE = {
				JOHNNY2 = none,
				JOHNNY1 = none,
				JOHNNYIDLE_CHILD = none,
				JOHNNYIDLE = none,
				FIGHT_IDLE = none,
			},
			JOHNNYSHOVE = {
				GIVE = COMMON[476],
				RCV = {
					NERD_IDLE = COMMON[477],
				},
			},
			CHEER_COOL3 = {
				CHEER_COOL_12 = none,
				CHEER_COOL_11 = none,
				CHEER_COOL_14 = none,
				CHEER_COOL_15 = none,
				CHEER_COOL_13 = none,
				STEPS = COMMON[517],
			},
			ANGRYDRIVER = {
				SHAKEFIST = none,
				DISGUSTED = none,
				STEPS = COMMON[517],
			},
			OUTROCORNELIUS = {
				OUTROCORN01 = none,
			},
			ALGIE = {
				ALGIE01 = none,
			},
			ALGIEOHFACE = {
				OHFACE = none,
			},
			EMPTY = none,
			ALGIECOWER = {
				COWERSTART = {
					COWERCYCLE = none,
				},
			},
			OUTROALGIE = {
				OUTROALGIE01 = none,
			},
		},
		NIS = {
			RICKY = none,
		},
		["3_04_END"] = {
			NERDS = {
				EARNEST01 = none,
				CORNELIUS01 = none,
				ALGIE01 = none,
			},
			SETUP = {
				CORNELIUS = {
					EARNEST = {
						ALGIE = {
							JIMMY = COMMON[95],
						},
					},
				},
			},
			JIMMY = COMMON[220],
		},
	},
	SOCIALANGRYSHOVE = {
		EXECUTEBRINGITON = none,
	},
	["1_04"] = {
		EXERCISE = {
			BREAKJJ = none,
			AEROBICS = {
				JJ_FOREVER = none,
				PUSHUP_FOREVER = none,
				TIRED_IN = none,
				AEROBIC = {
					PUSHUP_IN = {
						PUSHUP_LOOP = {
							PUSHUP_OUT = none,
						},
					},
					JJ = none,
				},
			},
			BURTONPOINT = none,
			BREAKPUSHUP = none,
			BURTONCOMEON = none,
		},
		["1_04_CLEARACTIONS"] = none,
		GARYPOINT = {
			GARYPOINTANIM = none,
		},
	},
	CONTROLLER = {
		DEFAULT = {
			CONTROLLER = none,
		},
		OBJECTIVES = COMMON[518],
	},
	AI_WRESTLER = {
		TUTORIAL = {
			STAGE2 = COMMON[519],
			STAGE5 = COMMON[520],
			STAGE1 = COMMON[519],
			STAGE3 = COMMON[520],
			STAGE4 = COMMON[520],
		},
	},
	["2_04_CONV"] = {
		ALLYCHEER = none,
		LOADANIMS = none,
		PLAYERIDLE = none,
		NIS_SUCCESS = {
			TOBIAS02 = none,
			TOBIAS01 = none,
		},
		M_2_04_19 = {
			M_2_04_19_CHILD = {
				M_2_04_19 = COMMON[522],
			},
		},
		CONVINITIATE = none,
		RESET = none,
		TOBIASIDLE = {
			TOBIASIDLE_END = none,
		},
		M_2_04_19_OLD = {
			M_2_04_20 = COMMON[522],
		},
		CHEERAGE = COMMON[523],
	},
	SHIELDS = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = COMMON[65],
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					COLLISIONEXECUTES = {
						SWING = COMMON[549],
						EXECUTEBANK = {
							SMASH_PLATE = none,
						},
						SMASH = COMMON[549],
					},
					SWING = {
						SMASH = none,
					},
				},
				THROWACTIONS = {
					FRISBEETHROW = {
						THROWSTARTMOBILE = {
							THROWFINISH = {
								THROWFINISHLID = none,
								THROWFINISHTRAY = none,
								THROWFINISHPLATE = none,
							},
						},
					},
				},
			},
			TRAYALTERNATEMODE = {
				TRAY_HOLD = {
					TRAY_INITIALISE = {
						ADDSTUFFTOTRAY = none,
					},
					TRAY_SCATTER = none,
					SMASH = none,
				},
			},
			LID_BLOCKS = {
				BLOCKPROJECTILES = none,
				BLOCKHITS = {
					BREAKER = none,
					HITSLIGHT = {
						BLOCK_RESULTS = {
							SOUNDHACK_LID = none,
							DEC_PLATE_SMASH = none,
							SOUNDHACK_PSHIELD = none,
						},
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	P_SNOW = {
		INTRO = {
			PREFECT01 = {
				PREFECT02 = {
					PREFECT03 = COMMON[550],
				},
			},
		},
		ANIMS = {
			SHOVEL = {
				DETECTSNOW = none,
			},
			EMPTY = none,
			BLOCK = none,
			BONK = none,
			BREAK = none,
			WEAPONSTRAFE = none,
		},
	},
	TATTOOSHOP = {
		ANIMATIONS = {
			END = none,
			LEFTARM = COMMON[551],
			IDLE = none,
			RIGHTARM = COMMON[551],
		},
	},
	G_JOHNNY = {
		CINEMATIC = {
			KICKDOWN = COMMON[556],
			THROATGRAB = {
				DASH = {
					THROATGRAB = COMMON[557],
				},
			},
			JIMMY = {
				BELLYUP = {
					ON_GROUND = none,
					BELLYUPGETUP = {
						BELLYUPGETUPGETUP = none,
					},
				},
				BELLYDOWN = {
					ON_GROUND = none,
					BELLYDOWNGETUP = COMMON[558],
				},
			},
		},
		DEFENSE = none,
		COMBATTAUNT = {
			COMBATTAUNT = none,
		},
		OFFENSE = {
			LONG = {
				GOTOSPECIAL = COMMON[175],
			},
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = {
						COMBO2 = {
							JAB = {
								RIGHTHOOK = {
									LEFTHOOK = none,
								},
							},
						},
						COMBO1 = COMMON[559],
					},
					TOSPECIAL = COMMON[560],
					JOHNNYKICK = none,
					HEAVYKICK = {
						MIDKICK = none,
						HEAVYKICK = {
							GRABKNEES = COMMON[561],
							COLLISION = COMMON[562],
							HEAVYKICKLAND = none,
						},
					},
				},
			},
			SPECIAL = {
				SPECIALACTIONS = {
					GRAPPLES = {
						DASH = {
							THROATGRAB = COMMON[557],
							DASHTIRED = COMMON[17],
						},
					},
					LIGHTATTACKS = COMMON[556],
					EXECUTENODES = COMMON[18],
				},
			},
			MEDIUM = {
				STRIKES = {
					JOHNNYKICK = none,
					HEAVYATTACK = COMMON[564],
					TOSPECIAL = COMMON[560],
				},
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[565],
			IDLE = none,
			RISINGATTACKS = COMMON[181],
		},
	},
	["3_03"] = {
		ANIMATIONS = {
			BREAK = none,
			TALKING = none,
		},
		SECOND = {
			["3_03_START2"] = {
				["3_03_08"] = {
					["3_03_09"] = none,
				},
			},
		},
		WAVE = COMMON[566],
		INTRO = {
			LOLA1 = {
				LOLA2 = {
					LOLA3 = {
						LOLA4 = {
							LOLARUNTOALLEY = COMMON[550],
						},
					},
				},
			},
		},
	},
	["4_03"] = {
		["4_03_TAD_FIGHT"] = {
			["4_03_TAD_FIGHT_THREAT"] = none,
			["4_03_TAD_FIGHT_RUN"] = none,
		},
		ANIMS = {
			DEJECTEDC = COMMON[567],
			CELEBRATE = none,
			DEJECTEDA = COMMON[567],
			BREAK = none,
			DEJECTEDB = COMMON[567],
		},
		["4_03_DOOR_ATTACKER"] = {
			["4_03_DOOR_ATTACKER_READY"] = none,
			["4_03_DOOR_ATTACKER_RUN"] = none,
			["4_03_DOOR_ATTACKER_IDLE"] = none,
		},
		["4_03_CS1"] = {
			["4_03_CS1_1_1"] = {
				["4_03_CS1_2_1"] = {
					["4_03_CS1_3_1"] = {
						["4_03_CS1_4_1"] = {
							["4_03_CS1_5_1"] = {
								["4_03_CS1_6_1"] = none,
							},
						},
					},
				},
			},
		},
		["4_03_CS2"] = {
			["4_03_CS2_1_1"] = {
				["4_03_CS2_2_1"] = {
					["4_03_CS2_3_1"] = none,
				},
			},
		},
	},
	DORMTV = {
		OFF = none,
		PEDPROPSACTIONS = {
			TURNON = none,
			TURNOFF = none,
			DISENGAGE = COMMON[215],
		},
		ON = {
			PLAYSHOW = none,
		},
		NOTUSEABLE = none,
	},
	GARYAI = {
		COMBAT = {
			ACTIVECOMBAT = {
				GUARDLOCO = none,
				COMBATLOCO = none,
				CHEERLOCO = none,
			},
		},
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[98],
		COMBATACTIONS = {
			CONTROLNODE = none,
			COMBATACTIONS = {
				CLOSINGATTACK = COMMON[623],
				EVADE = {
					EVADE = none,
					EVADEATTACK = none,
				},
				PURSUITATTACK = COMMON[624],
				GROUNDATTACK = COMMON[148],
				BLOCK = COMMON[99],
				POSTHIT = COMMON[625],
				COUNTERATTACK = COMMON[101],
				TAUNT = COMMON[149],
				OFFENSE = {
					MELEEACTIONS = {
						MEDIUM = COMMON[156],
						SHORT = {
							GRAPPLE = none,
							SHORT = none,
						},
					},
				},
			},
		},
		TETHERLOCO = COMMON[626],
	},
	BASKETBALL = {
		BASKETBALL = {
			SOCIALEXECUTE = none,
			FULLBODYACTIONOPPS = none,
			ACTIONS = {
				BBALL_HOOP = COMMON[627],
			},
			DEFAULT_KEY = {
				LOCOSPAWN = {
					SPAWNLOCO = none,
					DONTSPAWNLOCO = none,
				},
				BOUNCECYCLES = {
					IDLES = {
						BBALLCROSS = none,
						BBALLIDLE = none,
					},
					WEAPONSTRAFE = none,
					WEAPONRUN = none,
					WEAPONWALK = none,
				},
			},
		},
	},
	SHOTS = {
		SHOTS_IDLE = none,
	},
	PLAYERFACIAL = {
		FACIAL = {
			HAPPY = COMMON[628],
			LOW_HEALTH = COMMON[629],
			NEUTRAL = COMMON[630],
			SURPRISE = COMMON[631],
			ANGRY = COMMON[632],
		},
	},
	["1_02AGGRO"] = {
		["1_02AGGRO_CHILD"] = COMMON[633],
	},
	["1_08"] = {
		["1_08_BENTOVERPUKE"] = {
			SITDOWN = {
				IDLE = {
					GOIN = {
						THROWUP = {
							THROWUP_CHILD = none,
						},
					},
				},
			},
		},
		["1_08_FATTY"] = {
			IDLE = {
				STANDSTILL = none,
			},
		},
		TARGET = COMMON[634],
		PATROLMONITOR = {
			RESUMEPATROL = none,
		},
		["1_08_GIVESTINK"] = {
			FATTYGIVE = none,
		},
		CONTINUE = none,
		SHORTIDLE = none,
		["1_08GIRLSDRILLING"] = {
			["1_08DRILLA"] = {
				["1_08DRILLA2"] = {
					["1_08DRILLB"] = {
						["1_08DRILLB2"] = none,
					},
				},
			},
			["1_08MANDYSAYINGCMON"] = none,
			["1_08DRILLB"] = {
				["1_08DRILLB2"] = {
					["1_08DRILLC"] = {
						["1_08DRILLC2"] = none,
					},
				},
			},
			["1_08DRILLC"] = {
				["1_08DRILLC2"] = {
					["1_08DRILLA"] = {
						["1_08DRILLA2"] = none,
					},
				},
			},
		},
		["1_08_ROLLDICE"] = {
			IDLE = {
				PICKUP = {
					SHAKE = {
						ROLL = none,
					},
				},
			},
			ISSOCIALIZING = {
				STANDUP = none,
			},
		},
		["1_08_BEATRICE"] = {
			IDLE = {
				RAND = {
					DORAND = {
						DEFAULT = none,
						COMBHAIR = none,
						LOOKATMIRROR = none,
					},
				},
			},
		},
		GUARDBEHAVIOUR = {
			STANDGUARD = {
				STANDGUARD_CHILD = none,
			},
		},
		["1_08_PREFECT"] = {
			["1_08_IDLE"] = none,
			["1_08_LOOKAROUND"] = none,
		},
		["1_08_CAF_GRAB_PLAYER"] = {
			GRAPPLEATTEMP = {
				EARGRAB = COMMON[487],
				WAIT = none,
			},
		},
		CAFETERIALADY = {
			MONITOR = {
				MONITOR = COMMON[635],
			},
			POINTWARN = COMMON[636],
			POINT = {
				POINT = none,
			},
			RESUME = {
				RESUME = none,
			},
			MONITORONCE = {
				MONITORONCE = none,
			},
		},
		["1_08_MANDYCOLLPASE"] = {
			DOOIT = none,
		},
		INTERACTWITHTOILET = none,
		NIS_1_08_1 = {
			LOADANIMS = none,
			PLAYERIDLE = none,
			LINE1 = COMMON[637],
			CONVINITIATE = COMMON[638],
			GARYIDLE = {
				GARYIDLE_END = none,
			},
		},
		["1_08_MANYSAWPLAYER"] = {
			POINTAT = none,
		},
		["1_08_GETCHOCOLATE"] = {
			GRABCHOCO = none,
		},
		["1_08_GIVENOTES"] = {
			["1_08_GIVE"] = {
				GIVELABNOTES1_08 = COMMON[486],
			},
		},
		PATROLDIALOGUE = {
			["1_08_P1"] = {
				["1_08_P1_2"] = {
					["1_08_P2"] = {
						["1_08_P3"] = {
							["1_08_P4"] = {
								["1_08_P5"] = {
									["1_08_P6"] = {
										["1_08_P7"] = none,
									},
								},
							},
						},
					},
				},
			},
		},
		["1_08_GARYWALL"] = {
			WALL_START = {
				WALL_IDLE = none,
			},
			WALKTOWALL = none,
		},
		OPENCUT = {
			["1_08_REMINDER"] = {
				["1_08_BR1"] = none,
			},
			TARGET = COMMON[634],
			["1_08_PREFECT"] = {
				["1_08_PF01"] = {
					["1_08_PF02"] = {
						["1_08_PF03"] = none,
					},
				},
			},
			["1_08_NERDONOCAKE"] = {
				["1_08_N7"] = {
					["1_08_N8"] = none,
				},
			},
			["1_08_NERDO"] = {
				["1_08_N1"] = {
					["1_08_N2"] = {
						["1_08_N3"] = {
							["1_08_N4"] = {
								["1_08_N5"] = {
									["1_08_N6"] = none,
								},
							},
						},
					},
				},
			},
			["1_08_BEGINSTART"] = {
				["1_08_C1"] = {
					["1_08_C2"] = {
						["1_08_C3"] = {
							["1_08_C4"] = {
								["1_08_C5"] = {
									["1_08_C6"] = {
										["1_08_C7"] = {
											["1_08_C9"] = {
												["1_08_C10"] = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
			["1_08_ENDSTART"] = {
				["1_08_E1"] = {
					["1_08_E2"] = {
						["1_08_E3"] = {
							["1_08_E4"] = {
								["1_08_E5"] = {
									["1_08_E6"] = none,
								},
							},
						},
					},
				},
			},
			["1_08_NERDOYESCAKE"] = {
				["1_08_N7"] = {
					["1_08_N9"] = {
						["1_08_N10"] = {
							["1_08_N11"] = {
								["1_08_N12"] = {
									["1_08_N13"] = {
										["1_08_N14"] = none,
									},
								},
							},
						},
					},
				},
			},
			CONTINUE = none,
		},
		LOCKERSEQUENCE = {
			SEARCHING = {
				GUYENTERS = {
					GIVEIT = {
						COMEANDGETIT = none,
					},
				},
			},
		},
		["1_08_AFTERCAKE"] = {
			["1_08_CAFETERIAWCAKE1"] = {
				["1_08_CAFETERIAWCAKE2"] = none,
			},
		},
		["1_08_CAFETERIA"] = {
			["1_08_CAFETERIAWOCAKE"] = none,
		},
		LAUNCH108 = none,
	},
	["3_08"] = {
		WAVEATJIMMY = {
			WAVEATJIMMY = none,
		},
		QUICKIDLE = none,
		JIMMYGETGIFT = {
			JIMMYGETGIFT = none,
		},
		GIVEJIMMYGIFT = {
			GIVEJIMMYGIFT = none,
		},
		WAVEATSECRETARY = {
			WAVEATSECRETARY_CHILD = none,
		},
		OPENGIFT = {
			OPENGIFT = none,
		},
		SECRETARYGETUP = COMMON[357],
		NEWSWEATER = none,
	},
	BED = {
		PEDPROPSACTIONS = {
			EXEC = {
				WIDESCREEN = none,
				NORMAL = none,
				FADEIN = none,
				FLAGSANDLUA = none,
			},
			DISENGAGE = COMMON[215],
			GETINTOBED = {
				GETINTOBEDR = none,
				GETINTOBEDL = none,
			},
			LOAD = {
				STARTDIALOGBOX = {
					STARTDIALOGBOX = none,
					CANCELSLEEP = none,
				},
			},
		},
		USEABLE = none,
		NOTUSEABLE = none,
	},
	C5 = {
		EARNC = none,
		FAILURE = COMMON[373],
		UNLOCKS = COMMON[371],
		WORKOUT = COMMON[640],
		CLEAR = none,
		PLAYERVICTORY01 = none,
	},
	MGMUSIC = {
		CM_INTRO1 = {
			CM_2 = COMMON[641],
		},
		ANIMATIONS = {
			SUCCESS2 = none,
			HIT = COMMON[642],
			SUCCESS = none,
			GARY = COMMON[643],
			UNLOCKS = COMMON[644],
			FAILURE = COMMON[373],
			JIMMY = COMMON[643],
			MISS = {
				FACIAL1 = none,
			},
			TEACHER = {
				FACE = COMMON[642],
				CUSTOMIDLEENTER = none,
				CUSTOMIDLE = none,
			},
		},
	},
	TE_FEMALE_A = {
		DEFENSE = COMMON[244],
		DEFAULT_KEY = COMMON[652],
		OFFENSE = {
			SHORT = {
				GRAPPLES = COMMON[176],
			},
		},
	},
	SPRAYCAN = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = {
			ANIMATIONS = {
				WEAPONWALK = none,
				WEAPONBIKEIDLE = none,
				WEAPONSOCIAL = none,
				WEAPONCROUCH = none,
				WEAPONRUN = none,
				WEAPONSTRAFE = none,
				WEAPONIDLE = none,
			},
			GLOBALLOCO = COMMON[165],
		},
		ACTIONS = {
			TAGS = {
				PROPINTERACTLOCO = none,
			},
			ATTACKS = {
				HEAVYATTACKS = {
					SPRAYFRONT = {
						SPRAYEND = none,
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	LOCOMOTIONOVERRIDE = COMMON[82],
	SLASHER = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = COMMON[65],
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					COLLISIONEXECUTES = {
						POKE = {
							STICK_DEFAULT = none,
						},
						SWING2 = COMMON[691],
						SWING1 = {
							POOLCUE = none,
							WHIP = none,
							WAND = none,
							STICK_DEFAULT = none,
						},
						EXECUTEBANK = {
							COLLISIONFX = none,
						},
						SWING3 = COMMON[691],
						FORCEFEEDBACK = {
							FF144 = none,
							FF120 = none,
						},
					},
					SWING1 = {
						RELEASE = {
							UNBLOCKABLE = COMMON[692],
							SWING1 = none,
						},
						SWING2 = {
							RELEASE = {
								UNBLOCKABLE = {
									SWING2_CHARGED = none,
								},
								SWING2 = none,
							},
							SWING3 = {
								RELEASE = {
									UNBLOCKABLE = COMMON[692],
									SWING3 = none,
								},
							},
						},
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	CHAPT2TRANS = COMMON[693],
	J_MASCOT = {
		DEFENSE = none,
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				LIGHTATTACKS = {
					LIGHTATTACKSOP = none,
				},
				HEAVY = {
					STUNNERS = {
						HEADBUTT = none,
						SACK = {
							SACKFREQ = {
								GUTKICK_R = none,
								OUT = none,
							},
						},
					},
				},
			},
			DANCE = {
				DANCING = COMMON[694],
			},
			MEDIUM = COMMON[496],
			SPECIAL = {
				EXECUTENODES = {
					HEADBUTT_LOCO = none,
				},
				MASCOT = {
					MASCOT = {
						SPECIALCHOOSE = {
							HEADBUTT = {
								INVINCIBLE = {
									HEADBUTT = COMMON[174],
								},
							},
							DANCE = none,
						},
					},
				},
			},
		},
		INVINCIBLE = COMMON[395],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[697],
			IDLE = none,
			RISINGATTACKS = COMMON[181],
		},
	},
	WCAMERA = {
		WCAMERA = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = {
				ANIMATIONS = {
					WEAPONWALK = none,
					WEAPONBIKEIDLE = none,
					WEAPONSOCIAL = {
						AIM = none,
						PERFORMINGACTION = none,
					},
					WEAPONCROUCH = none,
					WEAPONRUN = {
						AIM = none,
						RELAXEDHOLD = none,
					},
					WEAPONSTRAFE = none,
					WEAPONIDLE = none,
				},
				GLOBALLOCO = COMMON[165],
			},
			ACTIONS = {
				CONTROLLER = {
					SPINECONTROLHACK = none,
					AUTOAIM = COMMON[167],
					UPPERBODY = {
						PRIMARY_FIRE = {
							TAKEPICTURE = {
								WAITONEFRAME = none,
							},
							SET1STPERSON = none,
						},
						AIM = {
							AIM_LOOP = {
								AIM_2IDLE = {
									LOCKRELEASE = none,
									["1STPERSONRETURN"] = none,
								},
							},
							IDLE_2AIM = none,
						},
					},
				},
				WAIT = none,
			},
			DEFAULT_KEY = none,
		},
	},
	KEEPUPS = {
		KEEPUPS = {
			EXECUTENODES = {
				PICKUPREMOVE = none,
			},
			ATTACH = none,
		},
		IDLEANIMATIONS = {
			WALKTOWALL = none,
			PLAYERIDLE = none,
			PLAYERWIN = none,
			JOCKIDLE = none,
			PLAYERFAIL = none,
			WALL_START = {
				WALL_IDLE = {
					WALLUPPERBODY = {
						WALLUPPERBODYA = none,
						WALLUPPERBODYB = none,
					},
					WALL_END = none,
				},
			},
		},
		SEQUENCES = {
			FAIL = {
				FAILMISSION = none,
			},
			JOCKSEQUENCE = {
				JOCKSEQUENCEHOLD = {
					JOCKSEQUENCESCRIPT = none,
				},
			},
			TIER1 = {
				TIER2 = {
					HOLDUP = none,
					TIER3 = {
						TIER4 = {
							HOLDUP = none,
							TIER5 = {
								HOLDUP = none,
							},
						},
						HOLDUP = none,
					},
				},
				HOLDUP = none,
			},
			DETACH = none,
		},
		KEEPUPSSTART = none,
	},
	AI_BOXER = {
		COMBAT = {
			ACTIVECOMBAT = {
				GUARDLOCO = none,
				CHEERLOCO = none,
				COMBATLOCO = none,
				SPECIAL = none,
			},
		},
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[98],
		COMBATACTIONS = {
			CONTROLNODE = none,
			COMBATACTIONS = {
				CHARGE_COUNTERATTACK = COMMON[101],
				BLOCK = COMMON[746],
				POSTHIT = COMMON[625],
				EVADE = COMMON[1],
				COUNTERATTACK = COMMON[101],
				OFFENSE = {
					MELEEACTIONS = {
						SPECIAL = COMMON[747],
						SHORT = COMMON[107],
						MEDIUM = COMMON[156],
					},
				},
				TAUNT = COMMON[149],
			},
		},
		TETHERLOCO = COMMON[626],
	},
	BIKELOCKPICK = {
		LOCKED = {
			SCRIPTEXECUTES = {
				SETUP = none,
				DISPLAYHUD = none,
				REWARD = none,
			},
			LOOPPICKING = {
				TRYOPEN = {
					OPENING = none,
				},
				LOOPPICKING = COMMON[194],
			},
			PLAYERSTOPEDUSING = none,
			LOOKAROUND = {
				LEANIN = none,
			},
		},
	},
	N_EARNEST = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = COMMON[489],
		},
		OFFENSE = {
			FIRESPUDGUN = none,
			THROWBOMBS = none,
		},
	},
	C2_ARTCLASS = {
		STUDENT01 = none,
		TEACHERSPEAKING = {
			TEACHERSPEAKING01 = none,
		},
		PLAYERFAIL = COMMON[373],
		TEACHERLISTENING = none,
		PLAYERVICTORY = {
			UNLOCKS = COMMON[371],
			PLAYERVICTORY02 = none,
			PLAYERVICTORY01 = none,
		},
		CLEAR = none,
		TEACHERIDLE = none,
		TEACHERDISGUST = none,
		STUDENT02 = none,
	},
	LIGHTFIRE = {
		START = {
			END = {
				RESTORE = none,
			},
		},
	},
	CAMERA = {
		CAMERAACTIONS = {
			AUTOMATIC = {
				FOLLOWCAM = {
					ACTIVATE = {
						SWITCH = none,
						SET = none,
						DESIREDNORESET = none,
						BLEND = none,
						DESIREDRESET = none,
					},
				},
				OFFSETCAM = {
					OFFSETCAM = {
						UPDATEWEAPON = {
							INCAN = none,
							NOWEAPON = none,
							MELEEWEAPON = none,
							DEFAULT = none,
							BALLTOSS = none,
							WBRUSH = none,
							INTREE_NOWEAPON = none,
							INTREE_WEAPON = none,
							SHOVEL = none,
							CHERRYBOMB = none,
							BASEBALL = none,
						},
						["1STPERSONDELAY"] = none,
						ACTIVATE = {
							BLEND = none,
							SET = none,
						},
					},
				},
				FIRSTPERSONCAM = {
					FIRSTPERSONCAM = {
						UPDATEWEAPON = {
							SUPERSLING = {
								SUPERSLING = none,
								ONTREE = none,
								ONBACKOFBIKE = none,
								SUPERSLINGCAND = none,
							},
							BBGUN = none,
							DEFAULT = none,
							WCAMERA = none,
						},
					},
				},
			},
			SCRIPTED = {
				DEFAULT = none,
				FIRSTPERSONCAM = {
					CAMERAINCANRETURN = none,
				},
				OFFSETCAM = none,
			},
		},
	},
	MG_BALLTOSS = {
		BASEBALL = {
			CONTROLLER = COMMON[438],
			GIVEBALL = COMMON[437],
			REMOVEBALL = COMMON[439],
		},
		INITIALIZE = none,
	},
	C4 = {
		ANIMATIONS = {
			SUCCESS2 = none,
			FAILURE = COMMON[373],
			STARTANIMATIONS = COMMON[751],
			RIGHT = {
				TUBE = COMMON[752],
				ROD = COMMON[753],
				BEAKER = COMMON[754],
			},
			PICKUPTORCH = COMMON[370],
			TEACHER = {
				TEACHERCHEW = none,
			},
			LEFT = {
				POWDER = COMMON[755],
				EYEDROP = COMMON[756],
				TUBE = COMMON[752],
			},
			CYCLECLEAR = none,
			SMOKEFACE = none,
			CUSTOMIDLE = none,
			UNLOCKS = COMMON[644],
			BOTHMISC = COMMON[758],
			REACT = COMMON[759],
			SUCCESS = none,
			TEACHERFINISHCLASS = none,
		},
		UNUSED = {
			C4_MENU = {
				C4_MENU_HARD = {
					C4_SETHARD = COMMON[735],
				},
				C4_MENU_EASY = {
					C4_SETEASY = COMMON[735],
				},
			},
		},
		C4_INTRO1 = {
			C4_2 = COMMON[641],
		},
		GOGGLESDESTROY = none,
		C4_INTRO3 = COMMON[761],
		GO = none,
		C4_INTRO4 = COMMON[761],
		C4_INTRO5 = {
			C4_2 = {
				C4_3 = none,
			},
		},
		C4_INTRO2 = none,
		GOGGLESINIT = none,
	},
	AI_2_02 = {
		CONTROLLER = COMMON[762],
		GENERALOBJECTIVES = {
			MOVEOBJECTIVE = none,
			FACEOBJECTIVE = none,
			GETONBIKE = COMMON[763],
		},
		COMBATACTIONS = {
			PROJECTILE = {
				FIRE = none,
				AIM = {
					FIRE = {
						RECOVERY = none,
					},
				},
			},
			OFFENSE = COMMON[141],
			WAIT = none,
			DEFENSE = {
				BLOCKING = COMMON[99],
			},
		},
		WORK = COMMON[764],
		IDLE = none,
		ONBIKE = COMMON[144],
	},
	["5_07C"] = {
		["5_07C_OMARPLAYEROILDRUM"] = {
			OMAR = {
				OMAR_CHILD = COMMON[201],
			},
		},
		["5_07C_ZOELEAVES"] = {
			ZOE = {
				PLAYER = COMMON[436],
			},
		},
		["5_07C_OMARZOE"] = {
			OMAR = {
				ZOE = COMMON[770],
			},
		},
		["5_07C_OMARPLAYER"] = {
			PLAYER = COMMON[770],
		},
	},
	FLASHLIGHT = {
		FLASHLIGHT = {
			FULLBODYACTIONOPPS = none,
			LOCOMOTION = COMMON[481],
			SOCIALEXECUTE = none,
			DEFAULT_KEY = none,
		},
	},
	AN_RAT = {
		HITRAT = {
			DEATH = {
				DEAD = {
					DEADCLEANUP = COMMON[775],
				},
			},
			FRONT = {
				GENERIC = none,
				SMOKEEFFECT = none,
				SMOKEEFFECTOLD = none,
			},
			REAR = COMMON[776],
		},
		DEFAULT_KEY = {
			FREE = {
				RUN = none,
				IDLE = none,
				WALK = none,
			},
			EXECUTENODES = {
				LOCOBASICANIMS = none,
				LOCOBASIC = none,
				WALKBASIC = none,
				ACTIONOPPS = none,
			},
		},
	},
	AMBIENT = {
		SOCIALANIMS = {
			SOCIALEXTORT = {
				SPEECHPRELOAD = {
					OTHER = none,
					AUTHORITYBRIBE = none,
				},
				BULLY = COMMON[777],
				OVERRIDE = none,
				PLAYANIM = none,
			},
			SOCIALINSULT1 = {
				SOCIALINSULT1 = {
					SOCIALINSULT1SPEECHPRELOAD = {
						SOCIALINSULT1SPEECHALLY = {
							SOCIALINSULT1SPEECHALLY1 = none,
							SOCIALINSULT1SPEECHALLY2 = none,
						},
						SOCIALINSULT1SPEECHREGULAR = none,
					},
					BULLY = {
						AGGRESSIVE = COMMON[778],
						NONAGGRESSIVE = COMMON[779],
					},
					GIRL = {
						AGGRESSIVE = COMMON[780],
						DISMISSIVE = {
							G_TAUNT_D = COMMON[781],
						},
					},
					OLD = {
						AGGRESSIVE = {
							OLD_TAUNT_A = COMMON[782],
						},
						NONAGGRESSIVE = {
							OLD_TAUNT_I = COMMON[782],
						},
					},
					NERD = {
						AGGRESSIVE = {
							N_TAUNT_A = COMMON[781],
						},
						NONAGGRESSIVE = {
							N_TAUNT_I = COMMON[783],
						},
					},
					AUTHORITY = {
						AGGRESSIVE = COMMON[784],
						NONAGGRESSIVE = {
							A_TAUNT_U = COMMON[785],
						},
					},
					FAT = {
						AGGRESSIVE = {
							FAT_TAUNT_A = COMMON[781],
						},
						NONAGGRESSIVE = {
							FAT_TAUNT_I = COMMON[783],
						},
					},
					GEN = {
						AGGRESSIVE = {
							GEN_TAUNT_A = COMMON[781],
						},
						NONAGGRESSIVE = {
							GEN_TAUNT_I = COMMON[783],
						},
					},
					SOCIALINSULT1SHARED = {
						SHAREDTRACKS = none,
						SOCIALINSULT1SPEECHCHOICES = {
							SOCIALINSULT1SPEECHALLY = none,
							SOCIALINSULT1SPEECHREGULAR = none,
						},
					},
				},
				OVERRIDE = none,
			},
			SOCIALWAVE = {
				GIRLS = {
					FRIENDLY = COMMON[786],
					SCARED = COMMON[787],
					DISMISSIVE = {
						G_WAVE_D = none,
					},
				},
				SHARED = {
					SOCIALWAVE_SHARED = {
						SOCIALWAVE_SPEECH = {
							VSNPC = none,
							VSPLAYER = none,
						},
					},
				},
				SPEECHPRELOAD = COMMON[788],
				OLD = COMMON[789],
				BULLY = {
					NOTINTIMIDATED = COMMON[790],
					INTIMIDATED = COMMON[791],
				},
				NERD = {
					INTIMIDATED = COMMON[792],
					FRIENDLY = COMMON[793],
					VERYSCARED = {
						N_WAVE_S = COMMON[783],
					},
				},
				AUTHORITY = {
					A_WAVE_F = none,
				},
				FAT = COMMON[794],
				OVERRIDE = none,
				GEN = COMMON[795],
			},
			SOCIALREACTANGRY = {
				SPEECHPRELOAD = none,
				OVERRIDE = none,
				PLAYANIM = none,
			},
			SOCIALLOSTTEMPER = {
				SOCIALLOSTTEMPERSPEECHPRELOAD = {
					SOCIALLOSTTEMPERSPEECHREGULAR = none,
				},
				OVERRIDE = none,
				WENEEDAPROPERANIMATION = none,
			},
			SOCIALLAUGH = {
				LAUGHINGSPEECHPRELOAD = {
					GIRLLAUGH = none,
					GUY_LAUGH = {
						LAUGH01 = none,
					},
				},
				OVERRIDE = none,
				LAUGHING = COMMON[796],
			},
			SOCIALWANTGIFT = {
				SPEECHPRELOAD = {
					SPEECHPRELOAD = none,
					SPEECHPRELOADRUSSELL = none,
					SPEECHPRELOADGIRL = none,
					SPEECHPRELOADROMMALE = none,
				},
				WANTGIFT = {
					WANTGIFTGIRLS = COMMON[787],
					PLAY = {
						GIFTTEXTSTUB = {
							TEXTALLY = none,
							TEXTGIRL = none,
						},
					},
				},
				OVERRIDE = none,
			},
			SOCIALTATTLE = {
				GIRL = COMMON[797],
				SPEECHPRELOADNONE = none,
				MALE = {
					PLAYANIM = none,
				},
				JUSTTATTLE = none,
				OVERRIDE = none,
			},
			SOCIALINITIALREACTION = {
				SOCIALINITIALREACTION = {
					GENERICS = COMMON[798],
					NERDS = COMMON[798],
					SHARED = {
						SOCIALINITIALREACTION_SHARED = none,
					},
					AUTHORITY = {
						SOCIALREACTAGGRESSIVE = none,
						SOCIALREACTFRIENDLY = none,
						SOCIALREACTUNFRIENDLY = none,
					},
					OLD = COMMON[798],
					TOUGHFACTIONS = {
						SOCIALREACTAGGRESSIVE = none,
						SOCIALREACTSCARED = none,
						SOCIALREACTUNFRIENDLY = none,
						SOCIALREACTFRIENDLY = none,
					},
					GIRLS = {
						SOCIALREACTAGGRESSIVE = none,
						SOCIALREACTFRIENDLY = none,
						SOCIALREACTSCARED = none,
						SOCIALREACTDISMISSIVE = none,
					},
					FAT = COMMON[798],
				},
			},
			SOCIALFLEE = {
				SOCIALFLEESPEECHPRELOAD = {
					SOCIALFLEESPEECHREGULAR = none,
				},
				OVERRIDE = none,
				JUSTFLEE = none,
			},
			SOCIALANGRYSHOVE = {
				SPEECHPRELOADNONE = none,
				RANGECHECK = none,
				OVERRIDE = none,
				SHOVE = {
					BULLY = COMMON[787],
					GIRL = COMMON[787],
					OLD = COMMON[787],
					NERD = COMMON[787],
					AUTHORITY = COMMON[787],
					FAT = COMMON[787],
					BULLYANGRY = COMMON[787],
					GEN = COMMON[787],
				},
			},
			SOCIALDISMISSSHRUG = {
				GIRL = {
					FRIENDLY = {
						G_DISMISS_F = COMMON[783],
					},
					DISMISSIVE = {
						G_DISMISS_D = COMMON[783],
					},
				},
				SHARED = {
					SOCIALDISMISSSHRUG_SHARED = none,
				},
				AUTHORITY = {
					A_DISMISS = COMMON[783],
				},
				OLD = {
					DISMISS = COMMON[782],
				},
				SPEECH_PRELOAD = {
					SPEECHPRELOADGIRL = {
						SPEECHPRELOADGIRL1 = none,
						SPEECHPRELOADGIRL2 = none,
					},
					SPEECHPRELOAD = none,
				},
				NERD = {
					N_DISMISS = COMMON[783],
				},
				BULLY = {
					B_DISMISS = {
						PLAY1 = none,
						PLAY2 = none,
					},
				},
				FAT = {
					FAT_DISMISS = COMMON[783],
				},
				OVERRIDE = none,
				GEN = {
					DISMISS = COMMON[783],
				},
			},
			SOCIALBRINGITON = {
				NERD = {
					N_TAUNT_I = COMMON[783],
					N_TAUNT_A = COMMON[781],
				},
				BULLY = COMMON[779],
				AUTHORITY = COMMON[784],
				SHARED = {
					SOCIALBRINGITON_SHARED = none,
				},
				SPEECHPRELOAD = {
					SPEECHPRELOAD = none,
					SPEECHPRELOADHARASS = none,
					SPEECHPRELOADAGGRO = none,
				},
				OLD = {
					OLD_TAUNT_A = COMMON[782],
					OLD_TAUNT_I = COMMON[782],
				},
				BULLYANGRY = COMMON[778],
				GEN = {
					GEN_TAUNT_A = COMMON[781],
					GEN_TAUNT_I = COMMON[783],
				},
				SOCIALBRINGITONPRELOAD = {
					SPEECHPRELOADGIRL = none,
					SPEECHPRELOAD = none,
				},
				FAT = {
					FAT_TAUNT_I = COMMON[783],
					FAT_TAUNT_A = COMMON[781],
				},
				OVERRIDE = none,
				GIRL = COMMON[780],
			},
			SOCIALPRAISE = {
				SHARED = {
					SOCIALPRAISE_SHARED = none,
				},
				SPEECHPRELOAD = {
					SPEECHPRELOAD = none,
					SPEECHPRELOADKISS = none,
					SPEECHPRELOADGIRL = {
						SPEECHPRELOADGIRLDEFAULT = none,
						SPEECHPRELOADCLOTHES = none,
					},
				},
				OLD = {
					INTIMIDATED = {
						PRAISE_I = COMMON[782],
					},
					FRIENDLY = {
						PRAISE_F = COMMON[782],
					},
					VERYSCARED = {
						PRAISE_S = COMMON[782],
					},
				},
				BULLY = {
					NOTINTIMIDATED = {
						B_PRAISE_F = COMMON[783],
					},
					INTIMIDATED = {
						B_PRAISE_S = COMMON[783],
					},
				},
				NERD = {
					INTIMIDATED = {
						N_PRAISE_I = COMMON[783],
					},
					FRIENDLY = {
						N_PRAISE_F = COMMON[783],
					},
					VERYSCARED = {
						N_PRAISE_S = COMMON[783],
					},
				},
				GIRL = {
					KISSREADY = COMMON[799],
					PLAY = none,
				},
				FAT = {
					FRIENDLY = {
						FAT_PRAISE_F = COMMON[783],
					},
					VERYSCARED = {
						FAT_PRAISE_S = COMMON[783],
					},
					KISSREADY = COMMON[799],
					INTIMIDATED = {
						FAT_PRAISE_I = COMMON[783],
					},
				},
				OVERRIDE = none,
				GEN = {
					INTIMIDATED = {
						PRAISE_I = COMMON[783],
					},
					FRIENDLY = {
						PRAISE_F = COMMON[783],
					},
					VERYSCARED = {
						PRAISE_S = COMMON[783],
					},
				},
			},
			SOCIALREACTCOWER = {
				SHARED = {
					SOCIALREACTCOWER_SHARED = {
						SPEECH = COMMON[800],
					},
				},
				SPEECHPRELOAD = COMMON[800],
				OLD = {
					SCARED = {
						COWER_I = COMMON[782],
					},
					VERYSCARED = {
						COWER_S = COMMON[782],
					},
				},
				BULLY = {
					B_COWER_S = COMMON[783],
				},
				NERD = {
					SCARED = {
						N_COWER_I = COMMON[783],
					},
					VERYSCARED = {
						N_COWER_S = COMMON[783],
					},
				},
				GIRL = {
					SCARED = {
						G_COWER_S = COMMON[783],
					},
				},
				FAT = {
					SCARED = {
						FAT_COWER_I = COMMON[783],
					},
					VERYSCARED = {
						FAT_COWER_S = COMMON[783],
					},
				},
				OVERRIDE = none,
				GEN = {
					SCARED = {
						COWER_I = COMMON[783],
					},
					VERYSCARED = {
						COWER_S = COMMON[783],
					},
				},
			},
			SOCIALSTOPHAND = {
				SPEECHPRELOAD = {
					SPEECHPRELOAD = none,
					SPEECHPRELOADFLUSTERED = none,
				},
				OVERRIDE = none,
				SOCIALSTOPHAND = {
					GIRL = {
						FRIENDLY = COMMON[787],
						SCARED = COMMON[787],
					},
					OLD = COMMON[801],
					GEN = COMMON[801],
					BULLY = COMMON[787],
					FAT = COMMON[801],
					NERD = COMMON[801],
					SHARED = {
						SOCIALSTOPHAND_SHARED = none,
					},
				},
			},
			UBO_CHECKS = {
				UBO_CHECKS = {
					UNARMED = COMMON[802],
					WEAPON = {
						PERFORMINGACTIONLHANDWEAP = COMMON[803],
						PERFORMINGACTION = {
							UMBRELLA = none,
							TEDDYBEAR = none,
							SCHOOLBOOK = none,
							PERFORMINGACTION = none,
						},
					},
				},
			},
			SOCIALREACTDONTHURT = {
				DONTHURTSHARED = {
					DONTHURTSPEECHCHOICES = COMMON[788],
					DONTHURTSHARED = none,
				},
				BULLY = COMMON[804],
				SPEECHPRELOAD = {
					DHSPEECHALLY = {
						DONTHURTSPEECHALLY1 = none,
						DONTHURTSPEECHALLY2 = none,
					},
					DONTHURTSPEECHREGULAR = none,
				},
				OLD = COMMON[805],
				GEN = COMMON[806],
				GIRL = {
					SCARED = {
						G_HELP_S = COMMON[783],
					},
				},
				FAT = COMMON[807],
				OVERRIDE = none,
				NERD = COMMON[808],
			},
			SOCIALCHITCHAT = {
				AUTHORITY = COMMON[787],
				SPEECHPRELOAD = none,
				OVERRIDE = none,
				PLAYANIM = none,
			},
			SOCIALGREETING = {
				GIRLS = {
					INTIMIDATED = COMMON[787],
					FRIENDLY = COMMON[786],
					VERYSCARED = COMMON[787],
				},
				SHARED = {
					SOCIALGREETING_SHARED = {
						SOCIALGREETING_EMOTION = {
							FRIENDLY = none,
							SCARED = none,
							DISMISSIVE = none,
						},
					},
				},
				SPEECHPRELOAD = {
					FRIENDLY = none,
					SCARED = none,
					GIRLFRIEND = {
						FRIENDLY = none,
						HEYBABEFEM = none,
						DORM = none,
						HEYBABE = none,
					},
					DISMISSIVE = none,
				},
				OLD = COMMON[789],
				BULLY = {
					ANGRY = {
						B_GREET_A = COMMON[781],
					},
					FRIENDLY = COMMON[790],
					VERYSCARED = COMMON[791],
				},
				NERD = {
					INTIMIDATED = COMMON[792],
					FRIENDLY = COMMON[793],
					VERYSCARED = COMMON[812],
				},
				AUTHORITY = COMMON[787],
				FAT = COMMON[794],
				OVERRIDE = none,
				GEN = COMMON[795],
			},
			SOCIALHUMILIATEATTACK = {
				GETVICTIMHEIGHT = {
					PLAYER = none,
					["4-10"] = {
						["4-10"] = none,
					},
					["6-1"] = COMMON[817],
					ELSE = none,
					["5-8"] = COMMON[818],
				},
				GETATTACKERHEIGHT = {
					["6-5"] = {
						["6-5"] = none,
					},
					["6-1"] = COMMON[817],
					ELSE = none,
					["5-8"] = COMMON[818],
				},
				NPC_WAIT = {
					PLAYER = none,
					TIMEOUT = none,
					GEN = COMMON[777],
					GIRL = COMMON[777],
					NERD = COMMON[777],
					BULLY = COMMON[777],
				},
				SPEECHPRELOAD = none,
				ANIMLOADTRIGGER = {
					HUMILIATE = {
						FAIL = {
							TIMEOUT = none,
							TIMEOUTTARGET = none,
						},
						["5-8_VS_PLAYER"] = COMMON[819],
						["6-1_VS_4-10"] = {
							SUCCESS = {
								GV = none,
								RCV = COMMON[357],
								LOADANIMS = none,
							},
						},
						["6-5_VS_4-10"] = COMMON[820],
						["5-8_VS_6-1"] = COMMON[820],
						["6-5_VS_PLAYER"] = {
							SUCCESS = {
								GV = {
									END = {
										ANIMATION = COMMON[822],
									},
									ANIMATION = COMMON[822],
								},
								RCV = COMMON[95],
								LOADANIMS = none,
							},
						},
						["6-1_VS_PLAYER"] = COMMON[819],
						TWOHANDSHOVE = none,
						["6-5_VS_6-1"] = COMMON[820],
						["6-1_VS_6-1"] = COMMON[820],
						["5-8_VS_4-10"] = COMMON[820],
					},
				},
				INSULTANIMOPP = none,
				OVERRIDE = none,
				NPCVSNPC = none,
			},
			SOCIALFOLLOW = {
				FOLLOWALLYORGIRLSPEECHPRELOAD = {
					FOLOWALLYTEXT = {
						FOLOWALLYTEXTMALE = none,
						FOLOWALLYTEXTMALEROMANTIC = none,
						FOLOWALLYTEXTGIRL = none,
					},
				},
				FOLLOWALLYORGIRL = {
					PLAYANIMGIRL = none,
				},
				FOLLOWDEFAULT = {
					PLAYANIM = {
						RECRUIT = none,
					},
				},
				OVERRIDE = none,
			},
			SOCIALACCEPTAPOLOGY = {
				GEN = COMMON[787],
				SHARED = {
					SOCIALACCEPTAPOLOGY_SPEECH = COMMON[824],
				},
				SPEECHPRELOAD = {
					SPEECHPRELOADAUTH = none,
					SPEECHPRELOAD = none,
					SPEECHPRELOADREG = none,
					ACCEPTAPOLOGYGIRLS = {
						SPEECHPRELOADGIRLMAD = none,
						SPEECHPRELOADGIRLREG = none,
					},
				},
				OLD = COMMON[787],
				BULLY = {
					GIVEUP = {
						PLAY = {
							COLLISIONBEHIND = none,
						},
					},
				},
				NERD = COMMON[787],
				GIRL = {
					FRIENDLY = COMMON[787],
					DISMISSIVE = COMMON[787],
				},
				FAT = COMMON[787],
				OVERRIDE = none,
				AUTH = {
					TARGETFLAGSET = {
						TARGETFLAG = none,
					},
					GIVEUPNOCOL = COMMON[787],
					GIVEUPCOL = COMMON[787],
				},
			},
			SOCIALAPOLOGY = {
				SHARED = {
					SOCIALAPOLOGY_SHARED = none,
				},
				SPEECHPRELOAD = none,
				OLD = COMMON[805],
				BULLY = COMMON[804],
				NERD = COMMON[808],
				GIRL = COMMON[797],
				FAT = COMMON[807],
				OVERRIDE = none,
				GEN = COMMON[806],
			},
		},
		COMBATDIALOGBANK = {
			COMBATDIALOG = {
				COMBATTAUNTSPEECH = {
					COMBATFEARSPEECH = {
						COMBATF1 = none,
						COMBATF2 = none,
					},
					COMBATAGGSPEECH = {
						COMBATS1 = none,
						COMBATS2 = none,
					},
				},
				COMBATTAUNT = {
					COMBATTAUNT2 = none,
					COMBATTAUNT1 = none,
				},
				COMBATTAUNTFEAR = {
					COMBATFEAR1 = {
						COMBATFEAREND = none,
					},
				},
			},
		},
		INCREMENTBUSTEDCOUNT = {
			DOIT = none,
		},
		TALKING = {
			TALKING = {
				FAT = COMMON[485],
				FEMALE2 = {
					AGRF = {
						ANIMS = {
							GSF = COMMON[826],
							SEXY = COMMON[826],
							CIVF = COMMON[826],
						},
					},
				},
				TALKING_LOAD = none,
				MALE = COMMON[485],
				GEN = COMMON[485],
				NERDMALE = COMMON[485],
				MALE2 = {
					AGR1 = {
						ANIMS = {
							PREP = COMMON[826],
							JOCK = COMMON[826],
							GENERICSTUDENTMALE = COMMON[826],
							NERD = COMMON[826],
							GREASER = COMMON[826],
							BULLY = COMMON[826],
						},
					},
					AGR2 = {
						ANIMS = {
							DROPOUT = COMMON[826],
							CIVILLIANMALE = COMMON[826],
							AUTHORITY = COMMON[826],
						},
					},
				},
				FEMALE = {
					SPEECHANIMS = {
						SPAWNS = none,
						ANIMS = {
							DISMISS_02 = none,
							PRAISE_F_01 = none,
							PRAISE_F_02 = none,
							DISMISS_01 = none,
						},
					},
					LOAD = none,
				},
				LOCO = {
					LOCO = {
						SOCIAL_IDLE = none,
						NONCOMBATSTRAFEANIMS = none,
					},
				},
			},
		},
		HARASSMOVES = {
			CRIMEWEAPONSTEAL = {
				GRAPPLEEXEC = none,
			},
			THROWWEAPONAWAY = {
				THROWWEAPONEXEC = none,
			},
			PLACESIGN = {
				TRIGGERSIGN = {
					ATTACHSIGN = none,
					SIGNDETACH = none,
				},
			},
			HARASSSPEECH = {
				HARASSSPEECHEXEC = none,
			},
			BOOKATTACK = {
				BOOKATTACKEXEC = none,
			},
			SIGNKICK = {
				GIRLKICK = {
					GIRLKICK_1 = none,
				},
				DEFAULT = none,
				GREASER = {
					GREASERKICK_1 = none,
					EXECUTES = {
						GREASERKICK_1 = {
							KICK_1_LANDED = none,
						},
						GREASERKICK_2 = {
							KICK_2_LANDED = none,
						},
					},
					GREASERKICK_2 = none,
				},
			},
			HARASSSHORT = {
				TRIP = none,
				PINCHGIRLBUTT = none,
				SHOVES = {
					SHOVE2HAND = none,
					SHOVE2HANDEXECUTE = none,
				},
			},
		},
		SCRIPTED = {
			MONITORLOOP = {
				MONLOOPPLAY = {
					MONLOOPSTOP = none,
				},
			},
			COOKIN = {
				COOK2 = {
					COOK3 = none,
				},
				COOK1 = {
					COOK1CHOICE = {
						COOK2 = none,
						COOK1 = none,
					},
				},
			},
			WALL_SMOKE = {
				WALL_START = {
					WALL_IDLE = {
						WANTSTOSMOKE = {
							WALL_SMOKE_START = {
								WALL_SMOKE_IDLE = {
									WALL_SMOKE_IDLE_CHILD = COMMON[235],
								},
							},
						},
						WALL_END = none,
					},
				},
				WALKTOWALL = none,
			},
			WALL_LEAN = {
				WALL_START = {
					WALL_IDLE = none,
					WALL_END = none,
				},
				WALKTOWALL = none,
			},
			WARMHANDS = {
				WARMINGHANDSSTART = {
					WARMINGHANDSLOOP = none,
				},
			},
			ORDERLYPATROL = {
				ORDERLYPATROL_CHILD = COMMON[828],
			},
			CHEERROUTINES = {
				CHEERROUTINEA = COMMON[829],
				RELEASEGROUP = COMMON[830],
			},
			CUDDLE = {
				GRAPPLEATTEMPT = {
					GRAPPLED = {
						GIVE = none,
						RECEIVE = none,
						WAIT = {
							BREAKRECEIVE = none,
							BREAKGIVE = none,
						},
					},
				},
			},
			SPECIALPUKE = {
				LOADPUKE = none,
				PUKEONDEMAND = {
					PUKEEXEC = none,
				},
			},
			DRUNK = {
				DRUNK_2 = {
					RESTART = none,
				},
				DRUNK3 = {
					DRUNK3_IDLE = {
						DRUNK3ACTIONS = {
							DRUNK3ACTIONS1 = none,
							DRUNK3ACTIONS2 = none,
						},
						DRUNK3BREAK = COMMON[831],
					},
					DRUNK4_IDLE = {
						DRUNK4BREAK = COMMON[831],
						DRUNK4DETACH = {
							DRUNK4DETACHNODE = none,
						},
						DRUNK4ACTIONS = {
							DRUNK4ACTIONS2 = none,
							DRUNK4ACTIONS1 = none,
						},
					},
				},
				RELEASEGROUP = COMMON[830],
				DRUNK_1 = {
					DRUNK_1_CHILD = none,
				},
			},
			WALL_HOLD = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						HOLD_IDLE = {
							GRAPPLEBREAK = COMMON[394],
							HARASSED = none,
							HARASSING = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
			},
			USESOCCERGOAL2 = {
				USESOCCERGOALEND = none,
				USESOCCERGOALSTART = COMMON[832],
			},
			COWDANCE = {
				COWDANCEMUSICSTOP = none,
				ANIMATION = {
					BREAKOUT = none,
					SUCCESS = none,
					CIRCLE = {
						CIRCLE = none,
					},
					BREAK = none,
					CUSTOMIDLE = {
						CUSTOMIDLELOOP = none,
					},
					FAILURE = none,
					TRIANGLE = {
						TRIANGLE = none,
					},
					SQUARE = {
						SQUARE = none,
					},
					CROSS = COMMON[833],
					BOTCH = none,
				},
				COWDANCEMUSICSTART = none,
			},
			DRIBBLE = {
				DRIBBLEOPP = none,
			},
			KISS_ME_BABY = {
				GRAPPLEATTEMPT1 = {
					GRAPPLESUCCESS = {
						KISS2 = {
							KISS2_LOOP = {
								KISS2LOOP_GIVE = none,
								KISS2LOOP_RCV = none,
								KISSBREAK = COMMON[834],
							},
							KISS_RCV = none,
							KISS_GIVE = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
				GRAPPLEATTEMPT2 = {
					GRAPPLESUCCESS = {
						KISS4 = {
							KISS4_LOOP = {
								KISS4LOOP_RCV = none,
								KISS4LOOP_GIVE = none,
								KISSBREAK = COMMON[834],
							},
							KISS_RCV = none,
							KISS_GIVE = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
				LOADANIMS = {
					KISS4 = none,
					KISS2 = none,
				},
			},
			CANDUMP = {
				DUMPTARGET = none,
			},
			SWIRLIE = {
				SWIRLTARGET = {
					SWIRLTARGSPEECH = none,
				},
			},
			PLAY_CATCH = {
				PLAYCATCHSTART = COMMON[835],
			},
			CARNY = {
				CARNYGAME = {
					CARNYIDLE = {
						PRELOADSPEECH = none,
						CARNYACTIONS = {
							CARNYACTION5 = none,
							CARNYACTION1 = none,
							CARNYACTION7 = none,
							CARNYACTION4 = none,
							CARNYACTION9 = none,
							CARNYACTION8 = none,
							CARNYACTION3 = none,
							CARNYACTION6 = none,
							CARNYACTION2 = none,
						},
					},
				},
				CARNYBAIL = none,
				CARNYDUNK = COMMON[836],
				CARNYHOUSE = {
					CARNYIDLE = {
						PRELOADSPEECH = none,
						CARNYACTIONS = {
							CARNYACTION8 = none,
							CARNYACTION5 = none,
							CARNYACTION3 = none,
							CARNYACTION1 = none,
							CARNYACTION11 = none,
							CARNYACTION4 = none,
							CARNYACTION2 = none,
						},
					},
				},
			},
			GUARDDOG = {
				GUARDDOGLOOP = COMMON[837],
			},
			TELL_OFF = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						PULL_IN_HEAVY = {
							HELD = none,
							HOLD_IDLE = {
								GRAPPLEBREAK = COMMON[394],
								GIVE = none,
								SPEECH = {
									SPEECH1 = none,
								},
								RCV = none,
							},
							HOLD = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
			},
			CRYING = {
				IDLE = {
					DOCRYING = {
						DOCRYINGSPEECH = none,
					},
				},
			},
			SWEEPFLOORS = {
				START_SWEEPING = {
					END = none,
					SOCHACK = none,
				},
			},
			HAMMER = {
				HAMMERTIME = none,
			},
			WORKOUT = {
				WORKOUT_CHILD = {
					BEGINWORKOUT = {
						PUSHUP = COMMON[838],
						RUNINPLACE = COMMON[839],
						ENDWORKOUT = {
							ENDWORKOUT_CHILD = none,
						},
						JUMPINGJACK = COMMON[840],
					},
				},
			},
			LOCKERSTUFF = {
				PROPSTUFFTARGET = {
					STUFFGRAP = {
						GRAPPLEOPPS = {
							SCRIPTED = {
								GARBCANINTERACT = none,
								PROPINTERACT = none,
								WEAPONSTEAL = {
									STEAL_EASY = COMMON[125],
								},
							},
						},
						HOLD_IDLE = {
							GIVE = COMMON[252],
							GRAPPLESEXECUTENODES = {
								FACETARGETSPAWN = {
									TARGETONLY = none,
								},
							},
							RCV = none,
						},
						GRAPPLESUCCESS = COMMON[842],
					},
				},
			},
			CHEERLEADING = {
				ROUTINE = {
					EXECUTES = {
						NOSPEECH = none,
						CHEERSPEECH = none,
					},
					INITPOMPOMS = {
						LEFT = {
							KICK = {
								KICKC = none,
								RIGHT = {
									RIGHTB = none,
									RIGHTC = none,
									STAR = {
										STARB = none,
										UP = {
											UPA = none,
											UPB = none,
											UPC = none,
											DOWN = {
												DOWNA = none,
											},
										},
										STARA = none,
										STARC = none,
									},
									RIGHTA = none,
								},
								KICKB = none,
								KICKA = none,
							},
							LEFTC = none,
							LEFTA = none,
							LEFTB = none,
						},
					},
				},
				BREAKOFF = COMMON[843],
			},
			CHEERING = {
				CHEERA = none,
				CHEERB = none,
				IDLE = none,
				RELEASEGROUP = COMMON[830],
			},
			BATHROOM = COMMON[390],
			EMPTY = {
				EMPTYNODE = {
					TRUEEMPTYNODE = none,
				},
			},
			BOOKHARASS = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						HOLD_IDLE = {
							HARASSING = none,
							GRAPPLEBREAK = COMMON[48],
							HARRASSED = none,
						},
					},
				},
				BREAKOFF = COMMON[843],
			},
			SHAKEFIST = {
				SHAKE = COMMON[39],
			},
		},
		KNOCKOUTTAUNT = {
			KNOCKOUTTAUNTANIM1 = none,
			KNOCKOUTTAUNTANIM5 = none,
			KNOCKOUTTAUNTANIM3 = none,
			KNOCKOUTTAUNTANIM4 = none,
			KOSPEECHEXEC = {
				KOSPEECHBANK = {
					KOSPEECH2 = none,
					KOSPEECH4 = none,
					KOSPEECH1 = none,
					KOSPEECH3 = none,
				},
			},
			KNOCKOUTTAUNTANIM2 = none,
		},
		REACTIONS = {
			PUKE = COMMON[844],
			SURPRISED = {
				SURPRISED_MALE = {
					SURPRISEDM1 = {
						SURPRISEDM1A = none,
					},
					SURPRISEDM2 = {
						SURPRISEDM2A = none,
					},
				},
				SURPRISED_FEMALE = {
					SURPRISEDFEM = none,
				},
			},
			TATTLING = {
				TATTLE = none,
			},
			WAITFORBALL = {
				WAITFORBALL2 = none,
				WAITFORBALL = none,
			},
			FOODINMOUTH = {
				FOODANIM = none,
			},
			GIRLFREAK = {
				GIRLFREAK2 = none,
				GIRLFREAK1 = none,
			},
			LOOKAROUNDACTION = {
				LOOKAROUND = none,
			},
			STEALTHWHATUP = {
				STEALTHWU2 = none,
				STEALTHWU1 = none,
			},
			FIREWORKSHRUG = {
				FORGETIT = none,
				DONTCARE = none,
			},
			DOOREXITS = {
				DOOREXITATTACK = {
					DOOREXITCHARGE = {
						RUNSHOULDER = {
							RUNSHOULDERBACKTORUN = none,
						},
					},
					DOOREXITSTOP = {
						DOOREXITSTOPANIM = none,
					},
					DOOREXITLOOK = {
						DOOREXITLOOKANIM = none,
					},
				},
			},
			TAUNTREACT = {
				TAUNTAFRAID = COMMON[845],
				TAUNTDCARE = {
					DONTCARE = none,
					TAUNTDCAREGIRL = {
						DONTCAREGIRL = none,
					},
					TAUNTDCAREADULT = {
						DONTCAREADULT = none,
					},
				},
			},
			COWERBANK = {
				COWER_START = {
					EXECUTE = {
						["SCRIPTCALL1.05"] = none,
					},
					COWER_CYCLE = {
						COWER_BLOCK = none,
						COWER_END = none,
					},
				},
			},
			VEHICLEAVOIDDIVE = {
				VEHICLECOWER = COMMON[846],
				VEHICLEAVOIDDIVELEFT = COMMON[357],
				VEHICLEAVOIDDIVERIGHT = COMMON[357],
			},
			REACTIONS_SHARED = {
				TURNING_HEADTRACK = none,
			},
			ATTACKLOOP = {
				HITLOOKAROUND = none,
			},
			HUMILIATIONREACT = {
				LAUGHING = COMMON[796],
			},
			CATCHREACT = COMMON[848],
		},
		DUNKTANKMIDGET = COMMON[849],
		SPECTATOR = {
			DEFAULT_KEY = {
				SPECTATORSPAWN = {
					SPECTATORWAIT = {
						SPECTATORLIKEWAIT = none,
						SPECTATORHATEWAIT = none,
					},
					SPECSPEECH = {
						SPECSPEECHHATE = {
							SPECSPEECHHATE = none,
							SPECSPEECHFREAK = none,
						},
						SPECSPEECHLIKE = {
							SPECSPEECHFREAK = none,
							SPECSPEECHLIKE = none,
						},
					},
					SPECTATORINSTORE = {
						KIDANIMS = COMMON[850],
						REGSTOREANIMS = {
							SPECTATORANIM2 = none,
							SPECTATORANIM1 = none,
						},
						FEMALEANIMS = COMMON[850],
					},
					SPECTATORANIMS = {
						SPECLIKE = COMMON[851],
						SPECNOTLIKE = COMMON[851],
					},
				},
				NOTSPECTATOR = none,
				SPECTATING = none,
			},
		},
		SITTING_DOWN = {
			SITTINGSNAP = {
				GUY = none,
				GETUP = {
					SITEND = COMMON[852],
				},
				GIRL = none,
			},
			SITHIGH = {
				SIT_STARTGIRL = {
					SIT_GIRLIDLE = {
						SIT_GIRLTALK = COMMON[853],
					},
					SIT_GIRLEND = {
						SIT_GIRLEND1 = none,
						SIT_GIRLEND2 = none,
					},
				},
				SIT_START = {
					SIT_IDLE = {
						SIT_TALK = COMMON[853],
						SIT_SMOKE_START = {
							SIT_SMOKE_IDLE = {
								WALL_SMOKE_STUB = none,
							},
						},
					},
					SIT_END = COMMON[854],
				},
			},
		},
		CHEERBANK = {
			NPC_CHEER_A = {
				DEFAULT = {
					MOVEYOASS = none,
					SHOVE = none,
					IDLE = {
						STOPCHEERING = none,
						AMBIENT = {
							CHEERING = {
								WHOWANTSTOCHEER = {
									GIRL = COMMON[776],
									PREPPY = {
										GENERIC = none,
										POSH = none,
									},
									NERD = {
										GENERIC = none,
										NERD = none,
									},
									ELSE = COMMON[776],
									JOCKGREASER = {
										GENERIC = none,
										COOL = none,
									},
								},
								CHEER_ANIMS = {
									CHEER_NERD = {
										CHEER_NERD2 = {
											LOADED = {
												CHEER_NERD_07 = {
													CHEER_NERD_07 = none,
												},
												CHEER_NERD_09 = {
													CHEER_NERD_09 = none,
												},
												CHEER_NERD_06 = {
													CHEER_NERD_06 = none,
												},
												CHEER_NERD_08 = {
													CHEER_NERD_08 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_NERD3 = {
											LOADED = {
												CHEER_NERD_13 = {
													CHEER_NERD_13 = none,
												},
												CHEER_NERD_11 = {
													CHEER_NERD_11 = none,
												},
												CHEER_NERD_14 = {
													CHEER_NERD_14 = none,
												},
												CHEER_NERD_12 = {
													CHEER_NERD_12 = none,
												},
												CHEER_NERD_10 = {
													CHEER_NERD_10 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_NERD1 = {
											LOADED = {
												CHEER_NERD_03 = {
													CHEER_NERD_03 = none,
												},
												CHEER_NERD_05 = {
													CHEER_NERD_05 = none,
												},
												CHEER_NERD_02 = {
													CHEER_NERD_02 = none,
												},
												CHEER_NERD_01 = {
													CHEER_NERD_01 = none,
												},
												CHEER_NERD_04 = {
													CHEER_NERD_04 = none,
												},
											},
											BANK_LOAD = none,
										},
									},
									CHEER_GIRL = {
										CHEER_GIRL3 = {
											LOADED = {
												CHEER_GIRL_11 = {
													CHEER_GIRL_11 = none,
												},
												CHEER_GIRL_12 = {
													CHEER_GIRL_12 = none,
												},
												CHEER_GIRL_09 = {
													CHEER_GIRL_09 = none,
												},
												CHEER_GIRL_10 = {
													CHEER_GIRL_10 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_GIRL1 = {
											LOADED = {
												CHEER_GIRL_01 = {
													CHEER_GIRL_01 = none,
												},
												CHEER_GIRL_02 = {
													CHEER_GIRL_02 = none,
												},
												CHEER_GIRL_04 = {
													CHEER_GIRL_04 = none,
												},
												CHEER_GIRL_03 = {
													CHEER_GIRL_03 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_GIRL4 = {
											LOADED = {
												CHEER_GIRL_14 = {
													CHEER_GIRL_14 = none,
												},
												CHEER_GIRL_15 = {
													CHEER_GIRL_15 = none,
												},
												CHEER_GIRL_16 = {
													CHEER_GIRL_16 = none,
												},
												CHEER_GIRL_13 = {
													CHEER_GIRL_13 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_GIRL2 = {
											LOADED = {
												CHEER_GIRL_08 = {
													CHEER_GIRL_08 = none,
												},
												CHEER_GIRL_07 = {
													CHEER_GIRL_07 = none,
												},
												CHEER_GIRL_05 = {
													CHEER_GIRL_05 = none,
												},
												CHEER_GIRL_06 = {
													CHEER_GIRL_06 = none,
												},
											},
											BANK_LOAD = none,
										},
									},
									CHEER_POSH = {
										CHEER_POSH3 = {
											LOADED = {
												CHEER_POSH_12 = {
													CHEER_POSH_12 = none,
												},
												CHEER_POSH_13 = {
													CHEER_POSH_13 = none,
												},
												CHEER_POSH_11 = {
													CHEER_POSH_11 = none,
												},
												CHEER_POSH_10 = {
													CHEER_POSH_10 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_POSH1 = {
											LOADED = {
												CHEER_POSH_04 = {
													CHEER_POSH_04 = none,
												},
												CHEER_POSH_02 = {
													CHEER_POSH_02 = none,
												},
												CHEER_POSH_05 = {
													CHEER_POSH_05 = none,
												},
												CHEER_POSH_01 = {
													CHEER_POSH_01 = none,
												},
												CHEER_POSH_03 = {
													CHEER_POSH_03 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_POSH2 = {
											LOADED = {
												CHEER_POSH_09 = {
													CHEER_POSH_09 = none,
												},
												CHEER_POSH_07 = {
													CHEER_POSH_07 = none,
												},
												CHEER_POSH_06 = {
													CHEER_POSH_06 = none,
												},
												CHEER_POSH_08 = {
													CHEER_POSH_08 = none,
												},
											},
											BANK_LOAD = none,
										},
									},
									CHEER_GEN = {
										CHEER_GEN1 = {
											LOADED = {
												CHEER_GEN_03 = {
													CHEER_GEN_03 = none,
												},
												CHEER_GEN_01 = {
													CHEER_GEN_01 = none,
												},
												CHEER_GEN_02 = {
													CHEER_GEN_02 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_GEN2 = {
											LOADED = {
												CHEER_GEN_04 = {
													CHEER_GEN_04 = none,
												},
												CHEER_GEN_05 = {
													CHEER_GEN_05 = none,
												},
												CHEER_GEN_06 = {
													CHEER_GEN_06 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_GEN3 = {
											LOADED = {
												CHEER_GEN_07 = {
													CHEER_GEN_07 = none,
												},
												CHEER_GEN_09 = {
													CHEER_GEN_09 = none,
												},
												CHEER_GEN_08 = {
													CHEER_GEN_08 = none,
												},
											},
											BANK_LOAD = none,
										},
									},
									CHEER_COOL = {
										CHEER_COOL2 = {
											LOADED = {
												CHEER_COOL_10 = {
													CHEER_COOL_10 = none,
												},
												CHEER_COOL_09 = {
													CHEER_COOL_09 = none,
												},
												CHEER_COOL_07 = {
													CHEER_COOL_07 = none,
												},
												CHEER_COOL_08 = {
													CHEER_COOL_08 = none,
												},
												CHEER_COOL_06 = {
													CHEER_COOL_06 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_COOL1 = {
											LOADED = {
												CHEER_COOL_01 = {
													CHEER_COOL_01 = none,
												},
												CHEER_COOL_03 = {
													CHEER_COOL_03 = none,
												},
												CHEER_COOL_05 = {
													CHEER_COOL_05 = none,
												},
												CHEER_COOL_04 = {
													CHEER_COOL_04 = none,
												},
												CHEER_COOL_02 = {
													CHEER_COOL_02 = none,
												},
											},
											BANK_LOAD = none,
										},
										CHEER_COOL3 = {
											LOADED = {
												CHEER_COOL_12 = {
													CHEER_COOL_12 = none,
												},
												CHEER_COOL_11 = {
													CHEER_COOL_11 = none,
												},
												CHEER_COOL_15 = {
													CHEER_COOL_15 = none,
												},
												CHEER_COOL_13 = {
													CHEER_COOL_13 = none,
												},
												CHEER_COOL_14 = {
													CHEER_COOL_14 = none,
												},
											},
											BANK_LOAD = none,
										},
									},
									CHEER_STATIC = {
										EMERGENCY_STATIC_ANIM = none,
									},
								},
							},
						},
						DODGE = none,
					},
				},
			},
		},
		DIALOG = {
			TVREACT = {
				WARNINGPOINT = none,
			},
			HELP = {
				HELPMALE = none,
				HELPFEMALE = none,
			},
			GREETWALK = {
				WAVEWALK = none,
				SHRUGWALK = none,
			},
			ADULTWARNING = {
				ADULTWARNING1 = none,
				ADULTWARNING3 = none,
				ADULTWARNING2 = none,
			},
			WARNINGS = {
				WARNINGCLOSE = {
					WARNINGANIMCLOSE = none,
				},
				WARNINGPOINT = none,
			},
			ONESHOTDIALOG = {
				FEMALETALK = {
					FEMALETALK1 = none,
					FEMALETALK2 = none,
				},
				MALETALK = {
					MALETALK2 = none,
					MALETALK3 = none,
					MALETALK1 = none,
				},
			},
			TAUNTS = {
				TAUNTCLOSE = {
					F_OFF = none,
					LAUGHING = COMMON[796],
				},
				TAUNTRANGE = {
					F_OFF = none,
					WARNINGPOINT = none,
					LAUGHING = COMMON[796],
				},
			},
			GREETINGS = COMMON[566],
			POSTBUST = {
				POSTBUSTANIM = none,
			},
		},
		ATTACKWARNINGS = {
			ATTACKWARNANIM = none,
		},
		MISSIONSPEC = {
			FIREMAN = {
				WALL_SMOKE = {
					WALKTOWALL = none,
					WALL_START = {
						WALL_IDLE = {
							WALL_SMOKE_START = COMMON[110],
							WALL_END = none,
						},
					},
					RELEASEANIMGROUP = COMMON[112],
					LOAD_ANIMATION = COMMON[510],
				},
				LOOKAROUND = none,
				TELL_OFF = {
					RELEASEANIMGROUP = COMMON[112],
					GRAPPLEATTEMPT = COMMON[109],
					LOAD_ANIMATION = COMMON[510],
				},
			},
			KISSME = COMMON[855],
			CLOTHING = {
				TRYCLOTHESANIMS = {
					TRYCLOTHESANIM01 = none,
					TRYCLOTHESANIM04 = none,
					TRYCLOTHESANIM02 = none,
					TRYCLOTHESANIM03 = none,
				},
				TRYINGON = none,
				FINISHED = none,
			},
			GETONCANNON = {
				MOVETOCANNON = {
					CANNONINTERACT = none,
				},
			},
			MISSIONLOOKAROUND = {
				HITLOOKAROUND = {
					HITLOOKAROUNDSOUND = none,
				},
			},
			KISSMEADULT = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						PULL_IN_HEAVY = COMMON[856],
					},
				},
				LOAD_ANIMATION = {
					LOADANIM = none,
				},
			},
			PEEDANCE = {
				PEEDANCE = none,
			},
			PLAYERIDLE = {
				IDLEONEFRAME = none,
			},
			WAKEUP = {
				GETUP = {
					GETUP = {
						DUVETINTERACT = none,
					},
					WAITFORANIMS = none,
				},
				WAKEUP_ANYWHERE = {
					WAKEUPBANK = {
						GETUP = none,
						FADEIN = none,
					},
					COLLAPSESCRIPT = none,
					ROBBED = {
						ROBBEDNODE = none,
					},
				},
			},
			KNOCK = {
				KNOCK = {
					KNOCK = {
						KNOCK = none,
					},
				},
			},
			WAKEUPINF = {
				PLAYERANIM = none,
			},
			MISSIONCOWER = {
				COWER_START = COMMON[846],
			},
			PREFECT = {
				PREFECTCHEW = none,
				PREFECTIDLE = {
					PREFECTCHEW = none,
				},
			},
			CUDDLEME = COMMON[855],
			BOXINGCHEER = {
				BOXINGENDING4 = none,
				BOXINGENDING = {
					BOXINGENDING1 = {
						BOXINGENDING2 = {
							BOXINGENDING3 = none,
						},
					},
				},
				CHEERSTART = {
					CHEERCYCLE = none,
				},
			},
			PETERSHOUTING = {
				PETERSHOUTING = none,
			},
		},
		SCENARIOS = {
			SCENARIOGREET = {
				SCENGREETBOY = COMMON[858],
			},
			SCENARIOTALK = {
				SCENARIOTALKBOY = COMMON[859],
				SCENARIOTALKGIRL = COMMON[859],
			},
			SCENARIOEND = {
				SCENARIOEND = none,
			},
			SCENARIOGIVE = {
				SCENARIORECEIVE = none,
				SCENARIOGIVE = none,
			},
		},
	},
	P_BIF = {
		DEFENSE = {
			EVADE = {
				EVADEDUCK = {
					HEAVYATTACKS = {
						EVADEDUCKPUNCH = none,
					},
				},
				EVADERIGHT = {
					HEAVYATTACKS = {
						EVADELEFTPUNCH_LAND = none,
						EVADELEFTPUNCH = COMMON[860],
					},
				},
				EVADELEFT = {
					HEAVYATTACKS = {
						EVADERIGHTPUNCH = COMMON[860],
						EVADERIGHTPUNCH_LAND = none,
					},
				},
			},
			BLOCK = {
				BLOCK = {
					BLOCKHITS = {
						BLOCKIT = {
							BREAKER = COMMON[861],
							HITSLIGHT = none,
						},
					},
				},
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				COMBAT = {
					LONGRANGESTRAFE = none,
					CHEERSTRAFE = COMMON[53],
					STRAFEBASE = COMMON[54],
					STRAFEIDLE = none,
					CLOSERANGESTRAFE = none,
				},
				FREE = {
					IDLE = {
						IDLE_CHECK = {
							IDLE_REGULAR = none,
							IDLE_SOCIAL = {
								GENERICS = COMMON[91],
								UBO_CHECKS = COMMON[92],
								AUTHORITY = COMMON[73],
								NERDS = COMMON[69],
								TOUGHFACTIONS = COMMON[71],
								GIRLS = COMMON[72],
								FAT = COMMON[91],
							},
							IDLE_STEALTH = none,
						},
					},
					WALK = none,
				},
				CROUCHACTIONOPPS = none,
				CROUCHACTIONOPPSBASE = none,
				ACTIONOPPS = none,
			},
			IDLE = none,
			EXECUTENODES = {
				FREE = COMMON[87],
				LOCOMOTIONOVERRIDE = COMMON[28],
				CUSTOMACTIONOPS = COMMON[27],
			},
		},
		OFFENSE = {
			SPECIAL = {
				POWERPUNCHRIGHT = none,
				POWERPUNCHLEFT = none,
			},
			SHORT = {
				LIGHTATTACKS = COMMON[20],
				HEAVYATTACKS = {
					RIGHTHOOK = none,
					LEFTHOOK = none,
				},
			},
			MEDIUM = {
				HEAVYATTACKS = {
					STRAIGHTPUNCH = none,
					GUTPUNCH = none,
				},
			},
		},
	},
	["3_01D"] = {
		ANIMATIONS = {
			SANTA_START = none,
			FACE_IDLE = none,
			SANTA_CYCLE2 = none,
			SANTA_LISTEN = none,
			SANTA_ANNOYED = none,
			SANTA_CYCLE = none,
			SANTA_STRUGGLE = none,
			IDLE = none,
			SANTA_END = none,
			SANTA_TALK = none,
		},
		KIDANIMATIONS = {
			KID_FROWN_SIDE = none,
			KID_STRUGGLE = none,
			SANTA_START = none,
			KID_MAKEFACE2 = none,
			KID_LISTEN_SMILE = none,
			KID_NEUTRAL = none,
			KID_MAKEFACE1 = none,
			KID_ANGRY = none,
			SANTA_CYCLE = none,
			KID_SMILE = none,
			KID_SMILE_SIDE = none,
			KID_SIDE = none,
			KID_TALK = none,
			SANTA_END = none,
			KID_LISTEN = none,
		},
		["3_01D_FACE"] = {
			FACIAL_SMILE = none,
			FACIAL_FROWN = none,
		},
	},
	["1_03_RUNNER"] = {
		CLIMB = none,
		JUMP = none,
	},
	DTCOMICS = {
		PURCHASE = COMMON[31],
		NOROOM = COMMON[32],
		BROKE = COMMON[33],
		START = COMMON[34],
		STOCK = COMMON[35],
		CANCEL = {
			CANCEL = {
				STOPSHOPPING = none,
			},
		},
		BROWSE = COMMON[32],
	},
	SIGNS = {
		PEDPROPSACTIONS = {
			LOOKATSIGN = none,
			DISENGAGE = COMMON[215],
		},
		USEABLE = none,
		NOTUSEABLE = none,
	},
	CV_FEMALE_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[652],
		OFFENSE = {
			SHORT = COMMON[383],
		},
	},
	GIVE1_07 = {
		GIVE_ATTEMPT = {
			PLAYER = {
				PLAYER_PART2 = none,
			},
			SETTARGET = none,
			BUCKY = {
				BUCKY_PART2 = none,
			},
			LOADWAIT = none,
		},
	},
	DBGAME = {
		ROOT = {
			BEFORESTART = {
				NBEFORESTART = {
					NSTART = none,
				},
			},
			ERROR5 = none,
			BALLCONTROL = {
				TEST = none,
				NBALLCONTROL = none,
			},
			CAMERACONTROL = {
				CAMERACONTROLSTART = none,
				CAMERACONTROL = {
					BALLINTEAM1 = {
						BALLINTEAM1COURT = {
							BALLINTEAM1COURT_WITHBALL = none,
							BALLINTEAM1COURT_WITHOUTBALL = none,
						},
						BALLINTEAM1OUTZONE = {
							BALLINTEAM1OUTZONE_WITHBALL = none,
							BALLINTEAM1OUTZONE_WITHOUTBALL = none,
						},
					},
					BALLINTEAM0 = {
						BALLINTEAM0OUTZONE = {
							BALLINTEAM0OUTZONE_WITHBALL = none,
							BALLINTEAM0OUTZONE_WITHOUTBALL = none,
						},
						BALLINTEAM0COURT = {
							BALLINTEAM0COURT_WITHOUTBALL = none,
							BALLINTEAM0COURT_WITHBALL = none,
						},
					},
					GAMEOVER = none,
					TEST = none,
					FREEBALL = {
						FREEBALL = none,
					},
				},
			},
			ERROR1 = none,
			AFTERSTART = {
				NAFTERSTART = none,
			},
			ERROR4 = none,
			TURNCONTROL = {
				TURNCONTROL = {
					ERROR3 = none,
					WAITPICKUP = {
						BALLSTOPPED = none,
						WAITPICKUP = {
							UPDATETURN = none,
						},
					},
					GAMEOVER = {
						SHUTDOWNMISSION = none,
						OTHERTEAMWIN = none,
						PLAYERTEAMWIN = none,
					},
					TURN0 = COMMON[863],
					RESTART = {
						PEDOUTREACT = {
							RESETNOFADE = none,
						},
						RESTARTFADE = {
							NRESTART1 = {
								NRESTART2 = {
									NRESTART3 = none,
								},
							},
						},
						CHECKGAMEOVER = none,
					},
					TURN1 = COMMON[863],
				},
				TURNCONTROLSTART = none,
			},
			ERROR2 = none,
			TEST = {
				TESTNOTHING = none,
			},
		},
	},
	C31STRT = {
		OPPONENTDEFEATED = none,
		PLAYERSTRETCH = none,
		C3_1_CHILD = {
			C3_1_CHILD_CHILD = {
				C3_1_CHILD_CHILD_CHILD = {
					C3_1_CHILD_CHILD_CHILD_CHILD = none,
				},
			},
		},
		LUISINTRO = {
			LUISINTRO01 = none,
		},
		FATTYAVOID = none,
		PLAYERCHEER = {
			PLAYERCHEER02 = none,
		},
		BURTONWHISTLE = {
			BW02 = none,
		},
		PLAYERVICTORY = COMMON[371],
		PLAYERVICTORY01 = {
			PLAYERVICTORY02 = {
				PLAYERVICTORY03 = none,
			},
		},
		PLAYERTAUNT = {
			PLAYERTAUNT2 = none,
		},
		CLEAR = none,
		PLAYERFAIL = COMMON[373],
		BURTONIDLE = {
			BI01 = {
				BI02 = none,
			},
		},
	},
	FREAKS = {
		PAINTEDMAN = {
			PAINTEDMANIDLE2 = none,
			PAINTEDMANIDLE4 = none,
			PAINTEDMANIDLE = none,
			PAINTEDMANIDLE3 = none,
			EXECUTES = COMMON[865],
		},
		MERMAID = {
			MERMAIDIDLE = none,
			MERMAIDLOOP2 = none,
			MERMAIDIDLEA = none,
			MERMAIDLOOP1 = none,
			MERMAIDSWIM = none,
		},
		MIDGETS = {
			CYCLICIDLE = none,
			DESELECT = none,
			SELECT = none,
		},
		SKELETON = {
			SKELETONINIT = none,
			SKELETONWAVE = none,
			SKELETONIDLE = none,
			SKELETONIDLE02 = none,
			SKELETONSALUTE = none,
			EXECUTES = {
				SPEECHCOUGH = none,
				SPEECH = none,
			},
			SKELETONSMOKE = none,
		},
		BREAK = none,
		BEARDED = {
			BEARDEDINIT = none,
			BEARDEDIDLE = {
				BEARDEDANIMATIONS = {
					BEARDEDWAVE = none,
					BEARDEDKISS = none,
					BEARDEDEAT = none,
					BEARDEDFART = none,
					BEARDEDSEXY = none,
					EXECUTES = COMMON[865],
					BEARDEDCALL = none,
				},
			},
		},
	},
	PLAYERAI = {
		OBJECTIVES = {
			MOVEOBJECTIVE = none,
			FOLLOWPATH = none,
			FPPASSENGER = {
				ATBIKE = {
					GETINVEHICLE = {
						BASE = {
							FPPASSENGERGETON = {
								FPPASSENGERGETOFF = COMMON[866],
							},
						},
						LEFTHANDSIDE = none,
					},
				},
				FPPASSENGER_CHILD = none,
				MOVETOVEHICLELHS = COMMON[329],
			},
			FALSEFOLDER = {
				COMBATACTIONS = {
					CONTROLNODE = COMMON[146],
					COMBATACTIONS = {
						BREAKPROP = COMMON[867],
					},
				},
			},
			COMETOSTOPINVEHICLE = {
				BRAKE = none,
			},
			FACEOBJECTIVE = none,
			PROPS = COMMON[185],
		},
		HUDTOGGLE = {
			TAUNTHUDOFF = none,
			TAUNTHUDON = none,
		},
		DEFAULT = {
			CONTROLLER = none,
			FROZEN = none,
			CONTROLLER2 = none,
		},
		CONTROL_STATES = {
			SPAWNBANK = {
				RACESTART = {
					MONITORBUTTON = none,
				},
				SPRINTLOGIC = {
					SPRINT = {
						VARIABLESPRINT = {
							SPEEDLOW = none,
							SPEEDMED = none,
							SPEEDMAX = none,
						},
						PLAYERDECEL = none,
					},
					NOT_SPRINTING = {
						NOT_SPRINTING = none,
						HANDHOLDING_ALLY = {
							HANDHOLDING_ALLY_SMALL = none,
							HANDHOLDING_ALLY_LARGE = none,
						},
					},
				},
				BOOSTMONITOR = {
					BOOSTACTION = none,
				},
			},
			BIKE = {
				STATE = {
					CROUCH = {
						STEER = none,
					},
					MANUAL = {
						STEER = {
							NUDGE = none,
						},
					},
					ATTACK = {
						STEER = {
							ATTACKSPEEDMAINT = {
								HIGHSPEED = none,
								MEDSPEED = none,
							},
						},
					},
					HIT = {
						SLOWDOWN = none,
						HITBYEGG = none,
						HITBYSTINK = none,
					},
					FORWARD = {
						PEDAL = {
							REGULAR = none,
							BOOST = none,
						},
						BRAKE = {
							PAUSE = none,
						},
						COAST = none,
					},
					STAND = {
						DEFAULTBACKUP = none,
						DEFAULTFORWARD = none,
						STILL = none,
					},
					BACKWARD = {
						BACKUP = none,
						STOP = none,
						PEDAL = none,
					},
				},
			},
		},
		COMBO_INPUTS = {
			LOOP = none,
			CROSS_TAP_1 = {
				CROSS_TAP_2 = {
					USERACTIONREQUEST15 = none,
				},
			},
			FORWARD_1 = {
				BACK_2 = {
					USERACTIONREQUEST0 = none,
				},
				FORWARD_2USERACTIONREQUEST2 = none,
			},
			["LEFT_1+LOCK"] = {
				RIGHT_2 = {
					USERACTIONREQUEST7 = none,
				},
			},
			BACK_1 = {
				FORWARD_2 = {
					USERACTIONREQUEST9 = none,
				},
			},
			["RIGHT_1+LOCK"] = {
				LEFT_2 = {
					USERACTIONREQUEST6 = none,
				},
			},
		},
	},
	["1_B_OPEN"] = {
		["1_B_01"] = {
			["1_B_02"] = {
				["1_B_03"] = {
					["1_B_04"] = none,
				},
			},
		},
		TARGETACTIONS = {
			TARGETBRINGIT = none,
			TARGETLOOK = none,
			TARGETIDLE = none,
			TARGETCOMBAT = none,
		},
	},
	["2_01"] = {
		["2_01_GASSTATION"] = {
			["2_01_GASSTATION_1"] = {
				["2_01_GASSTATION_2"] = {
					["2_01_GASSTATION_3"] = COMMON[868],
				},
			},
		},
		["2_01_TRAINSTATION"] = {
			["2_01_TRAINSTATION_1"] = {
				["2_01_TRAINSTATION_2"] = {
					["2_01_TRAINSTATION_3"] = COMMON[868],
				},
			},
		},
		ANIM = {
			ENDINGNIS = {
				["19"] = none,
				["18"] = none,
				["20"] = none,
				["21"] = none,
			},
			GIVEITEM = COMMON[195],
			EDNADISMISS = none,
			TALKING = {
				TALKING4 = none,
				TALKING1 = none,
				TALKING3 = none,
				TALKING2 = none,
			},
			EDNASHRUG = none,
			CHEWOUT = COMMON[856],
			EDNATALK = none,
			GIVE = {
				GIVEEDNA_2_01 = COMMON[486],
			},
		},
		["2_01_GENERALSTORE"] = {
			["2_01_GENERALSTORE_1"] = {
				["2_01_GENERALSTORE_2"] = {
					["2_01_GENERALSTORE_3"] = none,
				},
			},
		},
		["2_01_EDNAEND"] = {
			["2_01_EDNAEND_1"] = none,
		},
		["2_01_EDNASTART"] = {
			["2_01_EDNASTART_1"] = {
				["2_01_EDNASTART_2"] = none,
			},
		},
	},
	["3_01"] = {
		ANIMS = {
			PICKLOCK = none,
			KISSING2 = {
				SPOTTED = COMMON[871],
				SEEBREAK = {
					SEEKBREAK_RCV = none,
				},
				GORD = none,
				SPEECH = {
					CONVO2 = {
						CONVO2IDLE = {
							CONVO2END = none,
							SEEBREAK = none,
						},
						CONVO2B = none,
					},
					CONVO1 = {
						CONVO1B = none,
						CONVO1IDLE = {
							CONVO1END = none,
							SEEBREAK = none,
						},
					},
				},
			},
			HOLD_IDLE = {
				SPEAK = none,
				SPEAK_CYCLE2 = none,
				ATTACKED = none,
				SPEAK_CYCLE1 = none,
			},
			QUICKIDLE = none,
			JOHNNYSMOKE = {
				START = COMMON[872],
				STUB = none,
			},
			BREAK = none,
			GIVEPHOTOS = {
				GIVEJOHNNY3_01 = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = {
							GIVE_WAIT = none,
							GET_OBJECT = none,
						},
						RECEIVE = COMMON[870],
						GIVE_ATTEMPT_SPEECH = none,
						RECEIVEWAIT = none,
					},
				},
			},
			FLOWERGIVE = {
				FLOWERGIVE = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = {
							GETFLOWERS = none,
						},
						RECEIVE = {
							RECEIVE = COMMON[873],
							SEEBREAK = COMMON[874],
						},
						RECEIVEWAIT = none,
					},
				},
			},
			WALL_SMOKE = COMMON[218],
			FAILANIM = none,
			KISSFINAL = {
				KISS = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = COMMON[876],
						RECEIVE = {
							RECEIVE = COMMON[873],
						},
						RECEIVEWAIT = none,
						GORDSPEECH = COMMON[877],
					},
				},
			},
			KISS = {
				KISS = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = COMMON[876],
						RECEIVE = {
							RECEIVE = {
								GIVE = none,
								SEEBREAK = COMMON[874],
								SCRIPTCALLBACK = none,
							},
						},
						RECEIVEWAIT = none,
						GORDSPEECH = COMMON[877],
					},
				},
			},
			POINT = none,
			EXITCAR = none,
			ENTERCAR = none,
		},
	},
	NPC1_09 = {
		EARNESTCRY = {
			BOOHOO = none,
		},
		OFFENSE = COMMON[878],
		STUDENT = {
			DEFAULT = {
				IDLES = {
					AMBIENT = COMMON[879],
					SITTING3 = none,
					SITTING1 = none,
					SITTING4 = none,
					ATTACKED = none,
					SITTING2 = none,
				},
			},
		},
		MASCOT = {
			MASCOTDANCING = COMMON[694],
		},
		SPEECH = {
			HITEXEC = {
				MOVEOPPS = none,
				EARNESTHITS = {
					BASE = {
						HITBASEEXEC = none,
					},
					HEAD = {
						FRONT = COMMON[880],
						REAR = COMMON[880],
					},
					TORSO = {
						FRONT = COMMON[881],
						REAR = COMMON[881],
					},
					DEFAULTBODY = {
						DEFAULT1 = none,
						DEFAULT2 = none,
						DEFAULT3 = none,
					},
				},
			},
			SPEECH1 = none,
		},
		SEATEDJOCK = {
			SITDOWNHIT = none,
			DEFAULT = {
				SITTING = {
					AMBIENT = COMMON[879],
				},
			},
			ATTACKLOOP = {
				ACTIONS = {
					STANDING = none,
					BOO = none,
					THROW = COMMON[835],
					F_OFF = none,
				},
				STANDUP = none,
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				COMBAT = {
					STRAFEBASE = {
						STRAFEFINISH = none,
						STRAFEBASIC = none,
					},
					STRAFEIDLE = none,
					STRAFE = none,
				},
				FREE = {
					RUN = none,
					IDLE = none,
					HITREACT = none,
					SPEEDRUN = {
						STOP = {
							SLIDE = COMMON[406],
						},
					},
				},
				ACTIONOPPS = none,
			},
			EXECUTENODES = {
				FREE = {
					FREEBASIC_TEST = none,
					FREEBASIC = none,
					SPEEDRUNBASIC = none,
				},
				COMBAT = {
					STARTIDLE = {
						IDLE = {
							IDLEEND = none,
						},
					},
				},
			},
		},
	},
	["1_01"] = {
		SHORTIDLE = none,
		PUNCHHANDS = none,
		GATES = {
			BARUPHOLD = none,
			OPENHOLD = none,
		},
		TALKING = COMMON[161],
		WAVETOSEC = none,
	},
	["1_09"] = {
		CUSTOMPEDTREE = {
			ANIMATIONS = {
				JOCK = {
					BOOS = {
						BOO5 = none,
						BOO1 = none,
						BOO4 = none,
						BOO3 = none,
						BOO2 = none,
					},
					BOOSELECTOR = none,
				},
				NERD = {
					CHEERS = {
						CHEER4 = none,
						CHEER2 = none,
						CHEER3 = none,
						CHEER1 = none,
						CHEER5 = none,
					},
					CHEERSELECTOR = none,
				},
			},
			NERDACTIONS = COMMON[885],
			JOCKACTIONS = COMMON[885],
			SPEECH = {
				SPEECHLINES = {
					BUCKY = none,
					FATTY = none,
					CASEY = none,
					KIRBY = none,
					DAN = none,
					CORNELIUS = none,
				},
				SPEECHSELECTOR = {
					SPEECHFALSE = none,
					SPEECHTRUE = none,
				},
			},
			BREAK = none,
		},
		NIS = {
			EARNEST = {
				EARNEST02 = none,
				EARNEST01 = none,
				EARNEST03 = none,
			},
		},
		EARNESTSPEECH = {
			["29"] = none,
			["19"] = none,
			["09"] = none,
			["07"] = none,
			["15"] = none,
			["05"] = none,
			["17"] = none,
			["13"] = none,
			["03"] = none,
			["11"] = none,
			["01"] = none,
			["28"] = none,
			["23"] = none,
			["31"] = none,
			["12"] = none,
			["02"] = none,
			["04"] = none,
			["27"] = none,
			["06"] = none,
			EXECUTENODES = {
				CUSTOMHITTREE = {
					HIT = COMMON[365],
					NOHIT = none,
				},
			},
			["08"] = none,
			["18"] = none,
			["25"] = none,
			["21"] = none,
			["14"] = none,
			["24"] = none,
			["16"] = none,
			["26"] = none,
			["20"] = none,
			["30"] = none,
			["22"] = none,
			["10"] = none,
		},
		PLAYERPICKUPSLINGSHOT = COMMON[306],
		["1_09_START"] = {
			["1_09_2"] = none,
		},
		["1_09_END"] = {
			["1_09_END2"] = none,
		},
	},
	C7 = {
		PLAYERSIT = COMMON[887],
		C7_INTRO_2 = COMMON[888],
		C7_INTRO_5 = COMMON[888],
		PLAYERFAIL = COMMON[373],
		C7_INTRO_1 = COMMON[888],
		PLAYERVICTORY = COMMON[891],
		C7_INTRO_3 = COMMON[892],
		NIS_OUT = COMMON[893],
		RELEASE = none,
		TEACHERDISGUST = none,
		C7_INTRO_4 = COMMON[892],
	},
	["4_01"] = {
		BUSTED = COMMON[511],
		BUSTEDSHOWER = {
			SETUPCAMERA = {
				FREAKOUT = COMMON[895],
			},
		},
		ANIMS = {
			GYMCUT = {
				CHLEADIDLE01 = COMMON[475],
				MANDY = {
					MANDY01 = none,
				},
				CHLEADIDLE03 = COMMON[475],
				SMELLSELFOLD = {
					SMELLLEFT = {
						SMELLRIGHT = none,
					},
				},
				FALLDOWNGETUP = {
					JUMP = {
						FALLDOWN = {
							STAYDOWN = {
								STAYDOWN02 = COMMON[357],
							},
						},
					},
				},
				CHLEADIDLE04 = COMMON[475],
				SMELLSELF = {
					SMELL_PITS = none,
				},
				CHLEADIDLE05 = COMMON[475],
			},
			EMPTY = none,
			GIVE = {
				GIVEEARNEST_4_01 = COMMON[486],
			},
			FREAKOUT = {
				FREAKOUT = {
					COVERUP = none,
				},
			},
			CHEERLEADING = COMMON[897],
			MASSAGINGLEG = {
				LEGIN = {
					LEGLOOPA = {
						LEGLOOPB = none,
					},
				},
			},
			SHOWERING = {
				FINISHEDSHOWER = none,
				WASH01 = {
					RINSE01 = {
						WASH02 = {
							RINSE02 = none,
						},
					},
				},
			},
		},
	},
	["5_01"] = {
		["5_01_POISONEFFECT1"] = {
			["5_01_POISONEFFECT1INTRO"] = {
				["5_01_POISONEFFECT1CYCLE"] = {
					["5_01_POISONEFFECT1OUTRO"] = none,
				},
			},
		},
		["5_01_LIBRARIAN_CLEARACTION"] = none,
		["5_01_POISONEFFECT2"] = {
			["5_01_POISONEFFECT2INTRO"] = {
				["5_01_POISONEFFECT2CYCLE"] = {
					["5_01_POISONEFFECT2OUTRO"] = none,
				},
			},
		},
		["5_01_WIPECRATELABEL"] = none,
		["5_01_POISONEFFECT3"] = {
			["5_01_POISONEFFECT3INTRO"] = none,
		},
		["5_01_RAT_AMBIENCE_START"] = none,
		["5_01STARTCONV"] = {
			["5_01STARTCONV_2"] = {
				["5_01STARTCONV_3"] = {
					["5_01STARTCONV_4"] = {
						["5_01STARTCONV_5"] = {
							["5_01STARTCONV_6"] = {
								["5_01STARTCONV_7"] = {
									["5_01STARTCONV_8"] = {
										["5_01STARTCONV_9"] = {
											["5_01STARTCONV_10"] = {
												["5_01STARTCONV_11"] = none,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		["5_01_LIBRARIAN"] = {
			["5_01_LIBRARIAN_ACTIONCOWER"] = COMMON[846],
			["5_01_LIBRARIAN_ACTIONLOOKAROUND"] = none,
			["5_01_LIBRARIAN_ACTIONCRY"] = none,
		},
		NIS = {
			PLAYER = {
				PLAYER_02 = none,
				PLAYER_01 = none,
			},
			LIBRARIAN = {
				LIBRARIAN_01 = none,
				LIBRARIAN_02 = none,
				LIBRARIAN_03 = none,
			},
		},
		["5_01_EMPTY"] = none,
		["5_01_START"] = {
			["5_02STARTCONV02"] = {
				["5_02STARTCONV03"] = COMMON[898],
			},
		},
		["5_01_POISONEFFECT0"] = {
			["5_01_POISONEFFECT0"] = none,
		},
		["5_01_RAT_AMBIENCE_STOP"] = none,
		["5_01_PLAYERCOLLAPSE"] = none,
	},
	["3_S03"] = {
		["3_S03_RCV"] = {
			["3_S03_RCV_ANIM"] = {
				["3_S03_RCV_IDLE"] = none,
			},
		},
		EMPTY = none,
		DELETEME = {
			CRABBLE01 = none,
			HATTRICK01 = none,
			PLAYER01 = none,
			GALLOWAY01 = none,
		},
		OUTROOLD = {
			CONVINITIATE = COMMON[638],
			LINE1 = {
				LINE2 = {
					LINE3 = {
						LINE4 = {
							LINE5 = {
								LINE6 = {
									LINE7 = {
										LINE8 = {
											LINE9 = {
												LINE10 = COMMON[95],
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		["3_S03_FINISH"] = none,
		NIS = {
			PLAYER = COMMON[431],
			HATTRICK = {
				HATTRICK01 = none,
			},
			CHEATERS = {
				GREASERS = {
					PREP = {
						PREPGIVE = none,
					},
					LUCKY = {
						LUCKYWAIT = none,
					},
					VANCE = {
						VANCETAKE = none,
						VANCEWAIT = none,
					},
				},
				HATTRICK = {
					HATTRICKWAIT = none,
					HATTRICK01 = none,
				},
				JOCKS = {
					PREP = none,
					CASEY = {
						CASEYWAIT = none,
					},
					MANDY = {
						MANDYWAIT = none,
					},
				},
			},
			CRABBLE = {
				CRABBLE01 = none,
			},
			GALLOWAY = COMMON[432],
			PLAYER01TEMP = none,
		},
		["3_S03_GIVEBOTTLE"] = {
			GIVEBOTTLE = none,
		},
		["3_S03_GIVE"] = {
			["3_S03_GIVE_ANIM"] = {
				["3_S03_GIVE_IDLE"] = none,
				["3_S03_GIVE_ANIM_DETACH"] = none,
			},
		},
		["3_S03_INTRO"] = {
			["3_S03_SETUPCONV02"] = {
				["3_S03_SETUPCONV03"] = {
					["3_S03_SETUPCONV04"] = {
						["3_S03_SETUPCONV05"] = {
							MENU = {
								YES = COMMON[899],
								NO = none,
							},
						},
					},
				},
			},
		},
		["3_S03_GALLOWAYJIMMYSTART"] = {
			["3_S03_GALLOWAYJIMMYSTART_CHILD"] = none,
		},
		ANIMS = {
			GIVEPAPERSOLD = COMMON[111],
			GIVEPAPERS = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						PULL_IN_HEAVY = {
							HELD = none,
							HOLD_IDLE = {
								GIVE = {
									GIVE = {
										GIVE = COMMON[255],
									},
								},
								GRAPPLEBREAK = COMMON[394],
								RCV = none,
							},
							HOLD = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
			},
			GIVEPAPERSSHORT = {
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						PULL_IN_HEAVY = {
							HELD = none,
							HOLD_IDLE = {
								GRAPPLEBREAK = COMMON[394],
							},
							HOLD = none,
						},
						GRAPPLERCVWAIT = none,
					},
				},
			},
		},
	},
	AI_DOG = {
		CONTROLLER = COMMON[762],
		GENERALOBJECTIVES = {
			MOVEOBJECTIVE = none,
			FOLLOWPATH = none,
			WANDER = none,
			FLEEOBJECTIVE = none,
			IDLE = none,
			FACEOBJECTIVE = none,
			FOLLOWFOCUS = none,
		},
		SCRIPTED = none,
		POIRELEASE = none,
		SOCIALDOG = {
			FOLLOWPLAYER = none,
			INITIALGREET = {
				PLEASANTIDLE = {
					RESPONSES = {
						ACCEPTGIFT = {
							GIFTCHEER = none,
						},
						FLATTER = none,
					},
				},
			},
		},
		REACTIONS = {
			FACTION = {
				HATECHECK = none,
				FRIENDATTACKED = none,
			},
			STIMULI = {
				TARGETED = {
					RESETSTIMULUS = none,
				},
				RESPONSE = {
					RESPONDTAUNT = {
						TAUNTTURN = none,
					},
				},
				COWDANCE = {
					FACECOW = none,
					COWDANCESPEAK = {
						DOG = none,
					},
				},
				COWDANCESUCCESS = COMMON[609],
				FETCH = {
					RUNTOOBJECT = {
						PICKUPOBJOPP = {
							RETURNTORUN = none,
							PICKUPOBJECT = {
								RETURNOBJECTTOOWNER = {
									DROPOBJECT = none,
								},
							},
						},
					},
					CLEARSTIMULUS = none,
				},
				DEADRAT = {
					FACERAT = {
						RATREACTIONS = {
							LOOKAT = none,
							RATFLEE = none,
						},
					},
				},
				PEDHITNEARBY = COMMON[900],
				PROJECTILE = none,
				MEATSTIM = {
					MEATSEE = {
						MEATMOVE = {
							MEATPICKUP = none,
						},
					},
					MEATSEEALLY = {
						MEATMOVE = {
							MEATPICKUPNOSLEEP = none,
							MEATPICKUPALLY = none,
						},
					},
				},
				EXPLOSION = COMMON[596],
				WEAPONFIRED = COMMON[901],
				COWDANCEFAIL = COMMON[605],
			},
			HITREACT = {
				HITREACTWAIT = {
					TURNTOFACE = {
						ATTACKCHECK = {
							SEEATTACKER = {
								ATTACKED = none,
							},
							SEEDISLIKED = COMMON[208],
						},
					},
				},
			},
		},
		DUMMYIDLE = none,
		COMBATACTIONS = {
			BREAKPROP = none,
			OFFENSE = {
				MELEEACTIONS = COMMON[107],
			},
		},
		ALLY = {
			ALLYLOCO = none,
			DISMISS = {
				DISMISS = none,
			},
			ALLYCOMBATLOCO = none,
			ALLYOPS = none,
		},
		COMBAT = {
			ACTIVECOMBAT = {
				GUARDLOCO = none,
				DOGFLEE = {
					DOGFLEE = none,
				},
				TETHERLOCO = none,
				MEATEXIT = none,
				COMBATLOCO = none,
				WAITFORTARGETLOCO = {
					WAITFORTARGETEXIT = none,
				},
				ATTACKWARNING = {
					ATTACKWARN = none,
				},
			},
		},
		PROPS = COMMON[185],
	},
	["3_G3_CONV"] = {
		CUSTOMANIM = {
			DISMISS = none,
			RESTOREIFHIT = none,
			PUSH = none,
			ANGRY = none,
			CHEER = {
				CHEERFIGHT5 = none,
				CHEERFIGHT4 = none,
				CHEERFIGHT2 = none,
			},
			RESTORE = none,
			KISS = COMMON[393],
			LOLACOUNTDOWNSTART = {
				LOLACOUNTDOWNEND = none,
			},
			SHAKEFIST = none,
			STRAIGHTENCOLLAR = {
				ANGRYDISMISS = none,
			},
			FACE = none,
		},
		WINRACENIS = {
			PLAYER = COMMON[431],
			GREASERS = {
				JOHNNY = none,
				LOLA = none,
			},
		},
		M_3_G3_10 = {
			M_3_G3_11 = {
				M_3_G3_12 = COMMON[95],
			},
		},
		CHEERAGE = COMMON[523],
	},
	["3_B"] = {
		NIS = {
			PETER = {
				PETER01 = none,
			},
		},
		PLAYERFALLOFFBIKE = {
			HITHARDBACK = COMMON[352],
			PLAYERRESET = none,
		},
		ANIMATION = {
			STAND = COMMON[906],
			CROUCH = {
				CROUCH = none,
			},
		},
		PETEYUSECRANE = {
			GETINANDUSECRANE = {
				GETIN = {
					USECRANE = {
						INCRANELOOPS = {
							INCRANESTART = {
								LOOPS = {
									CHEER = none,
									STAYIDLE = none,
									PUSHBUTTONS = none,
								},
							},
						},
					},
				},
			},
			USECRANE = {
				INCRANELOOPS = {
					INCRANESTART = {
						LOOPS = {
							CHEER = none,
							PUSHBUTTONS = none,
						},
						STAYIDLE = none,
					},
				},
			},
		},
	},
	SNOWSHOVEL = {
		SNOWSHOVEL = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = {
				ANIMATIONS = {
					WEAPONWALK = COMMON[351],
					WEAPONBIKEIDLE = none,
					WEAPONSOCIAL = COMMON[164],
					WEAPONCROUCH = none,
					WEAPONRUN = none,
					WEAPONSTRAFE = none,
					WEAPONIDLE = COMMON[351],
				},
				GLOBALLOCO = COMMON[165],
			},
			ACTIONS = {
				SHOVEL = {
					WEHAVESNOW = none,
					SNOWOPPHACK = none,
				},
			},
			DEFAULT_KEY = none,
		},
	},
	["3_R08_STORE"] = {
		CINEMATIC = {
			["3_R08_MENU_A"] = {
				["3_R08_MENU_A01"] = {
					["3_R08_MENU_B"] = {
						["3_R08_MENU_B03"] = {
							["3_R08_DIRECT03"] = {
								["F_SETCURRENTRACE(2)"] = COMMON[898],
							},
						},
						["3_R08_MENU_B05"] = {
							["3_R08_NEG"] = COMMON[95],
						},
						["3_R08_MENU_B02"] = {
							["3_R08_DIRECT02"] = {
								["F_SETCURRENTRACE(1)"] = COMMON[898],
							},
						},
						["3_R08_MENU_B04"] = {
							["3_R08_DIRECT04"] = {
								["F_SETCURRENTRACE(3)"] = COMMON[898],
							},
						},
						["3_R08_MENU_B01"] = {
							["3_R08_DIRECT01"] = {
								["F_SETCURRENTRACE(0)"] = COMMON[898],
							},
						},
					},
					["3_R08_INSTRUC01"] = {
						["3_R08_INSTRUC02"] = {
							["3_R08_INSTRUC03"] = {
								["3_R08_INSTRUC04"] = {
									["3_R08_DIRECT01"] = COMMON[898],
								},
							},
						},
					},
				},
			},
		},
	},
	GIVECHOCOLATES = {
		GIVECHOCOLATEBOX = {
			WAIT = none,
			GIVE_ATTEMPT = {
				GIVE_SEEK = {
					GIVE_WAIT = none,
					GET_OBJECT = none,
					GIVE_SEEKENTITY = none,
				},
				RECEIVE = {
					RECEIVE = {
						GIVE = COMMON[907],
						RECEIVE_SPEECH = COMMON[908],
					},
				},
				GIVE_ATTEMPT_SPEECH = none,
				RECEIVEWAIT = none,
			},
		},
	},
	THROWN = {
		THROWN = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = {
				ANIMATIONS = {
					WEAPONWALK = {
						WEAPONWALK = none,
						BALL = none,
						BANANA = none,
						FRISBEE = none,
						["2HANDED"] = none,
						POOBAG = none,
					},
					WEAPONBIKEIDLE = {
						WEAPONBIKEIDLE = none,
						BALL = none,
						BANANA = none,
						FRISBEE = none,
						POOBAG = none,
					},
					WEAPONSOCIAL = {
						WEAPONIDLE = COMMON[909],
						PERFORMINGACTION = {
							FRISBEE = none,
							BALL = none,
							BANANA = none,
							POOBAG = none,
							["2HANDED"] = none,
							PERFORMINGACTION = none,
						},
					},
					WEAPONCROUCH = {
						FRISBEE = none,
						BALL = none,
						WEAPONCROUCH = none,
						BANANA = none,
						POOBAG = none,
					},
					WEAPONRUN = {
						FRISBEE = none,
						BALL = none,
						BANANA = none,
						WEAPONRUN = none,
						["2HANDED"] = none,
						POOBAG = none,
					},
					WEAPONSTRAFE = {
						WEAPONSTRAFE = none,
						BALL = none,
						BANANA = none,
						FRISBEE = none,
						["2HANDED"] = none,
						POOBAG = none,
					},
					WEAPONIDLE = COMMON[909],
				},
				GLOBALLOCO = COMMON[165],
			},
			ACTIONS = {
				CONTROLLER = {
					SPINECONTROLHACK = none,
					UPPERBODY = {
						OVERHAND = {
							THROW = {
								CHARGE = {
									RELEASE = {
										ALTFIRE = {
											STINKBOMB = none,
											CHERRYBOMB = none,
											BANANA = none,
										},
										RELEASE = {
											DETACHWEAPON = none,
										},
										RBANDBALL = none,
									},
									LOWERBODY = {
										BLOCK = none,
										IDLE2AIM = none,
									},
								},
								THROWSTART_TED = none,
								AI_BANANA = none,
							},
							LIGHTBOMB = {
								LIGHTBOMB = none,
								LIGHTBOMBCROUCH = none,
							},
							EXECUTENODES = {
								CHERRYB_ACTIONOPPS = none,
								BOOM = none,
								SETUPBBALL = COMMON[910],
							},
						},
						UNDERHAND = {
							CHARGE = {
								RELEASE = {
									ALTFIRE = {
										MARBLES = none,
										ITCHINGPOWDER = none,
									},
									THROW = {
										DETACHWEAPON = none,
										PARTICLEEXECUTES = {
											W_ITCH = none,
										},
									},
								},
								ANIMEXECUTE = {
									FROMIDLE = none,
									AIMMODE = none,
								},
							},
						},
						["2HANDED"] = COMMON[911],
						FRISBEE = COMMON[911],
					},
				},
				THROWSPEECH = {
					THROWSPEECH1 = none,
				},
				DROPFOUNTAIN = {
					LIGHTFOUNTAIN = {
						PLACEFOUNTAIN = none,
					},
				},
				WAIT = none,
				FOODSECONDARY = {
					EATDIRECT = {
						AI = {
							AI_DROP = none,
						},
						EAT_APPLE = none,
						HEALTHGAIN = {
							BANANA = none,
						},
						EAT_NANA = {
							LOCOSPAWN = COMMON[483],
						},
					},
				},
				BBALL_HOOP = COMMON[627],
			},
			DEFAULT_KEY = none,
		},
	},
	["1_11X1"] = {
		ANIMATIONS = {
			PETECAN = {
				CYCLE = none,
				GETOUT = none,
			},
			GARYIDLEINBED = none,
			LAUGH_SHOVE = {
				LAUGH = {
					IDLE = {
						SHOVE = none,
					},
				},
			},
			LAUGHCYCLIC = {
				LAUGHCYCLIC = none,
			},
		},
		EMPTY = none,
	},
	OVERRIDE = {
		CONSTANTINE = none,
	},
	GIVEBAGMRBLS = COMMON[914],
	P_STRIKER_B = {
		DEFENSE = {
			EVADE = {
				EVADECOUNTER = none,
				EVADEBACK = {
					EVADEBACK = none,
				},
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[3],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = {
					CATCH_THROW = COMMON[12],
					HEAVYATTACKS = {
						CATCH_THROW = {
							COLLISION = {
								NORMAL = none,
								ATTACKINTERRUPT = none,
							},
						},
					},
				},
				NONCOMBATACTIONS = {
					TAUNTS = COMMON[6],
				},
				STRIKES = {
					UNBLOCKABLE = COMMON[5],
					HEAVYATTACKS = {
						HOOK2 = COMMON[14],
						UPPERCUT = none,
					},
					LIGHTATTACKS = {
						LEFTJAB = COMMON[16],
					},
				},
			},
			MEDIUM = {
				WEAVE = COMMON[19],
			},
		},
	},
	AI_MASCOT_4_05 = {
		COMBAT = {
			ATTACKFROMCOVER = COMMON[919],
			SCRIPTED = COMMON[920],
			ACTIVECOMBAT = {
				STEALTHPROPEXIT = COMMON[921],
				COMBATLOCO = COMMON[922],
				AUTHORITYEXIT = none,
				COMBATTETHERLOCO = {
					FOOTBALLGUYCOMBATTETHERLOCO = none,
				},
				GUARDLOCO = none,
				CHEERLOCO = none,
				DEATHTAUNT = COMMON[613],
				AUTHORITYEXIT2 = none,
				SPECIAL = COMMON[923],
				ATTACKWARNING = COMMON[924],
				WAITFORTARGETLOCO = COMMON[925],
			},
			FINDSNOWBALL = none,
		},
		GENERALOBJECTIVES = COMMON[926],
		AIACTIONOPPS = {
			CHEERING = COMMON[927],
			COWEROPPS = COMMON[928],
			DIALOGOPPS = COMMON[929],
			SPECTATOROPPS = COMMON[930],
			AUTHORITYGRABOPPS = COMMON[931],
			KNOCKOUTTAUNTOPPS = COMMON[932],
			REACTIONOPPS = COMMON[933],
			ALLYOPPS = COMMON[934],
			STUCKOPPS = COMMON[935],
			HANGOUTOPPS = {
				HANGOUTOPP = none,
			},
			HARASSOPPS = COMMON[936],
			ATTACKWARNINGOPPS = COMMON[937],
			SITOPPS = COMMON[938],
			SCENARIOOPPS = COMMON[939],
		},
		DUMMYIDLE = none,
		EVADE = COMMON[940],
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				REMOVEFLASHLIGHT = none,
				GROUNDATTACK = COMMON[148],
				POSTHIT = COMMON[241],
				AUTHORITYFIGHTSTIM = COMMON[941],
				CLOSINGATTACK = COMMON[623],
				EVADE = {
					ADULT = COMMON[942],
					PREPS = {
						GRAPPLER = COMMON[943],
						STRIKER_B = COMMON[943],
					},
				},
				PURSUITATTACK = COMMON[624],
				FINDWEAPON = COMMON[147],
				BREAKPROP = COMMON[867],
				BLOCK = COMMON[99],
				COMBATSPEECH = COMMON[153],
				OFFENSE = {
					RUNNINGATTACKS = COMMON[947],
					MELEEACTIONS = {
						LONG = none,
						FEMALEFLEE = COMMON[948],
						SHORT = COMMON[158],
						SPECIAL = COMMON[923],
						MEDIUM = COMMON[156],
					},
				},
				COMMUNICATION = {
					PICKHELPER = none,
				},
				COUNTERATTACK = COMMON[101],
				RANGEDWEAPONCHECK = COMMON[154],
				UMBRELLACHECK = COMMON[950],
			},
		},
		SCRIPTED = COMMON[920],
	},
	N_STRIKER_B = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[464],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = COMMON[465],
					HEAVYATTACKS = COMMON[488],
				},
			},
			MEDIUM = {
				SHORTEXEC = none,
				STRIKES = {
					HEAVYATTACKS = {
						VOMIT = COMMON[635],
					},
				},
			},
		},
	},
	DO_STRIKER_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[466],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = COMMON[467],
			MEDIUM = {
				HEAVYATTACKS = {
					OVERHANDSWING = none,
				},
			},
		},
	},
	GIVE2S04 = {
		GIVE = COMMON[195],
		GIVE_ATTEMPT = COMMON[955],
		EXECUTES = {
			ANIMS = COMMON[377],
			SPEECH = {
				RECEIVE = {
					WAITFORPLAYER = {
						SPEECHSTART = none,
					},
					PLAYERREMOTE = none,
				},
				GIVE = none,
				SEEK = none,
				RECEIVEWAIT = none,
			},
			MODELS = COMMON[198],
			WEAPONREMOVAL = COMMON[956],
		},
	},
	["2_06"] = {
		["2_06_GO"] = none,
		["2_06_LINEUP01BANK"] = {
			["2_06_LINEUP01WA"] = none,
			["2_06_LINEUP01A"] = {
				["2_06_LINEUP01B"] = {
					["2_06_LINEUP01C"] = {
						["2_06_LINEUP01D"] = {
							["2_06_LINEUP01E"] = {
								["2_06_LINEUP01F"] = {
									["2_06_LINEUP01G"] = {
										["2_06_STARTSUB1"] = none,
									},
								},
							},
						},
					},
				},
			},
		},
		["2_06_PINKYLINEUPBANK"] = {
			["2_06_PINKYLINEUP01"] = none,
		},
		["2_06_END"] = COMMON[127],
		["2_06_WIN"] = {
			["2_06_02"] = {
				["2_06_04"] = {
					["2_06_05"] = {
						["2_06_06"] = none,
					},
				},
			},
		},
		["2_06_LINEUP03BANK"] = {
			["2_06_LINEUP03A"] = {
				["2_06_LINEUP03B"] = {
					["2_06_LINEUP03C"] = {
						["2_06_LINEUP03D"] = {
							["2_06_LINEUP03E"] = {
								["2_06_LINEUP03F"] = {
									["2_06_STARTSUB3"] = none,
								},
							},
						},
					},
				},
			},
			["2_06_LINEUP03WA"] = {
				["2_06_LINEUP03WB"] = none,
			},
		},
		["2_06_TARGET"] = {
			["2_06_TARGETANIM2"] = none,
			["2_06_TARGETANIM1"] = none,
			["2_06_EMPTYANIM"] = none,
		},
		["2_06_LINEUP04BANK"] = {
			["2_06_LINEUP04A"] = {
				["2_06_LINEUP04B"] = {
					["2_06_LINEUP04C"] = {
						["2_06_LINEUP04D"] = {
							["2_06_LINEUP04E"] = {
								["2_06_LINEUP04F"] = {
									["2_06_LINEUP04G"] = {
										["2_06_STARTSUB4"] = none,
									},
								},
							},
						},
					},
				},
			},
			["2_06_LINEUP04FA"] = {
				["2_06_LINEUP04FB"] = none,
			},
		},
		["2_06_START"] = {
			["2_06_02"] = {
				["2_06_04"] = {
					["2_06_05"] = {
						["2_06_06"] = {
							["2_06_07"] = {
								REPLIES = {
									POSITIVE = COMMON[898],
									NEGATIVE = none,
								},
							},
						},
					},
				},
			},
		},
		["2_06_STARTFROMDEBUG"] = {
			["2_06_02"] = {
				["2_06_04"] = {
					["2_06_05"] = {
						["2_06_06"] = {
							["2_06_07"] = {
								POSITIVE = none,
							},
						},
					},
				},
			},
		},
		NISLOLA = {
			GORD = {
				GORD01 = none,
			},
			GLOBAL_CHILD = none,
			LOLA = {
				LOLA01 = none,
			},
		},
		ANIMS = {
			KNOCKONDOOR = none,
			LOOKAROUNDL = {
				LOOKAROUNDR = none,
			},
			DOG_LIE = {
				DOG_LIE_OUT = none,
			},
			HOMELESS = {
				SIT02B = none,
				SITIDLE01 = none,
				SITIDLE03 = none,
				DEFAULT = none,
				SIT03A = none,
				SIT03B = none,
				SITIDLE02 = none,
				SIT01 = none,
				SIT02A = none,
			},
			DEFAULT = none,
			SWEEPFLOORS = {
				START_SWEEPING = COMMON[95],
				END = none,
			},
			CRYING = {
				HOLDFACE = none,
				DEFAULT = none,
				CRY = none,
			},
		},
		CHEER_TEMP = none,
		["2_06_LINEUP02BANK"] = {
			["2_06_LINEUP02A"] = {
				["2_06_LINEUP02B"] = {
					["2_06_LINEUP02C"] = {
						["2_06_LINEUP02D"] = {
							["2_06_LINEUP02E"] = {
								["2_06_STARTSUB2"] = none,
							},
						},
					},
				},
			},
			["2_06_LINEUP02WA"] = {
				["2_06_LINEUP02WB"] = {
					["2_06_LINEUP02WC"] = none,
				},
			},
		},
		RELEASE = none,
		NISPINKY = {
			PINKY = {
				PINKY03 = none,
				PINKY02 = none,
				PINKY01 = none,
				PINKY04 = none,
			},
			JIMMY = COMMON[959],
		},
	},
	SIMPLELOCO = {
		MISSION = {
			INVULNERABLEIDLE = none,
		},
		MOVETOEXECUTE = {
			MOVETOSTRAFETO = {
				IDLE = none,
				LOCO = {
					MOVETO = none,
					STRAFE = {
						STRAFETO = COMMON[960],
						STRAFETOSTART = none,
					},
				},
			},
			TIRED_UPPERBODY = none,
			WALKBASIC = none,
			WALKBASICNONMASTER = none,
		},
		DEFAULT_KEY = {
			FULLBODYACTIONOPPS = none,
			DEFAULT = none,
			LOCOMOTION = COMMON[231],
			SOCIALEXECUTE = none,
		},
	},
	["4_06"] = {
		["4_06_MARBLEDR"] = COMMON[962],
		["4_06_HACK_SWITCH"] = {
			["4_06_HACK_SWITCH_ACTION"] = none,
		},
		WORKOUT = COMMON[640],
		["4_06_DONALD"] = {
			["4_06_DONALD_01"] = {
				["4_06_DONALD_02"] = COMMON[868],
			},
		},
		["4_06_WIZZ"] = {
			PUKE = {
				VOMIT = {
					VOMIT02 = {
						VOMIT03 = none,
					},
				},
				GAGSOUND = COMMON[214],
			},
			CROUCH = {
				CROUCH1 = {
					CROUCH2 = none,
				},
			},
			["4_06_GO_WIZZ"] = {
				["4_06_STOP_SOUND"] = none,
			},
			DISAPPOINT = none,
			PUKEOLD = COMMON[844],
		},
		["4_06_BEATRICE"] = {
			["4_06_BEATRICE_01"] = {
				["4_06_BEATRICE_02"] = {
					["4_06_BEATRICE_03"] = {
						["4_06_BEATRICE_04"] = {
							["4_06_BEATRICE_05"] = COMMON[868],
						},
					},
				},
			},
		},
		COWDANCETUTORIAL = {
			MESSAGE2 = {
				MESSAGE2 = COMMON[735],
			},
		},
		RECEIVEIDLE = none,
		GUARDDOG = {
			GUARDDOGLOOP = COMMON[837],
			PLANTING = none,
		},
		["4_06_AI"] = {
			["4_06_POOL_BENCH_01"] = {
				["4_06_POOL_BENCH_SIT_01"] = none,
				["4_06_POOL_BENCH_CHEER_02"] = none,
				["4_06_POOL_BENCH_DANCE_FAIL_01"] = none,
				["4_06_POOL_BENCH_CHEER_01"] = none,
				["4_06_POOL_BENCH_DANCE_PASS_01"] = none,
			},
			["4_06_FIELD_JJ"] = {
				["4_06_FIELD_JJ_STOP"] = none,
				["4_06_FIELD_JJ_START"] = none,
				["4_06_FIELD_JJ_LOOP"] = none,
				["4_06_FIELD_JJ_TO_PUSHUP"] = none,
			},
			["4_06_POOL_PEE"] = {
				PISSING = none,
				PISSOUT = none,
			},
			["4_06_CHEERING_SITTING"] = {
				["4_06_CHEERING_SITTING_99"] = none,
				["4_06_CHEERING_SITTING_66"] = none,
				["4_06_CHEERING_SITTING_33"] = none,
			},
			["4_06_CHEERING_STANDING"] = {
				["4_06_CHEERING_STANDING_99"] = none,
				["4_06_CHEERING_STANDING_33"] = none,
				["4_06_CHEERING_STANDING_66"] = none,
			},
			["4_06_CHEER_01"] = {
				["4_06_CHEER_02"] = none,
			},
			["4_06_FIELD_PUSHUPS"] = {
				["4_06_FIELD_PUSHUPS_STOP"] = none,
				["4_06_FIELD_PUSHUP_TO_JJ"] = none,
				["4_06_FIELD_PUSHUPS_LOOP"] = none,
				["4_06_FIELD_PUSHUPS_START"] = none,
			},
			["4_06_JEERING_SITTING"] = {
				["4_06_JEERING_SITTING_33"] = none,
				["4_06_JEERING_SITTING_99"] = none,
				["4_06_JEERING_SITTING_66"] = none,
			},
			["4_06_FIELD_RUN"] = {
				["4_06_FIELD_RUN_STOP"] = none,
				["4_06_FIELD_RUN_LOOP"] = none,
			},
			["4_06_COACH_SWITCH"] = none,
			["4_06_JEERING_STANDING"] = {
				["4_06_JEERING_STANDING_33"] = none,
				["4_06_JEERING_STANDING_66"] = none,
				["4_06_JEERING_STANDING_99"] = none,
			},
			SIT_START = {
				SIT_IDLE = none,
				SIT_END = {
					SIT_END1 = none,
				},
			},
		},
		BREAK = none,
		["4_06_ALGERNON"] = {
			["4_06_AL_01"] = {
				["4_06_AL_02"] = {
					["4_06_AL_03"] = COMMON[868],
				},
			},
		},
		BLANK = none,
		["4_06_WAITFORJIM"] = COMMON[858],
		GATENERD = {
			PICKLOCK = {
				PICKLOCK2 = {
					PICKLOCK3 = none,
				},
			},
		},
		["4_06_MARBLEDL"] = COMMON[962],
		NISS = {
			PLAYER = {
				PLAYERMELVIN02 = none,
				PLAYERCORNELIUS02 = none,
				PLAYERALGIE = none,
				PLAYERFATTY = none,
				PLAYERMELVIN = none,
				PLAYERCORNELIUS = none,
				PLAYERCORNELIUS03 = none,
				PLAYERBUCKY = none,
			},
			JOCKS = {
				LAUGHING = {
					GUY_LAUGH = COMMON[847],
				},
			},
			PRANKS = {
				FOOTBALL = {
					KIRBYGETSBALL = none,
				},
			},
			NERDS = {
				ALGIE = {
					ALGIE03 = none,
					ALGIE02 = none,
					ALGIE01 = none,
				},
				BUCKY = {
					BUCKY02 = none,
					BUCKY01 = none,
				},
				MELVIN = {
					MELVIN01 = none,
					MELVIN02 = none,
				},
				FATTY = {
					FATTY01 = none,
					FATTY02 = none,
				},
				CORNELIUS = {
					CORNELIUS01 = none,
					CORNELIUS03 = none,
					CORNELIUS02 = none,
				},
			},
			MARBLES = {
				HIT_LEG_FRONT_R_FALL = none,
				HIT_LEG_FRONT_L_FALL = none,
			},
		},
		["4_06_GLUE"] = {
			SIT_START_NEWTEMP = {
				SIT_IDLE = {
					SIT_TALK = COMMON[853],
					STUCK = none,
				},
				SIT_END = COMMON[854],
			},
			TEMP = none,
			["4_06_GLUE"] = none,
			SIT_START = {
				SIT_IDLE = none,
			},
		},
		["4_06_THROW_TACKS"] = {
			["4_06_THROW_TACKS_DEPLOY"] = none,
		},
		["4_06_INTRODUCTION"] = {
			["4_06_INTRO_01"] = {
				["4_06_INTRO_02"] = {
					["4_06_INTRO_03"] = {
						["4_06_INTRO_04"] = COMMON[868],
					},
				},
			},
		},
	},
	["3_06"] = {
		["3_06_MISSIONSTART"] = none,
		FRISK = COMMON[388],
		["3_06_POINT"] = none,
		PLAYERNIS = none,
		GREASERNIS = none,
		IDLEONEFRAME = none,
		CREATEAUTHFIGHT = none,
		GREASERIDLES = {
			GREASERIDLES2 = none,
			GREASERIDLES3 = none,
			GREASERIDLES1 = none,
		},
	},
	AI_EDGAR_5_B = {
		WEAPONACTIONS = COMMON[966],
		GENERALOBJECTIVES = COMMON[926],
		MOBILITY = COMMON[975],
		COMBAT = {
			ATTACKFROMCOVER = COMMON[919],
			FINDSNOWBALL = none,
			ACTIVECOMBAT = {
				STEALTHPROPEXIT = COMMON[921],
				COMBATLOCO = COMMON[922],
				AUTHORITYEXIT = none,
				COMBATTETHERLOCO = none,
				GUARDLOCO = none,
				CHEERLOCO = none,
				DEATHTAUNT = COMMON[613],
				AUTHORITYEXIT2 = none,
				SPECIAL = none,
				ATTACKWARNING = COMMON[924],
				WAITFORTARGETLOCO = COMMON[925],
			},
		},
		REACTIONS = COMMON[98],
		DUMMYIDLE = none,
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				FINDWEAPON = {
					GETPIPE = {
						PICKUP = none,
						PICKUPACTION = COMMON[130],
					},
				},
				TIMEOUT = COMMON[1008],
				EVADE = {
					DUCKPIPE = {
						DROPTOFLOOR = none,
						DROPANDCOUNTER = none,
					},
					EVADECOUNTER = none,
				},
				COMBATDIALOG = {
					COMBATSTIM = {
						COMBATAPOLOGY = COMMON[1009],
						TAUNTED = COMMON[1010],
					},
				},
				CLEARSTIMFLAG = COMMON[1011],
				GROUNDATTACK = COMMON[148],
				RUNNINGATTACKS = {
					RUNNINGATTACK = {
						RUNNINGATTACKCALL = COMMON[17],
					},
					PROJECTILECOUNTER = COMMON[1012],
					PURSUITATTACK = COMMON[624],
				},
				COMBATSPEECH = COMMON[153],
				OFFENSE = {
					MELEEACTIONS = {
						LONG = none,
						MEDIUM = COMMON[156],
						SPECIAL = none,
						SHORT = COMMON[158],
					},
					GRAPPLECONTROL = COMMON[1013],
				},
				BLOCK = COMMON[151],
				COUNTERATTACK = COMMON[101],
				POSTHIT = COMMON[152],
				BREAKPROP = COMMON[1016],
			},
		},
		TETHERLOCO = COMMON[626],
		PICKUP = {
			PICKUP = {
				PICKUPPICKUP = none,
			},
		},
		PROPS = COMMON[1017],
	},
	FIGHT_TUTORIAL = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = COMMON[63],
		},
		OFFENSE = {
			MEDIUM = {
				SHORTEXEC = none,
			},
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = COMMON[1019],
					HEAVYATTACKS = COMMON[1020],
				},
			},
		},
	},
	["5_05"] = {
		SUCCESS = none,
		ZOECONV = {
			PLAYERSTART = {
				ZOE = {
					ZOE = {
						PLAYER = {
							PLAYER = {
								PLAYER = {
									ZOE = {
										ZOE = {
											PLAYER = {
												ZOE = {
													PLAYER = {
														PLAYER = {
															ZOE = COMMON[199],
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		["3_S11_FIRESWITCH"] = COMMON[433],
		DOG = {
			BARK2 = none,
			INITIALIZE = {
				SLEEP = {
					DETECT = {
						ATTACK = none,
					},
				},
			},
			CHEWING = none,
			BARK = COMMON[1022],
			SLEEP = none,
		},
		BLANK = none,
		NIS = {
			PLAYER = COMMON[1023],
			GIVE = {
				GIVEZOE_5_05 = COMMON[486],
			},
			ZOE = {
				ZOE01 = none,
				ZOE03 = none,
				ZOE02 = none,
				ZOEIDLE = none,
			},
		},
		WORKERANIMS = {
			TALK = none,
		},
		ZOECONVPARK = {
			ZOE = {
				JIMMY = {
					ZOE = {
						ZOE = {
							JIMMY = none,
						},
					},
				},
			},
		},
		BURTONREACTIONS = {
			BURTONLOCKEDOUT = none,
			SPRINKLERREACT = {
				SPRINKLERREACT1 = {
					SPRINKLERREACT2 = none,
				},
			},
			BURTONINTOPOTTY = none,
			BURTONPEEDANCE = {
				SCRIPT = none,
			},
			POTTYFALL = {
				POTTYFALL3 = {
					POTTYFALL3_CHILD = none,
				},
				POTTYFALL2 = none,
			},
		},
		ZOEANIMATIONS = {
			CUT = {
				CUTWAIT = {
					CUTEND = none,
				},
			},
		},
	},
	["4_B1"] = {
		CANNON = COMMON[700],
		EMPTY = none,
		PLATFORM = {
			RUMBLEWEST = none,
			RUMBLENORTH = none,
			COLLAPSEWEST = none,
			IDLE = none,
			COLLAPSENORTH = none,
		},
	},
	["3_05"] = {
		ANIMATIONS = {
			GETUP = none,
			BREAKTEST = none,
			SLEDGESWING = none,
			PLAYER = COMMON[431],
			LAUGH = none,
			SIT_CONV = COMMON[1024],
			PUTOUTCIGEND = COMMON[219],
			NORTON = none,
			DONTHURT = none,
			BREAK = none,
			BREAK_STAND = none,
			GIVE = {
				GIVELOLA3_05 = COMMON[486],
			},
			BREAK_STANDSMOKE = none,
			IDLES = {
				CROUCHING = none,
				BREAK = none,
				SLEEPING = {
					SLEEPING = none,
				},
				SMOKING = COMMON[872],
			},
			SIT_SMOKE = COMMON[1024],
			WALL_BREAK = {
				IDLE = COMMON[357],
			},
			CLIMBWINDOW = none,
		},
		CONV305 = {
			PLAYERSTART = {
				TEACHERREPLY = {
					PLAYERRESPONSE = {
						TEACHER = {
							TEACHERNEXT = {
								PLAYER = {
									TEACHER = {
										PLAYER = {
											TEACHERREPLY = {
												PLAYERRESPONSE = {
													TEACHER = {
														TEACHERNEXT = {
															PLAYER = {
																TEACHER = {
																	PLAYER = {
																		PLAYER = COMMON[201],
																	},
																},
															},
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		STRTMSSN = COMMON[899],
	},
	["4_05"] = {
		NIS = {
			JOCKS = {
				BO_01 = none,
				BO_02 = none,
				CASEY_01 = none,
			},
			MASCOT = {
				MASCOT01 = {
					CHARGEIN = {
						CHARGELOOP = {
							CHARGELOOP = {
								CHARGELOOP = COMMON[1026],
							},
						},
					},
				},
				CHARGEIN = COMMON[1026],
				MASCOTPOOL = none,
			},
			JIMMY = {
				JIMMY_POOL = none,
				JIMMY01 = none,
			},
		},
		ANIMS = {
			MASCOTANGRY = {
				MAD = none,
			},
			JOCKSIDLE = {
				JOCKIDLEA = {
					JK_IDLE_D = none,
					JK_IDLE_C = none,
					JK_IDLE_A = none,
					JK_IDLE_B = none,
					JK_IDLE_E = none,
				},
				JOCKIDLEB = none,
				JOCKIDLED = none,
				JOCKIDLEC = none,
			},
			MASCOTSIT = {
				GETUP = none,
				SIT = none,
			},
			NISJOCKSTAUNT = {
				TAUNT3 = none,
				TAUNT1 = none,
				TAUNT2 = none,
			},
			CHEERLEADING = COMMON[897],
			PLAYERCLIMB = {
				CLIMBOUT = none,
			},
			STEALCOSTUMECUT = {
				DANCE = none,
				KNOCKEDOUT = none,
				KNEEL = COMMON[1028],
			},
			MASCOTACTIONS = {
				DANCEB = none,
				DANCEA = none,
				CHATA = none,
				CHATB = none,
				SIT = none,
				PRACTICECHARGE = {
					CHARGEIN = {
						CHARGELOOP = {
							DANCED = {
								BOW = none,
							},
						},
					},
				},
				PUSHUPS = COMMON[838],
				DONEDANCE = none,
				DANCED = none,
				DANCEC = none,
			},
			PUSHUPS = COMMON[838],
			EMPTY = none,
		},
	},
	DARBYAI = {
		COMBAT = {
			ACTIVECOMBAT = {
				GUARDLOCO = none,
				COMBATLOCO = none,
				WAITFORTARGETLOCO = COMMON[160],
			},
		},
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[145],
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				RUNNINGATTACKS = COMMON[150],
				BLOCK = {
					BOXING = {
						CHARGE_COUNTERATTACK = COMMON[101],
						ATTACKBLOCKED = none,
					},
				},
				POSTHIT = COMMON[152],
				EVADE = {
					BOXING = {
						EVADEDUCK = none,
						EVADERIGHT = none,
						EVADELEFT = none,
					},
				},
				COUNTERATTACK = COMMON[101],
				OFFENSE = {
					MELEEACTIONS = {
						LONG = none,
						MEDIUM = COMMON[156],
						SPECIAL = COMMON[747],
						SHORT = {
							GROUNDATTACK = none,
							SHORT = none,
						},
					},
				},
			},
		},
		TETHERLOCO = COMMON[626],
	},
	["6_02"] = {
		RUSSELL_NIS = {
			PLAYER = COMMON[1023],
			RUSSELL = {
				RUSSELL03 = none,
				RUSSELL01 = none,
				RUSSELL02 = none,
			},
		},
		PLAYERGETUP = COMMON[357],
		HEADBUTT = {
			HEADBUTT_ANTICSTART = COMMON[696],
			HEADBUTT_LOCO = none,
		},
		TONFAGRAPPLETEMP = {
			GIVE = COMMON[252],
			RCV = COMMON[1034],
		},
		GARYNIS = {
			PLAYER = {
				BLANK = none,
				PLAYERSURPRISED = none,
				PLAYER01 = none,
				PLAYER02 = none,
				PLAYERLOOKAROUND = none,
			},
			GARY = none,
			RUSSELL = {
				RUSSELLLOCO = none,
				RUSSELL01 = {
					RUSSELL02 = none,
				},
			},
			EDGAR = {
				EDGARBLANK = none,
				EDGARCOCKY = none,
				EDGAR01 = none,
				EDGAR02 = none,
			},
			PREFECTSETH = none,
			PREFECTMAX = none,
			BULLIES = {
				BULLY01 = none,
				BULLY03 = none,
				BULLY02 = none,
			},
		},
		PLAYERBUSTED = {
			BUSTTHATBITCH = none,
			BUSTED = {
				GIVE = none,
				RCV = COMMON[1034],
			},
		},
		DETACHWEAPON = none,
		BESCARED = {
			REACT1 = none,
		},
		WONDERNIS = {
			GRAPPLE = none,
			RECEIVE = none,
			LOOKDOWN = none,
			LOOKAROUND = none,
		},
		RUSSELLALLEY = {
			JIMMY = COMMON[220],
			RUSSELL = COMMON[1035],
		},
		SCHOOLGATESNIS = {
			JIMMY = COMMON[959],
			RUSSELL = COMMON[1035],
		},
		EQUIPSLINGSHOT = {
			CONTINUED = none,
		},
		PREFECTGETUP = {
			PREFECTGETUP = none,
		},
		TONFA_IMPALEOLD = {
			TONFAIMPALE = {
				TONFAGRAPPLE = {
					GIVE = {
						PREFECTGETUP = none,
						JOINTDRIVERS = none,
					},
					RCV = COMMON[1034],
				},
			},
		},
		ENDPREFECT = {
			ACT = none,
		},
		RUSSELLHIDE = {
			LOOP = none,
			COWER_CHILD = {
				COWER_CHILD = none,
			},
		},
		GARYCRAZY = {
			GOOFF = none,
		},
		BLANK = none,
		FACTIONLEADERNIS = {
			PLAYER = {
				JOCKS = COMMON[1023],
				GREASERS = COMMON[1023],
				PREPS = COMMON[431],
				NERDS = COMMON[1036],
			},
			JOCKS = {
				BLANK = none,
				LACKEY2 = none,
				TED01 = none,
				LACKEY1 = none,
				CHEERING = {
					CHEERING01 = {
						CHEERING02 = none,
					},
				},
			},
			GREASERS = {
				JOHNNY01 = none,
				PEANUT = COMMON[1037],
				JOHNNYCHEER = none,
				HAL = COMMON[1037],
			},
			PREPS = {
				DARBY01 = none,
				CHAD01 = none,
			},
			NERDS = {
				CHEERING = {
					CHEERING01 = none,
					CHEERING02 = none,
					CHEERING03 = none,
				},
				EARNEST02 = none,
				EARNEST01 = none,
				BLANK = none,
			},
		},
	},
	G_RANGED_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[1038],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = {
						RIGHTHOOK = {
							HEAVYATTACK = {
								HEAVYKNEEEXECUTE = none,
							},
						},
					},
				},
			},
			MEDIUM = {
				STRIKES = {
					HEAVYATTACKS = {
						HEAVYKNEE = none,
					},
				},
			},
		},
	},
	HF_SPECTATOR = {
		DEFAULT_KEY = {
			IDLE = {
				IDLE = {
					AMBIENT = COMMON[1039],
				},
			},
			EXECUTENODES = {
				COMBATSTRAFEIDLE = {
					COMBATSTRAFEIDLE = none,
					WEAPONCOMBATSTRAFEIDLE = none,
				},
			},
		},
	},
	["1_05"] = {
		SOUNDS = {
			FART = {
				FART = {
					GROAN = none,
				},
			},
			PEE = {
				PEESTART = none,
				PEESTOP = none,
			},
		},
		["105QSTN"] = none,
		ANIMS = {
			RECEIVE = none,
			PEEDANCE = {
				DANCEDECISION = {
					DONOTDANCE = none,
					DANCE = none,
				},
			},
			CHATTER = COMMON[1040],
			GIVE = none,
			MAKEOUT = {
				GIRL = none,
				BOY = none,
			},
			PISSSELF = {
				PEESELF = none,
			},
			EMPTY = none,
			RUMMAGE = {
				LOCKER = {
					SYNC = COMMON[1041],
				},
			},
			CHILL = none,
			WAVE = none,
			HANDWASH = {
				WASHHANDS = none,
			},
		},
	},
	["2_05"] = {
		DIALOG = none,
		ANIMATIONS = {
			RUSELLFALLOFFBIKE = {
				HITHARDBACK = {
					ON_GROUND = COMMON[357],
				},
			},
			LEGUP = {
				LIFTATTEMPT = {
					GRAPPLESUCCESS = {
						LIFTPLAYER = {
							LIFT = none,
							LIFTED = none,
						},
					},
				},
			},
			BULLYLAUGH = {
				BULLYLAUGHEND = none,
				BULLYLAUGHLOOP = none,
			},
			GIVEEGGS = {
				GIVEATTEMPT = {
					GRAPPLESUCCESS = {
						EGGGIVE = COMMON[195],
					},
				},
			},
			RUSSELLLEAN = {
				EXIT = none,
				STARTNOHIT = COMMON[1042],
				STARTHIT = COMMON[1042],
			},
			TADCLOSESHUTTERS = {
				RESETTAD = none,
				SYNCHWITHWINDOW = none,
			},
		},
	},
	["1_02"] = {
		SECSTART = COMMON[1043],
		IDLEFIGHT = {
			IDLELOOP = none,
			SIMPLEIDLE = none,
		},
		TALKING = COMMON[161],
		SECIDLE = none,
		SECSTARTOLD = COMMON[1043],
		SITONWALL = none,
		SHORTIDLE = none,
		POINTATPLAYER = COMMON[104],
		NIS = {
			MEETRUSSELL = {
				BULLIES = {
					BULLIES = none,
				},
				HATTRICK = {
					BLANK = none,
					HATTRICK01 = {
						HATTRICK02 = none,
					},
					HATTRICKUBO = none,
				},
				JIMMY = COMMON[959],
				RUSSELL = COMMON[434],
			},
			PLAYER_BULLIES = COMMON[431],
		},
		POINTATRUSSEL = none,
		TAUNTONCE = none,
		TAUNTPLAYER = {
			TAUNT04 = none,
			TAUNT03 = none,
			TAUNT02 = none,
			TAUNT01 = none,
		},
		ON_GROUND = none,
		LAUNCH102 = none,
	},
	["2_03I"] = {
		ANIMATIONS = {
			TADREJECT = {
				REBUFF = {
					REBUFF2 = none,
					REBUFF1 = none,
				},
			},
		},
	},
	G_MELEE_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = COMMON[565],
		},
		OFFENSE = {
			GROUNDATTACK = COMMON[1049],
			MEDIUM = {
				STRIKES = {
					HEAVYATTACKS = COMMON[564],
				},
			},
			TAUNTS = {
				TAUNT_B = none,
			},
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					LIGHTATTACKS = COMMON[559],
					HEAVYATTACKS = {
						MIDKICK = none,
					},
				},
			},
		},
	},
	OPENCUT = {
		["4_S11_START"] = {
			["4_S11_06"] = {
				["4_S11_07"] = {
					["4_S11_08"] = {
						["4_S11_09"] = {
							["4_S11_10"] = none,
						},
					},
				},
			},
		},
		TARGET = COMMON[634],
		["4_S11_MONEY"] = {
			["4_S11_21"] = {
				["4_S11_22"] = none,
			},
		},
	},
	["5_02"] = {
		ANIMATIONS = {
			GASOLINEPOUR = {
				START = {
					POUR = {
						POUR2 = none,
					},
				},
				STOP = none,
			},
			OBSERVERLOOPS = {
				IDLES = {
					DUNCANIDLE = none,
				},
				ARMPUMP = {
					MOSH_FOR_2SECS = none,
				},
			},
			RATPACKING = {
				NULL = none,
				STANDBACKUP = COMMON[906],
				LEON = none,
				CATCHRATLOOP = none,
			},
			GREASERS = {
				VANCE = {
					VANCE01 = none,
					VANCE02 = none,
				},
			},
			ZOELOOPS = {
				IDLES = COMMON[30],
				DUSTBOOTS = {
					DUSTBOOTSOFF = none,
				},
			},
			STANDINGSMOKE = {
				LIGHT = {
					SMOKEORIDLE = {
						IDLELOOPS = {
							IDLE2X = none,
							IDLE1X = none,
						},
						SMOKE = {
							PUFF = none,
						},
					},
				},
				STUBITOUT = none,
			},
			PLAYER = COMMON[1036],
			STEPBACKMOSHOUT = {
				STEPBACK = none,
			},
			MOSHOUT = {
				MOSHB = {
					MOSHOUTLOOPS = {
						GOSPAZ = {
							CHANGE_MOSH_POSE = {
								CHANGE_TO_SPAZ = none,
							},
						},
						KEEPMOSHING = {
							MOSHB_RANDOM = {
								MOSH_FOR_3SECS = none,
								MOSH_FOR_5SECS = none,
								MOSH_FOR_4SECS = none,
								MOSH_FOR_2SECS = none,
							},
						},
					},
				},
				MOSHSPAZ = {
					SPAZLOOPS = {
						GOMOSH = {
							CHANGE_MOSH_POSE = {
								CHANGE_TO_MOSH = none,
							},
						},
						KEEPSPAZING = {
							SPAZ_RANDOM = {
								SPAZTWICE = COMMON[1052],
								SPAZONCE = COMMON[1052],
							},
						},
					},
				},
			},
		},
	},
	["4_02"] = {
		["4_02_CS1"] = {
			["4_02_CS1_1_1"] = {
				["4_02_CS1_2_1"] = {
					["4_02_CS1_3_1"] = {
						["4_02_CS1_4_1"] = none,
					},
				},
			},
		},
		["4_02_CS4"] = {
			["4_02_CS4_1_1"] = {
				["4_02_CS4_2_1"] = {
					["4_02_CS4_3_1"] = {
						["4_02_CS4_4_1"] = none,
					},
				},
			},
		},
		ALGIE_IDLE = {
			ALGIE_IDLE_LOOPS = COMMON[247],
		},
		BREAK = {
			BREAKNODE = none,
		},
		ALGIE_BLOCK = {
			ALGIE_BLOCK_1 = none,
		},
		BLANK = none,
		["4_02_CS2"] = {
			["4_02_CS2_1_1"] = {
				["4_02_CS2_2_1"] = none,
			},
		},
		NIS = {
			EARNESTRUN = none,
			EARNEST_01 = none,
		},
		["4_02_CS2_6"] = {
			["4_02_CS2_6_1_1"] = {
				["4_02_CS2_6_2_1"] = {
					["4_02_CS2_6_3_1"] = {
						["4_02_CS2_6_4_1"] = {
							["4_02_CS2_6_5_1"] = {
								["4_02_CS2_6_6_1"] = {
									["4_02_CS2_6_7_1"] = none,
								},
							},
						},
					},
				},
			},
		},
		["4_02_CS2_5"] = {
			["4_02_CS2_5_1_1"] = {
				["4_02_CS2_5_2_1"] = {
					["4_02_CS2_5_3_1"] = {
						["4_02_CS2_5_4_1"] = {
							["4_02_CS2_5_5_1"] = none,
						},
					},
				},
			},
		},
		ALGIECOWER = COMMON[1053],
		["4_02_CS3"] = {
			["4_02_CS3_1_1"] = {
				["4_02_CS3_2_1"] = {
					["4_02_CS3_2_2"] = {
						["4_02_CS3_3_1"] = {
							["4_02_CS3_4_1"] = {
								["4_02_CS3_4_2"] = {
									["4_02_CS3_4_3"] = none,
								},
							},
						},
					},
				},
			},
		},
	},
	["3_02"] = {
		["3_02_CONCLUSION"] = {
			CHECKIFPLAYERHITGORD = {
				["3_02_DISMISSIVE"] = {
					["3_02_12"] = {
						["3_02_13"] = {
							["3_02_14"] = COMMON[1054],
						},
					},
				},
				["3_02_CONGRATULATORY"] = {
					["3_02_09"] = {
						["3_02_10"] = {
							["3_02_11"] = COMMON[1054],
						},
					},
				},
			},
		},
		["3_02_PREPHANG"] = {
			["3_02_PREPHANG_BREAK"] = none,
		},
		["3_02_INTRODUCTION"] = {
			["3_02_01"] = {
				["3_02_02"] = {
					["3_02_03"] = {
						["3_02_04"] = {
							["3_02_05"] = {
								["3_02_06"] = COMMON[868],
							},
						},
					},
				},
			},
		},
		["3_02_ANIMATION"] = {
			["3_02_POINT"] = none,
		},
		["3_02_JOHNNYCONFRONTATION"] = {
			["3_02_07"] = {
				["3_02_08"] = none,
			},
		},
		["3_02_PLAYERCONFRONTATION"] = {
			["3_02_15"] = {
				["3_02_16"] = {
					["3_02_17"] = {
						["3_02_18"] = COMMON[868],
					},
				},
			},
		},
		NIS = {
			INTROBMX = none,
			OUTRO = {
				JOHNNY = {
					JOHNNY_02 = none,
					JOHNNY_01 = none,
				},
				JIMMY = COMMON[512],
			},
			BIKE = COMMON[159],
		},
		["3_02_BIKECRASH"] = {
			["3_02_BIKECRASH_SOUND"] = none,
			["3_02_BIKECRASH_ANIMS"] = {
				["3_02_BIKECRASH_IDLE_CHILD"] = {
					["3_02_BIKECRASH_IDLE_CHILD_CHILD"] = {
						["3_02_BIKECRASH_IDLE_CHILD_CHILD"] = none,
					},
				},
			},
			["3_02_BIKECRASH_LOOP"] = none,
		},
	},
	PUNCHBAGBS = {
		IDLE = {
			HITMANAGEMENT = {
				HIT1 = COMMON[1055],
				ACTIONREQUEST = {
					BACK = {
						WAIT = {
							BACK = {
								WAIT = {
									BACK = {
										WAIT = {
											BACK = none,
										},
									},
								},
							},
						},
					},
					FRONT = {
						WAIT = {
							FRONT = {
								WAIT = {
									FRONT = {
										WAIT = COMMON[320],
									},
								},
							},
						},
					},
					RIGHT = {
						WAIT = {
							RIGHT = {
								WAIT = {
									RIGHT = {
										WAIT = COMMON[37],
									},
								},
							},
						},
					},
					LEFT = {
						WAIT = {
							LEFT = {
								WAIT = {
									LEFT = {
										WAIT = COMMON[38],
									},
								},
							},
						},
					},
				},
				HIT2 = COMMON[1055],
			},
		},
	},
	ANIMATIONS = COMMON[693],
	C8 = {
		C8_INTRO_4 = COMMON[1059],
		PLAYERFAIL = COMMON[373],
		NIS_OUT = COMMON[893],
		C8_INTRO_3 = COMMON[1059],
		C8_INTRO_2 = COMMON[1063],
		C8_INTRO_1 = COMMON[1063],
		C8_INTRO_5 = COMMON[1063],
		RELEASE = none,
		TEACHERDISGUST = none,
		PLAYERVICTORY = COMMON[891],
	},
	CLO = {
		MGCLO = {
			MGCLO_01 = {
				MGCLO_02 = {
					MGCLO_03 = {
						MGCLO_04 = COMMON[1066],
					},
				},
			},
		},
		CLOREEXPLAIN = COMMON[1066],
	},
	["1_07"] = {
		SKATE_PU = {
			LOADWAIT = none,
			BUCKY = {
				BUCKY_PICKUP = none,
			},
		},
		COWER = none,
		PUNCH = {
			DIE = COMMON[1068],
		},
		BUCKYTALK = none,
		KO_COLLAPSE = COMMON[352],
		BACKUP = none,
		DONTMESS = none,
		["1_07STARTCONV"] = {
			["1_07STARTCONV02"] = {
				["1_07STARTCONV03"] = {
					["1_07STARTCONV04"] = {
						["1_07STARTCONV05"] = none,
					},
				},
			},
		},
		GUTSHOTFINISH = none,
		SPIT = none,
		PICKUPITEM = none,
		PARAMETRICDOOR = COMMON[1069],
		SK8_EXAMINE = none,
		PUTAWAY = none,
		POPENSIDE = {
			GATE = {
				STARTOPEN = {
					USEABLE = {
						USEABLE = {
							USEABLE = COMMON[1070],
						},
					},
				},
			},
			BASE = none,
			PEDPROPACTIONS = {
				STARTOPEN = {
					SLIDEOPEN = {
						SLIDEOPEN = {
							SLIDEOPEN = COMMON[1070],
						},
					},
				},
			},
		},
		IDLE = none,
		OPENGATEIMMEDIATE = COMMON[1071],
		OPENTSGATE = none,
		GOINGDOWN = none,
		COWERONEFRAME = none,
		JIMMYTALK02 = none,
		STUNNED = none,
		ENDCOWER = none,
		OPENGATE = COMMON[1071],
		BREAK = none,
		JIMMYTALK = none,
		BLANK = none,
		HOBOOPENGATE = none,
		FAKETRY = {
			STARTOPEN = {
				SLIDEOPEN = {
					SLIDEOPEN = {
						SLIDEOPEN = {
							SLIDEOPEN = {
								SLIDEOPEN = {
									SLIDEOPEN = {
										SLIDEOPEN = {
											SLIDEOPEN = {
												SLIDEOPEN = {
													SLIDEOPEN = none,
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		GETUP = none,
		PEANUTTALK = none,
		CLOSEGATE = {
			PROPCLOSED = none,
		},
		BUCKYLINE = none,
		SUCCESS = none,
	},
	["4_B2"] = {
		DEFENSIVE = {
			INTOPOSE = {
				POSEIDLE = none,
			},
		},
		["4_B2_BLANK"] = none,
		REACTIONANIMS = {
			GETUP = COMMON[1072],
			GETUPEASY = {
				GETUPEASY2 = none,
			},
			GETUPHARD = {
				GETUPHARD2 = none,
			},
			GETUPBELLY = {
				GETUPBELLYA = none,
			},
			REACT = none,
			TAUNT = {
				TAUNT5 = none,
				TAUNT2 = none,
				TAUNT3 = none,
				TAUNT4 = none,
				TAUNT1 = none,
			},
			GETUPBKUP = {
				GETUP0 = {
					GETUPA = {
						GETUPB = COMMON[1072],
					},
				},
			},
		},
		NISTED = {
			TEDCOWER = none,
		},
	},
	MG_BBALL_3PT = {
		BBALLINTRO = none,
		PLAYERIDLE = none,
		BBALLIDLELOADANIMS = {
			BBALLIDLE = {
				BBALLREADY = none,
			},
		},
		PEDSHOVEYA = none,
		NPCDISSMISS = {
			NPCDISSMISS = none,
		},
		ANIMATIONNODES = {
			RNDFAILNODES = {
				FAIL03 = none,
				FAIL02 = none,
				FAIL01 = none,
				FAIL04 = none,
			},
			LOSE = none,
			SUCKTHISBALL = none,
			RNDCHEERNODES = {
				CHEER01 = none,
			},
			PLAYERJINX = none,
			WIN = none,
			RANDOMTAUNTANIMS = {
				TAUNT01 = none,
				TAUNT03 = none,
				TAUNT02 = none,
				GRRWAIT = none,
				LOOKINTOUGH = none,
			},
		},
	},
	CLIENT_3_R05 = {
		CATCHCHEM = {
			CATCHSUCCESS = none,
		},
		LOOK = COMMON[828],
		WALK = none,
	},
	["3_R09"] = {
		CONVERSATIONS = {
			["3_R09_J3"] = {
				["3_R09_J3"] = {
					["3_R09_J3"] = {
						["3_R09_J3"] = {
							["3_R09_J3"] = none,
						},
					},
				},
			},
			["3_R09_G2"] = {
				["3_R09_G2"] = {
					["3_R09_G2"] = {
						["3_R09_G2"] = none,
					},
				},
			},
			["3_R09_P1"] = {
				["3_R09_P1"] = {
					["3_R09_P1"] = {
						["3_R09_P1"] = {
							["3_R09_P1"] = {
								["3_R09_P1"] = none,
							},
						},
					},
				},
			},
			["3_R09_G3"] = {
				["3_R09_G3"] = {
					["3_R09_G3"] = {
						["3_R09_G3"] = {
							["3_R09_G3"] = {
								["3_R09_G3"] = none,
							},
						},
					},
				},
			},
			["3_R09_P2"] = {
				["3_R09_P2"] = {
					["3_R09_P2"] = {
						["3_R09_P2"] = none,
					},
				},
			},
			["3_R09_D1"] = {
				["3_R09_D1"] = {
					["3_R09_D1"] = {
						["3_R09_D1"] = {
							["3_R09_D1"] = none,
						},
					},
				},
			},
			["3_R09_J2"] = {
				["3_R09_J2"] = {
					["3_R09_J2"] = {
						["3_R09_J2"] = none,
					},
				},
			},
			["3_R09_G1"] = {
				["3_R09_G1"] = {
					["3_R09_G1"] = {
						["3_R09_G1"] = {
							["3_R09_G1"] = none,
						},
					},
				},
			},
			["3_R09_J1"] = {
				["3_R09_J1"] = {
					["3_R09_J1"] = {
						["3_R09_J1"] = {
							["3_R09_J1"] = {
								["3_R09_J1"] = none,
							},
						},
					},
				},
			},
			["3_R09_D3"] = {
				["3_R09_D3"] = {
					["3_R09_D3"] = {
						["3_R09_D3"] = {
							["3_R09_D3"] = none,
						},
					},
				},
			},
			["3_R09_D2"] = {
				["3_R09_D2"] = {
					["3_R09_D2"] = {
						["3_R09_D2"] = {
							["3_R09_D2"] = none,
						},
					},
				},
			},
			["3_R09_N"] = {
				["3_R09_N1"] = {
					["3_R09_N2"] = {
						["3_R09_N3"] = none,
					},
				},
			},
			["3_R09_P3"] = {
				["3_R09_P3"] = {
					["3_R09_P3"] = {
						["3_R09_P3"] = {
							["3_R09_P3"] = none,
						},
					},
				},
			},
		},
		FAILURE = COMMON[373],
		ANIMATIONS = {
			GENERIC = {
				LISTEN1 = none,
				AMBTALK3 = none,
				EARNB = none,
				LISTEN2 = none,
				AMBTALK4 = none,
				TALK2 = none,
				AMBTALK1 = none,
				AMBTALK2 = none,
				WEIGHTSHIFT = none,
				SITDOWN = {
					SITDOWNLOOP = none,
					STANDUP = none,
				},
				TALK1 = none,
			},
			JOCKS = {
				CASEY02 = none,
				CASEY01 = none,
				BO01 = none,
				JOCKSOUTRO = {
					CASEY01 = none,
				},
			},
			EMPTY = none,
			GREASERS = COMMON[1073],
			CHEERCOOL = {
				CHEER08 = none,
				CHEER01 = none,
				CHEER06 = none,
				CHEER03 = none,
				CHEER04 = none,
				CHEER07 = none,
				CHEER09 = none,
				CHEER02 = none,
				CHEER05 = none,
			},
			COMICOWNER = {
				COMIC02 = none,
				COMIC01 = none,
			},
			GETBROCKETLAUNCHER = {
				GIVE = COMMON[195],
				GIVE_ATTEMPT = COMMON[196],
				EXECUTES = COMMON[1075],
			},
			FADEHOLD = none,
			LOADBROCKET = {
				BROCKETHOLD = none,
				RETURNTOIDLE = none,
				REMOVEROCKETSINCASE = none,
			},
			PLAYER = {
				DROPOUTS = {
					DROPOUTS01 = none,
					DROPOUTS02 = none,
				},
				JOCK = {
					PLAYER01 = none,
					PLAYER02 = none,
					PLAYEROUTRO = none,
				},
				NERDS = COMMON[1023],
				GREASERS = COMMON[1073],
				COMIC = COMMON[1036],
				PREPPIES = COMMON[431],
			},
			NERDS = {
				CHEER12 = none,
				NERDS03 = none,
				NERDS04 = none,
				NERDS02 = none,
				CHEER10 = none,
				NERDS01 = none,
				CHEER14 = none,
			},
			DROPOUTS = {
				DROPOUTS04 = none,
				DROPOUTS01 = none,
				INSULTCROTCH = none,
				IDLE = none,
				DROPOUTS03 = none,
				DROPOUTS02 = none,
			},
			PREPPIES = {
				PREPPIES03 = none,
				PREPPIES02 = none,
				PREPPIES01 = none,
			},
		},
	},
	["1_11X2"] = {
		ANIMATIONS = {
			["2PUMPCHEER"] = {
				CHEER = COMMON[233],
			},
			RECEIVE = {
				TAKE = none,
			},
			STOP = COMMON[1070],
			SHITSTOMP = {
				STOMPIN = {
					STOMPLOOP1 = {
						STOMPLOOP2 = {
							STOMPOUT = {
								CHECKSHOE = none,
							},
						},
					},
				},
			},
			DOGCHEW = {
				CHEWIN = {
					CHEWLOOP = {
						CHEWOUT = none,
					},
				},
			},
			KNEELFEED = {
				KNEELFEED = none,
			},
			GARYLIGHTBAG = {
				KNEELIN = {
					LIGHTIN = {
						LIGHTLOOP = none,
					},
				},
			},
			KNEELIDLE = {
				KNEEL = COMMON[1028],
			},
			DOGSHIT = {
				SHITIN = {
					SHITLOOP1 = {
						SHITLOOP2 = {
							SHITLOOP3 = {
								SHITOUT = none,
							},
						},
					},
				},
			},
			PLACEBAG = {
				PLACESHITBAG = none,
			},
		},
		FAILURE = COMMON[373],
		EMPTY = none,
		SOUNDS = {
			SHITFIRESTOP = none,
			SHITFIRESTART = none,
			STUFFPOOBAG = none,
		},
		CUTPLAN = {
			GARY93 = none,
			GARY97 = none,
			PETE94 = none,
			GARY92 = none,
			PETE96 = none,
		},
	},
	GARBAGECAN = {
		PEDPROPSACTIONS = {
			NULL = none,
			EXECUTENODES = {
				EXIT_CAMERA = {
					PXGARB = none,
					PXPLANTR = none,
				},
				PROPUSAGETOGGLES = COMMON[1076],
				STEALTHEXECUTES = {
					GETINCANFLAGS = {
						SPOTTEDWARNING = none,
					},
				},
			},
			STEALTH = {
				HIDEGETINFROMRUN = none,
				HIDEGETIN = {
					WAITINCAN = {
						CAMERAVIEWBANK = {
							CAMERAVIEW = {
								UNSEEN = none,
							},
						},
						CHECKSPOTTED = {
							CHECKSPOTTEDNODE = none,
						},
						WAITPLAYERSPEECH = {
							PLAYERSPEECH = none,
						},
					},
					OUTCAN = none,
				},
				CAUGHTBANK = {
					CAUGHT = {
						CAUGHTREQUEST = {
							CAUGHTCOLL = none,
							CAUGHTANIM = {
								CAUGHT_GIVE = none,
								CAUGHT_RCV = none,
								DRIVER = COMMON[252],
							},
						},
					},
				},
			},
			STUFFGRAP = {
				GIVE = COMMON[283],
				RCV = {
					INCAN = COMMON[1068],
				},
			},
		},
		NORMAL = none,
		NOTUSEABLE = {
			STUFFGRAP_FX = none,
			DESTROYED = none,
		},
	},
	J_MELEE_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[93],
			IDLE = {
				IDLE = none,
				FOOTBALLIDLE = none,
				WEAPONIDLE = none,
			},
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					LIGHTATTACKS = {
						RIGHTHAND = {
							LEFTHAND = none,
						},
					},
				},
			},
			MEDIUM = {
				STRIKES = {
					NOBAT = {
						LIGHTATTACKS = none,
					},
					HEAVYATTACKS = {
						HEAVYRIGHT = {
							HEAVYRIGHT_LAND = none,
						},
					},
					UNBLOCKABLE = {
						SHOULDERBUTT_CHARGE = {
							SHOULDERBUTT_RELEASE = none,
						},
					},
				},
			},
		},
	},
	["3_09"] = {
		ANIMS2 = COMMON[1078],
		ANIMS = COMMON[1078],
	},
	["2_S06"] = {
		SOUNDS = {
			SPRINKLERSFINISH = none,
			SPRINKLERSSTART = none,
		},
		ANIMS = {
			HITFIREALARM02 = none,
			GIRLSOUTSIDE = {
				ENTRY3 = {
					SXY_IMPATIENT = {
						SXY_ARMSX = {
							SXY_FOOTSTOMP = {
								SXY_ARMSHIPS = none,
							},
						},
					},
				},
				ENTRY2 = {
					F_FREAKOUT = {
						GEN_SHOPKID = {
							GIRL_LAUGH = {
								SXY_FOOTSTOMP = none,
							},
						},
					},
				},
				ENTRY1 = {
					AMBIENT_3 = {
						SXY_ARMSHIPS = {
							SXY_IMPATIENT = {
								F_FREAKOUT = none,
							},
						},
					},
				},
			},
			SHOWERING = {
				LOADANIMS = {
					SHWR_START = {
						WASH_02 = none,
						WASH_01 = none,
					},
					SHWR_ANIMS = {
						SHWR_RINSE_01 = {
							RINSE_01 = {
								PICKNEXT = {
									PICK_WASH_02 = none,
									PICK_WASH_01 = none,
									PICK_RINSE_02 = none,
								},
							},
						},
						SHWR_RINSE_02 = {
							RINSE_02 = {
								PICKNEXT = {
									PICK_WASH_01 = none,
									PICK_RINSE_01 = none,
									PICK_WASH_02 = none,
								},
							},
						},
						SHWR_WASH_01 = {
							WASH_01 = {
								PICKNEXT = {
									PICK_WASH_02 = none,
									PICK_RINSE_01 = none,
									PICK_RINSE_02 = none,
								},
							},
						},
						SHWR_WASH_02 = {
							WASH_02 = {
								PICKNEXT = {
									PICK_WASH_01 = none,
									PICK_RINSE_01 = none,
									PICK_RINSE_02 = none,
								},
							},
						},
					},
				},
			},
			PANTYGIVE = none,
			PANTYRECEIVE = none,
			TE_SITTING = {
				SITLOOP = none,
			},
			GIVE = {
				GIVEBURTON2_S06 = COMMON[486],
			},
			EMPTY = none,
			BEATRICEFREAKOUT = {
				FREAKOUT = none,
			},
		},
		BUSTCONV = {
			START = {
				CONV = COMMON[735],
			},
		},
	},
	["1_G1"] = {
		GIVE = none,
		ANIMS = {
			GIVE = {
				GIVEBEATRICE1_G1 = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = none,
						RECEIVE = {
							RECEIVE = {
								GIVE = none,
								THANKS = {
									SPEECHSTART = none,
									WAITFORPLAYER = none,
								},
							},
						},
						GIVE_ATTEMPT_SPEECH = none,
						RECEIVEWAIT = none,
					},
				},
			},
			GETDIARY = {
				PICK = COMMON[1080],
			},
		},
	},
	ACTIONS = {
		SWIMMING = {
			CHECK_DESELECT = {
				DROP = {
					SKATE = none,
					DESELECT = none,
				},
			},
			FROMJUMP = none,
			BASE = {
				ONVEHICLE = none,
				SWIMMINGOPPS = none,
			},
			LOCO = {
				LOCOMOTION = {
					RATPED = {
						SWIM_SLOW_UNDERWATER = none,
						SPRINT = none,
						SWIM_SLOW = none,
						TREADWATER = none,
					},
					DOGPED = {
						SWIM_SLOW_UNDERWATER = none,
						SPRINT = COMMON[1081],
						SWIM_SLOW = none,
						TREADWATER = none,
					},
					REGULARPEDS = {
						TREADWATER = none,
						SWIMLOCO = {
							SWIMANIMS = {
								SPRINT = COMMON[1081],
								SWIM_SLOW = none,
							},
							SPRINTCONTROLLER = {
								SWIM = none,
								SPRINTBASIC = none,
							},
						},
						SWIM_SLOW_UNDERWATER = none,
					},
				},
				DRIP = none,
				ACTION = {
					HUDENABLE = none,
				},
			},
		},
		DEFAULTRESET = COMMON[290],
		REVERSALS = {
			STRUGGLEON = {
				SQUARE = none,
				TRIANGLE = none,
				CROSS = none,
				CIRCLE = none,
			},
			ANYSTRUGGLE = {
				WAITFORINPUT = COMMON[1083],
			},
			SINGLE = {
				RANDOM = {
					TRIANGLE = none,
					SUCCESS = COMMON[1084],
				},
				RANDOM_OLD = {
					SQUARE = none,
					TRIANGLE = none,
					CIRCLE = none,
					CROSS = none,
					SUCCESS = COMMON[1084],
				},
			},
			RESULTS = {
				FAIL = {
					FAILNOCONDITION = none,
				},
				SUCCESS = {
					CHARGE = none,
					ONESHOT = none,
				},
			},
			PARAMETRIC = {
				STRUGGLE = COMMON[1083],
			},
			STRUGGLESOFF = none,
		},
		RETARD_LOCO = {
			RETARD_LOCO = {
				WALK = none,
				IDLE_GIRL = none,
				WALK_FAT = none,
				WALK_GIRL = none,
				IDLE = none,
				IDLE_FAT = none,
			},
		},
		DEFENCE = {
			BLOCK = {
				BLOCK = {
					BLOCKHITS = COMMON[339],
				},
			},
		},
		SOCIAL_ACTIONS = {
			SOCIAL_EXECUTES = {
				GRAPPLERELEASE = none,
			},
			SOCIAL_ACTIONS = none,
		},
		SOCIALIDLES = {
			IDLE_REGULAR = none,
			IDLE_SOCIAL = {
				GENERICS = COMMON[91],
				NERDS = COMMON[69],
				PLAYER = {
					SOCIALIDLE = none,
				},
				UBO_CHECKS = COMMON[92],
				AUTHORITY = COMMON[73],
				TOUGHFACTIONS = COMMON[71],
				GIRLS = COMMON[72],
				FAT = COMMON[91],
			},
		},
		GROUNDATTACKS = {
			GROUNDMOUNT = {
				MOUNTS = {
					GIVE = {
						BELLYUP = COMMON[1086],
						BELLYDOWN = COMMON[1086],
					},
					MOUNTFLIP = COMMON[48],
					RCV = COMMON[368],
				},
			},
		},
		PROPATTACKS = {
			PROPATTACKLOW = none,
		},
		SPEECHGEN = {
			BUSTEDSTIMULUS = none,
		},
		WALK_IDLES = {
			GENERIC_WALK_OVERRIDES = {
				LOOKAROUND = {
					LOOKAROUND_IDLES = COMMON[192],
					LOADANIMS = none,
				},
				PERFORMACTION = {
					MELEEEQUIPPED = {
						LOADANIMS = none,
						LEFTARM_ACTIONS = COMMON[190],
					},
					DEFAULT = {
						LOADANIMS = none,
						ACTIONS = {
							INSYNC_ACTIONS = {
								INSYNC_ACTION1 = none,
							},
							LEFTARM_ACTIONS = {
								SHAREMELEELEFTARMACTIONS = none,
							},
							BOTHARMS_ACTIONS = COMMON[191],
							RIGHTARM_ACTIONS = COMMON[193],
						},
					},
				},
			},
		},
		GRAPPLES = {
			FRONT = {
				GRAPPLES = {
					GRAPPLEMOVES = {
						GRAPPLEEXECUTES = {
							BUSTEDINVULN = {
								SETPLAYERINVULN = {
									SETTARGETINVULN = none,
								},
							},
						},
						PUNISHMENT_HOLD = {
							GIVE = COMMON[252],
							RCV = none,
							HOLD_CYCLE = {
								ESCAPEPARAMETRIC = {
									GIVE = COMMON[1087],
									ADULT_HOLD_ESCAPE = {
										GIVE = {
											EXECUTENODES = {
												INCREMENTESCAPESTAT = COMMON[1088],
											},
											ESCAPE2 = {
												GIVE = none,
												RCV = {
													HITGUTCYCLE = none,
													JOINTDRIVERS = none,
												},
											},
											ESCAPE1 = {
												GIVE = none,
												RCV = {
													STOMPRCVCYCLE = none,
													JOINTDRIVERS = none,
												},
											},
											ESCAPE3 = {
												GIVE = none,
												RCV = {
													SPEECH = {
														SPEECHSACKED = none,
														SPEECHWTF = none,
													},
													HITGUTCYCLE = none,
													JOINTDRIVERS = none,
												},
											},
										},
									},
									RCV = COMMON[252],
								},
								GIVE = COMMON[252],
								RCV = {
									SFXSPAWN = none,
								},
								BUSTED = COMMON[48],
							},
						},
						ORDERLYGRAPPLE = {
							GRAPPLEATTEMPT = {
								GRAPPLESUCCESS = {
									HELD = none,
									SPEECHGEN = {
										SPEECHGEN_CHILD = none,
									},
									HOLD = none,
								},
							},
						},
						GRAPPLESTRIKES = {
							HITA = {
								CHARGE = {
									GIVE = COMMON[1089],
									RELEASE = COMMON[1090],
									RCV = none,
								},
								NPC_CHARGE = {
									GIVE = COMMON[1089],
									RELEASE = {
										HEAVY = COMMON[48],
									},
									RCV = none,
								},
							},
							HITC = {
								CHARGE = {
									GIVE = COMMON[1089],
									RELEASE = COMMON[1090],
									CHARGE_PT2 = COMMON[48],
									RCV = none,
								},
							},
							PUNCH_HOLD_IDLE = COMMON[48],
							EXECUTENODES = {
								STANCETRANSITION = COMMON[48],
							},
							HITB = {
								CHARGE = {
									GIVE = COMMON[1089],
									RELEASE = {
										LIGHT = COMMON[1091],
										HEAVY = {
											GIVE = none,
											RCV = COMMON[213],
										},
									},
									RCV = none,
								},
							},
						},
						TAKEDOWN = {
							IF_LARGE = COMMON[48],
							RCV = none,
							GIVE = none,
						},
						POWERBOMB = {
							GIVE = {
								["1_B_SCRIPTCALL"] = none,
							},
							RCV = COMMON[44],
						},
						BODYSLAM = {
							GIVE = none,
							RCV = {
								BODYSLAMREVERSAL = COMMON[48],
								BODYSLAMREVERSALOPPS = {
									PLAYER = COMMON[1092],
									STRIKER = COMMON[1092],
									GRAPPLER = COMMON[1092],
								},
							},
						},
						ADULT_TAKEDOWN = {
							GIVE = COMMON[252],
							RCV = none,
							HOLD_CYCLE = {
								ESCAPEPARAMETRIC = {
									BUSTED = {
										GIVE = {
											JOINTDRIVERS = none,
											NPCGETUP = none,
										},
										RCV = {
											RCV_NPC = none,
										},
									},
									ADULT_HOLD_ESCAPE = COMMON[1093],
									GIVE = COMMON[1087],
									RCV = COMMON[252],
								},
								RCV = none,
								GIVE = COMMON[252],
							},
						},
						PROPINTERACT = {
							PROPINTERACT = none,
						},
						BUSTEDSTATSBANK = {
							INCREMENTBUSTEDSTAT = COMMON[1088],
						},
						BUSTED = COMMON[48],
						BEARHUG = {
							GIVE = COMMON[252],
							RCV = {
								BEARHUGCYC = {
									GIVE = {
										JOINTDRIVERS = {
											ARMDRIVERS = {
												ARMDRIVERSON = none,
												ARMDRIVERSOFF = none,
											},
										},
									},
									RCV = {
										BEARHUGFINISH = COMMON[1095],
										PUNCHSPAWN = {
											ESCAPE = COMMON[1093],
											PARAMETRIC = {
												SUCCESSMONITOR = {
													PASSED = none,
													WAITFORPASS = none,
												},
											},
											NOANIMATION = none,
										},
									},
								},
							},
						},
						SPEECHGEN = {
							BUSTEDSTIM = none,
						},
						TONFA_IMPALE = {
							TONFAIMPALE = none,
							TONFAIMPALENPC = none,
						},
						TANDEMGRAPPLE = {
							RESCUE = {
								GIVE = COMMON[1096],
							},
							TANDEMGRAPPLE_ACTIVE = {
								HIT = {
									GIVE = {
										RCV = COMMON[252],
									},
								},
								HELD = {
									ESCAPESTRUGGLE = COMMON[1097],
								},
								GIVE = COMMON[252],
								FEEDBACKSPAWN = {
									STRUGGLEFEEDBACK = {
										STRONG = none,
										WEAK = none,
										STRONGEST = none,
										STRONGER = none,
										NORMAL = none,
									},
								},
								RCV = none,
								DEAD = COMMON[1093],
							},
						},
						WEAPONSTEAL = {
							PLAYER_WINNING = {
								GIVE = COMMON[1098],
								PLAYONTARGET = none,
								RCV = none,
							},
							GIVESPAWNED = none,
							GIVE = none,
							STEAL_EASY = COMMON[125],
							STEAL = COMMON[125],
							NPC_WINNING = {
								GIVE = none,
								RCV = COMMON[1098],
							},
							RCV = none,
							FIREEXTINGSOCKET = {
								SOCKETCHANGE = none,
							},
						},
						DIRECTIONALPUSH = {
							PUSHFWD = COMMON[1100],
							DIRECTIONALTOSS = {
								RIGHT = COMMON[1100],
								BACK = COMMON[1100],
								LEFT = COMMON[1100],
							},
						},
						PREFECTBUSTDIALOGUE = {
							CAM_BUS1 = COMMON[1102],
							CAM_BUS_CLS = COMMON[1103],
							CAM_BUS_CLS_CPY = COMMON[1103],
						},
						GIRLFIGHT = {
							GIRLFIGHT_OUT = COMMON[48],
							GIRLFIGHT_START = none,
							GIRLFIGHT_LOOP = COMMON[48],
							GIRLFIGHT_INIT = COMMON[48],
						},
						BACKBREAKER = {
							GIVE = none,
							RCV = {
								REVERSALOPPS = {
									PLAYER = COMMON[1104],
									STRIKER = COMMON[1104],
									GRAPPLER = COMMON[1104],
								},
								REVERSAL = COMMON[48],
							},
						},
						WALLSMASH = COMMON[1095],
						EARGRAB = {
							GIVE = {
								EARGRAB = {
									VSNPC = {
										GIVE = COMMON[172],
										RCV = {
											BUSTED = none,
										},
									},
									WAIT = none,
									VSPLAYER = {
										GIVE = COMMON[1105],
										RCV = COMMON[1105],
									},
								},
							},
						},
					},
					HOLD_IDLE = {
						GRAPPLELOCO = {
							EXECUTEBANK = {
								GRAPLOCOOPPS = none,
							},
							NPC = COMMON[1095],
							PUSHFWD = COMMON[48],
							GRAPPLEROTATE = {
								CWTURN = COMMON[1106],
								FWDS = COMMON[1095],
								CCWTURN = COMMON[1106],
							},
						},
					},
					REVERSALOPPS = COMMON[1108],
					GRAPPLEOPPS = {
						GRAPPLER = {
							GREASER = {
								TANDEM = none,
								TAKEDOWN = none,
								BEARHUG = none,
							},
							JOCK = {
								TANDEM = none,
								TAKEDOWN = none,
								BODYSLAM = none,
								BACKBREAKER = none,
							},
							PREPPY = COMMON[1109],
							BULLY = {
								GUTPUNCH = none,
								TANDEM = none,
								TAKEDOWN = none,
								RUSSELPOWERBOMB = none,
								DIRECTIONALPUSH = none,
							},
						},
						MELEE = {
							GREASER = {
								GUTPUNCH = none,
								TAKEDOWN = none,
								GRABKNEES = COMMON[561],
								KNEE = none,
							},
							JOCK = COMMON[1109],
						},
						DEFAULT = COMMON[1110],
						AUTHORITY = {
							PUNISHMENT_HOLD = none,
						},
						WRESTLERS = {
							GENERICWRESTLER = {
								BEARHUG = none,
								TAKEDOWN = none,
								PUNCH = none,
								KNEE = none,
							},
							JK_LUISWRESTLE = {
								BEARHUG = none,
								TAKEDOWN = none,
								BODYSLAM = none,
								BACKBREAKER = none,
								KNEE = none,
							},
						},
						GARY = {
							TAKEDOWN = none,
							PUNCH = none,
							DIRECTIONALPUSH = none,
							KNEE = none,
						},
						PLAYER = {
							HANDLEDOORS = COMMON[332],
							TAKEDOWN = none,
							LETGO = none,
							DIRECTIONALPUSH = {
								DIRECTIONALPUSHWALL = none,
								DIRECTIONALPUSH = none,
							},
							PROPINTERACT = none,
							STRIKES = {
								PUNCH = none,
							},
						},
						STRIKER = {
							BULLY = {
								GUTPUNCH = none,
								TAKEDOWN = none,
								RUSSELPOWERBOMB = none,
								DIRECTIONALPUSH = none,
							},
						},
						RANGE = COMMON[1110],
						ADULT_MALE = {
							ADULT_TAKEDOWN = none,
						},
					},
					GRAPPLEATTEMPT = {
						PLAYER = none,
						RCVWAIT = none,
						GRAPPLESUCCESS = COMMON[1111],
						NPC = {
							GRAPPLEHIGH = {
								GRAP_HIGH = {
									GRAP_HIGH_RCV = none,
								},
							},
							GRAPPLEBREAK = none,
							EXECUTENODES = {
								ADULTGRAPPLE = none,
							},
							VSGOKART = COMMON[256],
							VSBIKE = COMMON[256],
							GRAPPLEATTEMPT = none,
						},
					},
					GRAPPLESEXECUTENODES = {
						FACETARGETSPAWN = {
							TARGETONLY = none,
							FACETARGETLOCK = none,
							FACETARGETAUTOTHROW = none,
						},
					},
				},
			},
			RUNNINGTAKEDOWN = {
				TAKEDOWN_MISS = COMMON[45],
			},
			GRAPPLEREVERSALS = {
				MOUNTREVERSALS = {
					MOUNTREVERSALPUNCHES = {
						GUARDPUNCHFINISH = COMMON[48],
						RCV = none,
						GIVE = none,
					},
					GUARDPUNCHREVERSAL = COMMON[1095],
					MOUNTREVERSALTOPUNCH = COMMON[1095],
					MOUNTREVERSAL = COMMON[1095],
					PUSHOFFREVERSE = COMMON[48],
					PUSHOFF = COMMON[1095],
				},
				STANDINGREVERSALS = {
					SPRAWL = {
						THROW = COMMON[48],
						RCV = none,
						GIVE = none,
					},
					RUNNINGTAKEDOWNBREAK = COMMON[48],
					GRAPPLEBREAKREVERSE = COMMON[394],
					GIRLNUTKICK = COMMON[48],
					GREASERKNEEREVERSAL = COMMON[561],
					KNEEREVERSALTAKEDOWN = COMMON[48],
					GRAPPLEBREAK = COMMON[394],
				},
			},
			MOUNT = {
				MOUNTOPPS = {
					JOCK = COMMON[1112],
					BULLY = {
						SPIT = none,
						DISMOUNT = none,
						FACEPUNCH = none,
					},
					PLAYER = {
						SPIT = none,
						KNEEDROP = none,
						HEADBUTT = none,
						DISMOUNT = none,
						PULLUP = none,
						FACEPUNCH = none,
					},
					GARY = {
						SPIT = none,
						KNEEDROP = none,
						HEADBUTT = none,
						DISMOUNT = none,
						FACEPUNCH = none,
					},
					GREASER = COMMON[1112],
					PREPPY = {
						DISMOUNT = none,
						FACEPUNCH = none,
					},
					WRESTLERS = {
						GENERICWRESTLER = {
							HEADBUTT = none,
							DISMOUNT = none,
							FACEPUNCH = none,
						},
						JK_LUISWRESTLE = {
							KNEEDROP = none,
							HEADBUTT = none,
							DISMOUNT = none,
							FACEPUNCH = none,
						},
					},
					DROPOUT = {
						HEADBUTT = none,
						DISMOUNT = none,
						KNEEDROP = none,
					},
				},
				GRAPPLEMOVES = {
					SPIT = COMMON[48],
					KNEEDROP = {
						GIVE = COMMON[252],
						KNEEDROPREVERSAL = COMMON[48],
						RCV = {
							BELLYUP = COMMON[352],
						},
					},
					PULL_UP = COMMON[48],
					HEADBUTT = COMMON[1095],
					DISMOUNT = {
						GIVE = none,
						DISMOUNT_NO_PLAYONTARGET = COMMON[255],
						RCV = COMMON[1096],
					},
					FACEPUNCH = {
						HIT3 = COMMON[1113],
						HIT1 = COMMON[1113],
						HIT2 = COMMON[1113],
					},
				},
				EXECUTENODES = {
					MOUNTRCVFLAGS = none,
				},
				MOUNTHITS = {
					MOUNT = {
						HIT_LEFT = COMMON[1116],
						HIT_RIGHT = COMMON[1116],
						EXECUTENODES = {
							TOGETUP = COMMON[352],
							RCV = none,
							MOUNTHITBASE = none,
						},
						HIT_FRONT_DEFAULT = COMMON[1116],
						HIT_BACK = COMMON[1116],
					},
				},
				MOUNTIDLE = COMMON[1095],
				REVERSALOPPS = COMMON[1108],
			},
		},
		ACTIONOPPS = {
			FULLBODYACTIONOPPS = {
				KICKBALLSPAWN = COMMON[333],
			},
		},
		OFFENSE = {
			RUNNINGATTACKS = {
				RUNNINGATTACKSDIRECT = {
					UNARMED = {
						GRAPPLER = {
							GRAPPLES = none,
							STRIKES = none,
						},
						ADULT = COMMON[1118],
						ATTACKS = {
							ADULT = COMMON[1119],
							AUTHORITYTEMP = COMMON[1119],
							GRAPPLES = COMMON[89],
							HEAVYATTACKS = {
								RUNSHOULDER = {
									COLLISION = COMMON[1121],
									RUNSHOULDERBACKTORUN = none,
								},
								RUNPUNCH = {
									COLLISION = COMMON[1121],
									RUNPUNCHBACKTORUN = none,
								},
							},
						},
						STRIKER = COMMON[1122],
						AUTHORITY = COMMON[1118],
						GENERIC = COMMON[1122],
					},
					WEAPON = {
						UNBLOCKABLE = {
							CHARGE = {
								ATTACK = COMMON[17],
							},
							PREATTACKANIMATION = none,
						},
						HEAVYATTACKS = none,
					},
				},
			},
			TANDEMATTACK = {
				CO_OP_PUNCH_1 = {
					CO_OP_PUNCH_2 = none,
				},
			},
		},
		ACTION_BREAKOUT = {
			ACTION_BREAKOUT = none,
		},
		RISINGATTACKS = {
			HEAVYATTACKS = {
				RISINGATTACKS = {
					MOVES = {
						FEMALE = COMMON[351],
						MALE = {
							GRAPPLER = none,
							DEFAULT = none,
							NONFACTION = none,
						},
					},
				},
			},
		},
	},
	["5_03"] = {
		["5_03_NIS_GATECLOSE"] = {
			JOHNNY = COMMON[296],
			JIMMY = COMMON[220],
		},
		["5_03_CELL_DOOR_SWITCH"] = none,
		["5_03_CRAZY_DOOR"] = {
			DOOR = {
				DOOR_IDLE = none,
				DOOR_OPEN = none,
			},
		},
		["5_03_STAND_SMOKE"] = {
			WALL_SMOKE = COMMON[237],
		},
		["5_03_SLEEPING_ORDERLY"] = {
			["5_03_SLEEPING_ORDERLY_TO_SLEEP"] = {
				["5_03_SLEEPING_ORDERLY_SLEEP"] = none,
			},
			["5_03_SLEEPING_ORDERLY_WAKE_UP"] = {
				["5_03_SLEEPING_ORDERLY_LOOK"] = none,
			},
		},
		["5_03_REC_DOOR"] = {
			["5_03_REC_DOOR_CLOSE_BREAK"] = {
				["5_03_REC_DOOR_CLOSE_BREAK_ANIM"] = none,
			},
			["5_03_REC_DOOR_CLOSE"] = {
				["5_03_REC_DOOR_CLOSE_ANIM"] = none,
			},
			["5_03_REC_DOOR_PARA"] = {
				["5_03_REC_DOOR_PARA"] = none,
			},
		},
		["5_03_JOHNNY_IN_CELL"] = {
			CELLLOOPS = {
				CELL5 = none,
				CELL3 = none,
				CELL4 = none,
				CELL6 = none,
				CELL2 = none,
				CELL1 = none,
			},
		},
		["5_03_NIS_OUTRO"] = {
			JOHNNY = {
				JOHNNY03 = none,
				JOHNNY01 = none,
				JOHNNY02 = none,
			},
			JIMMY = {
				JIMMY02 = none,
				JIMMY03 = none,
				JIMMY01 = none,
			},
		},
		["5_03_DOORSWITCH"] = {
			DOORSWITCH = {
				DOORSWITCH_OPEN = none,
			},
		},
		["5_03_RESET"] = none,
		["5_03_STAND_TALKING"] = {
			TALKINGLOOPS = COMMON[428],
			["5_03_SEE_PLAYER"] = none,
		},
		["5_03_JOHNNY_INTRO1_1"] = {
			["5_03_JOHNNY_INTRO1_1_5"] = {
				["5_03_JOHNNY_INTRO1_2"] = {
					["5_03_JOHNNY_INTRO1_3"] = {
						["5_03_JOHNNY_INTRO2_1"] = {
							["5_03_JOHNNY_INTRO2_2"] = {
								["5_03_JOHNNY_INTRO3_1"] = {
									["5_03_JOHNNY_INTRO3_2"] = {
										["5_03_JOHNNY_INTRO3_3"] = {
											["5_03_JOHNNY_INTRO4_1"] = {
												["5_03_JOHNNY_INTRO5_1"] = {
													["5_03_JOHNNY_INTRO5_2"] = {
														["5_03_JOHNNY_INTRO5_3"] = {
															["5_03_JOHNNY_INTRO6_1"] = {
																["5_03_JOHNNY_INTRO7_1"] = {
																	["5_03_JOHNNY_INTRO7_2"] = none,
																},
															},
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
	KICKMESIGN = {
		KICKMESIGN = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = COMMON[65],
			ACTIONS = {
				TRIGGERSIGN = {
					ATTACHSIGN = {
						FEMALE = {
							ATTACHSIGN_EDNA = none,
							ATTACHSIGN_SMALL = none,
							ATTACHSIGN_GEN = none,
							ATTACHSIGN_FAT = none,
						},
						MALE = {
							ATTACHSIGN_GYMTEACHER = none,
							ATTACHSIGN_GEN = none,
							ATTACHSIGN_RUSSELL = none,
							ATTACHSIGN_SMALL = none,
							ATTACHSIGN_HUGE = none,
							ATTACHSIGN_FAT = none,
						},
					},
					SIGNDETACH = {
						HALLOWEENCALLBACK = none,
					},
				},
				SHRUG = none,
			},
			DEFAULT_KEY = none,
		},
	},
	ROOFTOPATTACKER = COMMON[30],
	BOXINGPLAYER = {
		ATTACKS = {
			SPECIALS = {
				KOPUNCH = {
					HEAVYATTACKS = {
						KNOCKOUTCHARGE = {
							RELEASE = {
								JAB = none,
								HEAVYATTACKS = {
									KNOCKOUT = none,
								},
							},
						},
					},
				},
			},
			BOXINGATTACKS = {
				LIGHTATTACKS = {
					RIGHT2 = {
						RELEASE = {
							UNBLOCKABLE = COMMON[1124],
							HEAVYATTACKS = COMMON[1125],
							CROSS = none,
						},
					},
					RIGHT4 = {
						RELEASE = {
							GUTPUNCH = none,
							UNBLOCKABLE = COMMON[1124],
							HEAVYATTACKS = COMMON[1126],
						},
					},
					LEFT3 = {
						RELEASE = {
							UNBLOCKABLE = COMMON[1127],
							HEAVYATTACKS = COMMON[1128],
							HOOK = none,
						},
					},
					EXECUTEBANK = {
						HEAVYATTACK_FF = none,
						INCREMENTSTATPUNCHES = none,
					},
					LEFT5 = COMMON[230],
					LEFT1 = {
						RELEASE = {
							JAB = none,
							UNBLOCKABLE = COMMON[1127],
							HEAVYATTACKS = {
								JAB_CHARGED = none,
							},
						},
					},
				},
			},
		},
		EVADEBANK = {
			EVADES = {
				EVADESUCCESS = {
					SUCESS = none,
					CHECK = none,
				},
				DUCK = none,
				EVADEATTACKS = {
					RIGHTCHARGE = {
						RELEASE = {
							RIGHTPUNCH = none,
							HEAVYATTACKS = {
								RIGHTPUNCH_CHARGED = none,
							},
						},
					},
					BACKCHARGE = {
						RELEASE = {
							BACKPUNCH = none,
							HEAVYATTACKS = {
								BACKPUNCH_CHARGED = none,
							},
						},
					},
					LEFTCHARGE = {
						RELEASE = {
							HEAVYATTACKS = {
								LEFTPUNCH_CHARGED = none,
							},
							LEFTPUNCH = none,
						},
					},
				},
				RIGHT = none,
				LEFT = none,
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				SPRINTDEPLETE = COMMON[397],
				COMBAT = {
					BLOCK = {
						COMBATIDLEBLOCK = none,
						BLOCKSTRAFE = none,
					},
					COMBATTRANSITION = {
						COMBATIDLE_OUT = COMMON[1130],
						COMBATSTART = COMMON[1130],
					},
					DEFAULT = {
						COMBATSTRAFE = none,
						COMBATIDLE = none,
					},
					EXECNODES = {
						TARGET = COMMON[530],
						BLOCKHITS = {
							HITSLIGHT = COMMON[1085],
							BOXINGKNOCKOUT = {
								BREAKER = none,
							},
							BREAKER = COMMON[861],
						},
					},
				},
				LOCOMOTIONEXECUTES = {
					CROUCHLOCOTARGET = none,
					STRAFELOCOBASICFACING = none,
					NONCOMBATSTRAFEANIMS = none,
					STRAFELOCOBASIC = none,
					CROUCHLOCORUN = none,
					SPRINTTIRED = none,
					STRAFELOCOBASICTURNING = none,
					NONTARGETLOCO = COMMON[1131],
					COMBATLOCOBASIC = none,
					CROUCHLOCOBASIC = none,
					WALKBASICNONMASTER = none,
					NONCOMBATSTRAFE = none,
					STRAFELOCOBASICANIMS = none,
					OLDLOCOMOTION = {
						LOCOBASICOLD = none,
						LOCOLOWBOOST = none,
					},
					LOCOBASIC = none,
					RUN_STARTLOCO = none,
					WALK_STARTLOCO = none,
					SPEEDRUNLOCOBASIC = none,
					WALKBASIC = none,
					TIRED_UPPERBODY = none,
				},
				OFFSETCAM = {
					STRAFELOCO_UNARMED = {
						NC_STRAFE = {
							SPAWNS = none,
							NC_LOOK = none,
							NC_LOCO = {
								IDLE = none,
								NONCOMBATSTRAFEANIMS = none,
							},
						},
						CROUCH = {
							CRAWLTRANSITION = {
								CRAWLSTART = none,
							},
							CROUCHEND = none,
							STRAFE = none,
							CROUCHSTART = none,
							IDLE = none,
						},
					},
				},
				BOXINGCOMBAT = {
					STRAFEMOVE = {
						COMBATSTRAFE = none,
						BLOCKSTRAFE = none,
					},
					COMBATIDLE = {
						COMBATIDLEDEFAULT = none,
						COMBATIDLEBLOCK = none,
					},
				},
				SAUNTER = {
					NOTTIRED = {
						SAUNTER_START = none,
						SAUNTER = {
							SAUNTER_STOP = none,
						},
					},
					FEMALE = COMMON[188],
					TIRED = {
						SAUNTERTIRED = none,
					},
				},
				WALK = {
					TIRED = COMMON[418],
					ALLY = COMMON[525],
					NOTTIRED = {
						WALK = {
							WALK_STOP = none,
						},
						WALK_START = none,
					},
					FEMALE = COMMON[188],
				},
				IDLE = none,
			},
			EXECUTENODES = {
				DEFAULTRESET = none,
				IDLEOPPS = {
					IDLETIRED = {
						IDLETIREDANIM = none,
					},
					IDLEANIMATION = {
						REGULARIDLEANIMATION = {
							AMBIENTSPAWN = COMMON[413],
							AMBIENTACTIONS = {
								AMBIENTACTIONS_GROUPLOAD2 = COMMON[667],
								AMBIENTACTIONS_GROUPLOAD1 = COMMON[668],
								AMBIENTACTIONS_GROUPLOAD3 = {
									AMBIENTACTIONS = {
										ARMSFOLD = none,
										ARMSONHIPS = none,
										SCRATCHARSE = none,
										SCRATCHHEAD = none,
										SCRATCHPIT = none,
										STRETCH = none,
									},
								},
							},
						},
						TIREDANIMATION = COMMON[1132],
						VERYTIREDANIMATION = COMMON[1132],
						EXHAUSTED_COLLAPSE = COMMON[417],
					},
					WALL_CHECK = {
						CHECK_WALL_REAR = none,
						EXECUTENODES = {
							ONWALL = none,
							TURNRIGHT = none,
							BACKUPTOWALL = none,
							TURNLEFT = none,
							GOTOWALL = {
								GOTOWALL2 = none,
							},
						},
						CHECK_WALL_RIGHT = none,
						CHECK_WALL_FRONT = none,
						CHECK_WALL_LEFT = none,
					},
				},
				SNAPIDLE = none,
				ACTIONOPPS = none,
				JUMPACTIONOPPS = none,
				CROUCHACTIONOPPSBASE = none,
				OFFSETCAM = {
					STRAFELOCO_UNARMED = {
						IDLE = none,
						CROUCH = {
							CROUCHEND = none,
							STRAFE = none,
							CROUCHSTART = none,
							IDLE = none,
						},
						NONCOMBATSTRAFEANIMS = none,
					},
				},
				EARLYACTIONS = none,
				ACTIONOPPSBASE = none,
				CROUCHACTIONOPPS = none,
				ACTIONOPPSCOMBAT = none,
				ACTION_BREAKOUT = none,
			},
		},
	},
	MG_DUNKTANK = {
		INITIALBALLATTACH = none,
		DUNKGLOBAL = {
			DUNKTANK_MG = {
				THROW = {
					RELOAD = none,
				},
			},
		},
	},
	NIS_3_S03_GIVEHAT = {
		GIVE = {
			GIVE = {
				PREPIDLE = none,
			},
			RECEIVE = none,
		},
		GIVE_ATTEMPT = COMMON[955],
		EXECUTES = COMMON[1075],
	},
	["1_03"] = {
		ANIMATIONS = {
			DAVISBRAG = {
				RELEASE = none,
				WAIT = none,
				CAUGHT = none,
			},
			FALLOFFBARRELS = {
				BOBBLE = {
					FALLOFF = COMMON[357],
				},
				NEWFALL = {
					WRITHEONGROUND = none,
				},
			},
			DAVISWAITTIRED = {
				TIREDLOOP = none,
				STOP = none,
			},
			HIDING = COMMON[234],
			DAVISWAIT = {
				RELEASE = none,
				WAITLOOP = none,
			},
			DAVISKICKLADDER = {
				KICK = none,
			},
			PLAYERPICKUPSLINGSHOT = COMMON[1080],
			PETERFISTSHAKE = {
				PETERHIT = {
					ONBELLYLOOP = none,
				},
				INIT = none,
				FISTSHAKEEND = COMMON[95],
				END = none,
			},
			DAVISSHOULDER = {
				SHOULDERSLAM = none,
			},
			GENSTANDTALKING = {
				TALKINGLOOPS = COMMON[428],
				ENDTALKING = none,
			},
		},
		PARAMETRICDOOR = COMMON[1069],
		["1_03_DAVISBRAGS"] = {
			PED1_IDLE = COMMON[238],
			LOADANIMS = none,
			PED0_IDLE = none,
			LINE1 = COMMON[479],
			CONVINITIATE = none,
		},
		CONV = {
			DAVISLINE = none,
			WADELAUGH = none,
			WADERESPONSE = none,
		},
	},
	FRALRM = {
		NOTUSEABLE = none,
		PEDPROPSACTIONS = {
			NOTUSED = {
				IDLEPED = COMMON[1139],
				IDLE = COMMON[1139],
				LOADANIMS = none,
			},
			DISENGAGE = COMMON[215],
		},
		USEABLEBYANYONE = none,
		USEABLEPLAYERONLY = none,
		STATS = {
			STATINCNODE = none,
		},
	},
	GS_FAT_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[8],
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				STATIONARY = COMMON[10],
				STRIKES = COMMON[383],
			},
		},
	},
	CV_OLD = {
		DEFENSE = COMMON[1141],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = {
					DEFAULT_WALKOVERRIDES = COMMON[1142],
					RUNBASIC = none,
					IDLE_OVERRIDES = COMMON[493],
					WALKBASIC = COMMON[188],
					SPRINTBASIC = none,
				},
				LOCOMOTIONOVERRIDE = {
					COMBAT = COMMON[88],
				},
				CUSTOMACTIONOPS = COMMON[27],
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			SHORT = COMMON[492],
		},
	},
	GIVESUPERGLUE = COMMON[914],
	C9 = {
		PLAYERSIT = COMMON[887],
		NIS_OUT = COMMON[893],
		PLAYERFAIL = COMMON[373],
		C9_INTRO_4 = COMMON[1145],
		C9_INTRO_3 = COMMON[1145],
		C9_INTRO_1 = COMMON[1147],
		C9_INTRO_2 = COMMON[1147],
		C9_INTRO_5 = COMMON[1147],
		RELEASE = none,
		TEACHERDISGUST = none,
		PLAYERVICTORY = COMMON[891],
	},
	HOBO_BLOCKER = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = COMMON[1140],
				LOCOMOTIONOVERRIDE = COMMON[426],
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			SHORT = {
				TAUNT = {
					TAUNT_LOCO = {
						CLOSERANGESTRAFE = none,
						STRAFEIDLE = none,
					},
				},
				HOBO_TAUNTS = {
					HOBO_TAUNT3 = none,
					HOBO_TAUNT6 = none,
					HOBO_TAUNT5 = none,
					HOBO_TAUNT2 = none,
					HOBO_TAUNT1 = none,
					HOBO_TAUNT4 = none,
				},
			},
		},
	},
	CV_DRUNK = {
		DEFENSE = COMMON[1141],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = {
					DEFAULT_WALKOVERRIDES = COMMON[1142],
					RUNBASIC = none,
					IDLE_OVERRIDES = {
						CONTROLLER_NODE = {
							ACTIONS = {
								GENERIC = COMMON[246],
								FACTION_SPECIFIC = {
									FACTION_IDLE2 = none,
									FACTION_IDLE1 = {
										BULLY_IDLE1 = none,
									},
								},
								NOOVERRIDE = none,
							},
						},
					},
					WALKBASIC = {
						WALKBASIC = COMMON[1156],
						HOBODRUNK = COMMON[188],
					},
					SPRINTBASIC = none,
				},
				LOCOMOTIONOVERRIDE = COMMON[1157],
				CUSTOMACTIONOPS = COMMON[27],
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			SHORT = COMMON[446],
		},
	},
	MGSOCPEN = {
		PLAYERREACTIONS = {
			PLAYERBADFAILURE = none,
			PLAYERGOODVICTORY = none,
			PLAYERVICTORY = none,
			PLAYERIDLE = none,
			PLAYERFAILURE = none,
		},
		USESOCCERGOALEND = none,
		USESOCCERGOALSTART = {
			CHARGE = none,
			IDLE = none,
			GROUNDKICK = {
				GROUNDKICKPROJECTILE = none,
			},
		},
		USESOCCERGOAL3OLD = {
			USESOCCERGOALSTART = COMMON[832],
			USESOCCERGOALEND = none,
			FINALIDLE = none,
		},
		USESOCCERGOAL2 = {
			USESOCCERGOALEND = none,
			USESOCCERGOALSTART = {
				CHARGE = none,
				GROUNDKICK = COMMON[1159],
				RESTING = none,
				IDLE = {
					IDLE2 = {
						IDLE3 = none,
					},
				},
			},
		},
		USESOCCERGOAL3 = {
			USESOCCERGOALEND = none,
			USESOCCERGOALSTART = {
				CHARGE = none,
				IDLE = none,
				DO = COMMON[832],
			},
		},
		TARGETREACTIONS = {
			CHEER = {
				CHEER1 = none,
			},
			CUSTOMHITTREE = {
				LEGS = {
					RIGHT = COMMON[351],
					LEFT = COMMON[351],
				},
				KO = none,
				HEAD = COMMON[1160],
				WALLHITS = {
					FRONT = COMMON[361],
					REAR = COMMON[362],
				},
				NADS = COMMON[1160],
				CUSTOMHITTREEEXECUTES = {
					HITBASESTANDINGPROJECTILE = none,
					HITBASESTANDINGPROJECTILEHEAD = none,
					HITBASESTANDINGPROJECTILENADS = none,
				},
				TORSO = COMMON[1160],
			},
			KO = none,
			HITS = {
				FAILS = {
					FAILS04 = none,
					FAILS02 = none,
					FAILS01 = none,
					FAILS03 = none,
				},
				HITS1 = none,
			},
			DEFAULT = none,
			SCARED = none,
			MOCK = {
				MOCK2 = none,
				MOCK1 = none,
			},
		},
	},
	TESTCONV_3PED = {
		LINE1 = COMMON[637],
	},
	NPC_CHEER_A = {
		AGROTAUNTS = {
			GONNAKILLYA = none,
			IMHEREBUDDYMAN = none,
			BRINGIT = none,
			DONTBEMESSIN = none,
			YOGOINDOWN = none,
			COMEON = none,
		},
		DEFAULT_KEY = {
			LOCOMOTION = {
				STRAFELOCOBASIC = none,
			},
			IDLE = {
				AMBIENT = COMMON[1039],
				EXECUTERANDOMCHEERS = {
					RAMDOMCHEEROPP = none,
				},
			},
		},
		AFRAIDREACTION = COMMON[845],
	},
	CAMERAS = {
		ORDERLY_BUSTED = COMMON[1164],
		GAME_PLAY_CAMERA_BANK = {
			GAME_CAM_FRONT = none,
		},
		GRAPPLE_CAMERAS = {
			GRAPPLE_BEARHUG_CAMERAS = COMMON[1164],
			GRAPPLE_TANDEM_CAMERAS = COMMON[1164],
		},
		RELEASE_CAM_BANK_NO_PREVE = COMMON[1165],
		TREE_AND_LADDER_CLIMB_CAM = COMMON[1166],
		BOXING_KO = {
			BOXING_KO_CAM_CORNERS = none,
			BOXING_KO_CAM = none,
		},
		COP_BUSTED_PIN = {
			CAMERA01 = none,
		},
		QUICK_RELEASE_CAM_BANK = COMMON[1165],
		GRAPPLE_CAM_WEAPONSTRUGGLE = COMMON[1167],
		RUSSELL_FIGHTCAM_RELEASE = {
			RUSSELL_FIGHTCAM_RELEASE = none,
		},
		PISSING_CAM = {
			CAMERA_01 = none,
		},
		BUSTEDCOMMENTARY = {
			CAM_BUS1 = COMMON[1102],
		},
		GET_ON_BIKE = {
			CAMERA = none,
		},
		RUSSELL_HEADBUTT = {
			RUSSELL_HEADBUTT_RUN = none,
			RUSSELL_HEADBUTT_WALLHIT = COMMON[1164],
		},
		RAIL_SLIDE = {
			RAIL_SLIDE_RELEASE = none,
			RAIL_SLIDE_CAM = none,
			RAIL_SLIDE_RELEASE_OLD = none,
		},
		PREFECT_BUSTED = {
			CAMERA02 = none,
			CAMERA04 = none,
			CAMERA01 = none,
			CAMERA03 = none,
		},
		WAKE_UP_CAM = {
			WAKE_UP_CAM_1 = none,
			WAKE_UP_CAM_2 = none,
		},
		HUMILIATION_CAMERAS = {
			HUMILIATION_SLAP = COMMON[1164],
			HUMILIATE_TRIP_KID = COMMON[1164],
			HUMILIATION_PEE = COMMON[1164],
			HUMILIATION_DEAD_LEG = COMMON[1164],
			HUMILIATION_DEAD_ARM = COMMON[1164],
			HUMILIATION_HANDCRUSH = COMMON[1164],
			HUMILIATION_EAR_GRAB = COMMON[1164],
			HUMILIATION_INDIAN_BURN = COMMON[1164],
			HUMILIATION_NOSE = COMMON[1164],
			HUMILIATION_NOOGIE_SPIT = COMMON[1164],
			HUMILIATION_TRIP_BIGKID = COMMON[1164],
			HUMILIATION_HIT_SELF = COMMON[1164],
			HUMILIATION_WEDGIE = COMMON[1164],
		},
		COP_BUSTED_WALK = COMMON[1164],
		CRAWL_CAM = {
			CRAWL_CAM = none,
			CRAWL_RELEASE = COMMON[1165],
		},
		RELEASE_CAM_BANK = COMMON[1165],
		GRAPPLE_CAM_ARMBAR = COMMON[1167],
		TOILET_DUNKING_CAM = {
			TOILET_DUNKING_CAM = none,
		},
		RUSSELL_BOSTON_CRAB = {
			RUSSELL_BOSTON_CRAB_CYC_CAM = none,
		},
		QUICK_RELEASE_CAM_NO_RESET = {
			RELEASE_CAM_NO_RESET = none,
		},
		CLIMB_CAM = COMMON[1166],
		GRAPPLE_CAM_WEDGE = COMMON[1167],
		GRAPPLE_CAMS_LOW = COMMON[1167],
		GRAPPLE_CAMS_MEDIUM = COMMON[1167],
		GRAPPLE_CAMS_HIGH = COMMON[1167],
		GENTLE_RELEASE_CAM_BANK = COMMON[1165],
		KISS_CAMERAS = {
			KISS_CAMERAS_FAT = COMMON[1168],
			KISS_CAMERAS_COLLISION = {
				ONFLATGROUND = COMMON[1169],
				FAIL_TRYFAT = none,
				ONSLOPE = COMMON[1170],
			},
			KISS_CAMERAS_FAT_COLLISION = {
				ONFLATGROUND = COMMON[1169],
				ONSLOPE = COMMON[1170],
			},
			KISS_CAMERAS_RANDOM = COMMON[1168],
		},
		RUSSELL_POWERBOMB = {
			RUSSELL_POWER_BOMB_CAM = none,
		},
	},
	B_STRIKER_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[63],
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					LIGHTATTACKS = {
						WINDMILL_R = {
							COLLISION = COMMON[1175],
							WINDMILL_L = COMMON[1176],
						},
					},
					HEAVYATTACKS = {
						SWINGPUNCH = {
							SWINGPUNCH_R = COMMON[1176],
						},
						GUTKICK = {
							GUTKICK_R = COMMON[1176],
						},
					},
				},
			},
			MEDIUM = COMMON[396],
		},
	},
	J_GRAPPLER_A = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = COMMON[425],
				LOCOMOTIONOVERRIDE = COMMON[82],
				CUSTOMACTIONOPS = COMMON[27],
			},
			IDLE = COMMON[427],
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = COMMON[83],
			},
			MEDIUM = {
				STRIKES = {
					HEAVYATTACKS = {
						RIGHTPUNCH = {
							AXEHANDLE = none,
						},
					},
				},
			},
		},
	},
	STANDARDDAMAGE = {
		IDLE = {
			DODAMAGE = none,
			HANDLEOBSTACLE = {
				ENABLEOBSTACLE = none,
				DISABLEOBSTACLE = none,
			},
		},
		DONOTHING = none,
		RESET = none,
	},
	NPC_YARDSTICK = {
		HEAVYATTACKS = {
			POKE = none,
			SWING1 = COMMON[508],
		},
	},
	G_STRIKER_A = {
		DEFENSE = none,
		DEFAULT_KEY = COMMON[1038],
		OFFENSE = {
			GROUNDATTACK = COMMON[1049],
			RUNNINGATTACKS = none,
			SHORT = {
				STRIKES = {
					LIGHTATTACKS = COMMON[559],
					HEAVYATTACKS = {
						HEAVYKNEE = none,
						HEAVYKICK = {
							GRABKNEES = {
								GV = COMMON[252],
								RCV = none,
							},
							COLLISION = COMMON[562],
							HEAVYKICKLAND = none,
						},
					},
				},
			},
			TAUNTS = {
				TAUNT_2 = none,
				TAUNT_A = none,
			},
			MEDIUM = {
				STRIKES = {
					HEAVYATTACK = {
						KICKTHRUST = none,
					},
				},
			},
		},
	},
	CUTSCENES = {
		["2-S05"] = {
			PLAYEROBJECT = none,
			CIG = none,
			COOKOBJECT = none,
		},
		["2-01"] = {
			COOKOBJECT = none,
			PLAYEROBJECT = none,
			SPOON = none,
			CIG = none,
		},
		["2-S07"] = {
			GNOMEOBJECT = none,
		},
		CIGTEMP = none,
	},
	DBALL = {
		DB_START = {
			DB_01 = {
				DB_02 = {
					DB_03 = {
						DB_04 = {
							DB_05 = {
								DB_MISSION = none,
							},
						},
					},
				},
			},
		},
		DB_TARGET = {
			DB_TARGETANIM2 = none,
			DB_TARGETANIM1 = none,
		},
	},
	MGBASEBALLTOSS = {
		ANIMATIONS = {
			CARNY = {
				HIT = {
					TORSOFRONT2 = none,
					TORSOFRONT1 = none,
					KICKPLAYEROUT = none,
				},
				UMPIRE = none,
				BONUSHIT = none,
				BALL4 = none,
				STANDIDLE = none,
				WONGAME = none,
				BALL = none,
				LOSTGAME = none,
				STRIKE = none,
				STRIKEOUT = none,
			},
			FAIL = {
				IDLE = none,
				DETTACH = none,
			},
			VICTORY = none,
		},
	},
	EDGARSHIELD = {
		LOCOMOTION = {
			ANIMATIONS = {
				WEAPONWALK = COMMON[163],
				WEAPONBIKEIDLE = none,
				WEAPONSOCIAL = COMMON[164],
				WEAPONCROUCH = none,
				WEAPONRUN = none,
				WEAPONSTRAFE = {
					IDLE = none,
					BLOCK = none,
				},
				WEAPONIDLE = COMMON[163],
			},
			GLOBALLOCO = COMMON[165],
		},
		OFFENSE = COMMON[64],
		FULLBODYACTIONOPPS = none,
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					SWING = {
						RELEASE = {
							CHARGE = none,
							SWING = none,
							SWING_HEAVY = none,
						},
					},
				},
			},
			SHIELDBLOCKS = {
				PLAYERSHIELDDAMAGE = {
					TRIGGERPIPEDAMAGE = {
						STUMBLE = none,
						TODAMAGESTATE2 = none,
						TODESTROYEDSTATE = none,
						TODAMAGESTATE1 = none,
					},
					SHIELDDAMAGE = {
						TODAMAGESTATE = {
							OPPORTUNITYINSERT = {
								RECOIL = none,
							},
						},
						TODESTROYEDSTATE = COMMON[860],
					},
				},
			},
		},
		DEFAULT_KEY = none,
	},
	AUTHORITY = {
		DEFENSE = COMMON[444],
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[445],
			IDLE = {
				IDLES = {
					PREFECT = none,
					ADULT = none,
					FAT = none,
				},
			},
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = {
					GRAPPLEATTEMPT = none,
					TONFAIMPALE_EXEC = none,
				},
			},
		},
	},
	CARNISTRIKER = {
		CARNYINTRO = {
			CARNYNEXT = {
				PLAYGAME = COMMON[212],
			},
		},
	},
	NONWEAPON = {
		NONWEAPON = {
			FULLBODYACTIONOPPS = none,
			LOCOMOTION = {
				ANIMATIONS = {
					WEAPONWALK = {
						TEDDYBEAR = none,
						WEAPONWALK = none,
					},
					WEAPONBIKEIDLE = {
						WEAPONBIKEIDLE = none,
					},
					WEAPONSOCIAL = {
						WEAPONIDLE = COMMON[1189],
						PERFORMINGACTION = {
							TEDDYBEAR = none,
							PERFORMINGACTION = none,
						},
					},
					WEAPONCROUCH = {
						TEDDYBEAR = none,
						WEAPONCROUCH = none,
					},
					WEAPONRUN = {
						TEDDYBEAR = none,
						WEAPONRUN = none,
					},
					WEAPONSTRAFE = {
						TEDDYBEAR = none,
						WEAPONSTRAFE = none,
					},
					WEAPONIDLE = COMMON[1189],
				},
				GLOBALLOCO = COMMON[165],
			},
			SOCIALEXECUTE = none,
			DEFAULT_KEY = none,
		},
	},
	PHOTOGRAPHY = {
		GRADES = {
			GRADEA = {
				GRADEA_1 = {
					GRADEA_2 = none,
				},
			},
			GRADEAP = {
				GRADEAP_1 = {
					GRADEAP_2 = none,
				},
			},
			GRADEC = {
				GRADEC_1 = {
					GRADEC_2 = none,
				},
			},
			GRADEB = {
				GRADEB_1 = {
					GRADEB_2 = none,
				},
			},
			GRADED = {
				GRADED_1 = {
					GRADED_2 = none,
				},
			},
		},
		POSTCARD = {
			POSTCARD1 = {
				POSTCARD2 = {
					POSTCARD3 = {
						POSTCARD4 = {
							POSTCARD5 = none,
						},
					},
				},
			},
		},
		JOURNALISM = {
			FLAGWEEK = {
				FOOTWEEK1 = {
					FOOTWEEK2 = {
						FOOTWEEK3 = {
							FOOTWEEK4 = {
								FOOTWEEK5 = {
									FOOTWEEK6 = {
										FOOTWEEK7 = {
											FOOTWEEK8 = none,
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
	WATERFOUNTAIN = {
		PEDPROPSACTIONS = {
			DISENGAGE = COMMON[215],
			FILL_WATERBALLOON = {
				WAITFORMODEL = none,
				WBALLOON_FILL = none,
				SETUSAGESTATE = none,
			},
			DRINK = {
				DRINKSHORT = {
					FOUNTAINOFF = none,
				},
			},
			PEDDRINKSYNC = {
				PEDDRINK = {
					DRINKSHORTPED = {
						RELEASEPROP = none,
					},
				},
			},
		},
		USEABLE = none,
	},
	NPCFACIAL = {
		FACIAL = {
			HAPPY = COMMON[628],
			INTIMIDATED_SCARED = COMMON[629],
			ANGRY = COMMON[632],
			KICKMESTIMULUS = {
				KICKMECREATE = none,
			},
			ATTACKED = {
				ATTACKFACE = none,
			},
			VSCARED = COMMON[629],
			NEUTRAL = COMMON[630],
			SURPRISE = COMMON[631],
			ANNOYED = COMMON[632],
		},
	},
	["4_G4"] = {
		ANIMATIONS = {
			WANKER = none,
			SETUPPOSTER = {
				PLACEIT = none,
			},
			GENKISSING = COMMON[111],
			DRINK = {
				DRINK_CHILD = none,
			},
			GENREACTIONS = {
				REACTIONLOOPS = {
					DISMISS = none,
					QUESTION = none,
					LAUGH = none,
					AGREE = none,
					DISAGREE = none,
				},
			},
			GENSTANDTALKING = COMMON[389],
		},
		["4_G4_HELLO"] = none,
		["4_G4_MANDYINTRO"] = {
			["4_G4_MANDYINTRO_01"] = {
				["4_G4_MANDYINTRO_02"] = {
					["4_G4_MANDYINTRO_03"] = {
						["4_G4_MANDYINTRO_04"] = {
							["4_G4_MANDYINTRO_05"] = {
								["4_G4_MANDYINTRO_06"] = {
									["4_G4_MANDYINTRO_07"] = {
										["4_G4_MANDYINTRO_07"] = COMMON[95],
									},
								},
							},
						},
					},
				},
			},
		},
		SHORTIDLE = none,
		["4_G4_WHERE"] = none,
		SCREAM = none,
		COWER = none,
		["4_G4_LAUNCH"] = none,
	},
	["1_01AGGRO"] = {
		["1_01AGGRO_CHILD"] = COMMON[633],
	},
	DODGEBALLGAME = {
		GAME3 = {
			GAME3_CHILD = {
				GAME3_CHILD_CHILD = {
					GAME3_CHILD_CHILD_CHILD = COMMON[1190],
				},
			},
		},
		ANIMS = {
			DEJECTED = {
				LOADANIMSTEMP = {
					DEJECTIONS = {
						DEJECTION6 = none,
						DEJECTION5 = none,
						DEJECTION3 = none,
						DEJECTION2 = none,
						DEJECTION4 = none,
						DEJECTION1 = none,
					},
				},
			},
			BANK = {
				REAC_COMEON = none,
				NERDS_RUBHEAD_A = none,
				FAT_SMELLARMPIT_A_01 = none,
				AMBIENT6 = none,
				BURTON_DODGE_007 = none,
				STINK_REACT = none,
				HARAS_WHAT = none,
				DB_ALG_IDLE = none,
				PREP_WIPE_SLEEVES_B = none,
				AMBIENT3 = none,
				AMBIENT2 = none,
				AMBIENT4 = none,
				IDLE = none,
				DB_BURTON_AMBIENT_1 = none,
				AMBIENT7 = none,
				PREP_TIME_CHECK_2 = none,
				BURTON_DODGE_011 = none,
				DOUT_IDLE_E_01 = none,
				JOCK_HAMSTRINGS_A = none,
				NERDS_SCRATCHARSE_A = none,
				GRES_IDLE_B = none,
				AMBIENT5 = none,
				FAT_LOOKSIDES_A_01 = none,
				JOCK_IDLE_E = none,
				JOCK_STRETCH_B = none,
				PREP_IDLE = none,
				FAT_LOOKPANIC_B_01 = none,
				GRES_FISTPALM_A = none,
				JOCK_SMELLPITS_A = none,
				REAC_BRING_IT = none,
				FAT_PICKNOSE_A_01 = none,
				NERDS_IDLE_D = none,
				DONTMESS = none,
				IDLE_MELVIN = none,
				GRES_FIXHAIR_D = none,
				DOUT_IDLE_G_01 = none,
				PREP_PREP_IDLE_A = none,
				DB_BURTON_AMBIENT_3 = none,
				NERDS_SMELLPIT_A = none,
				AMB_WEIGHTSHIFT = none,
				DOUT_IDLE_I_01 = none,
				HARAS_FORGET = none,
				GRES_LOOSENUP_A = none,
				DOUT_IDLE_B_01 = none,
			},
			CELEBRATEC = {
				CELEBRATE3 = none,
				CELEBRATE2 = none,
			},
			CELEBRATED = COMMON[1191],
			CELEBRATEB = COMMON[1191],
			UNLOCK = {
				CHARGE = {
					RELEASE = COMMON[39],
					CHARGE_HOLD = none,
				},
			},
			DEJECTEDC = COMMON[567],
			CELEBRATEA = {
				CELEBRATE1 = none,
				CELEBRATE2 = none,
			},
			CELEBRATE = {
				LOADANIMSTEMP = {
					CELEBRATIONS = {
						CELEBRATION5 = none,
						CELEBRATION6 = none,
						CELEBRATION3 = none,
						CELEBRATION1 = none,
						CELEBRATION4 = none,
						CELEBRATION2 = none,
					},
				},
			},
			COACH = {
				COACHWHISTLE = none,
			},
			DEJECTEDA = COMMON[567],
			DEJECTEDD = COMMON[567],
			DEJECTEDB = COMMON[567],
		},
		GAME2 = {
			GAME2_CHILD = {
				GAME2_CHILD_CHILD = COMMON[1190],
			},
		},
		GAME4 = {
			GAME4_CHILD = COMMON[1190],
		},
		FIRSTGAME = {
			FG02 = {
				FG03 = {
					FG04 = {
						FG05 = {
							FG06 = {
								FG07 = {
									FG08 = {
										FG09 = {
											FG10 = COMMON[1190],
										},
									},
								},
							},
						},
					},
				},
			},
		},
		GAME5 = {
			GAME5_CHILD = COMMON[1190],
		},
	},
	PLAYER = {
		SOCIAL_COMBAT = {
			CAMERA = {
				SOCIAL_COMBAT_O = {
					SHOVETAUNT = none,
				},
				SOCIAL_COMBAT_X = {
					GREET = none,
				},
			},
			MASCOTDANCE = COMMON[1192],
			SOCIAL_COMBAT_O = {
				HUMILIATE = none,
				SHOVETAUNT = none,
			},
			SOCIAL_COMBAT_X = {
				APOLOGIZE = none,
				MASCOT = none,
			},
			LOCO = {
				LOCO = {
					COMBATSTRAFE = {
						STRAFELOCOBASICANIMS = none,
					},
					COMBATIDLE = none,
				},
			},
		},
		BED = {
			EXEC = {
				WIDESCREEN = none,
				NORMAL = none,
				FADEIN = none,
				FLAGSANDLUA = none,
				RELEASEPROP = none,
			},
			GETOUTBED = {
				GETOUTBED = none,
			},
		},
		DEFAULT_KEY = {
			FULLBODYACTIONOPPS = none,
			DEFAULT = none,
			LOCOMOTION = COMMON[481],
			SOCIALEXECUTE = none,
		},
		SOCIAL_ACTIONS = {
			GIVE = {
				USEOVERRIDE = COMMON[1193],
				SHAREDGIVE = {
					GIVE_ATTEMPT = {
						GIVE_SEEK = COMMON[876],
						RECEIVE = none,
						GIVE = none,
						RECEIVEWAIT = none,
					},
				},
				CHOCOLATES = COMMON[1194],
				EMPTYGIVE = none,
				MONEY = COMMON[1194],
				FLOWER = COMMON[1194],
			},
			HARASSMOVES = {
				USEOVERRIDE = COMMON[1193],
				HUMILIATIONS = {
					HUMILIATE_INIT = {
						ATTEMPT = none,
						COLLISIONPEDFLAGS = none,
						HUMILIATEFLEE = COMMON[367],
						HUMILIATE_ME = {
							FAIL = {
								FAIL = none,
								FAIL_PLAYER = none,
							},
							["4-10_NOSE"] = COMMON[1196],
							["5-8_INDIANBURN"] = COMMON[1196],
							["5-8_PEE"] = COMMON[1196],
							["4-10_TRIP"] = {
								SUCCESS = {
									GV = COMMON[95],
									RCV = {
										WALL_HIT = none,
										RCV_PT2 = COMMON[1198],
									},
									LOAD = none,
								},
							},
							["5-8_NOOGIESPIT"] = COMMON[1196],
							["6-5_TRIP"] = {
								SUCCESS = {
									GV = COMMON[95],
									RCV = {
										END = COMMON[1198],
									},
									LOAD = none,
								},
							},
							["6-5_HANDCRUSH"] = COMMON[1196],
							DEBUGFAIL = none,
							["6-1_DEADARM"] = COMMON[1196],
							["6-1_EARGRAB"] = COMMON[1196],
							["6-5_DEADLEG"] = COMMON[1196],
							["6-1_SLAP"] = COMMON[1196],
							["5-8_WEDG"] = COMMON[1196],
							["5-8_HITSELF"] = COMMON[1196],
						},
						HUMILIATESPEECH = COMMON[283],
						ABORT = {
							TARGET_ABORT = none,
						},
						LOADWAIT = {
							ACTION3 = COMMON[1200],
							ACTION4 = COMMON[1200],
							ACTION1 = {
								WAIT = none,
								VICTIM = {
									COMBAT = none,
									PLAYER = none,
									VICTIM2 = none,
								},
							},
							UBO_CHECKS = {
								UBO_CHECKS = none,
							},
							LOADSPAWN = none,
							ACTION2 = COMMON[1200],
						},
						WAITFORVICTIM = {
							SEEKENTITY = {
								FACETARGET = none,
							},
							RCV = COMMON[95],
							EMERGENCYANIM = COMMON[95],
						},
					},
					USEOVERRIDE = COMMON[1193],
				},
				TAUNT_ONGROUND = none,
				WEDGIE = {
					ATTEMPT = {
						WEDGIERECEIVE = {
							SETHEALTH = none,
						},
						WEDGIEATTACK = {
							WEDGIEATTACKCOMPLETE = none,
						},
					},
				},
				SHOVE_STILL = {
					SHOVE = {
						SMASHINNAFACESTINK = {
							GRAPPLES = {
								PULL_IN_HEAVY = {
									HELD = none,
									HOLD = none,
									EXECUTENODES = COMMON[143],
								},
							},
						},
						SMASHINNAFACE = {
							GRAPPLES = {
								PULL_IN_HEAVY = {
									HELD = none,
									HOLD = none,
									EXECUTENODES = {
										ATTACHEDEFFECT = COMMON[1201],
										IMPACTSFX = COMMON[1201],
									},
								},
							},
						},
					},
				},
				PINCHBUM = {
					BUTTPINCH = {
						GRAPPLESUCCESS = {
							GIVE = {
								BUTTPINCHCOMPLETE = none,
							},
							RCV = none,
						},
						BUTTPINCHSICK = {
							BUTTPINCHSICKNODE = none,
						},
					},
				},
			},
			POSITIVEREACTION = {
				ACCEPTSCENARIO = {
					SURETHING = none,
				},
				LAUGH = {
					JOININTEASING = none,
				},
				APOLOGY = {
					USEOVERRIDE = COMMON[1193],
					BEG = COMMON[1202],
					ENGLISH1 = COMMON[1202],
				},
				OFFERASSISTANCE = {
					HELP = none,
				},
				FLIRT = {
					USEOVERRIDE = COMMON[1193],
					GREETSTAGE2 = COMMON[1203],
					DISMISSIVETARGET = {
						NOTWORTHTHEBOTHER = none,
					},
					GREET = COMMON[566],
				},
				MASCOTDANCE = COMMON[1192],
				GREET = {
					GREET = {
						WAVE01 = none,
						WAVE03 = none,
						WAVE02 = none,
					},
					SHOULDERTAP = {
						SHOULDERTAP = {
							SOCIALIZING = none,
						},
					},
					GREETSTAGE2 = COMMON[1203],
					DISMISSIVETARGET = {
						WAVEWANDER = none,
					},
					USEOVERRIDE = COMMON[1193],
				},
			},
			SPECIAL = {
				MASCOTDANCE = COMMON[1192],
			},
			MAKEOUT = {
				MAKEOUT = {
					USEOVERRIDE = COMMON[1193],
					GRAPPLEATTEMPT = {
						GRAPPLESUCCESS = {
							WAITFORPLAYER = none,
							LOADANIMS = COMMON[1204],
							WAITFORPLAYERMOVING = none,
							TARGETTYPE = {
								TARGETMOVING = none,
								TARGETSTATIONARY = none,
							},
						},
						TARGETTYPE = {
							TARGETMOVING = none,
							TARGETSATIONARY = none,
						},
						KISSES = {
							DISMISS = COMMON[1205],
							KISS1 = {
								KISS_RCV = {
									ANIM = COMMON[1206],
									MOTIONCONTROLLER = COMMON[1207],
								},
								KISS_GIVE = none,
							},
							KISSB2A = COMMON[1208],
							KISS3 = COMMON[1208],
							UPPERBODYOVERRIDES = COMMON[1209],
							KISSDROP = none,
							KISSB2B = COMMON[1208],
							KISS2 = COMMON[1208],
							KISSF = COMMON[1210],
							HEALTHINCREMENT = COMMON[1211],
							KISS4 = COMMON[1208],
							KISSB3A = COMMON[1208],
							KISSB3B = COMMON[1208],
						},
					},
				},
			},
			NEGATIVEREACTION = {
				USEOVERRIDE = COMMON[1193],
				BURN = {
					FUCKYOU4 = none,
					FUCKYOU3 = none,
					FUCKYOU = COMMON[1212],
					FUCKYOU2 = none,
					STIMBANK = {
						BURNSTIM = {
							BURNSTIM = none,
							TAUNTSTIMCOMBAT = none,
						},
					},
				},
				NOANIM = none,
				TAUNTS = {
					FUCKYOU4 = none,
					FUCKYOU3 = none,
					FUCKYOU = COMMON[1212],
					FUCKYOU2 = none,
				},
				VICTORY_TAUNT = {
					VICTORY_TAUNT = none,
				},
			},
		},
		JUMPACTIONS = COMMON[232],
		ATTACKS = {
			EXECUTENODES = COMMON[221],
			GRAPPLES = {
				GRAPPLES = {
					GRAPPLEATTEMPT = {
						CHECK_DESELECT = none,
						GRAPPLEATTEMPT = none,
					},
					RUNNINGTAKEDOWN = {
						CHECK_DESELECT = none,
						RUNNINGTAKEDOWN = none,
					},
				},
			},
			GROUNDATTACKS = {
				GROUNDATTACKS = COMMON[222],
				BALLGROUNDATTACKS = COMMON[223],
				PROPATTACKS = {
					GROUNDKICK = none,
				},
			},
			STRIKES = {
				RUNNINGATTACKS = COMMON[224],
				LIGHTATTACKS = {
					SHOVE = none,
					EXECUTEBANK = COMMON[225],
					CHECK_DESELECT = none,
					LEFT1 = {
						RELEASE = COMMON[226],
						RIGHT2 = {
							RELEASE = COMMON[227],
							LEFT3 = {
								RELEASE = COMMON[228],
								RIGHT4 = {
									RELEASE = COMMON[229],
									LEFT5 = {
										RELEASE = {
											UNBLOCKABLE = {
												PUNCH_CHARGE_5 = none,
											},
											HEAVYATTACKS = COMMON[1221],
											UPPERCUT = COMMON[1222],
										},
									},
								},
							},
						},
					},
				},
			},
		},
		GIFTS = {
			CAMERAS = {
				CAMFAIL = none,
				CAMERA1 = none,
				CAMERA4 = none,
				CAMERA3 = none,
				CAMERA2 = none,
			},
			ERRAND_BUS_JACKET = COMMON[1223],
			WEAPONREMOVAL = COMMON[956],
			ERRAND_BUS_PHOTOCASH = COMMON[1223],
			ERRAND_SCH_TUTORIAL2 = COMMON[1223],
			ERRAND_SCH_TUTORIAL = {
				GIVEATTEMPT = COMMON[486],
			},
			ERRAND_SCH_ADMIRE2 = COMMON[1223],
			ERRAND_RIC_CRAB = COMMON[1223],
			GIVEFLOWERS = {
				GIVE = COMMON[195],
				GIVE_ATTEMPT = COMMON[196],
				EXECUTES = {
					SPEECH = {
						RECEIVE = COMMON[214],
						GIVE = none,
						SEEK = none,
						RECEIVEWAIT = none,
					},
					MODELS = COMMON[198],
					ANIMS = COMMON[197],
				},
			},
			ERRAND_IND_PACKAGE = COMMON[1223],
			ERRAND_BUS_DETECTIVE = COMMON[1223],
			GIVEMONEY = {
				GIVE = {
					GIVE = {
						GIVE_SEQUENCE = COMMON[1225],
					},
					RECEIVE = {
						RCV_SEQUENCE = COMMON[1225],
					},
				},
				GIVE_ATTEMPT = COMMON[196],
				EXECUTES = {
					SPEECH = {
						RECEIVE = {
							RECEIVE = {
								["1_02B"] = COMMON[787],
								BULLY = COMMON[787],
								PED = COMMON[787],
							},
						},
						GIVE = none,
						SEEK = {
							PLAYER = none,
							PLAYEREXTORTED = none,
							PLAYEREXTORTED_PREENG = none,
						},
						RECEIVEWAIT = none,
					},
					MODELS = COMMON[198],
					ANIMS = COMMON[197],
				},
			},
			ERRAND_RIC_MAILMAN = COMMON[1223],
			ERRAND_IND_PACKMON = COMMON[1223],
			ERRAND_BUS_DRUGS = COMMON[1223],
			ERRAND_RIC_LOSTBEAR = {
				GIVE_ATTEMPT = COMMON[375],
				GIVEPT2 = COMMON[48],
				GIVE = COMMON[374],
				EXECUTES = {
					SPEECH = COMMON[376],
					MODELS = COMMON[198],
					ANIMS = COMMON[197],
				},
			},
			ERRAND_IND_PACKGET = COMMON[1223],
			ERRAND_SCH_ADMIRE1 = COMMON[1223],
			GETMONEY = {
				GIVE = COMMON[195],
				GIVE_ATTEMPT = COMMON[196],
				EXECUTES = {
					SPEECH = {
						RECEIVE = none,
						GIVE = none,
						SEEK = none,
						RECEIVEWAIT = {
							ALGIE_1_05 = none,
						},
					},
					MODELS = COMMON[198],
					ANIMS = COMMON[197],
				},
			},
			AMBIENTGIFT_FAIL = {
				FAIL = none,
			},
			GIVECHOCOLATES = {
				GIVECHOCOLATEBOX = {
					WAIT = none,
					GIVE_ATTEMPT = {
						GIVE_SEEK = COMMON[869],
						RECEIVE = {
							RECEIVE = {
								GIVE = COMMON[907],
								RECEIVE_SPEECH = COMMON[908],
								CAMERA = none,
							},
						},
						GIVE_ATTEMPT_SPEECH = none,
						RECEIVEWAIT = none,
					},
				},
			},
			LOCOMOTIONSPAWN = {
				LOCOMOTION = {
					SEEKENTITY = none,
					WAIT = none,
				},
			},
		},
		SOCIAL_SPEECH = {
			GREET_SPEECH = {
				ACCEPTSCENARIO = {
					GREET_SCENARIO = none,
				},
				VS_GIRL = {
					GREETDEFAULT = none,
					FLIRTGOOD = none,
					FLIRTPOOR = none,
					FLIRTDEFAULT = none,
				},
				VS_SUPERIOR = {
					GREET_ADULT_FEMALE = none,
					GREET_ADULTMALE = none,
				},
				GREET_DEFAULT = none,
			},
			APOLOGY = {
				ENGLISH5 = {
					VS_GIRL = COMMON[1230],
					APOLOGY_SMOOTH = none,
					APOLOGY_COPS = none,
				},
				BEG = {
					BEG = none,
				},
				STIMBANK = {
					APOLOGYSTIM = {
						APOLOGYSTIM = none,
						APOLOGYSTIMCOMBAT = none,
					},
				},
				ENGLISH1 = {
					VS_GIRL = COMMON[1230],
					APOLOGY_DEFAULT = none,
				},
				ENGLISH3 = {
					VS_AUTHORITY = {
						APOLOGY_GOOD = none,
					},
					APOLOGY_CHILL = none,
					VS_GIRL = COMMON[1230],
				},
			},
			LAUGH = {
				LAUGH_DEFAULT = none,
			},
			HELPOUT_SPEECH = {
				HELPOUT_DEFAULT = none,
			},
			TAUNTS = {
				TAUNT_SPEECH = COMMON[1231],
				TAUNT_SHOVE = {
					SUPERSHOVE = COMMON[1232],
					PREENGLISH2 = none,
				},
				TAUNT_COMBATSHOVE = COMMON[1232],
				STIMBANK = {
					TAUNTSTIM = {
						TAUNTSTIM = none,
						TAUNTSTIMCOMBAT = none,
					},
				},
				TAUNT_DEAD = {
					TAUNT_DEAD = none,
				},
				TAUNTRESPONSE_SPEECH = {
					VS_BITCH = {
						TAUNT_GIRL_01 = none,
					},
					TAUNT_RESPONSE = none,
				},
				TAUNT_COMBAT = COMMON[1232],
				INITIALTAUNT_SPEECH = {
					WHITEKNIGHT = {
						MALEVICTIM = COMMON[1233],
						FEMALEVICTIM = COMMON[1233],
					},
					LAUGHAT = {
						LAUGHAT = none,
					},
					TAUNT_DEFAULT = none,
					VS_BULLY = {
						TAUNT_BULLY_01 = none,
					},
				},
				TAUNT_FLEE = {
					TAUNT_FLEE = none,
				},
				TAUNT_SPEECH_HIGH_ENG = COMMON[1231],
			},
			GIFTGIVE_SPEECH = {
				VS_GIRL = {
					GIFTGIVE_GIRL_01 = none,
				},
				GIFTGIVE_DEFAULT = none,
				VS_BULLY = {
					GIFTGIVE_BULLY_01 = none,
				},
			},
			STATSEXECUTES = {
				TAUNTSTATS = COMMON[1234],
				GREETSTATS = COMMON[1234],
			},
		},
	},
	RUSSELL_102 = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			IDLE = none,
			EXECUTENODES = COMMON[697],
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				MEDIUM = COMMON[139],
				STRIKES = COMMON[695],
			},
			MEDIUM = COMMON[496],
		},
	},
	DTBIKE = {
		START = {
			MODES = {
				SHOP = COMMON[206],
				LEAVE = {
					LEAVESTOREMODE = none,
				},
			},
		},
	},
	GOKART_SR1 = {
		RACE_INTRO = {
			RACE1_2 = {
				RACE1_3 = {
					RACE1_4 = {
						RACE1_5 = {
							INTROGO = none,
						},
					},
				},
			},
		},
		RACE_3 = {
			RACE3_2 = {
				RACE3_3 = {
					RACE3_GO = none,
				},
			},
		},
		RACE_2 = {
			RACE2_2 = {
				RACE2_3 = {
					RACE2_4 = {
						RACE2_GO = none,
					},
				},
			},
		},
		RACE_1 = {
			RACE1_2 = {
				RACE1_3 = {
					RACE1_GO = none,
				},
			},
		},
	},
	HIGHSTRIKER = {
		HAMMERACTIONS = {
			HAMMERLIFTHOLD = {
				HAMMERLIFT = {
					HAMMERHOLD = none,
				},
			},
			END = {
				ENDDROPHAMMER = none,
				END = none,
			},
			HAMMERIDLE = COMMON[30],
			HAMMERSWINGS = {
				STRONG = none,
				WEAK = none,
				MEDIUM = none,
				FAIL = {
					FAILGETUP = none,
				},
				STRONGISH = none,
			},
			START = COMMON[1243],
		},
		IDLE = none,
		HUD = {
			PUSHSTRUGGLEON = none,
			STRUGGLEOFF = none,
		},
	},
	UMBRELLA = {
		FULLBODYACTIONOPPS = none,
		OFFENSE = COMMON[64],
		SOCIALEXECUTE = none,
		LOCOMOTION = {
			ANIMATIONS = {
				WEAPONIDLE = COMMON[1244],
				WEAPONWALK = COMMON[1244],
				WEAPONSOCIAL = COMMON[1244],
				WEAPONSTRAFE = COMMON[1244],
				WEAPONRUN = COMMON[1244],
				WEAPONCROUCH = COMMON[1244],
				BLOCKOPPS = {
					BLOCKPROJECTILES = none,
					BLOCKHITS = {
						BREAKER = none,
						KNOCKDOWN = none,
						HITSLIGHT = none,
						TONORMALHITS = none,
					},
				},
			},
			GLOBALLOCO = COMMON[165],
		},
		ACTIONS = {
			ATTACKS = {
				HEAVYATTACKS = {
					SWING1 = COMMON[508],
				},
			},
			TOGGLE = {
				CLOSE = none,
				COMBATCLOSE = none,
				OPEN = none,
				COMBATOPEN = none,
			},
			EXECUTENODES = {
				CLOSE = none,
				OPEN = none,
			},
		},
		DEFAULT_KEY = none,
	},
	AI_RAT = {
		RATLOCO = none,
		DUMMYIDLE = none,
	},
	FUNHOUSE = {
		GRAVEYARDSTEAMREACTION = COMMON[215],
		JOCKGETREADY = {
			IDLE = none,
			DOUBLETHREATIN = {
				DOUBLETHREATLOOP = {
					DOUBLETHREATOUT = {
						DONE = COMMON[215],
					},
				},
			},
		},
		GRAVEYARDCHEER = {
			RELEASECHEER = COMMON[215],
			CHEER3 = none,
			CHEER1 = none,
			CHEER2 = none,
		},
		STEAMREACTION = COMMON[215],
		JOCKCROUCH = {
			CROUCHIDLE = {
				CROUCHEND = COMMON[215],
			},
		},
		STARTLEREACTION = COMMON[215],
		MAZEDOORCLOSE = {
			SHAKEFIST = {
				RELEASEANIM = COMMON[215],
			},
			IDLE = none,
		},
		SCRATCHHEADIDLE = {
			IDLE = none,
			HANDTOHEAD = {
				SCRATCHHEAD = {
					LOOP = none,
					RELEASEGROUP = COMMON[215],
				},
			},
		},
	},
	["2_07"] = {
		CELEBRATETROPHY = {
			REMOVETROPHY = none,
		},
		EMPTY = none,
		JUSTINHURT = {
			FALL_OVER = none,
			SHAKE_HEAD_GROUND = none,
		},
		OTHERGUYCOWERS = COMMON[1053],
		GORDRUNTAUNT = {
			CHEER = none,
		},
		HITHARDFRONT = COMMON[317],
		WIN = none,
		PUSHPLAYER = {
			GRAPPLESUCCESS = {
				GRAPPLERCVWAIT = none,
				YAY = {
					ATTACKIDLE = none,
					HITREACTION = COMMON[343],
				},
			},
			PUSHPLAYER_CHILD = none,
		},
		GORDTAUNT = {
			POSH03 = none,
			POSH01 = none,
			POSH04 = none,
			POSH05 = none,
			POSH02 = none,
			STEPS = {
				SEQUENCE = none,
			},
		},
		DUCK = none,
	},
	RUSSELAI = {
		COMBAT = COMMON[239],
		GENERALOBJECTIVES = COMMON[97],
		REACTIONS = COMMON[145],
		COMBATACTIONS = {
			CONTROLNODE = none,
			COMBATACTIONS = {
				EVADE = COMMON[1],
				PURSUITATTACK = COMMON[624],
				GROUNDATTACK = COMMON[148],
				TAUNT = COMMON[149],
				BLOCK = COMMON[746],
				OFFENSE = {
					RUNNINGATTACKS = COMMON[947],
					MELEEACTIONS = {
						LONG = COMMON[155],
						MEDIUM = COMMON[156],
						SPECIAL = {
							RUSSELL = none,
						},
						SHORT = COMMON[107],
					},
				},
				POSTHIT = {
					HIT = {
						HIT = none,
						PROJECTILEHIT = COMMON[157],
					},
					INCAPACITATED = COMMON[241],
					STUNNED = COMMON[1250],
					GRAPPLED = COMMON[242],
				},
				COUNTERATTACK = COMMON[101],
				STUNNED = COMMON[1250],
				CHARGE_COUNTERATTACK = COMMON[101],
			},
		},
		AMBIENT = COMMON[102],
	},
	["2_G2"] = {
		JIMMYWAITS = none,
		["2_G2_START"] = none,
		["2_G2_ANIMS"] = {
			EMPTY = none,
			CHATTER = COMMON[1040],
			COASTER = {
				COASTER_MIDDLE = COMMON[1252],
				COASTER_REAR = COMMON[1252],
				MIDDLEOUT = none,
				REAROUT = none,
				GRAVITYBACKON = none,
			},
			PINKYCHEERRANDOM = {
				PINKYCHEER03 = none,
				PINKYCHEER02 = none,
				PINKYCHEER01 = none,
			},
			PINKYBOORANDOM = {
				PINKYBOO01 = none,
				PINKYBOO03 = none,
				PINKYBOO02 = none,
			},
			CELEBRATE = none,
			GIRLLAUGH = none,
			WAVE = none,
		},
		["2_G2_INTRO"] = {
			PINKY = {
				PLAYER = {
					PINKY = {
						PLAYER = COMMON[550],
					},
				},
			},
		},
	},
	["1_03_DAVIS"] = {
		DEFENSE = none,
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = {
				FREE = {
					DEFAULT_WALKOVERRIDES = COMMON[1142],
					RUNBASIC = none,
					IDLE_OVERRIDES = COMMON[1172],
					WALKBASIC = COMMON[1173],
					SPRINTBASIC = none,
				},
				LOCOMOTIONOVERRIDE = COMMON[426],
				CUSTOMACTIONOPS = COMMON[27],
			},
			IDLE = none,
			RISINGATTACKS = none,
		},
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLES = COMMON[4],
				STRIKES = {
					LIGHTATTACKS = COMMON[1019],
					HEAVYATTACKS = {
						SWINGPUNCH = COMMON[1020],
						GUTKICK = {
							GUTKICK_R = none,
						},
					},
				},
			},
			MEDIUM = COMMON[396],
		},
	},
	HMB_2_R03 = {
		EXECUTE = {
			IDLEBYPEDTYPE = COMMON[447],
		},
		CATCHPAPER = {
			CATCHSUCCESS = {
				AFTERCATCHSUCCESS = COMMON[852],
			},
		},
		IDLE = none,
	},
	MGCHEM = {
		ANIMATIONS = {
			SUCCESS2 = none,
			SUCCESS = none,
			FAILURE = COMMON[373],
		},
		GARYANIMS = COMMON[1256],
		TEACHER = {
			BOTH = {
				LEFTRIGHT = none,
				RIGHTLEFT = none,
			},
			TEACHER_SCOLD = {
				SCOLD_P1 = {
					SCOLD_P1 = none,
					SCOLD_P1_END = none,
					SCOLD_P1_LOOP = none,
				},
				SCOLD_P2 = {
					SCOLD_P2 = none,
					SCOLD_P2_LOOP = none,
					SCOLD_P2_END = none,
				},
			},
			RIGHT = COMMON[1257],
			TEACHER_IDLE = {
				TEACHER_IDLE = none,
			},
			LEFT = COMMON[1257],
		},
		GO = none,
		JIMMYANIMS = COMMON[1256],
	},
	["5_09"] = {
		["5_09_CITYHALL_CUT"] = {
			["5_09_CITYHALL_CUT_CHILD"] = {
				ANIM2A = none,
				ANIM2 = none,
				ANIM3 = none,
				ANIM1A = none,
				ANIM1 = none,
				ANIM3A = none,
			},
			EXECUTES = COMMON[283],
		},
		ANIMS = {
			PETESIT = none,
		},
		DOG = {
			GETUP = none,
			CHEWING = none,
			BARK2 = none,
			BARK = COMMON[1022],
			SLEEP = none,
		},
		["5_09_BIKERETURNCUT"] = {
			["5_09_DROP_06"] = {
				["5_09_DROP_07"] = {
					["5_09_DROP_08"] = {
						["5_09_DROP_09"] = {
							["5_09_DROP_10"] = {
								["5_09_DROP_11"] = {
									["5_09_DROP_12"] = COMMON[868],
								},
							},
						},
					},
				},
			},
		},
		["5_09_INTRODUCTION"] = {
			["5_09_INTRO_01"] = {
				["5_09_INTRO_02"] = {
					["5_09_INTRO_03"] = {
						["5_09_INTRO_04"] = {
							["5_09_INTRO_05"] = {
								["5_09_INTRO_06"] = {
									["5_09_INTRO_07"] = COMMON[868],
								},
							},
						},
					},
				},
			},
		},
	},
	MISSIONBANK = {
		CHAPTER4 = {
			["3_R09_J3"] = COMMON[1264],
			["4_05"] = COMMON[1264],
			["2_S05B"] = COMMON[1264],
			["4_03"] = COMMON[448],
			["4_01"] = COMMON[1264],
			CHAPT4TRANS = COMMON[1264],
			["4_B2"] = COMMON[1264],
			["4_S12"] = COMMON[1264],
			["4_06"] = COMMON[448],
			["4_G4"] = COMMON[1264],
			["4_04"] = COMMON[448],
			["4_02"] = COMMON[448],
			["3_S11"] = COMMON[448],
			["4_B1"] = COMMON[1264],
		},
		CHAPTER3 = {
			["3_R09_N"] = COMMON[1264],
			["3_08_POSTDUMMY"] = COMMON[1264],
			["3_XM"] = COMMON[1264],
			["3_S10"] = COMMON[1264],
			["3_04"] = COMMON[1264],
			["3_05"] = COMMON[1264],
			["3_01C"] = COMMON[1264],
			["3_B"] = COMMON[1264],
			["3_08"] = COMMON[1264],
			CHAPT3TRANS = COMMON[1264],
			["3_01A"] = COMMON[1264],
			["2_S02"] = COMMON[1264],
			["3_G3"] = COMMON[1264],
			["3_R09_G3"] = COMMON[1264],
			["3_08_LAUNCH"] = COMMON[1264],
			["2_S05"] = COMMON[1264],
			["3_R05B"] = COMMON[1264],
			["3_01D"] = COMMON[1264],
			["3_01"] = COMMON[1264],
			["3_02"] = {
				ACTIVE = COMMON[451],
			},
			["3_06"] = COMMON[1264],
		},
		CHAPTER5 = {
			["5_03"] = COMMON[1264],
			["5_06"] = COMMON[1264],
			["6_PASSALL"] = COMMON[1264],
			["6_DUMMY"] = COMMON[1264],
			["5_G5"] = COMMON[1264],
			["5_04"] = COMMON[1264],
			["3_R07"] = COMMON[1264],
			["5_07A"] = COMMON[1264],
			["6_B"] = COMMON[1264],
			["5_05"] = COMMON[1267],
			["6_02"] = COMMON[1264],
			["6_01"] = COMMON[1264],
			["3_S03"] = COMMON[1264],
			["5_01"] = COMMON[1264],
			["3_S08"] = COMMON[1264],
			["5_09"] = COMMON[1264],
			["5_02"] = COMMON[1264],
			["6_01_LAUNCH"] = COMMON[1264],
			["6_03"] = COMMON[1264],
			["5_B"] = COMMON[1264],
			["3_R09_D3"] = COMMON[1264],
		},
		MINIGAMES = {
			MG_SOCCERPENALTY = {
				SOCCERPEN = COMMON[1264],
			},
			BMXRUMBLE = COMMON[448],
			CARNIVALGAMES = {
				MGSHOOTING = COMMON[448],
				MGCARNISTRIKER = COMMON[1264],
				MGBASEBALLTOSS = COMMON[1264],
				MGDUNKTANK = COMMON[448],
			},
			ARCADEMINIGAMES = {
				AG_SO = COMMON[448],
				MGFLING = COMMON[448],
				TRAINASUMO = COMMON[448],
				MISSILECOMMAND = COMMON[448],
				ARCADERACE3D = COMMON[448],
				MGNUCLEARRAIN = COMMON[448],
				MGGANDG = COMMON[448],
				ARCADERACE = COMMON[448],
				MGSMASH = COMMON[448],
				MGFEND = COMMON[448],
				ARCADEGAME = COMMON[448],
				LUNARLANDER = COMMON[448],
			},
			MGHACKYSACK = COMMON[448],
			["2PLAYER"] = {
				MGBIOLOGY2P = COMMON[448],
				MGLAWNMOWING2P = COMMON[448],
				MGSHOOTING2P = COMMON[448],
				MGART2P = COMMON[1264],
				MGGEOGRAPHY2P = COMMON[448],
				MGMUSIC2P = {
					ACTIVE = {
						RUN = {
							SUCCEED = none,
						},
					},
				},
				MGCHEM2P = COMMON[1264],
				MGENGLISH2P = COMMON[448],
				MGSUMO2P = COMMON[448],
				MGMATH2P = COMMON[448],
				MGPHOTOGRAPHY2P = COMMON[448],
				MGNUTSHOTS2P = COMMON[448],
			},
			ARCADERACE = {
				ARCADERACE3D = COMMON[448],
				ARCADERACE = COMMON[448],
			},
			GOKARTMISSIONS = {
				GOKARTSTREET = {
					GOKART_SR2 = COMMON[1264],
					GOKART_SR1 = COMMON[1264],
					GOKART_SR3 = COMMON[1264],
				},
				GOKARTCIRCUIT = {
					GOKART_GP4 = COMMON[1264],
					GOKART_GP2 = COMMON[1264],
					GOKART_GP5 = COMMON[1264],
					GOKART_GP1 = COMMON[1264],
					GOKART_GP3 = COMMON[1264],
				},
			},
			LOCKPICK = COMMON[1264],
			CARNIVALRIDES = {
				COASTER = COMMON[1264],
				FERRISWHEEL = COMMON[1264],
				SQUID = COMMON[1264],
			},
		},
		DUMMY = COMMON[1264],
		DEBUG = {
			TESTFIGHTS = {
				GRAPTESTDIRTOSS = COMMON[1264],
				FFT09 = COMMON[1264],
				FFT05 = COMMON[1264],
				FFT10 = COMMON[1264],
				FFT07 = COMMON[1264],
				FFT06 = COMMON[1264],
				GRAPTESTUNLOCK = COMMON[1264],
				FFT08 = COMMON[1264],
				PFT01 = COMMON[1264],
				TESTREMEMBER = COMMON[1264],
				TESTCOVER = COMMON[1264],
				FFT02 = COMMON[1264],
				FFT01 = COMMON[1264],
				FFT04 = COMMON[1264],
				GRAPTEST = COMMON[1264],
				FFT03 = COMMON[1264],
			},
			TESTCOMBATAI = COMMON[1264],
			GAMEPLAYTESTMISSIONS = {
				TESTPEDPICKUP = COMMON[1264],
				TGIRLKISS = COMMON[1264],
				SOCIALAUTHORITYTEST = COMMON[1264],
				TCHARIDLES = COMMON[1264],
				TESTBMXTRACK = COMMON[1264],
				TESTWALKABLEMESH = COMMON[1264],
				SNOWBALL = COMMON[1264],
				POKERPATH = COMMON[1264],
				TESTTRAINCAR = COMMON[1264],
				GRAFFITITEST = COMMON[1264],
				TCLIMBLADDER = COMMON[1264],
				TESTAMBIENTFOOTBALL = COMMON[1264],
				TEST_4_02 = COMMON[1264],
				TBLOCK = COMMON[1264],
				SWIMRACE_TEST = COMMON[1264],
				TESTZONE = COMMON[1264],
				TPUNISH = COMMON[1264],
				TESTPROJDETECTION = COMMON[1264],
				TESTCARFOLLOWPATH = COMMON[1264],
				TESTJENSCHOOLINTERIOR = COMMON[1264],
				TFOLLOWPATH = COMMON[1264],
				T3WAYS = COMMON[1264],
				TESTCORYCARLOT = COMMON[1264],
				SHOTS = COMMON[1264],
				FRAFFY = COMMON[1264],
				TESTPROJACC = COMMON[1264],
				TESTAMBIENT = COMMON[1264],
				KISSYKISSYREFCOUNTTEST = COMMON[1264],
				["3_B_TEST"] = COMMON[1264],
				TESTPLATFORM = COMMON[1264],
				NORTONTEST = COMMON[1264],
				TESTRAT = COMMON[1264],
				TESTNEWTARGET = COMMON[1264],
				TESTBIKEAI = COMMON[1264],
				TESTSPUDCANNON = COMMON[1264],
				PEDUSELOCKER = COMMON[1264],
				TESTBIKES = COMMON[1264],
				TESTCONVERSATION = COMMON[1264],
				CLAKE_PICKUP_TEST = COMMON[1264],
				RANGEDPROPTEST = COMMON[1264],
				GUARD1 = COMMON[1264],
				PICKUP = COMMON[1264],
				TESTNPCPROJ = COMMON[1264],
				TESTSAFECUT = COMMON[1264],
				TTARGETSWITCH = COMMON[1264],
				TESTMOVE = COMMON[1264],
				TESTPATHFINDING = COMMON[1264],
				NEW = COMMON[1264],
				TESTBIKEUPHILL = COMMON[1264],
				TESTSOCCERBALL = COMMON[1264],
				TESTSIT = COMMON[1264],
				TESTENTERCAR = COMMON[1264],
				TESTPEDTRAN = COMMON[1264],
				TESTFIGHT = COMMON[1264],
				TFIGHT03 = COMMON[1264],
				TESTKISS = COMMON[1264],
				PICKUP_TEST = COMMON[1264],
				TESTREVEALPLAYERROOM = COMMON[1264],
				TESTJUMP = COMMON[1264],
				TESTJENSCHOOLEXTERIOR = COMMON[1264],
				TESTRUMBLERANGED = COMMON[1264],
				TESTPEDFALL = COMMON[1264],
				TPUNISHMENTHACK = COMMON[1264],
				TESTFORCERUN2 = {
					FORCESTARTMISSION = none,
					ACTIVE = none,
					TRIGGERMISSION = none,
				},
				TESTALLY = COMMON[1264],
				DODGEBALLWAI = COMMON[1264],
				TESTPHOTOGLASS = COMMON[1264],
				TESTMISSIONLOG = COMMON[1264],
				SOCIALTEST = COMMON[1264],
				TESTDOG = COMMON[1264],
				TESTFULLNELSON = COMMON[1264],
				HANGTEST = COMMON[1264],
				BIKEPATTERN = COMMON[1264],
				TPROJAI = COMMON[1264],
				TENGLISH = COMMON[1264],
				TESTSOAK01 = COMMON[1264],
				TESTSTEALTH = COMMON[1264],
				TETHER1 = COMMON[1264],
				TESTVEHICLEAI = COMMON[1264],
				AVOIDANCETEST = COMMON[1264],
				TFIGHT02 = COMMON[1264],
				CUTSCENETEST = COMMON[1264],
				TESTSTUDY = COMMON[1264],
				TESTCARDRIVING = COMMON[1264],
				TESTFORCERUN1 = COMMON[448],
				["6_02GDORM"] = COMMON[1264],
			},
		},
		CHAPTER2 = {
			CHAPT2TRANS = COMMON[1264],
			["2_06"] = COMMON[1264],
			["3_R08_SIGNUP"] = {
				["3_R08_RICH6"] = COMMON[1264],
				["3_R08_BUSINESS2"] = COMMON[1264],
				["3_R08_SCHOOL1"] = COMMON[1264],
				["3_R08_BUSINESS3"] = COMMON[1264],
				["3_R08_RICH7"] = COMMON[1264],
				["3_R08_RICH2"] = COMMON[1264],
				["3_R08_RICH1"] = COMMON[1264],
				["3_R08_POOR1"] = COMMON[1264],
				["3_R08_RICH5"] = COMMON[1264],
				["3_R08_POOR2"] = COMMON[1264],
				["3_R08_BUSINESS4"] = COMMON[1264],
				["3_R08_RICH4"] = COMMON[1264],
				["3_R08_RICH3"] = COMMON[1264],
				["3_R08_BUSINESS1"] = COMMON[1264],
			},
			["2_04"] = COMMON[1267],
			["2_01"] = COMMON[1264],
			["3_R09_P3"] = COMMON[1264],
			["2_G2"] = COMMON[1264],
			["2_02"] = COMMON[1264],
			["2_09"] = COMMON[1264],
			["2_B"] = COMMON[1264],
			["2_05"] = COMMON[1264],
			["2_R03_GROUP"] = {
				["2_R03_X"] = COMMON[1264],
				["2_R03"] = COMMON[1264],
			},
			["2_03"] = {
				["2_03_CONDITIONSSAVE"] = none,
				ACTIVE = COMMON[1265],
			},
			["2_08"] = COMMON[1264],
			["2_07"] = COMMON[1264],
			["2_S06"] = COMMON[1264],
			["1_S01"] = COMMON[1264],
			["2_R11"] = {
				["2_R11_JUSTIN"] = COMMON[1264],
				["2_R11_BRYCE"] = COMMON[1264],
				["2_R11_PARKER"] = COMMON[1264],
				["2_R11_RANDOM"] = COMMON[1264],
				["2_R11_CHAD"] = COMMON[1264],
			},
			["2_GN"] = COMMON[1264],
		},
		DOORS = {
			DOORS_CHILD = {
				PREPHOUSE = COMMON[448],
				LIBRARY = COMMON[448],
				JOCKSSAVEZONE = COMMON[448],
				PREPSSAVEZONE = COMMON[448],
				DROPSSAVEZONE = COMMON[448],
				GENERALSTORES = COMMON[448],
				RICHBIKESTORE = COMMON[448],
				GYMDOORS = COMMON[448],
				BUSDOORS = COMMON[448],
				TADGATES = COMMON[448],
				SCHOOLGROUNDDOORS = COMMON[448],
				STORES = COMMON[448],
				NERDSAVEZONE = COMMON[448],
				GREASERSAVEZONE = COMMON[448],
				BMXTRACK = COMMON[448],
				SCHOOLBASEMENT = COMMON[448],
			},
			MISSIONOVERRIDE = {
				["3_01"] = none,
				LIBRARY = none,
				["1_S01"] = none,
				["3_06"] = none,
				["5_02"] = none,
				ACTIVE = none,
				["2_04"] = none,
				["2_G2"] = none,
			},
		},
		TUTORIALS = {
			WEAPONINV = {
				CAMERATUTORIAL = COMMON[1269],
				WEAPON1 = COMMON[1270],
				BIKEPROJECTILES = COMMON[1269],
				DPADDOWN = COMMON[1269],
				SSLING01 = COMMON[1269],
				SKATE02 = COMMON[1269],
				SKATE01 = COMMON[1269],
			},
			AMBIENT = {
				LOOKBACK = COMMON[1270],
				PICKUPX = COMMON[1269],
				CANTSAVEX = COMMON[1269],
				WEAPOVERX = COMMON[1269],
				R1THROW = COMMON[1270],
				HIDING2X = {
					ACTIVE = COMMON[735],
					NOPAPERSXX = none,
				},
				RESPECTX = COMMON[1269],
				OBJXREMX = COMMON[1269],
				HUMILREMX = COMMON[1270],
				PASSEDOUT = COMMON[1270],
				CHECKBOARD = COMMON[1269],
				CLIMBING = COMMON[1270],
				KNOCKEDOUT = {
					ACTIVE = {
						ONMISSIONX = COMMON[735],
					},
				},
				REDVBLUEX = COMMON[1269],
			},
			VEHICLE = {
				GOKARTX = COMMON[1269],
				BIKEPARK4X = COMMON[1272],
				BIKEPARK2X = COMMON[1269],
				BIKEGARAGE1X = COMMON[1270],
				BIKEMOUNTX = COMMON[1270],
				SCOOTERON = COMMON[1269],
				BIKEON = COMMON[1269],
				BIKEGARAGE2X = COMMON[1270],
				BIKESTORAGEX = COMMON[1269],
				BIKETAPX = COMMON[1269],
				BIKEBUYX = COMMON[1269],
				BIKEPARK3X = COMMON[1269],
				BIKEPARK1X = COMMON[1269],
			},
			NIGHTTIMEX = {
				GOTOSLEEPX = COMMON[1269],
				GOBEDX = COMMON[1269],
				NOMISSIONSX = COMMON[1269],
				AFTERHOURS = COMMON[1269],
			},
			HUD = {
				PREPCLUB = COMMON[1269],
				JOCKCLUB = COMMON[1269],
				DPAD1 = COMMON[1270],
				REDSTAR1 = COMMON[1273],
				DPAD2 = COMMON[1270],
				NEEDHEALTH = COMMON[1269],
			},
			BUSTEDX = {
				LOSEWEAPONS = COMMON[1270],
				BUSTPREFNOCLASS = COMMON[1270],
				BUSTCOPS = COMMON[1270],
				BUSTPREFNIGHT = COMMON[1270],
				BUSTPREFCLASS = COMMON[1273],
			},
			SAVEX = {
				SAVETUTORIAL2 = COMMON[448],
			},
			PUNISH = {
				HASPUNISHPTS = {
					NOHELMETX = COMMON[1270],
					TRUANTX = COMMON[1269],
					GIRLVIOLENCEX = COMMON[1269],
					DRESSCODEX = COMMON[1269],
					FIGHTX = COMMON[1270],
					VANDALX = COMMON[1269],
					STEALBIKEX = COMMON[1269],
					FIREALARMX = COMMON[1269],
					BULLYX = COMMON[1269],
					SKIPCLASSX = COMMON[1273],
					TRESPASSX = COMMON[1273],
				},
				CURFEWX = COMMON[1269],
				USEPREFECTSX = COMMON[448],
				WHOAREPREFECTSX = COMMON[1270],
			},
			MISSIONS = {
				["1_02C"] = {
					CLOCKTUTX = COMMON[1270],
					TIMERTUTX = COMMON[1270],
					CLASSSCHEDX = COMMON[1270],
				},
				["1_11"] = {
					GIRLRATS = none,
					VOLCANO = COMMON[1270],
					HALLOWEEN1 = COMMON[1269],
					KICKME = COMMON[1270],
				},
				["1_06"] = {
					TRANSTUTX = COMMON[1269],
				},
				["3_S10"] = {
					TAGREASONX = COMMON[1270],
					TAGGINGTUT2 = none,
					TAGGINGTUT1 = COMMON[1272],
				},
				["1_10"] = {
					CRAWLING1 = {
						ACTIVE = {
							ACTIVE2 = COMMON[735],
							CRAWLING = none,
						},
					},
				},
				["1_02"] = {
					COMBATX = none,
					HUMILIATEX = {
						HUMCLOSEX = none,
						ACTIVE = COMMON[1274],
						HUMGRAPX = none,
					},
					ABOVEBELOWOBJS2 = none,
				},
				["1_04"] = {
					SHOOTING = {
						ACTIVE = {
							EQUIPSS = {
								TARGETW = {
									LASTTUT = COMMON[735],
								},
							},
						},
					},
					REMEMBER = {
						ACTIVE = {
							CLIMBTREE = {
								BRNCHHANG = {
									EQUIPWEAPON = {
										ENTERFIRST = {
											CONTROLS = COMMON[735],
										},
									},
								},
							},
						},
					},
				},
				["2_01"] = {
					BUS01 = COMMON[1269],
				},
				["1_08"] = {
					REDBLIPS = none,
					POST108X = COMMON[1270],
				},
				WRESTLING = {
					WRESTCHANGE = COMMON[1270],
				},
				["1_01"] = {
					MOVE1 = none,
					CHECKOBJS = COMMON[1270],
					GAMESTART = COMMON[1269],
					CHECKMAP = COMMON[1269],
					ABOVEBELOWOBJS = COMMON[1269],
				},
				["1_09"] = {
					SSLING1 = COMMON[1269],
				},
				["1_02B"] = {
					RUSLOCKX = {
						ACTIVE = {
							RUSNOTPICK = {
								RUSPICKLOCK = COMMON[735],
							},
						},
					},
					ALLIESX = none,
					PREFECTX = COMMON[1270],
					HIDINGX = COMMON[1269],
					YELAROW1 = COMMON[1269],
					PUNHIDINGX = COMMON[1270],
					CONSTANTX = {
						DOLNEG = none,
						ACTIVE = COMMON[1271],
						DOLHUM = none,
						POSNEG = none,
						WAIT = none,
						POSHUM = none,
						NOTARGET = none,
						PEACEHUM = none,
						PEACEFIST = none,
						PEACENEG = none,
						DOLFIST = none,
						POSFIST = none,
					},
					INTHEBIN = COMMON[1272],
				},
				["1_05"] = {
					TIMER = COMMON[1269],
				},
				["2_05"] = {
					MANAIMREMX = COMMON[1273],
				},
				["1_03"] = {
					SPRINT1 = COMMON[1273],
					REDX1 = {
						ACTIVE = {
							NOMISSIONX = COMMON[735],
						},
					},
				},
				["2_03"] = {
					AQUASTORE = COMMON[1269],
				},
				["4_G4"] = {
					TAGGINGTUT = {
						ACTIVE = COMMON[735],
						NOTINTRIGGER = COMMON[448],
					},
				},
				JOBS = {
					JOBSAVAILX = COMMON[1273],
				},
				["1_02A"] = {
					SODACAN = COMMON[1270],
				},
				PHOTOGRAPHY = {
					PHOTO2X = {
						ACTIVE = {
							ACTIVE2 = {
								PHNOTARGET = none,
								ACTIVE3 = COMMON[1278],
							},
						},
					},
					PHOTO1X = COMMON[1273],
				},
				ART = {
					ART2X = COMMON[1269],
					ART1X = COMMON[1270],
				},
				POST1_02A = {
					RUNMISS102B = COMMON[1269],
					SAVETUTORIAL = COMMON[1273],
					YELLOWB = COMMON[1273],
				},
			},
			PROPSX2 = {
				PICKLOCKER2 = COMMON[1269],
				EXITTREE2 = COMMON[1269],
			},
		},
		PUNISH = {
			JOB_LAWNMOWING = {
				TIER2 = {
					JOBLAWNMOWING2A = COMMON[1264],
					JOBLAWNMOWING2C = COMMON[1264],
					JOBLAWNMOWING2B = COMMON[1264],
				},
				TIER1 = {
					JOBLAWNMOWING1C = COMMON[1264],
					JOBLAWNMOWING1A = COMMON[1264],
					JOBLAWNMOWING1B = COMMON[1264],
				},
			},
			PUNISH_SNOWSHOVELING = {
				P_SNOW1 = COMMON[1264],
				P_SNOW2 = COMMON[1264],
				P_SNOW3 = COMMON[1264],
				P_SNOW4 = COMMON[1264],
				P_SNOW5 = COMMON[1264],
				P_SNOW6 = COMMON[1264],
			},
			PUNISH_LAWNMOWING = {
				TIER2 = {
					LAWNMOWING2B = COMMON[1264],
					LAWNMOWING2C = COMMON[1264],
					LAWNMOWING2A = COMMON[1264],
				},
				TIER1 = {
					LAWNMOWING1C = COMMON[1264],
					LAWNMOWING1A = COMMON[1264],
					LAWNMOWING1B = COMMON[1264],
				},
				TIER3 = {
					LAWNMOWING3A = COMMON[1264],
					LAWNMOWING3C = COMMON[1264],
					LAWNMOWING3B = COMMON[1264],
				},
			},
			PRIOFF = COMMON[1264],
		},
		CHAPTER1 = {
			["2_S04"] = COMMON[1264],
			["1_02C"] = COMMON[1264],
			["1_02"] = COMMON[1264],
			["1_MORN_CLASS"] = COMMON[1264],
			["1_11X2UNLOCK"] = COMMON[1264],
			["1_02B"] = COMMON[1264],
			["1_06"] = {
				["1_06_08"] = COMMON[1279],
				["1_06_04"] = COMMON[1279],
				["1_06_02"] = COMMON[1279],
				["1_06_03"] = COMMON[1279],
				["1_06_07"] = COMMON[1279],
			},
			["1_11X1"] = COMMON[1264],
			["1_11_HALLSTRT"] = COMMON[1264],
			["1_11X2"] = COMMON[1264],
			["1_G1"] = COMMON[1264],
			["1_07"] = COMMON[1264],
			["1_04"] = COMMON[1264],
			["1_02B_DUMMY"] = COMMON[1264],
			["1_08"] = COMMON[1264],
			["1_11XP"] = COMMON[1264],
			["1_01"] = COMMON[1264],
			["1_B"] = COMMON[1264],
			["1_03"] = COMMON[1264],
			["1_05"] = COMMON[1264],
			["1_11_DUMMY"] = COMMON[1264],
			POST_1_03 = none,
			["1_09"] = COMMON[1264],
			CHAPT1TRANS = COMMON[1264],
			["1_AFT_CLASS"] = COMMON[1264],
			["1_02A"] = COMMON[1264],
			["1_E01"] = COMMON[1264],
			["1_06_01"] = COMMON[1279],
			["1_10"] = COMMON[1264],
		},
		CLASSES = {
			CLASS_BIOLOGY = {
				C_BIOLOGY_2 = COMMON[1281],
				C_BIOLOGY_1 = COMMON[1281],
				C_BIOLOGY_4 = COMMON[1281],
				C_BIOLOGY_3 = COMMON[1281],
				C_BIOLOGY_5 = COMMON[1281],
				C_BIOLOGY_5_UNLOCKED = COMMON[1281],
			},
			CLASS_WRESTLING = {
				C_WRESTLING_3 = COMMON[1281],
				C_WRESTLING_4 = COMMON[1281],
				C_WRESTLING_2 = COMMON[1281],
				C_WRESTLING_1 = COMMON[1281],
				C_WRESTLING_5 = COMMON[1281],
			},
			CLASS_ART = {
				C_ART_5 = COMMON[1281],
				C_ART_3 = COMMON[1281],
				C_ART_1 = COMMON[1281],
				C_ART_2 = COMMON[1281],
				C_ART_5_REPEAT = COMMON[1281],
				C_ART_4 = COMMON[1281],
			},
			CLASS_MUSIC = {
				C_MUSIC_5 = COMMON[1281],
				C_MUSIC_4 = COMMON[1281],
				C_MUSIC_3 = COMMON[1281],
				C_MUSIC_1 = COMMON[1281],
				C_MUSIC_2 = COMMON[1281],
				C_MUSIC_5_UNLOCKED = COMMON[1281],
			},
			CLASS_ENGLISH = {
				C_ENGLISH_5 = COMMON[1281],
				C_ENGLISH_1 = COMMON[1281],
				C_ENGLISH_4 = COMMON[1281],
				C_ENGLISH_5_UNLOCKED = COMMON[1281],
				C_ENGLISH_3 = COMMON[1281],
				C_ENGLISH_2 = COMMON[1281],
			},
			CLASS_SHOP = {
				C_SHOP_2 = COMMON[1281],
				C_SHOP_5_REPEAT = COMMON[1281],
				C_SHOP_5 = COMMON[1281],
				C_SHOP_3 = COMMON[1281],
				C_SHOP_1 = COMMON[1281],
				C_SHOP_4 = COMMON[1281],
			},
			GREY = {
				GREYCLASSES = COMMON[1264],
			},
			WRESTLING_DUMMY = {
				DUMMY_WRESTLING_3 = COMMON[1281],
				DUMMY_WRESTLING_1 = COMMON[1281],
				DUMMY_WRESTLING_2 = COMMON[1281],
				DUMMY_WRESTLING_5 = COMMON[1281],
				DUMMY_WRESTLING_4 = COMMON[1281],
			},
			CLASS_GEOGRAPHY = {
				C_GEOGRAPHY_5_UNLOCKED = COMMON[1281],
				C_GEOGRAPHY_4 = COMMON[1281],
				C_GEOGRAPHY_3 = COMMON[1281],
				C_GEOGRAPHY_2 = COMMON[1281],
				C_GEOGRAPHY_1 = COMMON[1281],
				C_GEOGRAPHY_5 = COMMON[1281],
			},
			CLASS_PHOTOGRAPHY = {
				C_PHOTOGRAPHY_5 = COMMON[1281],
				C_PHOTOGRAPHY_2 = COMMON[1281],
				C_PHOTOGRAPHY_4 = COMMON[1281],
				C_PHOTOGRAPHY_1 = COMMON[1281],
				C_PHOTOGRAPHY_3 = COMMON[1281],
			},
			CLASS_DODGEBALL = {
				C_DODGEBALL_2 = COMMON[1281],
				C_DODGEBALL_5 = COMMON[1281],
				C_DODGEBALL_1 = COMMON[1281],
				C_DODGEBALL_4 = COMMON[1281],
				C_DODGEBALL_3 = COMMON[1281],
			},
			CLASS_MATH = {
				C_MATH_1 = COMMON[1281],
				C_MATH_5 = COMMON[1281],
				C_MATH_4 = COMMON[1281],
				C_MATH_5_UNLOCKED = COMMON[1281],
				C_MATH_3 = COMMON[1281],
				C_MATH_2 = COMMON[1281],
			},
			CLASS_CHEM = {
				C_CHEM_4 = COMMON[1281],
				C_CHEM_1 = COMMON[1281],
				C_CHEM_5_REPEAT = COMMON[1281],
				C_CHEM_3 = COMMON[1281],
				C_CHEM_2 = COMMON[1281],
				C_CHEM_5 = COMMON[1281],
			},
		},
	},
	CLIENT_3_01 = {
		CHEERING_FIGHT_3 = none,
		CHEERING_FIGHT_5 = none,
		JOCKSCRATCH = none,
		CHEERING_FIGHT_4 = none,
		DRUNK1 = none,
		CHEERING_FIGHT_1 = none,
		DRUNK2 = none,
		CHEERING_FIGHT_2 = none,
		EXERCISE = {
			FALLENIDLE = none,
			TIRED = none,
			EXERCISE1 = none,
			VOMIT = {
				VOMIT = none,
			},
			BURTONPOINT = none,
			FALLOVER = none,
			BURTONCOMEON = none,
		},
	},
	["2_02_OWNER"] = {
		COMICGIVE = none,
		ANIMS = {
			GIVE = {
				GIVECOMICOWNER = COMMON[486],
			},
		},
		COMICRECEIVE = none,
		M_2_02_24 = {
			M_2_02_25 = COMMON[95],
		},
	},
	["2_08CONV"] = {
		YOUHERE = none,
		INTERRUPTABLE = {
			TALK = {
				TALKING2 = none,
			},
			SITDOWN = COMMON[1283],
			LISTENANIMS = {
				LISTEN1 = none,
				LISTEN3 = none,
				LISTEN2 = none,
			},
			TALKANIMS = {
				TALK2 = none,
				TALK1 = none,
			},
		},
		LOCK_PICKING = COMMON[108],
		TAUNT = {
			POINTATPLAYER = none,
			TAUNTPLAYER = none,
		},
		IDLE_REMOVE = none,
		STANDUP = {
			SITUP = none,
		},
		KILLEDPLANT = {
			YOU = {
				DARBY = {
					YOU = COMMON[1284],
				},
			},
		},
		IDLE = {
			PLAYERIDLE = none,
		},
		SITDOWN = COMMON[1283],
		COMEON = none,
	},
	PILLOW = {
		USEABLE = none,
		NOTUSEABLE = none,
	},
	["3_R08_CONV"] = {
		["3_R08_TOBIAS01"] = {
			["3_R08_PLAYER01"] = COMMON[898],
		},
		["3_R08_TRIGNOBIKE"] = COMMON[95],
	},
	RACE = {
		RESTORE = none,
		COUNTDOWN = {
			BREAK = {
				BREAKMALE = none,
				BREAKFEMALE = none,
			},
			INITIALIZE = {
				STARTMALE = none,
				STARTFEMALE = none,
			},
		},
		ONMARK = COMMON[273],
	},
	AN_DOG = {
		DOGREACTIONS = {
			BARK = {
				BARK = none,
			},
			DOGEAT = {
				DOGEATSTART = {
					DOGEATLOOP = {
						DOGEATEND = {
							DOGLIEDOWNSTART = {
								DOGSLEEP = {
									DOGWAKEUP = none,
								},
							},
						},
					},
				},
			},
		},
		WEAPONS = {
			PICKUPACTIONS = {
				PICKUPFETCHOBJECT = none,
			},
			DROPWEAPON = {
				DROPFETCHOBJECT = none,
			},
		},
		OFFENSE = {
			SHORT = {
				BARK = {
					OPPONENTONBIKE = none,
					BARK = none,
				},
				HEAVYATTACKS = {
					BITE = none,
				},
				GRAPPLES = {
					OPPONENTONBIKE = none,
					GRAPPLEATTEMPT = {
						GRAPPLESUCCESS = {
							PULL_IN_HEAVY = COMMON[48],
						},
					},
				},
			},
		},
		HITDOG = {
			GENERIC = {
				GENERIC = COMMON[357],
			},
			DEATH = {
				DEAD = COMMON[775],
			},
		},
		DEFAULT_KEY = {
			FREE = {
				RUN = none,
				SPRINT = none,
				WALK = none,
				IDLE = none,
			},
			BARKSWHILERUNNING = {
				BARKSWHILERUNNING = none,
			},
			EXECUTENODES = {
				RUNBASIC = none,
				WALKBASIC = none,
				SPRINTBASIC = none,
				ACTIONOPPS = none,
			},
		},
	},
	BUNSEN = {
		PEDPROPSACTIONS = {
			USE = {
				PLAYER = {
					GETWEAPON = {
						CALLSCRIPT = none,
					},
				},
			},
			DISENGAGE = COMMON[1076],
		},
		USEABLE = none,
		NOTUSEABLE = none,
	},
	["1_06"] = {
		JABUPPERCUTCOMBO = {
			JAB = {
				IDLE = {
					RIGHTCROSS = {
						IDLE = {
							LEFTHOOK = COMMON[95],
						},
					},
				},
			},
		},
		HOBOIDLECYCLE = {
			HOBOIDLECYCLE3 = {
				HOBOIDLECYCLE4 = none,
			},
		},
		INTROCONVERSATION = {
			["1_06_INTRO01"] = {
				["1_06_INTRO02"] = none,
			},
		},
		TACKLEFLURRY = {
			TAKEDOWN = {
				IDLE = {
					PUNCH1 = {
						IDLE = {
							PUNCH2 = {
								IDLE = {
									HEAVYPUNCH = {
										IDLE = {
											HEADBUTT = COMMON[95],
										},
									},
								},
							},
						},
					},
				},
			},
		},
		HOBOFLY = none,
		HARASSJIMMY = {
			HARASS = none,
		},
		TACKLEKNEETOGROIN = {
			TAKEDOWN = {
				IDLE = {
					KNEE = COMMON[1285],
				},
			},
		},
		JABOVERHEADCOMBO = {
			JAB = {
				IDLE = {
					RIGHTCROSS = {
						IDLE = {
							LEFTHOOK = {
								IDLE = {
									OVERHANDR = {
										IDLE = {
											UPPERCUT = COMMON[95],
										},
									},
								},
							},
						},
					},
				},
			},
		},
		FAILURE = COMMON[373],
		TACKLEFACESPIT = {
			TAKEDOWN = {
				IDLE = {
					SPIT = COMMON[95],
				},
			},
		},
		TACKLEHEADBUTT = {
			TAKEDOWN = {
				IDLE = {
					HEADBUTT = COMMON[1285],
				},
			},
		},
		JABHIGHKICKCOMBO = {
			JAB = {
				IDLE = {
					RIGHTCROSS = {
						IDLE = {
							LEFTHOOK = {
								IDLE = {
									HIGHKICKRELEASE = {
										HOWEVER = {
											HIGHKICKSTART = {
												HIGHKICKRELEASEMAX = COMMON[95],
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		EVADES = {
			IDLE = {
				IDLE = {
					EVADELEFT = {
						EVADERIGHT = {
							EVADERIGHT = {
								EVADEBACK = {
									EVADELEFT = {
										IDLE = {
											EVADELEFT = {
												EVADELEFT_PUNCH = {
													EVADERIGHT = {
														EVADERIGHT = {
															EVADERIGHT_PUNCH = {
																EVADELEFT = COMMON[95],
															},
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		JABSWEEPCOMBO = {
			JAB = {
				IDLE = {
					RIGHTCROSS = {
						IDLE = {
							LEGKICK = COMMON[1287],
						},
					},
				},
			},
		},
		LAUNCH106 = none,
		STANDINGGRAPPLEFLURRY = {
			TAKEDOWN = {
				IDLE = {
					PUNCH_GIVE = {
						REPUNCH2_GV = {
							REPUNCH3_GV = {
								IDLE = {
									PUNCH_GIVE = {
										REPUNCH2_GV = {
											KNEE_GIVE = {
												KNEE2_GV = {
													REPUNCH3_GV = {
														IDLE = COMMON[95],
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		JIMMY = {
			IDLELOOP = none,
			REGULARIDLELOOP = none,
			ONEFRAMEIDLE = none,
			SIMPLEIDLE = none,
		},
		PLAYERVICTORY = none,
		JABKNEECOMBO = {
			JAB = {
				IDLE = {
					RIGHTCROSS = {
						IDLE = {
							LEGKICK = {
								IDLE = {
									KNEETOBODYLRELEASE = {
										HOWEVER = {
											KNEETOBODYLSTART = {
												JACKIEKICK = COMMON[95],
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
		JABGROINKICKCOMBO = {
			JAB = {
				IDLE = {
					GROINKICK = COMMON[1287],
				},
			},
		},
		["1_06_GIVE"] = {
			GIVE = {
				GIVEHOBO_1_06 = COMMON[486],
			},
		},
	},
	["2_S02"] = {
		["2_S02_STAND_TALKING"] = {
			TALKINGLOOPS = COMMON[428],
			["2_S02_SEE_PLAYER"] = none,
		},
		["2_S02START"] = {
			["2_S02_02"] = {
				["2_S02_03"] = {
					["2_S02_04"] = {
						["2_S02_04_1"] = {
							["2_S02_04_2"] = {
								["2_S02_05"] = {
									["2_S02_06"] = {
										["2_S02_07"] = none,
									},
								},
							},
						},
					},
				},
			},
		},
	},
	BOOKS = {
		BOOKS = {
			FULLBODYACTIONOPPS = none,
			SOCIALEXECUTE = none,
			LOCOMOTION = {
				ANIMATIONS = {
					WEAPONWALK = COMMON[1289],
					WEAPONBIKEIDLE = none,
					WEAPONSOCIAL = COMMON[1289],
					WEAPONCROUCH = {
						GEN = none,
					},
					WEAPONRUN = COMMON[1289],
					WEAPONSTRAFE = COMMON[1289],
					WEAPONIDLE = COMMON[1289],
				},
				GLOBALLOCO = COMMON[165],
			},
			ACTIONS = {
				ATTACKS = {
					HEAVYATTACKS = {
						BOOKATTACKS = {
							PUNCH = {
								SWING = {
									SWINGFF = none,
									INCREMENTSTATPUNCH = none,
								},
							},
						},
					},
					THROWACTIONS = {
						FRISBEETHROW = {
							THROWSTART = COMMON[882],
							THROWSTARTMOBILE = COMMON[882],
						},
					},
				},
				OFFENSE = COMMON[64],
			},
			DEFAULT_KEY = none,
		},
	},
	WELCOME = {
		CARNIESTORESTART = none,
		DISGUSTED = none,
		SHAKEFIST = none,
		IDLE = none,
	},
	CHAP5TRANS = {
		BLANK = none,
		CHEERING = {
			CHEERNERD3 = {
				CHEERNERD_14 = none,
				CHEERNERD_12 = none,
				CHEERNERD_10 = none,
			},
			CHEERPOSH3 = {
				CHEERPOSH13 = none,
				CHEERPOSH11 = none,
			},
			CHEERGIRL2 = {
				CHEERGIRL07 = none,
				CHEERGIRL06 = none,
			},
			CHEER_MSPHILLIPS = {
				CHEER_MSPHILLIPS01 = none,
			},
			CHEERGEN3 = {
				CHEERGEN08 = none,
				CHEERGEN07 = none,
				CHEERGEN09 = none,
			},
			CHEERPOSH1 = {
				CHEERPOSH_02 = none,
				CHEERPOSH_01 = none,
				CHEERPOSH_03 = none,
				CHEERPOSH_04 = none,
			},
			CHEERGIRL3 = {
				CHEERGIRL11 = none,
			},
			CHEERCOOL2 = {
				CHEERCOOL06 = none,
				CHEERCOOL09 = none,
				CHEERCOOL10 = none,
				CHEERCOOL08 = none,
			},
			CHEERNERD1 = {
				CHEERNERD_03 = none,
				CHEERNERD_02 = none,
			},
		},
		MAKEOUT = {
			MAKEOUT = {
				USEOVERRIDE = COMMON[1193],
				GRAPPLEATTEMPT = {
					GRAPPLESUCCESS = {
						WAITFORPLAYER = none,
						LOADANIMS = COMMON[1204],
					},
					KISSES = {
						DISMISS = COMMON[1205],
						KISS1 = {
							KISS_RCV = {
								ANIM = COMMON[1206],
							},
							KISS_GIVE = {
								MOTIONCONTROLLER = COMMON[1207],
							},
						},
						KISSB2A = COMMON[1208],
						KISS3 = COMMON[1208],
						UPPERBODYOVERRIDES = COMMON[1209],
						KISSDROP = none,
						KISSB2B = COMMON[1208],
						KISS2 = COMMON[1208],
						KISSF = COMMON[1210],
						HEALTHINCREMENT = COMMON[1211],
						KISS4 = COMMON[1208],
						KISSB3A = COMMON[1208],
						KISSB3B = COMMON[1208],
					},
				},
			},
		},
	},
	["5_B"] = {
		REACTIONS = {
			RUNSHOULDER = none,
			STEAMREACTION = COMMON[215],
		},
	},
	["6_B"] = {
		GRAVITYRESET = none,
		FAILURE = COMMON[373],
		ADJUSTGRAVITY = none,
	},
	ARCADEMACH = {
		PEDPROPACTIONS = {
			PEDACTIVATE = none,
			ACTIVATIONRESULTS = {
				PEDUSING = {
					ENOUGHCASH = {
						PLAYLOOP = {
							PLAYGAME = {
								PLAYACTIONS = {
									ARCADEPLAY2 = none,
									ARCADEPLAY1 = none,
									ARCADEPLAY3 = none,
									ARCADEPLAY4 = none,
									ARCADEPLAY5 = none,
								},
								ENDGAME = {
									ENDGAME1 = none,
									ENDGAME2 = none,
									ENDGAME4 = none,
									ENDGAME3 = none,
								},
							},
						},
					},
				},
				PLAYERRESULTS = {
					ENOUGHCASH = COMMON[1293],
					NOTENOUGHCASH = none,
					MINIOBJCOMPLETE = COMMON[1293],
				},
			},
			PLAYERACTIVATE = none,
		},
		DISENGAGE = COMMON[215],
		IDLE = none,
		NOTUSEABLE = COMMON[30],
	},
	BUCKY = {
		AMBIENT = {
			IDLE = none,
			WANDER = none,
		},
		REACTIONS = {
			CONTROLLER = COMMON[1295],
			ATTACKED = {
				ATTACKEDWAIT = none,
			},
			OBJECTIVES = COMMON[518],
		},
	},
	INFIRMARY = {
		KIDS_HURT = {
			ONFRONT = none,
			ONBACK = {
				ONBACK_RANDOMS = {
					ONBACK_45SEC = none,
					ONBACK_60SEC = none,
					ONBACK_10SEC = {
						ONBACK_LOOP = none,
					},
					ONBACK_30SEC = none,
				},
				SIT_UP = {
					SITUP = {
						SITUP_RANDOMS = {
							SITUP_LOOP_10SEC = none,
							SITUP_LOOP_5SEC = none,
						},
						SITUP_ACTIONS = {
							HOLD_HEAD = {
								HOLD_HEAD_LOOP = {
									HOLD_HEAD_OUT = none,
								},
							},
							LOOKAROUND = none,
							LIEDOWN = none,
							SITUP_LOOP = none,
						},
					},
					STAYDOWN = none,
				},
			},
		},
	},
	["2_B"] = {
		DARBYDANCE = none,
		DRBYVAULT = {
			PLAYANIM = {
				RELEASEGROUP = COMMON[1076],
			},
		},
		HOLD_IDLE = COMMON[48],
		ADULTIDLE = {
			MALEIDLE = none,
			FEMALEIDLE = none,
		},
		TANDEMGRAPPLE = {
			GIVE = COMMON[252],
			HELD = {
				HIT = {
					GIVE = none,
					RCV = COMMON[252],
					DEAD = COMMON[1093],
				},
				ESCAPESTRUGGLE = COMMON[1097],
			},
			RCV = none,
		},
		["2_BINTRO"] = {
			DARBY = {
				PLAYER = {
					DARBY = {
						PLAYER = {
							DARBY = {
								PLAYER = COMMON[1284],
							},
						},
					},
				},
			},
		},
		DRBYFGHT = {
			DARBY = COMMON[201],
		},
		TALKING = {
			DARBY01 = none,
			DARBY02 = none,
			PLAYER02 = none,
			DARBYIDLE = none,
			DARBY03 = none,
			PLAYER01 = none,
		},
		EMPTY = none,
		GRAPPLEATTEMPT = {
			GRAPPLESUCCESS = COMMON[842],
			NPC = none,
		},
		BIFFKO = none,
		PLAYERONGROUND = {
			BELLYUP = none,
		},
		DRBYLEAN = {
			DRBYLEANEXIT = none,
			DRBYLEANLOOP = none,
		},
	},
	NIS_3_S03_GIVECAS = COMMON[441],
	WPROPS = {
		GEOINTERACT = {
			PLANTPOTS = {
				MIDANIM = none,
				GETPLANT = {
					HATSVASE = none,
					HATVASE = none,
					FLOWER = none,
					VASE = none,
				},
				LOWANIM = none,
			},
			VENUSFLYTRAP = {
				MOVETOFLYTRAP = {
					LIGHTBOMB = {
						DROP = {
							DONE = none,
						},
					},
				},
			},
			FLOWERBEDS = {
				WHICHHAND = COMMON[256],
			},
		},
		GARBINTERACT = {
			RUN = {
				GARBINTERACTFROMRUN = none,
			},
			GARBINTERACT = none,
		},
		COASTER_BACK = COMMON[1299],
		RAILINTERACT = none,
		DOORSDIRECT = {
			DOORS = {
				UNLOCKDOOR = none,
			},
		},
		PEDS = {
			SCRIPTEDPROPINTERACT = {
				PEDSYNCPROP = {
					PEDSYNCPROPIDLESOFTEN = none,
				},
			},
		},
		BUSSTOP = none,
		COASTER_MIDDLE = COMMON[1299],
		EXECUTES = {
			USEPROP = {
				USEPROPDIRECT = none,
				USEPROPOLD = none,
			},
			SYNCTOPROP = {
				DEBUG = {
					SYNCWORLDANCHOR = none,
					MARKWORLDANCHOR = none,
				},
				STRAFETO = {
					STRAFETO = none,
				},
				MOVETO = none,
				ORIENTONLY = COMMON[330],
			},
			STANDUP = none,
			DEEQUIP = {
				MISSION_1_08 = {
					NODEQUIP = none,
				},
				EXEC = none,
			},
			STRAFETOPROP = {
				STRAFE = COMMON[960],
			},
			ATTACHPROPPED = {
				PED02 = none,
				PED00 = none,
				PED07 = none,
				PED03 = none,
				PED01 = none,
				PED05 = none,
				PED04 = none,
				PED08 = none,
				PED06 = none,
				PED09 = none,
			},
		},
		DOORS = {
			LOCKEDDOORSOUND = none,
		},
		WALLCLIMB = {
			["6FOOTWALL"] = {
				RUNNING = COMMON[1301],
				WALKING = COMMON[1301],
			},
		},
		SAVEBOOKINTERACT = none,
		PROPINTERACT = {
			PROPINTERACTLOCO = {
				LOCODIRECTWITHDEEQUIP = none,
				BASE = {
					PROPINTERACTLOCODIRECT = COMMON[1041],
				},
			},
		},
		FIRECRACKER_TOILET = none,
	},
	CM = {
		CM_INTRO_4 = COMMON[1302],
		PLAYERSIT = COMMON[887],
		NIS_OUT = COMMON[893],
		PLAYERFAIL = COMMON[373],
		CM_INTRO_2 = COMMON[1303],
		PLAYERVICTORY = COMMON[891],
		CM_INTRO_3 = COMMON[1302],
		CM_INTRO_5 = COMMON[1303],
		RELEASE = none,
		TEACHERDISGUST = none,
		CM_INTRO_1 = COMMON[1303],
	},
	TEACHER = {
		INACTIVE = {
			AMBIENT = COMMON[1307],
			REACTIONS = {
				COMBAT = COMMON[1308],
				OBJECTIVES = COMMON[1309],
				WORK = {
					PREFECT = COMMON[1310],
					COP = COMMON[1311],
				},
				CONTROLLER = COMMON[1295],
			},
			STOP = none,
		},
		ACTIVE = COMMON[243],
	},
	DUNKTANK = {
		CARNY = {
			TAUNT_LOSE = COMMON[30],
			NERVOUS = none,
			FALL = {
				CURSE = COMMON[849],
			},
			TAUNTLOOP = COMMON[836],
		},
		MGDTMISSIONSTART = none,
	},
	AI = {
		ONBIKE = COMMON[144],
		GENERALOBJECTIVES = {
			REMOVEFLASHLIGHT = none,
			SPECIFICOBJECTIVES = {
				USESPUDCANNON = {
					SPUDSPEECH = {
						SPUDEARNEST = none,
					},
					PREFIREWAIT = {
						FIRE = {
							WAITFORPLAYERTOGETUP = none,
							POSTFIREWAIT = {
								POSTFIREWAITEARNEST = none,
								POSTFIREWAITDEFAULT = none,
							},
							FIREPATTERN = {
								FIREPATTERNEARNEST = none,
								FIREPATTERNDEFAULT = none,
							},
						},
					},
					WAITMOUNT = none,
				},
			},
			FACEOBJECTIVE = none,
			USEPROP = {
				USEPROPOBJ = none,
				USEPROPAMBIENT = {
					STARTROUTETOPROP = {
						PROPEXITEXEC = none,
						ACQUIREPROP = {
							WAITFORPROP = none,
							ACQUIRETHEPROP = {
								USINGPROP = none,
								OPPTVSIT = none,
							},
						},
					},
				},
				USEPROPMAILMAN = {
					STARTROUTETOPROP = {
						ACQUIREPROP = {
							WAITFORPROP = none,
							ACQUIRETHEPROP = none,
						},
					},
				},
			},
			PATROLFOLLOWPATH = none,
			POIPOINT = COMMON[968],
			FLEEOBJECTIVE = {
				FLEEDOCK = none,
				FLEE = {
					WAITACTIONS = {
						COWER = none,
						CRY = none,
					},
					EXIT = none,
					WAIT = none,
				},
			},
			USEPROPCAF = none,
			ROOFTOPATTACKER = COMMON[970],
			WANDER = {
				BROWSESTORE = {
					BROWSEACTIONS = {
						DOCK = none,
						LOOKATTARGETS = none,
						POI = none,
					},
					BROWSEEXECUTES = {
						BROWSEOPPS = none,
					},
				},
				WANDER = none,
			},
			GETONCAR = {
				MOVETOCAR = COMMON[866],
				MOUNTCAR = none,
			},
			FOLLOWPATH = none,
			MOVEOBJECTIVE = none,
			FOLLOWFOCUS = none,
			GETONBIKE = COMMON[763],
			EQUIPFLASHLIGHT = none,
			DOCK = none,
			IDLE = none,
			PLAYCATCH = {
				FINDBALL = COMMON[1331],
				PLAYCATCHIDLE = {
					REMOVEOBJECTIVE = none,
				},
				PLAYCATCHEXECUTES = {
					PLAYCATCHOPPS = none,
				},
				HAVEBALL = {
					FACETARGET = COMMON[878],
					DROPBALL = none,
				},
				WAITINGFORTHROW = {
					FACETARGET = COMMON[848],
					DROPWEAPON = none,
				},
			},
			EXITVEHICLE = none,
		},
		MOBILITY = COMMON[975],
		WEAPONACTIONS = {
			CONTROLNODE = COMMON[146],
			WEAPONACTIONS = COMMON[966],
		},
		CHARTRIGGER = none,
		POIRELEASE = none,
		RUMBLEHATE = {
			RUN = none,
			HATECHECK = none,
		},
		STEALTH = {
			FOLLOWPATH = none,
			WANDER = none,
			FACE = none,
			MOVE = none,
			STEALTHBEHAVIOR = {
				ONSIGHTBEHAVIOR = {
					STEALTHHELPYELL = {
						HELPFLEE = none,
					},
					ATTACKONSIGHT = {
						STEALTHPUNISHMENT = {
							GIVESTEALTHPUNISHMENT = none,
						},
						ATTACKANIM = {
							ATTACKOBJECTIVE = none,
						},
					},
					STSPEECH = {
						ONSIGHTSPEECHLOAD = {
							ONSIGHTSPEECHLOAD = none,
							ONSIGHTSPEECHLOADAUTH = none,
						},
					},
				},
				ONHEARBEHAVIOR = {
					INVESTIGATEONSTIMULUS = {
						INVESTIGATEANIM = COMMON[1334],
					},
					INVESTIGATEONFOOTSTEPS = {
						INVESTIGATEFOOTSTEPSANIM = COMMON[1334],
					},
				},
				MOVETOSTIMULUS = none,
			},
			SPAWNEDNOTIFICATIONS = {
				NOTIFYALLCONDITIONALLY = COMMON[1336],
			},
			EQUIPFLASHLIGHT = none,
			NOTIFICATIONS = COMMON[1336],
			POIPOINT = {
				SPECTATOR = {
					MOVETOSPECTACLE = {
						STOPSPECTACLE = none,
					},
				},
				HANGOUT = {
					HANGOUTSTUDENT = none,
					HANGOUTADULT = none,
					STOPHANGOUT = {
						EXITHANGTALK = none,
						EXITHANG = none,
					},
				},
				SITTING = {
					SITWEAPON = COMMON[1337],
					SITTING = {
						MOVETOSITSPOT = {
							SITDOWN = none,
						},
					},
					SITADULT = COMMON[1338],
				},
			},
			IDLE = none,
			PRANKBEHAVIOR = {
				JOKECANDYEXEC = none,
				FIREALARMEXEC = none,
				FIREWORKEXEC = none,
			},
			DOCK = none,
		},
		TETHERLOCO = COMMON[626],
		AIACTIONOPPS = {
			STUCKOPPS = COMMON[935],
			COWEROPPS = COMMON[928],
			DIALOGOPPS = COMMON[929],
			SPECTATOROPPS = COMMON[930],
			REACTIONOPPS = COMMON[933],
			DOOROPPS = {
				DOOROPP = none,
			},
			HARASSOPPS = COMMON[936],
			ATTACKWARNINGOPPS = COMMON[937],
			SITOPPS = COMMON[938],
			LOCKEROPPS = {
				LOCKEROPP = none,
			},
			TALKINGOPPS = {
				TALKINGOPP = none,
			},
			AUTHORITYGRABOPPS = COMMON[931],
			KNOCKOUTTAUNTOPPS = COMMON[932],
			ALLYOPPS = COMMON[934],
			CANOPPS = {
				CANOPP = none,
			},
			CDIALOGOPPS = {
				CDIALOGOPP = none,
			},
			CHEERING = COMMON[927],
			PROPINTERACTOPPS = {
				PROPINTERACTOPP = none,
			},
			SCENARIOOPPS = COMMON[939],
		},
		DUMMYIDLE = none,
		DOOREXIT = {
			DOOREXITSCHOOL = none,
			DOOREXITDEFAULT = none,
			DOORATTACK = none,
		},
		INCAR = {
			INCAR_REACTIONS = {
				INCARAUTHORITY = {
					FINDBADDIESBIKE = none,
					FINDBADDIESGROUND = COMMON[309],
				},
				ATTACKCAR = {
					MALEDRIVER = {
						GETOUTANDATTACK = {
							HALTVEHICLE = COMMON[309],
						},
					},
				},
			},
			RACE = {
				STOPCARRACE = none,
			},
			EXITCAROBJECTIVE = {
				STOPCAR = COMMON[309],
			},
			ATTACKPED = {
				MOWDOWNPED = none,
			},
			DRIVING = none,
		},
		INLIQUID = {
			ISSWIMMING = none,
			BASE = {
				SWIMMINGOPPS = none,
			},
			ONSHORE = {
				ONSHORE = none,
			},
		},
		VEHICLEAVOIDANCE = {
			DIVERIGHTSEQUENCE = {
				COWER = none,
				FACEDIVEENTITY = {
					DIVERIGHT = none,
				},
			},
			DIVELEFTSEQUENCE = {
				COWER = none,
				FACEDIVEENTITY = {
					DIVELEFT = none,
				},
			},
		},
		CONTROLLER = COMMON[762],
		MESSAGEACTIONS = {
			SENDTOHELPER = none,
		},
		VEHICLEOBJ = {
			BREAKVEHICLE = COMMON[1339],
		},
		SOCIAL_SYSTEM = {
			NEWSOCIALSYSTEM = {
				ANIMATIONS = {
					PLAYSOCIALINITIALREACTION = {
						SOCIALINITIALREACTION = COMMON[1340],
					},
					PLAYSOCIALANIMATION = {
						SOCIALSTOPHANDPRELOAD = COMMON[1340],
						SOCIALWAVEPRELOAD = COMMON[1340],
						SOCIALLOSTTEMPER = COMMON[1340],
						SOCIALREACTANGRYPRELOAD = COMMON[1340],
						SOCIALANGRYSHOVEPRELOAD = COMMON[1340],
						SOCIALREACTCOWERPRELOAD = COMMON[1340],
						SOCIALFLEE = COMMON[1340],
						SOCIALANGRYSHOVE = COMMON[1340],
						SOCIALPRAISEPRELOAD = COMMON[1340],
						SOCIALPRAISE = COMMON[1340],
						SOCIALFLEEPRELOAD = COMMON[1340],
						SOCIALREACTCOWER = COMMON[1340],
						SOCIALLAUGHPRELOAD = COMMON[1340],
						SOCIALLOSTTEMPERPRELOAD = COMMON[1340],
						SOCIALBRINGITONPRELOAD = COMMON[1340],
						SOCIALAPOLOGYPRELOAD = COMMON[1340],
						SCRIPTCALLBACK = none,
						SOCIALEXTORT = COMMON[1340],
						SOCIALINSULT1 = COMMON[1340],
						SOCIALHUMILIATEATTACK = COMMON[1340],
						SOCIALTATTLEPRELOAD = COMMON[1340],
						SOCIALLAUGH = COMMON[1340],
						SOCIALCHITCHATPRELOAD = COMMON[1340],
						SOCIALWANTGIFT = COMMON[1340],
						SOCIALTATTLE = COMMON[1340],
						SOCIALREACTANGRY = COMMON[1340],
						SOCIALREACTDONTHURT = COMMON[1340],
						SOCIALACCEPTAPOLOGY = COMMON[1340],
						SOCIALSTOPHAND = COMMON[1340],
						SOCIALDISMISSSHRUG = COMMON[1340],
						SOCIALBRINGITON = COMMON[1340],
						SOCIALCHITCHAT = COMMON[1340],
						SOCIALFOLLOWPRELOAD = COMMON[1340],
						SOCIALHUMILIATEATTACKPRELOAD = COMMON[1340],
						SOCIALDISMISSSHRUGPRELOAD = COMMON[1340],
						SOCIALWAVE = COMMON[1340],
						SOCIALACCEPTAPOLOGYPRELOAD = COMMON[1340],
						SOCIALAPOLOGY = COMMON[1340],
						SOCIALEXTORTPRELOAD = COMMON[1340],
						SOCIALWANTGIFTPRELOAD = COMMON[1340],
						SOCIALGREETING = COMMON[1340],
						SOCIALINSULT1PRELOAD = COMMON[1340],
						SOCIALREACTDONTHURTPRELOAD = COMMON[1340],
						SOCIALGREETINGPRELOAD = COMMON[1340],
						SOCIALFOLLOW = COMMON[1340],
					},
				},
				OPPS = {
					KEEPFACING = none,
					RAINBREAK = none,
					SOCIALOPPS = none,
					NEWKIDBREAK = none,
					TURFBREAK = none,
				},
				SOCIALTARGET = {
					SOCIALTARGETWAIT = {
						SOCIALTARGETWAIT = none,
						SOCIALTARGETINITIALREACTION = none,
					},
					SOCIALTARGETACT = {
						SOCIALTARGETPRELOAD = {
							SOCIALTARGETPRELOADCOMPLETE = none,
						},
						SOCIALTARGETMOVETOREACT = none,
						SOCIALTARGETFACEFORREACT = none,
						SOCIALTARGETREACTION = {
							SOCIALTARGETLOOP = none,
							SOCIALTARGETREACTION = none,
						},
					},
				},
				SOCIALINSTIGATOR = {
					SOCIALINSTIGATORWAIT = {
						SOCIALINSTIGATORWAIT = none,
						SOCIALINSTIGATORINITIALREACTION = none,
					},
					SOCIALINSTIGATORACT = {
						SOCIALINSTIGATORGREET = {
							SOCIALINSTIGATORGREET = none,
							SOCIALINSTIGATORLOOP = none,
						},
						SOCIALINSTIGATORPRELOAD = {
							SOCIALINSTIGATORPRELOADCOMPLETE = none,
						},
						SOCIALINSTIGATORMOVETOGREET = none,
						SOCIALINSTIGATORFACEFORGREET = none,
					},
				},
			},
		},
		EVADE = COMMON[940],
		SCRIPTED = {
			SCRIPTBREAK = none,
			SWALKAWAY = none,
			SCRIPTGRAPPLEBREAK = none,
			SATTACK = none,
			SCRIPTRUSSELL = {
				RUSSELLBULLY = {
					RUSSELLSOCIAL = none,
				},
			},
			STRAPPED = none,
			SFLEE = none,
		},
		SCRIPTEDAI = {
			CHEERINGAINODE = none,
		},
		PROJFIGHTCOMBAT = {
			PROJFIGHTOPPS = {
				CLEAR = none,
			},
			PROJFIGHTLOOP = {
				SEEKWEAPON = {
					FINDSNOWBALL = none,
					SEEKFOOD = {
						REACHEDPROP = none,
					},
				},
				PROJFIGHTBGACTION = {
					EXTENDSTIM = none,
					PROJFIGHTSPEECH = none,
				},
				DEFAULT = none,
				HAVEWEAPONACTIONS = {
					PICKENEMYRANDOM = none,
					TRYAGAIN = {
						TRYAGAINBREAK = none,
					},
				},
			},
		},
		COMBAT = {
			ATTACKFROMCOVER = COMMON[919],
			ACTIVECOMBAT = {
				REMOVEFLASHLIGHT = none,
				STEALTHPROPEXIT = {
					STEALTHPROPSPEECH = {
						STEALTHPROPSPEECHNODE = none,
						STEALTHCHARPROPSPEECHNODE = none,
					},
					STEALTHPROPCHOICES = {
						STEALTHCLEAR = {
							STEALTHCLEARANIMS = {
								STEALTHCLEARANIMSIDLE = none,
								STEALTHCLEARCONFUSED = none,
							},
						},
						STEALTHPROPLOOKAROUND = none,
						STEALTHPROPFIX = none,
						STEALTHPROPSPOTTED = {
							STEALTHPROPWAIT2 = none,
							STEALTHPROPBANK = {
								STEALTHPROPSYNC = {
									STEALTHPROPDOOR = none,
									STEALTHPROPLOCKER = none,
									STEALTHPROPCAN = none,
								},
							},
							STEALTHPROPGETCLOSER = none,
						},
					},
					STEALTHPROPHACK = {
						STEALTHPROPSET = {
							WARNSET = none,
						},
						STEALTHPROPSETMISSION = {
							MISSIONSET = none,
						},
					},
					STEALTHRESPONSE = {
						REMOVETARGET = none,
					},
				},
				COWDANCEEXIT = {
					COWDANCEEXITNODE = none,
				},
				COMBATLOCO = COMMON[922],
				AUTHORITYEXIT = none,
				ATTACKWARNING = {
					ATTACKWARNAUTHHIGHPUNISH = none,
					ATTACKWARNCLEAR = none,
					ATTACKWARNSPEECH = {
						ATTACKWARNSPEECH = none,
						ATTACKWARNSHOPKEEP = none,
					},
					ATTACKWARNAUTH = none,
					ATTACKWARN = none,
				},
				GUARDLOCO = none,
				CHEERLOCO = none,
				SPECIALRUSSELLHACKNODE = none,
				SPECIAL = none,
				AUTHORITYEXIT2 = {
					AUTHORITYEXITSPEAK = {
						JUSTEXIT = none,
						AUTHORITYEXITSPEAK = none,
					},
				},
				WAITFORTARGETLOCO = {
					WAITFORTARGETLOCO = {
						WAITFORTARGETTAUNT = none,
						OUTOFREACHSPAWNPROJECTILE = {
							AUTHORITY = {
								GIVEAPPLE = none,
							},
							GIVEBRICK = none,
						},
						WAITFORTARGETEXIT = none,
					},
				},
			},
		},
		BACKGROUNDACTIONS = {
			CHATTER = none,
			WANDERGREET = {
				WANDERGREETANIM = none,
			},
			USEBANANA = none,
			PUTUPUMBRELLA = none,
			ADULTCHATTER = none,
			CHECKOUT = {
				GREETFRIENDLY = none,
				ADULTGREET = {
					ADULTGREETCLOTHING = {
						ADULTGREETCLOTHINGDISLIKE = {
							CDSPEAK = none,
						},
						ADULTGREETCLOTHINGLIKE = {
							CLSPEAK = none,
						},
					},
					ADULTGREETSCHOOL = {
						SCHOOLSPEAK = none,
					},
					ADULTGREETCURFEW = {
						CURFEWSPEAK = none,
					},
				},
				CHECKOUT2 = {
					CHECKOUTCLOTHING = {
						CHECKOUTCLOTHINGDLIKE = {
							CDLKIDSPEAK = none,
						},
						CHECKOUTCLOTHINGLIKE = {
							CLKIDSPEAK = none,
						},
					},
					NEWKIDSPEAK = none,
				},
			},
			CANCEL = none,
			PUTDOWNUMBRELLA = none,
		},
		REACTIONS = COMMON[98],
		COMBATACTIONS = {
			CONTROLNODE = COMMON[146],
			COMBATACTIONS = {
				FINDWEAPON = COMMON[147],
				TIMEOUT = COMMON[1008],
				GROUNDATTACK = COMMON[148],
				POSTHIT = {
					HIT = COMMON[1015],
					EXECUTENODES = {
						AUTHORITYRELEASE = none,
					},
					INCAPACITATED = COMMON[241],
					GRAPPLED = COMMON[242],
				},
				AUTHORITYFIGHTSTIM = COMMON[941],
				EVADE = {
					NERDS = COMMON[488],
					ADULT = COMMON[942],
					PREPS = {
						GRAPPLER = COMMON[943],
						STRIKER = COMMON[943],
					},
				},
				BLOCK = COMMON[151],
				COMBATDIALOG = {
					COMBATSTIM = {
						COMBATAPOLOGY = COMMON[1009],
						SUPERTAUNT = COMMON[1010],
						TAUNTED = {
							FEAREXIT = none,
							TAUNTEDCHOICES = {
								COMBATT = none,
							},
						},
					},
				},
				CLEARSTIMFLAG = COMMON[1011],
				BREAKPROP = COMMON[1016],
				RUNNINGATTACKS = COMMON[150],
				COMBATSPEECH = COMMON[153],
				TANDEMATTACKER = {
					SWITCHTOUNARMED = none,
					FINDTANDEMRANGE = {
						TANDEMATTACK = none,
					},
				},
				RANGEDWEAPONCHECK = COMMON[154],
				COUNTERATTACK = COMMON[101],
				UMBRELLACHECK = COMMON[950],
				OFFENSE = {
					MELEEACTIONS = {
						LONG = none,
						FEMALEFLEE = COMMON[948],
						SHORT = {
							LOWATTACK = none,
							SHORT = none,
							FLOWERBUND = none,
						},
						SPECIAL = none,
						MEDIUM = {
							MEDIUM = none,
							FLOWERBUND = none,
						},
					},
					GRAPPLECONTROL = COMMON[1013],
				},
			},
		},
		WORK = COMMON[764],
		ALLY = {
			ALLYLOCO = {
				ATTACHEDALLYLOCO = COMMON[1375],
				PLAYERATTACHEDALLYLOCO = COMMON[1375],
				STANDARDLOCO = none,
			},
			DISMISS = {
				PLAYERDISMISS = none,
			},
			ALLYOPS2 = none,
			WAITFORTARGETLOCO = COMMON[160],
			ALLYLOST = {
				ALLYABOUTTOLEAVE = none,
				WANDER = none,
			},
			ALLYATTACKER = {
				TARGETED = {
					ALLYATTACKERTARGETTED = COMMON[1377],
				},
				ALLYATTACKED = none,
				ALLYATTACKERDAMAGED = {
					ALLYATTACKERDAMAGED = {
						ALLYATTACKERDAMAGEWEAK = none,
						ALLYATTACKER_NODAMAGE = none,
						ALLYATTACKERDAMAGEREBEL = COMMON[1378],
					},
				},
				SUPAKRAZYRUSSELL = {
					ALLYFINDTARGET = none,
				},
				ALLYFINDTARGET = none,
				AUTHCHEERBANK = COMMON[1379],
			},
			ALLYCOMBATLOCO = {
				RUSSELLKRAZYBREAK = none,
			},
			ALLYOPS = none,
			ALLYFEARACTION = {
				TARGETED = {
					FEARTARGETED = COMMON[1377],
				},
				ALLYCHEER = COMMON[1381],
				ALLYFEARACTIONDAMAGED = {
					ALLYFEARACTIONDAMAGEWEAK = none,
					ALLYFEARACTIONDAMAGEREBEL = COMMON[1378],
				},
				AUTHCHEERBANK = COMMON[1379],
				ALLYCOWER = none,
			},
			DIALOG = {
				DANGER = none,
				INSULT = none,
				CHATTER = none,
			},
		},
		PICKUP = {
			PICKUP = {
				PICKUPPICKUP = none,
				CLEARPICKUPOBJECTIVE = none,
			},
		},
		PROPS = COMMON[1017],
	},
	LE_ORDERLY_A = {
		BUSTED = none,
		DEFENSE = none,
		OFFENSE = {
			RUNNINGATTACKS = none,
			SHORT = {
				GRAPPLE = COMMON[176],
			},
		},
		DEFAULT_KEY = {
			LOCOMOTION = COMMON[2],
			EXECUTENODES = COMMON[445],
			IDLE = none,
			RISINGATTACKS = none,
		},
	},
	PUNISHMENT = {
		GARBAGE = {
			EMPTYTRASH = {
				SCRIPTCALLBACK = none,
			},
			DROPTRASH2 = {
				DROP2_CHILD = none,
			},
			DROPTRASH = none,
		},
		ANIMATIONS = {
			PREFECT = {
				LAUGH = none,
				SCOLD = none,
			},
		},
	},
	["3_S09"] = {
		["3_S09_RAISEDBROW"] = {
			["3_S09_RAISEDBROW_CHILD"] = none,
		},
		["3_S09_START"] = none,
	},
	CONV = {
		TESTFACIAL = {
			CHOICE = {
				MOUTH = COMMON[1394],
				EYEBROWS = COMMON[1394],
				EYES = COMMON[1394],
				QUIT = COMMON[1394],
				EYELID = COMMON[1394],
			},
		},
		OLDM72 = {
			START = {
				LINE = {
					LINE = {
						CHOICE = COMMON[1394],
					},
				},
			},
		},
		CONVTESTMIS1 = COMMON[1395],
		CONVTESTMIS2 = COMMON[1395],
		CONVTESTMIS3 = COMMON[1395],
		OLDM7 = {
			START = {
				LINE = {
					LINE = {
						LINE = {
							CHOICE = {
								LINE = COMMON[1397],
							},
						},
					},
				},
			},
		},
		M7OLF_6 = COMMON[1398],
		OLDM7_4 = COMMON[1398],
		M7 = {
			START = {
				START = {
					LINE = {
						LINE = {
							LINE = COMMON[1394],
						},
					},
				},
				GETOFFBIKE = none,
			},
		},
	},
}
COMMON = nil
shared._derpys_cached_nodes = GLOBAL
collectgarbage()
