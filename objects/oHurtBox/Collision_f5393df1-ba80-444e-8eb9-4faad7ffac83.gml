/// @description Hit resolution
// You can write your code in this editor

if(self.owner != other.owner){	
	if(instance_exists(self.owner)){
		if(!other.ignoreList[? self.owner]){			
			self.owner.hitPoints-= other.damage;
			other.ignoreList[? self.owner] = 1;
		}
	}		
}