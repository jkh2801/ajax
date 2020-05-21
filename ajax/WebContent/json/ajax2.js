
var ajax = {}; // 객체
ajax.xhr = {}; // 객체
ajax.xhr.Request = function(url, params, callback, method){ // ajax.xhr.Request의 생성자
	this.url = url;
	this.params = params;
	this.callback = callback;
	this.method = method;
	this.send(); // 멤버 메서드 실행
}
// prototype : 멤버 메서드 구현
ajax.xhr.Request.prototype = { 
		getXmlHttpRequest : function() { // 멤버메서드 (XMLHttpRequest 객체 생성 기능)
			if (window.ActiveXObject) {
				try {
					return new ActiveXObject("Msxml2.XMLHTTP");// 익스플로라 2가지의 버전 
				} catch (e) {
					try {
						return new ActiveXObject("Microsoft.XMLHTTP");// 익스플로러 2가지의 버전 
					} catch (e2) {
						return null;
					}
				}
			}else if(window.XMLHttpRequest){// 익스플로러  이외의 브라우저 (ajax 객체 --> 비동기로 서버와 통신 가능한 객체)
				return new XMLHttpRequest(); // ajax 객체
			}else{
				return null;
			}
		},
		send : function() { // 멤버메서드
			console.log(this);
			this.req = this.getXmlHttpRequest(); // XMLHttpRequest 객체를 저장 (ajax 객체)
			var httpMethod = this.method?this.method:"GET";
			if (httpMethod != "GET" && httpMethod != "POST") {
				httpMethod = "GET";
			}
			var httpParams = (this.params == null || this.params == '')? null:this.params; 
			var httpUrl = this.url;
			if(httpMethod == "GET" && httpParams != null){ // get 방식일 때 url 정보에 파라미터를 전송
				httpUrl = httpUrl + "?" + httpParams;
			}
			this.req.open(httpMethod, httpUrl, true);
			this.req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			var request = this; // this: ajax.xhr.Request 객체
			this.req.onreadystatechange = function(){
				request.onStateChange.call(request);
			}; 
			this.req.send(httpMethod == "POST"? httpParams:null); 
		}, 
		onStateChange : function(){ // 멤버메서드
			this.callback(this.req);
		}
}