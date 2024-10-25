using { /Fortnite.com/Devices }

crop := class<concrete>:
    @editable CropModel : creative_prop_asset = DefaultCreativePropAsset 
    @editable InteractionRadius : float = 200.0 
    @editable ItemGiver : item_granter = item_granter{}


    OnBegin<override>():void=
        SpawnCrop()
        SetInteractionTrigger()

    SpawnCrop():void=
        SpawnProp(CropModel, GetTransform())

    SetInteractionTrigger():void=
        var TriggerArea : trigger_device = trigger_device{}
        TriggerArea.SetRadius(InteractionRadius) 
        TriggerArea.OnPlayerEntered.Subscribe(OnPlayerApproach)

    OnPlayerApproach(Player : player):void=
        var PlayerAgent = agent[Player] 
        PlayerAgent.ShowInteractionButton("Collect Crop")
        PlayerAgent.OnInteractionPressed.Subscribe(() => GiveCropToPlayer(Player))


    GiveCropToPlayer(Player : player):void=
        ItemGiver.GiveItemToPlayer(Player) 
        StartGrowAgain()

    StartGrowAgain():void=
        Dispose() 
        var SmallCropModel : creative_prop_asset = CropModel.GetScaled(0.5) 
        SpawnProp(SmallCropModel, GetTransform())
        Sleep(5.0)
        GrowBack()

    GrowBack():void=
        SpawnCrop()