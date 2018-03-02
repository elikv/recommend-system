// test.js

var Main = {

    data() {

      return {
        dynamicTags: ['标签一', '标签二', '标签三'],
        inputVisible: false,
        inputValue: ''
      };
    },

    methods: {
        changeTag(shopId){
          var tag = new Array();

            $.ajax({
                url:'api/findAllLabels',
                type:'POST',
                success(data){
                    if(data.code=='50000'){
                        layer.msg(data.message,{time:1000,shade: [0.3, '#000']});
                        setTimeout(function(){window.location.href='user/login';},1000);
                        return false;
                    }else if(data.code=='200'){
                        tag = data.data;
                        console.log(tag);
                    }
                }
            });

            this.dynamicTags = tag;
            console.log(this.dynamicTags);
            $("#shopIdModel").val(shopId);
        },
      handleClose(tag) {
        this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
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
        }
        this.inputVisible = false;
        this.inputValue = '';
      }
    }
  }
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')