class KFPawn_HT extends KFPawn_Human;

function ThrowWeaponOnDeath()
{
	local KFWeapon TempWeapon;
	
	if(InvManager != none)
	{
		foreach InvManager.InventoryActors(class'KFWeapon', TempWeapon)
		{
			if (TempWeapon != none && TempWeapon.bDropOnDeath && TempWeapon.CanThrow())
			{
				TossInventory(TempWeapon);
			}
		}
	}
}


function PlayTraderDialog( AkEvent DialogEvent )
{
    return;
}

