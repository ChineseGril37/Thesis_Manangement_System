//获取当前时间并打印
export function setCurrentTime(){
    let yy = new Date().getFullYear();
    let mm = new Date().getMonth() + 1;
    let dd = new Date().getDate();
    let hh = new Date().getHours();
    let mf = new Date().getMinutes() < 10 ? '0' + new Date().getMinutes() : new Date().getMinutes();
    let ss = new Date().getSeconds() < 10 ? '0' + new Date().getSeconds() : new Date().getSeconds();
    return yy + '-' + mm + '-' + dd + ' ' + hh + ':' + mf + ':' + ss;
}
//读取用户提供的Date类型，将其转化为后端可以读取的JSON格式的字符串日期数据
export function getJsonDateForMat(date){
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let strDate = date.getDate();
    let hour = date.getHours();
    let minute = date.getMinutes();
    let second = date.getSeconds();
    month = month > 9 ? month : '0' + month
    strDate = strDate > 9 ? strDate : '0' + strDate
    hour = hour > 9 ? hour : '0' + hour
    minute = minute > 9 ? minute : '0' + minute
    second = second > 9 ? second : '0' + second
    return (year + '-' + month + '-' + strDate + ' ' + hour + ':' + minute + ':' + second);
}
