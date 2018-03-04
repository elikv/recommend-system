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