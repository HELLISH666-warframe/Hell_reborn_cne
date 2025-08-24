function onNoteHit(e){
    if (e.noteType == "GF Sing"){
        e.cancelAnim();
        gf.playSingAnim(e.direction, e.animSuffix);
    }
}