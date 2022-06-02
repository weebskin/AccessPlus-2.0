class KFDT_Microwave_Blast_EX extends KFDT_Microwave_Blast
	abstract
	hidedropdown;

DefaultProperties
{
	// This weapon uses radial impulses
	RadialDamageImpulse=5000
	KDamageImpulse=0
	KDeathUpKick=500.0
	KDeathVel=300

	// unreal physics momentum
	bExtraMomentumZ=True
	
	KnockdownPower=200
	StumblePower=3000
	GunHitPower=0
	MeleeHitPower=0

	MicrowavePower=3000

	EffectGroup=FXG_MicrowaveBlast
	//bCanObliterate=true
	//ObliterationHealthThreshold=-75
	//ObliterationDamageThreshold=100
	bCanGib=true
	GoreDamageGroup=DGT_Obliteration

	WeaponDef=class'KFWeapDef_MicrowaveGun'
	ModifierPerkList(0)=class'KFPerk_Firebug'
}
