/**
 * Created by ywzhou on 2016/4/17.
 */

//主机列表过滤功能
function host_list(tgt,idc_id,system_id,group_id) {
    $('#tgt_list').html(""); //初始化主机列表数据，*表示所有主机
    $.getJSON("/salt/target/",{tgt:tgt,idc_id:idc_id,system_id:system_id,group_id:group_id},function(result){
        //返回值 result 在这里是一个列表
        for (var i = result.length - 1; i >= 0; i--) {
          // 把 result 的每一项作为选项显示在网页上
            $("<option value='"+result[i]+"'>"+result[i]+"</option>").appendTo("#tgt_list");
        }
    });
    return false; //不刷新页面
}
//获取命令帮助信息功能
function cmd_help() {
    var cmd = $('#fun').val();
    $.getJSON("/salt/command/",{cmd:cmd},function(result){
        if (result) {$('#doc').html(result);}
        else {$('#doc').html("命令'"+cmd+"'还未采集帮助文档，请在'Salt命令配置'页面进行采集。");}
    });
    return false; //不刷新页面
}
//控制显示功能
function div_display(obj) {
    var id = document.getElementById(obj);
    id.style.display = !id.style.display||id.style.display=='block' ? 'none':'block';
}
//执行命令功能
function cmd_result(idc,tgt_type,tgt,fun,arg) {
    $.getJSON("/salt/cmd_result/",{idc:idc,tgt_type:tgt_type,tgt:tgt,fun:fun,arg:arg},function(result){

        if(result.minions.length > 120){var minions=result.minions.substr(0,120)+'...'}
        else{minions=result.minions}
        if(result.error){$('#result').append('<div class="row"><label class="label label-danger">' + result.error + '</label></div>')}
        else {
            $('#result').append(
                '<div class="container-fluid">' +
                '<div class="row">' +
                '<label class="label label-danger" id="status_' + result.jid + '"><span class="glyphicon glyphicon-paperclip"></span></label>&nbsp;' +
                '<label class="label label-primary">' + result.jid + '</label>&nbsp;' +
                '<label class="label label-default">' + result.fun + '&nbsp;' + result.arg + '</label>&nbsp;' +
                '<label class="label label-default" title="' + result.minions + '">' + minions + '</label>&nbsp;' +
                '<button class="btn btn-info btn-xs" onclick="jid_info(\'' + result.jid + '\')" id="btn_' + result.jid + '">Result<span class="caret"></span></button>&nbsp;' +
                    //'<button class="btn btn-info btn-xs" onclick=""><span class="glyphicon glyphicon-refresh"></span></button>&nbsp;'+
                '</div>' +
                '<div class="row border" id="result_' + result.jid + '" style="display: none;">' +
                '</div>' +
                '</div>'
            );
        }
        //setTimeout(1);//缓冲1秒时间再向后台获取job信息，否则job还没有完全完成只会获取部分
        //jid_info(result.jid);
    });
    return false;
}

