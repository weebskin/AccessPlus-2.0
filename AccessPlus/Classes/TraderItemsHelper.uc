class TraderItemsHelper extends ReplicationInfo;

struct SItem
{
	var string	DefPath;
	var int		TraderId;
};
var array<string> CustomItems;

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if(!ModifyTraderItems())
	{
		SetTimer(1.0, true, 'CheckTraderItems'); 
	}
}

simulated function CheckTraderItems()
{
	if(ModifyTraderItems())
	{
		ClearTimer('CheckTraderItems');
	}
}

simulated function bool ModifyTraderItems()
{
	local KFGameReplicationInfo KFGRI;
	local int I;
	local KFGFxObject_TraderItems TraderItems;
	local STraderItem SaleItem;
	local class<KFWeaponDefinition> WeaponDef;
	local class<KFWeapon> WeaponClass;

	KFGRI = KFGameReplicationInfo(WorldInfo.GRI);

	if(KFGRI != none)
	{
		TraderItems = KFGRI.TraderItems;
	}
	else
	{
		return false;
	}
	if(TraderItems == none)
	{
		return false;
	}

	for (I = 0;I < CustomItems.Length; i++)
	{
		WeaponDef = class<KFWeaponDefinition>(DynamicLoadObject(CustomItems[I], class'Class'));
		WeaponClass = class<KFWeapon>(DynamicLoadObject(WeaponDef.default.WeaponClassPath, class'Class'));

		if((WeaponDef != none) && WeaponClass != none)
		{
			SaleItem.WeaponDef = WeaponDef;
			SaleItem.ClassName = WeaponClass.Name;

			if((class<KFWeap_DualBase>(WeaponClass) != none) && class<KFWeap_DualBase>(WeaponClass).default.SingleClass != none)
			{
				SaleItem.SingleClassName = class<KFWeap_DualBase>(WeaponClass).default.SingleClass.Name;
			}

			if(WeaponClass.default.DualClass != none)
			{
				SaleItem.DualClassName = WeaponClass.default.DualClass.Name;
			}
			SaleItem.AssociatedPerkClasses = WeaponClass.static.GetAssociatedPerkClasses();
			SaleItem.MaxSpareAmmo = WeaponClass.default.SpareAmmoCapacity[0];
			SaleItem.InitialSpareMags = byte(WeaponClass.default.InitialSpareMags[0]);
			SaleItem.MagazineCapacity = byte(WeaponClass.default.MagazineCapacity[0]);
			SaleItem.InitialSecondaryAmmo = byte(WeaponClass.default.InitialSpareMags[1] * WeaponClass.default.MagazineCapacity[1]);
			SaleItem.MaxSecondaryAmmo = byte(WeaponClass.default.SpareAmmoCapacity[1]);
			SaleItem.BlocksRequired = WeaponClass.default.InventorySize;
			SaleItem.InventoryGroup = WeaponClass.default.InventoryGroup;
			SaleItem.GroupPriority = WeaponClass.default.GroupPriority;
			SaleItem.TraderFilter = WeaponClass.static.GetTraderFilter();
			SaleItem.AltTraderFilter = WeaponClass.static.GetAltTraderFilter();

			if(WeaponClass.default.SecondaryAmmoTexture != none)
			{
				SaleItem.SecondaryAmmoImagePath = "img://" $ PathName(WeaponClass.default.SecondaryAmmoTexture);
			}
			WeaponClass.static.SetTraderWeaponStats(SaleItem.WeaponStats);
			SaleItem.ItemId = TraderItems.SaleItems.Length;
			TraderItems.SaleItems.AddItem(SaleItem);
		}
		else
		{
			continue;
		}
	}
	return true;
}

defaultproperties
{

}

