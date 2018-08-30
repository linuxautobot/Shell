function randomStr(m) {
    var m = m || 15; s = '', r = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for (var i=0; i < m; i++) { s += r.charAt(Math.floor(Math.random()*r.length)); }
    return s;
}

function myFunction() {
var sheet = SpreadsheetApp.getActiveSheet();
var msg = '{"status":{"msg":"Success","code":0,"version":"1.0"},"metadata":{"timestamp_utc":"2018-07-12 11:54:14","custom_files":[{"bucket_id":"8575","play_offset_ms":14540,"duration_ms":"27000","acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc","title":"encore","score":100}]},"cost_time":1.1600000858307,"result_type":0}'
var idb = "android."
var id = idb.concat(randomStr(16));
var myArray = ['Mumbai', 'Delhi', 'Bangalore','Hyderabad','Ahmedabad','Chennai','Kolkata']; 
var loacation = myArray[Math.floor(Math.random() * myArray.length)];
var randomly = jsonContent["featured"][Math.floor(Math.random()*jsonContent["featured"].length)];
var time=['1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9']
var ms = time[Math.floor(Math.random() * time.length)];
  sheet.appendRow([id,loacation,ms,randomly]);  
  sheet.appendRow([id,loacation,ms,randomly]);  
  //sheet.appendRow([ms]);
 // myFunction()
 }
 
time=new Date().toLocaleString();
var jsonContent = {
        "featured": [
          {"status":"Success",
            "codeq":"0",
            "version":"1.0",
            "timestamp_ist":time,
            "custom_files":"bucket_id:8575",
            "play_offset_ms":"14540",
            "acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc",
            "title":"encore","score":"100",
            "cost_time":"1.1600000858307",
            "result_type":"0"},
           {"status":"Success",
            "codeq":"0",
            "version":"1.0",
            "timestamp_ist":time,
            "custom_files":"bucket_id:8575",
            "play_offset_ms":"14540",
            "acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc",
            "title":"encore","score":"100",
            "cost_time":"1.1600000858307",
            "result_type":"0"},
           {"status":"Success",
            "codeq":"0",
            "version":"1.0",
            "timestamp_ist":time,
            "custom_files":"bucket_id:8575",
            "play_offset_ms":"14540",
            "acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc",
            "title":"encore","score":"100",
            "cost_time":"1.1600000858307",
            "result_type":"0"},
           {"status":"Success",
            "codeq":"0",
            "version":"1.0",
            "timestamp_ist":time,
            "custom_files":"bucket_id:8575",
            "play_offset_ms":"14540",
            "acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc",
            "title":"encore","score":"100",
            "cost_time":"1.1600000858307",
            "result_type":"0"},
           {"status":"Failed",
            "codeq":"3015",
            "version":"1.0",
            "timestamp_ist":time,
            "custom_files":"bucket_id:8575",
            "play_offset_ms":"14540",
            "acrid":"b855a7610c3ba76ea50a0aa8ae56fbfc",
            "title":"encore","score":"100",
            "cost_time":"1.1600000858307",
            "result_type":"0"},
          
            ]
  }
