var ajax = null;
function getAjaxObject(){// ajax 객체를 생성해주는 함수
	if(window.ActiveXObject){// 브라우저의 종류를 구분 (이 브라우저가 익스플로러 브라우저 이냐?)
		try {
			return new ActiveXObject("Msxml2.XMLHTTP");// 익스플로라 2가지의 버전 
		} catch (e) {
			try {
				return new ActiveXObject("Microsoft.XMLHTTP");// 익스플로러 2가지의 버전 
			} catch (e) {
				return null;
			}
		}
	}else if(window.XMLHttpRequest){// 익스플로러  이외의 브라우저 (ajax 객체 --> 비동기로 서버와 통신 가능한 객체)
		return new XMLHttpRequest(); // ajax 객체
	}else{
		return null;
	}
}
function sendRequest(url, params, callback, method){
	/* sendRequest("hello.jsp", "name=" + document.f.name.value, helloFromServer, "POST"); */
	ajax = getAjaxObject();
	var httpMethod = method? method:"GET"; // method에 값이 있어? (Get or Post)
	if(httpMethod != "GET" && httpMethod != "POST"){
		httpMethod = "GET";
	}
	var httpParams = (params == null || params == '')? null:params; // name=홍길동
	var httpUrl = url;
	if(httpMethod == "GET" && httpParams != null){ // get 방식일 때 url 정보에 파라미터를 전송
		httpUrl = httpUrl + "?" + httpParams;
	}
	console.log(httpUrl); // hello.jsp
	ajax.open(httpMethod, httpUrl, true); // true : 비동기로 전송할 거다. (비동기로 전송하기 위해 ajax를 사용한다.)
	// 비동기 처리를 하기 위해 ajax 객체 준비
	ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	// ajax의 header 값을 설정해줘야 한다.
	ajax.onreadystatechange = callback; // onreadystatechange : 콜백함수(ajax의 상태가 변경될 때마다 자동으로 호출하는 함수) 등록
	ajax.send(httpMethod == "POST"? httpParams:null); // 작성된 Ajax 요청을 서버로 전달
	// post 방식 일때 파라미터를 같이 전송, get일 때는 url에서 보내기때문에 null로 전송
	console.log(ajax);
}