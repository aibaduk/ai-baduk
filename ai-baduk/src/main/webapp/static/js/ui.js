var Browser = {chk : navigator.userAgent.toLowerCase()}
Browser = {ie : Browser.chk.indexOf('msie') != -1, ie6 : Browser.chk.indexOf('msie 6') != -1, ie7 : Browser.chk.indexOf('msie 7') != -1, ie8 : Browser.chk.indexOf('msie 8') != -1, ie9 : Browser.chk.indexOf('msie 9') != -1, ie10 : Browser.chk.indexOf('msie 10') != -1, ie11 : Browser.chk.indexOf('msie 11') != -1, opera : !!window.opera, safari : Browser.chk.indexOf('safari') != -1, safari3 : Browser.chk.indexOf('applewebkir/5') != -1, mac : Browser.chk.indexOf('mac') != -1, chrome : Browser.chk.indexOf('chrome') != -1, firefox : Browser.chk.indexOf('firefox') != -1}
var responCheck = Browser.ie7 || Browser.ie8;

// mobile case :: scroll size
var mobile = (/iphone|ipod|ipad|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));
if (mobile) {
  $("html").addClass("mobile");
}

if (Browser.ie7) {
  $("html").addClass("ie7");
} else if(Browser.ie8){
  $("html").addClass("ie8");
} else if(Browser.ie9){
  $("html").addClass("ie9");
} else if(Browser.ie10){
  $("html").addClass("ie10");
} else {
  // mordern brow.
} function lowMsg(){
  //document.write('<div style="position:absolute; top:0; right:0; border:3px solid black">ie7/8</div>');
}

