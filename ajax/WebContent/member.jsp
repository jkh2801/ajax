<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<fmt:requestEncoding value="UTF-8" /> <!-- ajax 객체는 무조건 UTF-8로 인코딩 해야 한다. -->
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/classdb" user="scott" password="1234" />
<sql:query var="rs" dataSource="${conn}">select * from member where name like ?<sql:param>%${param.name}%</sql:param>
</sql:query>
<table border="1" style="border-collapse: collapse;">
	<tr>
		<th>아이디</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>성별</th>
	</tr>
	<c:forEach var="data" items="${rs.rows}">
		<tr>
			<td>${data.id }</td>
			<td>${data.name }</td>
			<td>${data.tel }</td>
			<td>${data.email }</td>
			<td>${data.gender == 1? '남자':'여자' }</td>
		</tr>
	</c:forEach>
</table>