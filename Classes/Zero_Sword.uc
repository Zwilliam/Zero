class Zero_Sword extends UTWeapon;

defaultproperties
{
	Begin Object Name=PickupMesh
		SkeletalMesh=SkeletalMesh'GDC_Materials.Meshes.SK_ExportSword2'
	End Object

		Begin Object Name=FirstPersonMesh
		SkeletalMesh=SkeletalMesh'GDC_Materials.Meshes.SK_ExportSword2'
		AnimSets(0)=AnimSet'GDC_Materials.Meshes.SwordAnimset'
		
	End Object
InstantHitDamage(0)=100.0
InstantHitDamage(1)=50.0

DefaultAnimSpeed=0.9

AttachmentClass=class 'Zero_Sword_Attachment'
       
       PivotTranslation=(Y=-25.0)
       
	ShotCost(0)=0
ShotCost(1)=0

MessageClass=class'UTPickupMessage'
DroppedPickupClass=None

MaxAmmoCount=1
AmmoCount=1

WeaponRange=100
}