var baduk = baduk || {
    init:function() {
        baduk.gnb.init();
        baduk.tab.init();
        baduk.introduce();
        baduk.myChart('.mychart-wrap .chart', mychart);
        baduk.recordChart('.record .chart', record);
    },
    gnb: {
        init: function(){
            $win = $(window);
            $menu = $('.btn-menu');
            $nav = $('header aside');
            $navLi = $('nav >ul >li >a');
            this.event();
        },
        event: function(){
            $menu.on('click', function(e){
                e.preventDefault();
                $('html,body').css({'overflow':'hidden','position':'fixed','height':'100%'});
                $nav.show().animate({left:0},300);
                $nav.prepend('<span class="dimmed"></span>');
            });
            $nav.on('click', '.btn-close, .dimmed', function(e){
                e.preventDefault();
                $('html,body').attr('style','');
                $nav.animate({left:'100%'},200, function(){
                    $(this).hide();
                    $('.dimmed').remove();
                });
            });
            $navLi.on('click', function(e){
                e.preventDefault();
                var $this = $(this),
                    $depthTarget = $this.next();
                    $siblings = $this.parent().siblings();
                $siblings.find('ul').slideUp(250);
                $this.parent('li').addClass('active').siblings().removeClass('active');
                $depthTarget.slideDown(300);
            });
        }
    },//gnb
    tab : {
        init: function(){
          if ($(".as-tab-wrap").length == 0) {return;}
          $tabEle = $(".as-tab-menu > li");
          this.event();
        },
        event: function(){
          var tab = this;
          $tabEle.find('a[href^="#"]').click(function(e){e.preventDefault();});
          $tabEle.on("click", function(e){
            tab.action($(this), $(this).closest(".as-tab-menu").find(" > li").index(this));
          });
          $tabEle.not(":hidden").each(function() {
            if ($(this).parent(".as-tab-menu").hasClass("flexible")){
              return;
            } else {
              var menuEa = $(this).parent(".as-tab-menu").find("li").length;
              var menuSize = (100/menuEa);
              $(this).parent(".as-tab-menu").find("li").width(menuSize+"%");
            }
          });
          if (($tabEle).hasClass("on")) {
            $(".as-tab-wrap > .as-tab-menu > li.on > a").trigger("click");
          } else {
            $(".as-tab-wrap > .as-tab-menu > li:first-child > a").trigger("click");
          }
        },
        action: function(ele, getIndex){
          var $findNode = $(ele);
          var $findEle = $findNode.closest(".as-tab-wrap ").find(" > .inner-depth > .tab-inner");
          $(ele).addClass("on").siblings().removeClass("on");
          $findEle.css("display","none");
          $findEle.eq(getIndex).css("display","block");
        }
    },//tab menu
    layerOpen:function(e, ele){
      var name_id = $('#'+ele),
        refFocusEl = e,
        $htmlH = $("html").scrollTop();
        name_id.attr('tabindex', '0').fadeIn().focus();
        name_id.append('<a href="#" class="loop">포커스이동</a>');
        $('.loop').focus(function(){
            name_id.attr('tabindex', '0').fadeIn().focus();
        });
        $('html,body').css({'overflow':'hidden','position':'fixed','height':'100%'});
        $(window).resize(function(){
            var win_h = $(window).outerHeight();
            var win_w = $(window).outerWidth();
            var pop_h = name_id.find('.pop-layer').outerHeight();
            var pop_w = name_id.find('.pop-layer').outerWidth();
            var position_top =  (win_h - pop_h) / 2;
            var position_left = (win_w - pop_w) / 2;
            if(position_top <= 0){position_top = 0;}
            if(position_left <= 0){position_left = 0;}
            name_id.find('.pop-layer').css({'top':position_top,'left':position_left});
            pop_h >= win_h ? $('.dimmed').css('height',pop_h) : $('.dimmed').css('height', 100 + "%");
            pop_w >= win_w ? $('.dimmed').css('width',pop_w) : $('.dimmed').css('width', 100 + "%");
        }).resize();
        //close
        name_id.find('.btn-close, .dimmed').click(function(e){
            e.preventDefault();
            e.stopPropagation();
            refFocusEl.focus();
            $('.loop').remove();
            $('.wrap-layer-popup').fadeOut();
            $('html,body').attr('style','');
            $("html").scrollTop($htmlH)
        });
    },//layerOpen
    introduce:function(){
        if($(".intro").length == 0) {return;}
        var idx = getParameterByName('tab');
        $(".intro .as-tab-menu >li").eq(idx).css('color','red').trigger('click');
        //Parameter
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                    results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
    },//introduce
    myChart:function($this, data){
        if($($this).length == 0){return;}
        var box = $($this),
            max = Math.max,
            sin = Math.sin,
            cos = Math.cos,
            width = box.width(),
            HALF_PI = Math.PI / 2;
        var cfg = {
            margin: {top:Math.round(width*.0585), right:Math.round(width*.1797), bottom:Math.round(width*.0101), left:Math.round(width*.1393)},
            w: Math.round(box.width() - (width*.3212)),
            h: Math.round(box.height() - (width*.0686)),
            levels: 5,
            maxValue: 0,
            labelFactor: 1.1,
            wrapWidth: 0,
            opacityArea: 0.7,
            dotRadius: 0,
            opacityCircles: 0.1,
            strokeWidth: 2,
            roundStrokes: false,
            format: '',
            unit: '',
            legend: false
        };
        if('undefined' !== typeof options){
          for(var i in options){
            if('undefined' !== typeof options[i]){ cfg[i] = options[i]; }
          }
        }
        var maxValue = 0;
        for(var j=0; j < data.length; j++) {
            for(var i = 0; i < data[j].axes.length; i++) {
                if (data[j].axes[i]['value'] > maxValue) {
                    maxValue = data[j].axes[i]['value'];
                }
            }
        };
        maxValue = max(cfg.maxValue, maxValue);
        var allAxis = data[0].axes.map(function(i, j){return i.axis}),
            total = allAxis.length,
            radius = Math.min(cfg.w/2, cfg.h/2),
            Format = d3.format(cfg.format),
            angleSlice = Math.PI * 2 / total;
        var rScale = d3.scaleLinear()
            .range([0, radius])
            .domain([0, maxValue]);
        var parent = d3.select($this);
        parent.select('svg').remove();
        var svg = parent.append('svg').attr('width',  box.width()).attr('height', box.height()).attr('class', 'radar');
        var g = svg.append('g').attr('transform', 'translate(' + (cfg.w/2 + cfg.margin.left) + ',' + (cfg.h/2 + cfg.margin.top) + ')');
        var filter = g.append('defs').append('filter').attr('id','glow'),
            feGaussianBlur = filter.append('feGaussianBlur').attr('stdDeviation','2.5').attr('result','coloredBlur'),
            feMerge = filter.append('feMerge'),
            feMergeNode_1 = feMerge.append('feMergeNode').attr('in','coloredBlur'),
            feMergeNode_2 = feMerge.append('feMergeNode').attr('in','SourceGraphic');
        var axisGrid = g.append('g').attr('class', 'axisWrapper');
        var axis = axisGrid.selectAll('.axis')
            .data(allAxis)
            .enter()
            .append('g')
            .attr('class', 'axis');
        axis.append('text')
            .attr('class', function(d, i){return 'legend'+i})
            .attr('dy', '.5em')
            .attr('x', function(d, i){return rScale(maxValue * cfg.labelFactor) * cos(angleSlice * i - HALF_PI)})
            .attr('y', function(d, i){return rScale(maxValue * cfg.labelFactor) * sin(angleSlice * i - HALF_PI)})
            .text(function(d){return d});
        var radarLine = d3.radialLine()
            .curve(d3.curveLinearClosed)
            .radius(function(d){return rScale(d.value)})
            .angle(function(d, i){return i * angleSlice});
        if(cfg.roundStrokes) {
            radarLine.curve(d3.curveCardinalClosed)
        }
        var blobWrapper = g.selectAll('.radarWrapper')
            .data(data)
            .enter().append('g')
            .attr('class', 'radarWrapper');
        blobWrapper
            .append('path')
            .attr('class', 'radarArea')
            .attr('d', function(d){return radarLine(d.axes)})
            .style('fill', function(d,i){return data[i].color})
            .style('fill-opacity', cfg.opacityArea)
            .on('mouseover', function(d, i){
                parent.selectAll('.radarArea')
                    .transition().duration(200)
                    .style('fill-opacity', 0.7);
                d3.select(this)
                    .transition().duration(200)
                    .style('fill-opacity', 0.7);
            })
            .on('mouseout', function(d, i){
                parent.selectAll('.radarArea')
                    .transition().duration(200)
                    .style('fill-opacity', cfg.opacityArea);
            });
        return svg;
    },//myChart
    recordChart:function($this, data){
        if($($this).length == 0){return;}
        var box = $($this),
            dataSet = data,
            cont = '';
        $.each(dataSet, function (index, item){
            cont += '<div class="item"><strong>'+item.tit+'</strong><div class="bar"><span style="width:'+item.percent+'%;background-color:'+item.color+';"></span></div><p>'+item.percent+'%</p></div>';
        });
        box.append(cont);
    },//recordChart
};

window.onload = function(){
    baduk.init();
};