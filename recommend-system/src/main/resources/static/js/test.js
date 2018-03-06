// test.js

var Main = {

    data() {

      return {
          dynamicTags: [],
          inputVisible: false,
          inputValue: '',

      };
    },
    mounted:function () {
        var that = this;
        $.ajax({
            url:'/recommend-system/api/findAllLabels',
            type:'POST',
            success(data){
                if(data.code=='50000'){
                    return false;
                }else if(data.code=='200'){
                    tag = data.data;
                    that.dynamicTags = tag;
                    console.log(that.dynamicTags);
                    that.$nextTick(function () {
                        changeColor();
                        // Code that will run only after the
                        // entire view has been rendered
                    })
                }
            }
        });
    },
    methods: {
        changeTag(shopId){
          var tag = new Array();
            var that = this;
            $.ajax({
                url:'/recommend-system/api/findAllLabels',
                type:'POST',
                success(data){
                    if(data.code=='50000'){
                        layer.msg(data.message,{time:1000,shade: [0.3, '#000']});
                        setTimeout(function(){window.location.href='user/login';},1000);
                        return false;
                    }else if(data.code=='200'){
                        tag = data.data;
                        that.dynamicTags = tag;
                        console.log(that.dynamicTags);
                        that.$nextTick(function () {
                            changeColor();
                            // Code that will run only after the
                            // entire view has been rendered
                        })
                    }
                }
            });
            if(shopId){
                $("#shopIdModel").val(shopId);
            }

        },
      handleClose(tag) {
        this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
          $.ajax({
              url:"/recommend-system/api/deleteLabel",
              data:{
                  labelName:tag
              },
              type:"POST",
              success:function (e) {
              }
          })
      },

      showInput() {
        this.inputVisible = true;
        this.$nextTick(_ => {
          this.$refs.saveTagInput.$refs.input.focus();
        });
      },

      handleInputConfirm() {
        let inputValue = this.inputValue;
        $(".modal-body .el-tag").each(function () {
            if($(this).text().trim()==inputValue){
                layer.msg("已存在"+inputValue+"标签，请勿重复添加",{time:1000,shade: [0.3, '#000']});
                inputValue =  false;
            }
        });
        if (inputValue) {
          this.dynamicTags.push(inputValue);
          $.ajax({
              url:'/recommend-system/api/addLabel',
              data:{
                  labelName:inputValue
              },
              type:"POST",
              success:function (e) {
              }
          })
        }
        this.inputVisible = false;
        this.inputValue = '';
      }
    }
  }
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')

function changeColor() {
    var tag = window.location.href;
    tag=tag.split('=')[1];
    tag =decodeURI(tag);
    $(document).find(".leftcolor .el-tag").each(function () {
        var activeTag = $(this).text().trim();
        if(tag==activeTag){
            $(this).css("box-shadow","rgba(64,158,255,.2)");
            $(this).css("background-color","rgba(64,158,255,1)");
            $(this).css("color","#FFF");
        }else {
            $(this).css("box-shadow","");
            $(this).css("background-color","rgba(64,158,255,.1)");
            $(this).css("color","#409EFF");
        }
    })
}