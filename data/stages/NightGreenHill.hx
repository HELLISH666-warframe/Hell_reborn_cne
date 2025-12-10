function postCreate() {
    Hand.visible=Evilsky.visible=Dead_Mountain.visible=Dead_Grass.visible=false;
}

public function spawn(val:String) {
    switch(val){
        case 'dead': Evilsky.visible=Dead_Mountain.visible=Dead_Grass.visible=true;
        case 'alive': Evilsky.visible=Dead_Mountain.visible=Dead_Grass.visible=false;
    }
}