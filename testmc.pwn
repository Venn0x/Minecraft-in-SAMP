#include <a_samp>
#include <streamer>
#include <zcmd>
#include <CA3>
//Textures:
#include <stone>
#include <cobblestone>
#include <dirt>
#include <planks_oak>
//---------
#define DIALOG_BLOCK 6999
new totalobj;
new currentblock[MAX_PLAYERS];
new PlayerText:logo[MAX_PLAYERS];
forward Loop();
public Loop(){
	for(new i; i < MAX_PLAYERS; i++){
		new Float:x, Float:y, Float:z;
  		GetPlayerPos(i, x, y, z);
  		new string[128];
  		new xa, ya, za;
  		xa = floatround(x);
  		ya = floatround(y);
  		za = floatround(z) - 900;
  		new block[64];
  		switch(currentblock[i]){
  			case 0: format(block, 64, "Stone");
  			case 1: format(block, 64, "Cobblestone");
  			case 2: format(block, 64, "Dirt");
  			case 3: format(block, 64, "Wooden Plank");
  		}
  		format(string, 128, "%d / %d / %d   ~p~Block: %s", xa, ya, za, block);
  		PlayerTextDrawSetString(i, logo[i], string);
	}
 
}

public OnGameModeInit(){
	AddPlayerClass(0, 0, 0, 905, 0, 0, 0, 0, 0, 24, 9999);
	CreateVehicle(522, 0, 0, 905, 0, 0, 0, 0, 0);
	for(new x; x <= 1000; x += 125){
		for(new y; y <= 1000; y += 125){ 
			CreateDynamicObject(19529, 0 + x, 0 + y, 900,   0.00000, 0.00000, 0.00000);  
			totalobj++;
		}
		for(new y; y >= -1000; y -= 125){ 
			CreateDynamicObject(19529, 0 + x, 0 + y, 900,   0.00000, 0.00000, 0.00000);  
			totalobj++;
		}		
	}
	for(new x; x >= -1000; x -= 125){
		for(new y; y <= 1000; y += 125){ 
			CreateDynamicObject(19529, 0 + x, 0 + y, 900,   0.00000, 0.00000, 0.00000);  
			totalobj++;
		}
		for(new y; y >= -1000; y -= 125){ 
			CreateDynamicObject(19529, 0 + x, 0 + y, 900,   0.00000, 0.00000, 0.00000);  
			totalobj++;
		}		
	}
	printf("Chunks: %d", totalobj);
	SetTimer("Loop", 1, 50);
	return 1;
}
public OnPlayerConnect(playerid){
	logo[playerid] = CreatePlayerTextDraw(playerid, 638.000000, 429.333374, "~g~authguard nr 1 coming soon");
	PlayerTextDrawLetterSize(playerid, logo[playerid], 0.240000, 2.100000);
	PlayerTextDrawAlignment(playerid, logo[playerid], 3);
	PlayerTextDrawColor(playerid, logo[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, logo[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, logo[playerid], 255);
	PlayerTextDrawFont(playerid, logo[playerid], 2);
	PlayerTextDrawSetProportional(playerid, logo[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, logo[playerid], 0);	
	PlayerTextDrawShow(playerid, logo[playerid]);
	GivePlayerWeapon(playerid, 24, 9999);
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys == KEY_NO) return cmd_placeblock(playerid);
	if(newkeys == KEY_YES) return cmd_block(playerid);
	return 1;
}
CMD:block(playerid){
	ShowPlayerDialog(playerid, DIALOG_BLOCK, DIALOG_STYLE_LIST, "Select building block", "Stone\nCobblestone\nDirt\nWooden Plank", "Ok", "Cancel");
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	if(dialogid == DIALOG_BLOCK && response == 1) currentblock[playerid] = listitem;
}
CMD:placeblock(playerid){
	new Float:fX, Float:fY, Float:fZ;
	GetPlayerPos(playerid, fX, fY, fZ);
	new xa, ya, za;
	xa = floatround(fX) - 1;
	ya = floatround(fY) - 1;
	za = floatround(fZ) - 1;
	switch(currentblock[playerid]){
		case 0: CreateDynamicArt3(stone, 5, xa, ya, za, 0, 0, 90); 
		case 1: CreateDynamicArt3(cobblestone, 5, xa, ya, za, 0, 0, 90); 
		case 2: CreateDynamicArt3(dirt, 5, xa, ya, za, 0, 0, 90); 
		case 3: CreateDynamicArt3(planks_oak, 5, xa, ya, za, 0, 0, 90); 
	}
	printf("%d %d %d", xa, ya, za);
	return 1;
}