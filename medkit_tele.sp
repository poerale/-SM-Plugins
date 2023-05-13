#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

static bool is_roundstarted = false;

public Plugin myinfo =
{
	name   = "[SM] MedKit Teleport",
	author = "vic",
}

public void OnPluginStart()
{
	RegConsoleCmd("medtp", cmd_medkit);
	HookEvent("survival_round_start", Event_RoundStart);
	HookEvent("round_end", Event_RoundEnd);
}

public Action cmd_medkit(int client, int args)
{
	tp_medkit(client);
	return Plugin_Handled;
}

public void tp_medkit(client)
{
	float vec[3];
	GetClientAbsOrigin(client, vec);
	if (is_roundstarted)
		return;
	int Med;
	// Пробегаемся по списку entity и ищем все "weapon_first_aid_kit_spawn"
	Med	= 0;
	Med	= FindEntityByClassname(Med, "weapon_first_aid_kit_spawn");
	while (Med > 0)
	{
		if (Med > 0)
		{
			RemoveEntity(Med);
			medkit_spawn(client);
		}
		Med = FindEntityByClassname(Med, "weapon_first_aid_kit_spawn");
	}
	// Пробегаемся по списку entity и ищем все "weapon_first_aid_kit"
	Med	= FindEntityByClassname(Med, "weapon_first_aid_kit");
	for (int i = 1; i <= MaxClients; i++) 
	while (Med > 0)
	{
		if (Med > 0 && IsPlayerAlive(i))
		{
			vec[2] += 10;
			TeleportEntity(Med, vec, NULL_VECTOR, {0.0,0.0,0.0});
		}
		Med = FindEntityByClassname(Med, "weapon_first_aid_kit");
	}
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	is_roundstarted = true;
	return Plugin_Handled;
}

public Action Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	is_roundstarted = false;
	return Plugin_Handled;
}

public void medkit_spawn(client)
{
	float vec[3];
	GetClientAbsOrigin(client, vec);
	new index = CreateEntityByName("weapon_first_aid_kit");
	DispatchSpawn(index);
	TeleportEntity(index, vec, NULL_VECTOR, NULL_VECTOR);
}