//获取任务详细信息功能
function jid_info(jid) {
    var r = $('#result_'+jid).html();
    var btn = document.getElementById('btn_'+jid);
    if( !r ) {
        btn.disabled=true; //从后台获取数据期间禁用按钮，防止重复点击
        $.getJSON("/salt/jid_info/", {jid: jid}, function (result) {
            for (var k in result) {
                var v = result[k]['return'];
                //k是minion，v是其return值，值为字典时只显示一个按钮，其结果使用formatJSON格式化后保存在一个隐藏的DIV中
                if (typeof v != 'object') {
                    var option = v;
                    item = "<strong>" + k + ":</strong>&nbsp;" + option + "</br>";
                    $('#result_' + jid).append(item);
                }
                else {
                    option = formatJson(v, true);
                    item = '<strong>' + k + ':</strong>&nbsp;' +
                        '<button class="btn btn-default btn-xs" onclick="div_display(\'return_' + jid + '_' + k + '\')">' +
                        'Return<span class="caret"></span></button><br>' +
                        '<div id="return_' + jid + '_' + k + '" style="display: none;">' + option + '</div>';
                    $('#result_' + jid).append(item);
                }
            }
            //结果返回后标签颜色由红变绿
            if(r){
                $('#status_'+jid).removeClass('label-danger').addClass('label-success');
            }
            btn.disabled=false;
        });
    }
    div_display('result_' + jid);
    return false;
}
$(document).ready(function(){
    //类型
    $('#tgt_type').change(function(){
        var tgt_type = $(this).val();
        var tgt_list = document.getElementById("tgt_list");
        if(tgt_type == 'list'){
            tgt_list.disabled=false;
            tgt_list.setAttribute("multiple","multiple");
        }
        else if (tgt_type == 'glob'){
            tgt_list.disabled=false;
            tgt_list.removeAttribute("multiple");
            var length = tgt_list.options.length - 1;
            for(var i = length; i >= 0; i--) {
                tgt_list[i].selected = false;
            }
        }
        else{tgt_list.disabled=true;}
    });
    //搜索
    $('#search').click(function(){
        var tgt = $('#tgt').val();
        var idc_id = $('#idc').val();
        var system_id = $('#system').val();
        var group_id = $('#group').val();
//{#                alert(hostname);#}
        host_list(tgt,idc_id,system_id,group_id)
    });
    //按组过滤
    $('#group').change(function(){
        var tgt = $('#tgt').val();
        var idc_id = $('#idc').val();      //获取机房选择对象的value值
        var system_id = $('#system').val();
        var group_id = $(this).val();                 //获取当前选择对象的value值，去掉了toString()
//{#                if (!idc_id) alert("请选择指定机房");#}
        host_list(tgt,idc_id,system_id,group_id)
    });
    //按机房过滤
    $('#idc').change(function(){
        var tgt = $('#tgt').val();
        var idc_id = $(this).val();
//{#                var server = document.getElementById("server");#}
//{#                server[0].selected = true;#}
//{#                var server_id = '';#}
        var system_id = $('#system').val();
        var group_id = $('#group').val();
        host_list(tgt,idc_id,system_id,group_id)
    });
    //按系统过滤
    $('#system').change(function(){
        var tgt = $('#tgt').val();
        var idc_id = $('#idc').val();
        var system_id = $(this).val();
        var group_id = $('#group').val();
        host_list(tgt,idc_id,system_id,group_id)
    });
    //模块+命令级联
    $('#module').change(function () {
        $('#fun').html("<option value=''>————————</option>"); //初始化数据
        var module_id = $(this).val();                 //获取当前选择对象的value值
        $.getJSON("/salt/command/",{module_id:module_id},function(result){
            //返回值 result 在这里是一个列表
            for (var i = result.length - 1; i >= 0; i--) {
              // 把 result 的每一项作为选项显示在网页上
                $("<option value='"+result[i]+"'>"+result[i]+"</option>").appendTo("#fun");
            }
        });
        return false; //不刷新页面
    });
    //命令帮助
    $('#fun').change(function(){
        if($('#fun').val()) {cmd_help();}
        else{$('#doc').html("请选择Function!")}
    });
    //执行按钮
    $('#run').click(function(){
        var idc = $('#idc').val();
        var tgt_type = $('#tgt_type').val();
        var tgt = $('#tgt').val();
        var tgt_list = $('#tgt_list').val();
        //var client = $('#client').val();
        var fun = $('#fun').val();
        var arg = $('#arg').val();
//{#                alert(idc+tgt_type+tgt+tgt_list+client+fun+arg);#}
        if (!idc){alert("请选择机房！");}
        else if(!tgt && !tgt_list){alert("目标不能为空！");}
        else if(!fun){alert("请选择命令！");}
        else if(tgt_type == 'list'){
            if(tgt == '*'){tgt_type='glob';cmd_result(idc,tgt_type,tgt,fun,arg)} //
            else if(tgt_list){cmd_result(idc,tgt_type,tgt_list.toString(),fun,arg)}
            else {alert("请选择目标列表或输入'*'符号！")}
        }
        else if(tgt_type == 'glob'){
            if(tgt == '*'){cmd_result(idc,tgt_type,tgt,fun,arg)}
            else if(tgt_list){cmd_result(idc,tgt_type,tgt_list,fun,arg)}
            else {alert("请选择一个目标！")}
            }
        else {
            if(tgt){cmd_result(idc,tgt_type,tgt,fun,arg)}
            else{alert("Target不能为空！")}
        }
    });
    //广播按钮
    $('#test_ping').click(function(){
        var idc = $('#idc').val();
        var tgt_type = 'glob';
        var tgt = '*';
        var fun = 'test.ping';
        if (!idc){alert("请选择机房！");}
        else{
            cmd_result(idc,tgt_type,tgt,fun,'');

        }
    });
//命令帮助按钮
    $('#help').click(function(){
        div_display('doc');
     });
});