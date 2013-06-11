class Zero_Sword_Attachment extends UTWeaponAttachment;
var ParticleSystemComponent SwordEffect;
var Name EffectSocket;


simulated function ThirdPersonFireEffects(vector HitLocation)
{
	
	Mesh.PlayAnim('WeaponFire');
	UTPawn(Instigator).FullBodyAnimSlot.PlayCustomAnimByDuration('hoverboardjumprtwarmup' , 0.6, 0.2, 0.2 , FALSE, TRUE);
Mesh.AttachComponentToSocket(SwordEffect,EffectSocket);
Super.ThirdPersonFireEffects(HitLocation);
}

defaultproperties
{
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'GDC_Materials.Meshes.SK_ExportSword2'
	End Object

	WeaponClass=class'Zero_Sword'

	MuzzleFlashSocket=MuzzleFlashSocket
	
	//Begin Object Class=ParticleSystemComponent Name=EffectComponent
		//Template=ParticleSystem'ZeroPackage.SwordTest'
	End Object
	SwordEffect=EffectComponent
	
}