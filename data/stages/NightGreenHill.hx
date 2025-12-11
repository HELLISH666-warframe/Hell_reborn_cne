function postCreate() {
    Hand.alpha=Evilsky.alpha=Dead_Mountain.alpha=Dead_Grass.alpha=0;
}

public function spawn(val:String) {
    switch(val){
        case 'dead': Evilsky.alpha=Dead_Mountain.alpha=Dead_Grass.alpha=1;
        strumLines.members[0].characters[0].alpha=strumLines.members[1].characters[0].alpha=0;
        strumLines.members[0].characters[1].alpha=strumLines.members[1].characters[1].alpha=1;
        iconP2.setIcon('x');
        iconP1.setIcon('tails');
        case 'alive': Evilsky.alpha=Dead_Mountain.alpha=Dead_Grass.alpha=0;
        strumLines.members[0].characters[0].alpha=strumLines.members[1].characters[0].alpha=1;
        strumLines.members[0].characters[1].alpha=strumLines.members[1].characters[1].alpha=0;
        iconP2.setIcon('Xain');
        iconP1.setIcon('tailsbff');
    }
}