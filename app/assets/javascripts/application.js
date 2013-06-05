// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

function convertToFloat(obj, event, decimal) {
    var value = obj.value.replace(/[^0-9.]/g,'');
    var ascii = event.which;
    var convertedNum = parseFloat(value);

    if (ascii == 8) { //backspace
        if (value == 0) {
            convertedNum = 0;
        } else {
            convertedNum = value/10;
        }
    } else if (ascii >= 48 && ascii <= 57 && value < 1000000) {
        convertedNum = value*10;
    }
    obj.value = convertedNum.toFixed(decimal);
    return;
}

function setCursorAtEnd(node){
    setTimeout(function(){
        setCursor(node,node.value.length);
    },10);
}

function setCursor(node,pos){

    var node = (typeof node == "string" || node instanceof String) ? document.getElementById(node) : node;

    if(!node){
        return false;
    }else if(node.createTextRange){
        var textRange = node.createTextRange();
        textRange.collapse(true);
        textRange.moveEnd(pos);
        textRange.moveStart(pos);
        textRange.select();
        return true;
    }else if(node.setSelectionRange){
        node.setSelectionRange(pos,pos);
        return true;
    }

    return false;
}