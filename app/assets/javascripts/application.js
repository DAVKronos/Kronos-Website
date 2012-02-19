// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap
setTimeout("$('.flash.success').fadeOut('slow');", 3000);
var beginX, beginY = 0;
var first = true;

var numberofphotos = 0;
var selectedphoto = 0;
var scrollphoto = 0;

function dowhenloaded(){
    if(window.document.getElementById("numberofphotosinalbum")){
        numberofphotos = window.document.getElementById("numberofphotosinalbum").value;
        selectedphoto = window.document.getElementById("selectedphotoinalbum").value;
        scrollphoto = selectedphoto - 2;
        if(selectedphoto < 2){
            scrollphoto = 0;
        }
        if(selectedphoto > numberofphotos - 3){
            scrollphoto = numberofphotos - 5;
            if(scrollphoto < 0){
                scrollphoto = 0;
            }
        }
        if(scrollphoto == 0){
            window.document.getElementById("imprev").style.display = "none";
        }
        if(scrollphoto >= (numberofphotos - 5)){
            window.document.getElementById("imnext").style.display = "none";
        }
        for(i=scrollphoto;(i<scrollphoto+5 && i<numberofphotos);i++){
            window.document.getElementById("image"+i).style.display = "inline-block";
        }
    }
}

function getDetails(obj){
    imagewidth = obj.width;
    imageheight = obj.height;
    if(first)
    {
        beginX = window.event.x-obj.offsetLeft;
        beginY = window.event.y-obj.offsetTop;
        window.document.getElementById("tag_xpos").value = Math.round(beginX*100/imagewidth);
        window.document.getElementById("tag_ypos").value = Math.round(beginY*100/imageheight);
        window.document.getElementById("tag_width").value = 1;
        window.document.getElementById("tag_heigth").value = 1;
        first = false;
        
        window.document.getElementById("demo_tag").style.left = Math.round((beginX*100/imagewidth)).toString()+"%";
        window.document.getElementById("demo_tag").style.top = Math.round((beginY*100/imageheight)).toString()+"%";
        window.document.getElementById("demo_tag").style.width = "1%";
        window.document.getElementById("demo_tag").style.height = "1%";
    }
    else
    {
        clickX = window.event.x-obj.offsetLeft;
        clickY = window.event.y-obj.offsetTop;
        if(clickX < beginX)
        {
            temp = beginX;
            beginX = clickX;
            clickX = temp;
        }
        if(clickY < beginY)
        {
            temp = beginY;
            beginY = clickY;
            clickY = temp;
        }
        wX = clickX - beginX;
        hY = clickY - beginY;
        window.document.getElementById("tag_xpos").value = Math.round(beginX*100/imagewidth);
        window.document.getElementById("tag_ypos").value = Math.round(beginY*100/imageheight);
        window.document.getElementById("tag_width").value = Math.round(wX*100/imagewidth);
        window.document.getElementById("tag_heigth").value = Math.round(hY*100/imageheight);
        first = true;
        
        window.document.getElementById("demo_tag").style.left = Math.round((beginX*100/imagewidth)).toString()+"%";
        window.document.getElementById("demo_tag").style.top = Math.round((beginY*100/imageheight)).toString()+"%";
        window.document.getElementById("demo_tag").style.width = Math.round((wX*100/imagewidth)).toString()+"%";
        window.document.getElementById("demo_tag").style.height = Math.round((hY*100/imageheight)).toString()+"%";
    }
}

function showprev(obj){
    numberofphotos = window.document.getElementById("numberofphotosinalbum").value;
    window.document.getElementById("imnext").style.display = "inline";
    scrollphoto--;
    if(scrollphoto == 0){
        obj.style.display = "none";
    }
    if(scrollphoto < 0){
        scrollphoto = numberofphotos - 1;
    }
    
    for(i=0;i<numberofphotos;i++){
        window.document.getElementById("image"+i).style.display = "none";
    }
    for(i=scrollphoto;(i<scrollphoto+5 && i<numberofphotos);i++){
        window.document.getElementById("image"+i).style.display = "inline-block";
    }
}

function shownext(obj){
    numberofphotos = window.document.getElementById("numberofphotosinalbum").value;
    window.document.getElementById("imprev").style.display = "inline";
    scrollphoto++;
    if(scrollphoto >= numberofphotos){
        scrollphoto = 0;
    }
    if(scrollphoto >= numberofphotos - 5){
        obj.style.display = "none";
    }
    
    for(i=0;i<numberofphotos;i++){
        window.document.getElementById("image"+i).style.display = "none";
    }
    for(i=scrollphoto;(i<scrollphoto+5 && i<numberofphotos);i++){
        window.document.getElementById("image"+i).style.display = "inline-block";
    }
}

function include(arr, obj){
    for(var i=0; i<arr.length; i++) {
        if (arr[i] == obj) return i;
    }
    return false;
}

function changepicture(){
    index = window.document.getElementById("tag_photo_id").selectedIndex;
    selected_option_text = window.document.getElementById("tag_photo_id").options[index].text;
    
    captiontourlarray = window.document.getElementById("captiontourl").value.split('**$$**');
    plaats = include(captiontourlarray, selected_option_text);
    window.document.getElementById("picture").src = captiontourlarray[plaats+1];
}