function onNoteHit(e){
	switch(e.noteType){
		case "strumLine3Sing"|"gf-sing":e.cancelAnim();
        strumLines.members[2].characters[0].playSingAnim(e.direction, e.animSuffix);
		case "strumLine4Sing":e.cancelAnim();
        strumLines.members[3].characters[0].playSingAnim(e.direction, e.animSuffix);	
		case "no-anim":e.cancelAnim();
		case "strumLine5Sing":e.cancelAnim();
        strumLines.members[4].characters[0].playSingAnim(e.direction, e.animSuffix);
	}
}