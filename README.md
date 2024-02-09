# Exile-Take-All-Fixes


What it does: This fixes a couple of issues and bugs with the take all function.
- Leaving Vest/Uniform/Backpack on the ground even tho slot is empty and the player could pick it up.
- Picking up multiple NVG/GPS (You can now bulk pickup these from containers).
- Multiple NVG's delete bug (TakeAll on a container with multiple NVG's deletes them). 
- Unnecessary network call for poptabs if the object has no poptabs.

# Installation
1. Download ExileClient_util_playerEquipment_canAdd & ExileClient_util_playerCargo_takeAll, copy them to your missionfile and add the CfgExileCustomCode override entries for it in the Exile config (\yourMission\config.cpp).
