#pragma semicolon 1
#pragma newdecls required


#include <sourcemod>
#include <sdktools>
#include <colors>
#include <unixtime_sourcemod>

public Plugin myinfo =
{
	name = "Round Announcer",
	author = "vic",
}

public void OnPluginStart()
{
	HookEvent("survival_round_start", start, EventHookMode_Pre);
	HookEvent("round_end", stop, EventHookMode_Pre);
}


public Action start(Event event, const char[] eName, bool dontBroadcast)
{
	char name[32];
	int client = GetClientOfUserId(event.GetInt("userid"));		//		User ID
	int iYear, iMonth, iDay, iHour, iMinute, iSecond;
	GetClientName(client, name, sizeof(name));
	UnixToTime(GetTime(), iYear, iMonth, iDay, iHour, iMinute, iSecond, UT_TIMEZONE_EEST);
	CPrintToChatAll("{green}[%02d:%02d:%02d]{green} {blue}%s{blue} {olive}started the round{olive}", iHour, iMinute, iSecond, name);
	return Plugin_Handled;
}

public Action stop(Event event, const char[] eName, bool dontBroadcast)
{
	int iYear, iMonth, iDay, iHour, iMinute, iSecond;
	UnixToTime(GetTime(), iYear, iMonth, iDay, iHour, iMinute, iSecond, UT_TIMEZONE_EEST);
	CPrintToChatAll("{green}[%02d:%02d:%02d]{green} {olive}Survival Round Ended{olive}", iHour, iMinute, iSecond);
	return Plugin_Handled;
}