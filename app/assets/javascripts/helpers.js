function Bullet(x,y,vely) {
	this.x = x;
	this.y = y;
	this.vely = vely;
};

Bullet.prototype.update = function() {
	this.y += this.vely;
};

function getPos(el) {
     var rect=el.getBoundingClientRect();
     return {x:rect.left,y:rect.top, z:rect.bottom, w:rect.right};
};

function Screen() {
	this.canvas = document.createElement("canvas");
	var ta = document.getElementsByClassName("container");
	this.canvas.width = this.width = getPos(ta[1]).w-getPos(ta[1]).x;
	this.canvas.height = this.height = ta[2].clientHeight;
	ta[2].remove();
	this.ctx = this.canvas.getContext("2d");
	document.body.appendChild(this.canvas);
	this.canvas.style.margin = "auto";
	this.canvas.style.display = "block";
	this.canvas.style.backgroundColor = "#000";
	this.canvas.style.position = "relative";
};

Screen.prototype.drawSprite = function(sp,x,y){
	this.ctx.drawImage(sp.img,sp.x, sp.y, sp.w, sp.h, x, y, sp.w, sp.h);
};

function Sprite(img,x,y,w,h) {
	this.img = img;
	this.x = x;
	this.y = y;
	this.w = w;
	this.h = h;
};

function InputHandler() {
	this.down = {};
	this.pressed = {};
	
	var _this = this;
	document.addEventListener("keydown",function(evt) {
		_this.down[evt.keyCode] = true;
	});
	document.addEventListener("keyup", function(evt) {
		delete _this.down[evt.keyCode];
		delete _this.pressed[evt.keyCode];
	});
};

InputHandler.prototype.isDown = function(code) {
	return this.down[code];
};

InputHandler.prototype.isPressed = function(code) {
	if (this.pressed[code]) {
		return false;
	} else if (this.down[code]) {
		return this.pressed[code] = true;
	}
	return false;
};