// Example usage: http://jsfiddle.net/q2gnX/
// Notes:
// - json2.js is not needed if browser supports JSON.stringify and JSON.parse natively
// - jQuery is only used to place the results

var formatJson = function(json, options) {
    var reg = null,
        formatted = '',
        pad = 0,
        PADDING = '    '; // one can also use '\t' or a different number of spaces 适用于textare
        //PADDING = '&nbsp;&nbsp;&nbsp;&nbsp;'; //适用于html控件，如div

    // optional settings
    options = options || {};
    // remove newline where '{' or '[' follows ':'  删除换行符
    options.newlineAfterColonIfBeforeBraceOrBracket = (options.newlineAfterColonIfBeforeBraceOrBracket === true) ? true : false;
    // use a space after a colon 冒号后用空间
    options.spaceAfterColon = (options.spaceAfterColon === false) ? false : true;

    // begin formatting...

    // make sure we start with the JSON as a string
    if (typeof json !== 'string') {
        json = JSON.stringify(json);
    }

    // parse and stringify in order to remove extra whitespace
    json = JSON.parse(json);
    json = JSON.stringify(json);

    // add newline before and after curly braces
    reg = /([\{\}])/g;
    json = json.replace(reg, '\r\n$1\r\n');

    // add newline before and after square brackets
    reg = /([\[\]])/g;
    json = json.replace(reg, '\r\n$1\r\n');

    // add newline after comma
    //reg = /(\,)/g;
    //json = json.replace(reg, '$1\r\n');
    //修改：不会处理“”内的逗号换行，但正常的数字类对象也不会换行
    reg = /(\,)(\")/g;
    json = json.replace(reg, '$1\r\n$2');

    //添加：将转义后显示的换行符替换成真实换行符，如dir、ls命令返回的值
    reg = /(\\r\\n)/g;
    json = json.replace(reg,'\r\n');
    reg = /(\\n)/g;
    json = json.replace(reg,'\r\n');

    // remove multiple newlines
    reg = /(\r\n\r\n)/g;
    json = json.replace(reg, '\r\n');

    // remove newlines before commas
    reg = /\r\n\,/g;
    json = json.replace(reg, ',');

    // optional formatting...
    if (!options.newlineAfterColonIfBeforeBraceOrBracket) {
        reg = /\:\r\n\{/g;
        json = json.replace(reg, ':{');
        reg = /\:\r\n\[/g;
        json = json.replace(reg, ':[');
    }
    if (options.spaceAfterColon) {
        reg = /\:/g;
        json = json.replace(reg, ': ');
    }

    //为每行设置缩进
    $.each(json.split('\r\n'), function(index, node) {
        var i = 0,
            indent = 0,
            padding = '';

        if (node.match(/\{$/) || node.match(/\[$/)) {
            indent = 1;
        } else if (node.match(/\}/) || node.match(/\]/)) {
            if (pad !== 0) {
                pad -= 1;
            }
        } else {
            indent = 0;
        }

        for (i = 0; i < pad; i++) {
          padding += PADDING;
        }

        formatted += padding + node + '\r\n'; //适用于textare控件
        //formatted += padding + node + '\<br\>'; //适用于div控件
        pad += indent;
    });
    return formatted;
};