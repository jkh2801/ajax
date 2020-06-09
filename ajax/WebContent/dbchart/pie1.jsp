<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>파이 그래프로 게시글 작성자의 건수 출력하기</title>
<script type="text/javascript"
	src="http://www.chartjs.org/dist/2.9.3/Chart.min.js"></script>
	<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/classdb" user="scott" password="1234" />
<sql:query var="rs" dataSource="${conn}">select name, count(*) cnt from board group by name having count(*) >= 1 order by cnt desc
</sql:query>
</head>
<body>
<div id="container" style="width: 75%; border: 1px solid black;">
		<canvas id="canvas"></canvas>
	</div>
	<script type="text/javascript">
		var randomColorFactor = function () { 
			return Math.round(Math.random()*255); // 0 ~ 255
		};
		var randomColor = function (opacity) { // 1 : 불투명
			return "rgba(" + randomColorFactor() + "," +// r
					randomColorFactor() + "," +// g
					randomColorFactor() + "," +// b
					(opacity || '.3') + ")";
		};
		var config = {
			type : 'pie',
			data : {
				datasets : [ {
					data : [ <c:forEach items="${rs.rows}" var="m"> "${m.cnt}", </c:forEach>],
					backgroundColor : [<c:forEach items="${rs.rows}" var="m"> randomColor(1), </c:forEach>],
					label : '도넛 그래프'
				} ],
				labels : [<c:forEach items="${rs.rows}" var="m"> "${m.name}", </c:forEach>]
			},
			options : {
				responsive : true,
				legned : {
					position : 'top'
				},
				title : {
					display : true,
					text : '글쓴이 별 게시판 등록 건수',
					position: 'bottom'
				},
				animation : {
					animateScale : true,
					animateRotate : true
				}
			}
		};
		window.onload = function() {
			var ctx = document.getElementById("canvas").getContext("2d");
			window.myBar = new Chart(ctx, config);
		}
	</script>
</body>
</html>