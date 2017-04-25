/**
 * Description:框架控制脚本
 * @author Seadon
 * @date 2016年2月06日
 *
 */

idefine(function(require, exports, module) {
  require('bootstrap');
  require('nicescroll');
  require('message');
  require('bootbox');
  require('toastr');
  require('app_plugin');
  require('lib/app/pop_label');
  // require.async('echarts_v2');
  var _tool = require('udmp/lib/util_tool');

  window.onload = function() {
    i_web_pg.finish()
  };

  (function($) {
    var $search = $('.i-search-txt');

    //滚动条美化
    $(".i-scroll,#winModal,#secondModal").niceScroll({
      styler: "fb",
      cursorcolor: "#e8403f",
      cursorwidth: '6',
      cursorborderradius: '10px',
      background: '#404040',
      horizrailenabled: false,
      cursorborder: '',
      zindex: '1000'
    });

    //窗口大小改变时触发
    $(window).resize(function() {
      if (document.body.clientWidth < 770)
        $('.i-aside-xs').removeClass('i-aside-xs');
    })
    $('#i-frame-tabs').multabs({
      monitor: '.i-nav-menu,.i-header-right,.i-my-work'
    });

    //bootstrap toggle增强
    $(document).on('click', '[data-toggle^="class"]', function(e) {
      e && e.preventDefault();
      var $this = $(e.target),
        $class, $target, $tmp, $classes, $targets;
      !$this.data('toggle') && ($this = $this.closest(
        '[data-toggle^="class"]'));
      $class = $this.data()['toggle'];
      $target = $this.data('target') || $this.attr('href');
      $class && ($tmp = $class.split(':')[1]) && ($classes = $tmp.split(','));
      $target && ($targets = $target.split(','));
      $classes && $classes.length && $.each($targets, function(index, value) {
        if ($classes[index].indexOf('*') !== -1) {
          var patt = new RegExp('\\s' +
            $classes[index].replace(/\*/g, '[A-Za-z0-9-_]+').split(' ').join(
              '\\s|\\s') +
            '\\s', 'g');
          $($this).each(function(i, it) {
            var cn = ' ' + it.className + ' ';
            while (patt.test(cn)) {
              cn = cn.replace(patt, ' ');
            }
            it.className = $.trim(cn);
          });
        }
        ($targets[index] != '#') && $($targets[index]).toggleClass($classes[
          index]) || $this.toggleClass($classes[index]);
      });
      $this.toggleClass('active');
    });

    //菜单tooptip
    $('[data-toggle="tooltip"]').tooltip();

    // 菜单触发事件
    $('.i-nav-menu').on('click', 'a', function(e) {
      var $this = $(e.target),
        $active;
      $this.is('a') || ($this = $this.closest('a'));

      $active = $this.parents().siblings('.active');

      $active && $active.toggleClass('active').find('> ul:visible').slideUp(
        200);

      if ($this.parent().hasClass('active')) {
        $this.next().slideUp(200);
      } else {
        $this.parents('ul:first').parent('li').addClass('active');
        $this.next().slideDown(200);
      }
      $this.parent().removeClass('cd').toggleClass('active');
      $this.next().is('ul') && e.preventDefault();
    });

    //小分辨率下，点击设置按钮触发
    $("#i-user-set").on("click", function() {
      var $dd = $(".dropdown");
      if ($dd.hasClass("open")) {
        $dd.removeClass("open");
      } else {
        setTimeout(function() {
          $dd.addClass("open");
        }, 100);
      }
    });

    //搜索功能
    $(".i-search-txt").on("keyup", function(e) {
      if(e&&e.keyCode==13){
        var _value = this.value;

        Multab.add({
          id: $search.data('menu'),
          title: $search.attr('title'),
          url: $search.data('url')
        });

        setTimeout(function(){
          var $document = $('.tab-content').find('.tab-pane:visible iframe').contents();
          $document.find('#name').val(_value);
          $document.find('#i-btn-query').trigger('click');
        },100);
      }
    });

    /*
     * 子页面调用模块，后续整合
     */

    //按下关闭按钮，触发表格刷新
    $("#inputForm").on("mousedown", "span.close",function(){
      $(this).prev().find(".lb_label").remove();
    })

    //提示信息调用
    window.showInfo = function(type, msg) {
      _tool.showInfo(type,msg);
    };

    //确认提示
    window.showConfirm = function(msg, callback) {
      _tool.showConfirm(msg,callback);
    };

    //提示框基类
    window.showBase = function(title,text,type,confirmtext,canceltext,showconfirm,showcancel,isconfirm,iscancel,callback,error,timer) {
      _tool.showBase(title,text,type,confirmtext,canceltext,showconfirm,showcancel,isconfirm,iscancel,callback,error,timer);
    };

    //关闭确认提示
    window.hideConfirm = function(msg, callback) {
      _tool.hideConfirm();
    };

    //确认信息
    window.showMsg = function(type, msg) {
      _tool.showMsg(type,msg);
    }

    //prompt
    window.showPrompt = function(type, title, callback) {
      _tool.showMsg(type,title,callback);
    }

  //获取URL地址参数
	window.getQueryString = function(name, url) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		if (!url || url == "") {
			url = window.location.search;
		} else {
			url = url.substring(url.indexOf("?"));
		}
		r = url.substr(1).match(reg)
		if (r != null) return unescape(r[2]);
		return null;
	}
    //调用loading模块
    window.showLoading = function() {
      $("<div>", {
        "class": "modal-backdrop fade in"
      }).appendTo('body');
      $("#loadingTips").text("努力加载中...");
      $("#loadingPage").css("opacity", "1").show();
    };
    window.hideLoading = function() {
      var $back = $(".modal-backdrop.in"),
        _true = $('body').is('.modal-open');
      $("#loadingTips").text("数据加载完成");
      _true && $back.length > 1 && $back.last().fadeOut(1000).remove();
      !_true && $back.fadeOut(1000).remove();
      $("#loadingPage").fadeOut(1000);
    }

    //子级设定scroll，兼容浏览器
    window.setScroll = function(num) {
      var $scr = $(".i-scroll").getNiceScroll().eq(1),
        _h = $scr.getScrollTop();
      $scr.setScrollTop(_h + parseInt(num));
    }

    //重新登录提示
    function showLogin() {
      showInfo("error", "会话已超时，请重新登录。");
      setTimeout(function(){window.document.location.href = $ctx + "/login";},3000);
    }

    //加载模态窗口
    window.showModal = function(url, html, params, buttons, callback, loadfunc) {
      var $modal = $("#winModal");
      //如果模态窗口已打开，则弹出二层模态窗口
      if ($modal.data("isShow")) {
        $modal = $("#secondModal");
      }
      //如果二层窗口已打开，则弹出三层模态窗口
      if ($modal.data("isShow")) {
        $modal = $("#thirdModal");
      }
      var $content = $modal.find(".modal-body .body-content").empty();
      if (params) {
        if (params.width) {
          $modal.find(".modal-dialog").width(params.width);
        }
        if (params.height) {
          $content.height(params.height);
        }
        if (params.overflow) {
    		  $content.css('overflow', params.overflow);
    		}
        if (params.minHeight) {
		        $content.css('min-height',params.minHeight);
        }
        if (params.title) {
          $modal.find(".modal-title .title-text").text(params.title);
        }
        if (params.confirmText) {
          $modal.find(".modal-footer .btn-confirm").text(params.confirmText);
        }
        if (params.cancelText) {
          $modal.find(".modal-footer .btn-cancel").text(params.cancelText);
        }
        if (params.confirmCallback) {
          $modal.find(".modal-footer .btn-confirm").data("callback", params.confirmCallback);
        }
      }
      if (buttons) {
        //TODO: 附加按钮
      }
      if (callback) {
        $modal.data("callback", callback);
      }

      if (url) {
        $.get(url, function(data) {
          setModalShow($modal, data);
          if(loadfunc) {
             loadfunc();
          }
        });
      } else {
        setModalShow($modal, html);
      }
    }

    //显示模态框
    function setModalShow($modal, html) {
      $modal.css({
        "display": "block"
      });
      //填充窗体内容
      var $back = $('.modal-backdrop'),
        $content = $modal.find(".modal-body .body-content").html(html),
        $mcontent = $modal.find(".modal-content");
      //替换自定义按钮组
      var $buttons = $modal.find(".my-buttons");
      if ($buttons.length) {
        $buttons.children().appendTo($modal.find(".modal-footer").empty());
        $buttons.hide();
      } else {
    	  var defaultButton = '<button type="button" class="btn i-btn-ok btn-confirm">确定</button>'+
		  					  '<button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">关闭</button>';
    	  $(defaultButton).appendTo($modal.find(".modal-footer").empty());

      }

      setTimeout(function(){
    	  //定位窗体到中间位置
	      var $dlg = $modal.find(".modal-dialog");
	      var margin = ($(window).height() - $mcontent.height() - 60) / 2;
	      if (margin < 10)
	        margin = 5;
	      $dlg.css("top", margin + "px");

	      //显示模态框
	      $modal.data("isShow", true);
	      $modal.modal({
	        backdrop: 'static',
	        keyboard: false
	      });
      },300)
    }

    //关闭模态窗口
    window.hideModal = function($modal) {
      if (!$modal) {
        if ($("#thirdModal").data("isShow")) {
          $modal = $("#thirdModal");
        } else if ($("#secondModal").data("isShow")) {
          $modal = $("#secondModal");
        } else {
          $modal = $("#winModal");
        }
      }
      $modal.data("isShow", false);
      $modal.modal("hide");
      if ($modal.data("callback"))
        $modal.data("callback")($modal);
    }
      //设置窗体数据
    window.setModalData = function(name, value, $modal) {
      if (!$modal) {
        if ($("#thirdModal").data("isShow")) {
          $modal = $("#thirdModal");
        } else if ($("#secondModal").data("isShow")) {
          $modal = $("#secondModal");
        } else {
          $modal = $("#winModal");
        }
      }
      $modal.data(name, value);
    }

    //获取窗体数据
    window.getModalData = function(name, $modal) {
      if (!$modal) {
        if ($("#secondModal").data("isShow")) {
          // 如果二层窗口已打开,表示刚才关闭的是三层窗口,取三层窗口数据
          $modal = $("#thirdModal");
        } else if ($("#winModal").data("isShow")) {
          // 如果一层窗口已打开,表示刚才关闭的是二层窗口,取二层窗口数据
          $modal = $("#secondModal");
        } else {
          $modal = $("#winModal");
        }
      }
      return $modal.data(name);
    }

    //重载本页
    window.reloadPage = function() {
      var $frame = $('body').find('.tab-content .tab-pane:visible iframe')[0].contentWindow;
      $frame.location.reload();
    }

    //通用模块初始化
    $(document).ready(function() {
      var $message = $("#message");

      var $drag = null; //要移动的模态窗口
      var _x, _y; //鼠标离控件左上角的相对位置

      //绑定右下角提示框关闭按钮点击事件
      $message.on("click", ".close", function() {
        hideMessage();
      });

      //绑定模态窗口关闭事件
      $(".modal").on("hidden.bs.modal", function(e) {
        $(this).find(".modal-dialog").removeClass("modal-lg").css("width",
          "none");
        $(this).find(".modal-title .title-text").text("标题");
        $(this).find(".alert").hide().removeClass().addClass("alert").find(
          ".alert-content").text("");
        $(this).find(".modal-body .body-content").empty().css("height",
          "auto");
        $(this).find(".modal-footer button").not(
          ".btn-confirm, .btn-cancel").remove();
        $(this).find(".modal-footer").removeClass("hide").children(
          ".btn-confirm, .btn-cancel").removeClass("hide");
        $(this).find(".modal-footer .btn-confirm").text("确定");
        $(this).find(".modal-footer .btn-cancel").text("关闭");
        $(this).removeData("bs.modal").removeData();
      });

      //绑定模态窗口确定事件
      $(".modal").on("click", ".btn-confirm", function(e) {
        var $modal = $(this).closest(".modal");
        if ($(this).data("callback")) {
          $(this).data("callback")($(this), $modal);
        } else {
          var $form = $modal.find(".body-content form");
          if ($form.length && $form.attr("action")) {
            $form.submit();
          } else {
            hideModal($modal);
          }
        }
      });

      //绑定模态窗口的拖动事件
      $(".modal").on("mousedown", ".modal-header", function(e) {
        $drag = $(this).closest(".modal");
        var point = $drag.find(".modal-dialog").offset();
        _x = e.pageX - point.left;
        _y = e.pageY - point.top;
      });

      $(document).mousemove(function(e) {
        if ($drag) {
          var x = e.pageX - _x; //控件左上角到屏幕左上角的相对位置
          var y = e.pageY - _y;
          $drag.find(".modal-dialog").offset({
            top: y,
            left: x
          });
        }
      }).mouseup(function() {
        $drag = null;
      });
    });

  }(jQuery));
});
