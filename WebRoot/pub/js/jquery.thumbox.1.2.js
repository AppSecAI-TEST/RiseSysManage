function(a){a.fn.thumbox=function(b){var c={thumbs:5,overlayColor:"#999",overlayOpacity:.8,overlaySpeed:500,scrollSpeed:500,zoomSpeed:250,showOne:!1,keyboardNavigation:!0,wheelNavigation:!0,showLabel:!0,labelPosition:"bottom",descAttr:"alt",dockPosition:"top",timeOut:15,maxThumbWidth:0,maxThumbHeight:0,openImageEffect:"linear",closeImageEffect:"linear",scrollDockEffect:"linear"};b=a.extend(c,b);var d=[],e=void 0,f=void 0,g=void 0,h=void 0,i=void 0,j=!1,k=!1,l=!1,m=0;$all=a(this),storeData=function(a,b){for(key in b)a.data(key,b[key])},getStoredData=function(b){arr=[];for(key in c)void 0!==a(b).data(key)&&(arr[key]=a(b).data(key));return arr},$all.each(function(c,d){objList="A"==d.tagName?a(d):a(d).find("a"),1==objList.size()?(storeData(objList,b),a(objList).bind("click",function(c){a(this).blur(),c.preventDefault(),l=!1,img=a(this).find("img"),label=a(img).attr(b.descAttr),big=a(this).attr("href"),coord={left:a(img).offset().left,top:a(img).offset().top,width:a(img).outerWidth(),height:a(img).outerHeight()},C(big,label,coord,b)})):objList.each(function(c,e){a(e).bind("click",function(b){b.preventDefault(),a(this).blur(),l=!1,showDock(a(this).data("objlist"),a(this).data("params"),a(this).data("indeximg"))}),storeData(a(e),{indeximg:c+1,params:b,objlist:a(d)}),a(e).find("img").data("big",a(e).attr("href")),b.showOne&&c>0&&a(e).css({position:"absolute",left:-5e3,top:-3e3})})}),showDock=function(b,c,d){A(c),l=!1,w(),maxThumbW=0===B("maxThumbWidth")?1e6:B("maxThumbWidth"),maxThumbH=0===B("maxThumbHeight")?1e6:B("maxThumbHeight"),cls=!1,pgs='<div class="thumbox-page" page="1">',qtd=a(b).find("a > img").size(),pag=1,a(b).find("a > img").each(function(b,c){src=a(c).attr("src"),big=a(c).data("big"),lbl=a(c).attr("alt"),widthThumb=a(c).width(),heightThumb=a(c).height(),widthThumb>maxThumbW&&(heightThumb/=widthThumb/maxThumbW,widthThumb=maxThumbW),heightThumb>maxThumbH&&(widthThumb/=heightThumb/maxThumbH,heightThumb=maxThumbH),pgs+='<img src="'+src+'" alt="'+lbl+'" big="'+big+'" imgindex="'+(b+1)+'" width="'+widthThumb+'" height="'+heightThumb+'" />',(b+1)%B("thumbs")||(pgs+="</div>",cls=!0,qtd>b+1&&(pag+=1,pgs+='<div class="thumbox-page" page="'+pag+'">',cls=!1))}),cls||(pgs+="</div>"),a("body").append('<div id="thumbox-dock"><div class="thumbox-arrowdock thumbox-leftarrow" arrowdir="p"></div><div class="thumbox-scrollerpages"><div class="thumbox-pages">'+pgs+'</div></div><div class="thumbox-arrowdock thumbox-rightarrow" arrowdir="n"></div></div>'),a(".thumbox-page > img").bind("click",function(b){s()||D(a(b.target).attr("imgindex"))}).bind("mouseover",function(b){a(b.target).addClass("thumbox-hoverImage")}).bind("mouseout",function(b){a(b.target).removeClass("thumbox-hoverImage")}),a(".thumbox-arrowdock").bind("click",function(b){s()||(page=g,H("n"==a(b.target).attr("arrowdir")?page+1:page-1))}),B("wheelNavigation")&&n(),B("keyboardNavigation")&&a(document).bind("keydown",u),a("#thumbox-dock > .thumbox-leftarrow").fadeTo(0,.1),1==a(".thumbox-page").size()&&a("#thumbox-dock > .thumbox-rightarrow").fadeTo(0,.1),wmax=hmax=0,a(".thumbox-page").each(function(b,c){a(c).width()>wmax&&(wmax=a(c).width()),a(c).height()>hmax&&(hmax=a(c).height())}),a(".thumbox-page, .thumbox-scrollerpages, #thumbox-dock").css({width:wmax,height:hmax}),a(".thumbox-pages").css({width:wmax*a(".thumbox-page").size()}),a(".thumbox-arrowdock").css({height:hmax}),F(),e=!0,f=wmax,g=1,h=qtd,i=!1,j=!1,k=!1,tTop="top"==B("dockPosition")?a(document).scrollTop()+10:a(window).height()+a(document).scrollTop()-a("#thumbox-dock").height()-10,a("#thumbox-dock").css({top:tTop,width:wmax+40,left:a(window).width()/2-wmax/2-20}).hide().fadeIn(B("overlaySpeed"),function(){r(),void 0!=d&&H(Math.ceil(d/B("thumbs")),d)})};var n=function(){document.attachEvent?document.attachEvent("onmousewheel",p):window.addEventListener&&window.addEventListener(a.browser.mozilla?"DOMMouseScroll":"mousewheel",p,!1)},o=function(){document.detachEvent?document.detachEvent("onmousewheel",p):window.removeEventListener&&window.removeEventListener(a.browser.mozilla?"DOMMouseScroll":"onmousewheel",p,!1)},p=function(b){if(!(a.browser.msie&&Number(a.browser.version)<8||a.browser.opera)){var c=0;if(b||(b=window.event),b.wheelDelta?(c=b.wheelDelta/120,window.opera&&(c=-c)):b.detail&&(c=-b.detail/3),c)if(c>0){if(s())return;z()}else{if(s())return;y()}}},q=function(){e=!0},r=function(){e=!1},s=function(){return e},t=function(){return k},u=function(a){if(27==a.keyCode)return l=!0,void K();if(B("keyboardNavigation")&&-1!=jQuery.inArray(a.keyCode,[39,40,13,32,37,38,8,27,36,35])&&(a.preventDefault(),!s()))switch(a.keyCode){case 39:case 40:case 13:case 32:t()||y();break;case 37:case 38:case 8:t()||z();break;case 36:t()||D(1);break;case 35:t()||D(h);break;case 27:K()}},v=function(){a(document).unbind("keydown",u),o()},w=function(){a("#thumbox-loader").size()||(a("body").append('<div id="thumbox-loader"></div>'),a("#thumbox-loader").css({left:a(window).width()/2-64,top:a(window).height()/2+a(document).scrollTop()-7}))},x=function(){a("#thumbox-loader").remove()},y=function(){D(i+1)},z=function(){D(i-1)},A=function(b){d=b,void 0==a.easing.def&&(d.openImageEffect="linear",d.closeImageEffect="linear",d.scrollDockEffect="linear")},B=function(a){return d[a]},C=function(b,c,d,e){A(e),k=!0,w(),F(),E(d,b,c,void 0),B("wheelNavigation")&&n(),B("keyboardNavigation")&&a(window).bind("keydown",u)},D=function(b){if(!(1>b||b>h||i==b)){if(q(),page=Math.ceil(b/B("thumbs")),g!=page)return void H(page,b);if(a(".thumbox-page > img").removeClass("thumbox-currentImage"),a(".thumbox-page").find('img[imgindex="'+b+'"]').addClass("thumbox-currentImage"),i=b,thumb=a('.thumbox-page > img[imgindex="'+b+'"]'),urlImg=a(thumb).attr("big"),label=a(thumb).attr(B("descAttr")),w(),a("#thumbox-image").size())return void J(b);cord={left:a(thumb).offset().left+5,top:a(thumb).offset().top+5,width:a(thumb).outerWidth()-10,height:a(thumb).outerHeight()-10},E(cord,urlImg,label,b)}},E=function(b,c,d,e){j=b;var f=document.createElement("img");a("body").append(f),m=0;var g=setInterval(function(){m>B("timeOut")&&(clearInterval(g),l=!0,K(),G())},1e3);a(f).hide().attr("src",c);var i=new Image;i.onerror=null,i.onload=function(){return clearInterval(g),x(),l?void a(f).remove():(f.id="thumbox-image",f.src=c,imgWidth=i.width,imgHeight=i.height,a(f).css(b).show().animate({left:a(window).width()/2-imgWidth/2,top:a(window).height()/2-imgHeight/2+a(document).scrollTop(),width:imgWidth,height:imgHeight},{easing:B("openImageEffect"),duration:B("zoomSpeed"),complete:function(){l||(a("body").append('<div id="thumbox-border"></div>'),pos=jQuery(f).position(),a("#thumbox-border").hide().css({width:imgWidth+12,height:imgHeight+12,left:pos.left-6,top:pos.top-6}).fadeIn("normal",function(){r(),a("body").append('<div id="thumbox-close"></div>'),a("#thumbox-close").bind("click",function(){s()||K()}).css({left:pos.left-12+imgWidth,top:pos.top-6-12})}),1!=e&&void 0!=e&&(a("body").append('<div id="thumbox-buttonPrev"></div>'),a("#thumbox-buttonPrev").bind("click",function(){s()||z()})),e!=h&&void 0!=e&&(a("body").append('<div id="thumbox-buttonNext"></div>'),a("#thumbox-buttonNext").bind("click",function(){s()||y()})),topBtn=pos.top+imgHeight/2-33,a("#thumbox-buttonPrev").css({top:topBtn,left:pos.left-51}),a("#thumbox-buttonNext").css({top:topBtn,left:pos.left+imgWidth+10}),a.browser.msie||a("#thumbox-buttonPrev, #thumbox-buttonNext").hide().fadeIn(),B("showLabel")&&""!=d&&void 0!=d&&(a("body").append('<div id="thumbox-label"></div>'),a("#thumbox-label").html(d),topPosLabel="bottom"==B("labelPosition")?pos.top+imgHeight+10:pos.top-25-a("#thumbox-label").height(),a("#thumbox-label").css({top:topPosLabel,left:pos.left+imgWidth/2-a("#thumbox-label").width()/2}),a.browser.msie||a("#thumbox-label").hide().fadeIn()))}}),void(i.onload=function(){}))},i.src=c},F=function(){a("body").append('<div id="thumbox-overlay"></div>').css({overflow:"hidden"}),a("#thumbox-overlay").bind("click",function(){l=!0,K()}).css({width:a(window).width(),height:a(document).height(),background:B("overlayColor")}).fadeTo(B("overlaySpeed"),B("overlayOpacity"))},G=function(){a("#thumbox-overlay").fadeOut(B("overlaySpeed"),function(){a("#thumbox-overlay").remove().unbind(),x(),a("body").css({overflow:"auto"})})},H=function(b,c){return page=g,move=!0,b==page&&(move=!1),dir=b>page?"n":"p",siz=Math.abs(b-page)*f,"p"==dir&&1==page&&(move=!1),"n"==dir&&page>=a(".thumbox-page").size()&&(move=!1),move?(walk=("n"==dir?"-":"+")+"="+siz,g=b,j=!1,1==b?a("#thumbox-dock > .thumbox-leftarrow").fadeTo("normal",.1):a("#thumbox-dock > .thumbox-leftarrow").fadeTo("normal",1),b==a(".thumbox-page").size()?a("#thumbox-dock > .thumbox-rightarrow").fadeTo("normal",.1):a("#thumbox-dock > .thumbox-rightarrow").fadeTo("normal",1),a(".thumbox-pages").animate({left:walk},{easing:B("scrollDockEffect"),duration:B("scrollSpeed"),complete:function(){void 0!=c?D(c):r()}}),void 0):void(void 0!=c?D(c):r())},I=function(){a("#thumbox-border").remove(),els="#thumbox-close, #thumbox-buttonNext, #thumbox-buttonPrev, #thumbox-label",a.browser.msie?a(els).unbind().remove():a(els).unbind().fadeOut("fast",function(){a(els).remove()})},J=function(b,c){a("#thumbox-image").size()&&(I(),coord=0!=j?j:{left:a(window).width()/2,top:a(window).height()/2+a(document).scrollTop(),width:0,height:0},a("#thumbox-image").animate(coord,{easing:B("closeImageEffect"),duration:B("zoomSpeed"),complete:function(){a("#thumbox-image").remove(),i=!1,void 0!=b?D(b):v(),void 0!=c&&K()}}))},K=function(){q(),a("#thumbox-image").size()?J(void 0,!0):(v(),a("#thumbox-dock").size()?(I(),a("#thumbox-dock").fadeOut(B("overlaySpeed"),function(){x(),a(".thumbox-arrowdock, .thumbox-page > img").unbind(),a("#thumbox-dock").remove(),G()})):G())}}}(jQuery,document);