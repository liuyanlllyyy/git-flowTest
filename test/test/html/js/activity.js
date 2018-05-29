var i = 0,nextIndex = 5,duration1 = 10 * 60 * 1000;//i初始Index   nextIndex下一次触发Index 间隔10分钟
var activityVM = {
    $page_body_wrapper : $('.page_body_wrapper'),
    //内容区图片集合
    contentImgs : [
        ['demo1_1.jpg','demo1_2.jpg','demo1_3.jpg','demo1_1.jpg','demo1_2.jpg','demo1_3.jpg','demo1_1.jpg','demo1_2.jpg','demo1_3.jpg'],
        ['demo2_1.jpg','demo2_2.jpg','demo2_3.jpg','demo2_1.jpg','demo2_2.jpg','demo2_3.jpg','demo2_1.jpg','demo2_2.jpg','demo2_3.jpg'],
        ['demo3_1.jpg','demo3_2.jpg','demo3_3.jpg','demo3_1.jpg','demo3_2.jpg','demo3_3.jpg','demo3_1.jpg','demo3_2.jpg','demo3_3.jpg'],
    ],
    contentClasses : ['redPacket','activity_poster','bubbleBox'],
    imgPrefix : '../assets/random/',
    /*
     * @name
     * @param
     * @description 开始随机生成界面,并调用原生截图api
     */
    startRefresh : function () {
          //随机生成内容图片数组
        var contentImgIndex = this.getRandomArbitrary(0,this.contentImgs.length);
        var curImgs = this.contentImgs[contentImgIndex];
        var msgNum = this.getRandomArbitrary(1,20);
        var onlineNum = this.getRandomArbitrary(1,30);
        var curTitle = schoolArray[i];
        //更新头部title
        $('.header_goback span').text('消息('+msgNum+')');
        $('.header_content p.ellipsis').text(curTitle);
        $('.header_content_num').text(onlineNum + '人在线');

        //生成内容图片区
        this.renderContentImgs(curImgs);
        //这里生成随机位置
        var position = this.getRandomArbitrary(0,$('.page_body_wrapper').height());
        $('.page_body_wrapper').scrollTop(position);
        i++;
        try {
            setTimeout(function () {
                startShoot();
            },1000);//截图写死时长
        }catch(err) {
            alert(err);
        }


    },
    renderContentImgs : function (targetImgs) {
        var html = '<ul>';
        targetImgs.length > 0 && function () {
            targetImgs.forEach(function (item,index) {
                var tempImgUrl = activityVM.imgPrefix + item;
                var tempClassStr = activityVM.contentClasses[index % 3];
                html += '<li class="fill_img_item ' + tempClassStr + '">';
                html += '<img src="' +tempImgUrl+ '" alt="">';
                html += '</li>';
            })
        }();
        html += '</ul>';
        this.$page_body_wrapper.append(html);
    },
    //随机数生成（整数）
    getRandomArbitrary :function (min,max) {
        return Math.floor(Math.random() * (max - min) + min);
    }
}


window.onload = function () {
    activityVM.startRefresh();
    var timer = setInterval(function () {
        if(i < nextIndex){//修改值
            activityVM.startRefresh();
        }else{
            clearInterval(timer);
        }
    },duration1);
}
//原生截图函数
function startShoot() {
    screenShoot();
}
