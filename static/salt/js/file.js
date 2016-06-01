/**
 * Created by ywzhou on 2016/5/4.
 */
$(document).ready(function(){
    //路径搜索
    $('#path_search').click(function(){
        var path = $('#path').val();
        file_list(path);
    });
    //写入文件
    $('#file_write').click(function(){
        var minion = $('#tgt_list').val();
        var file_path = $('#file_path').html();
        //alert(file_path);
        var file_content = $('#file_content').val();
        if(!minion){alert("Minion不能为空！")}
        else if(!file_path){alert("File_Path不能为空！")}
        else{
            $.getJSON("/salt/file_write/", {master: master,file_path: file_path , file_content:file_content}, function (result) {
                alert(result);
            });
        }
    });
});

//显示目录列表功能
function file_list(path){
    var minion = $('#tgt_list').val();
    if(!minion){alert("Minion不能为空！")}
    else if(!path){alert("Path不能为空！")}
    else if(path !='/' && path.substr(-1) == '/'){alert("Path必须是绝对路径，以'/'开头。")}
    else {
        //alert(master+path);
        //timeout('2');
        $.getJSON("/salt/file_list/", {minion: minion, path: path.replace('//','/')}, function (result) {
            //alert(result);
            var path_type=result['path_type'];
            var fl=$('#file_list');
            var fc=$('#file_content');
            var fp=$('#file_path');

            if (path_type=='dir'){
                fl.html("");
                fc.html("");
                fp.html("");
                var pdir=result['pdir'];
                var file_list=result['file_list'];
                $('#path').val(pdir);
                for (var i = 0; i<=file_list.length-1;  i++) {
                    item = '<button type="button" class="label label-default" ' +
                        'onclick="file_list(\'' + pdir + '/' +file_list[i] + '\')">' +
                        file_list[i] + '</button><br>';
                    fl.append(item);
                }
            }
            else if (path_type=='file'){
                fc.html(result['file_content']);
                fp.html(result['pdir'])
            }
            else{
                fl.html('<div class="alert alert-danger">ERROR: This path is not valuable dir or file.</div>');
                fc.html("");
                fp.html("");
            }
        });
    }
}
