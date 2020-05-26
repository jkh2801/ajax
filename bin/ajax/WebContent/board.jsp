<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:requestEncoding value="UTF-8" /> <!-- ajax 객체는 무조건 UTF-8로 인코딩 해야 한다. -->
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/scott" user="scott" password="1234" />
<sql:query var="rs" dataSource="${conn}">SELECT * FROM board WHERE ${param.column} LIKE ? <sql:param>%${param.find }%</sql:param>
</sql:query>
<table border="1" style="border-collapse: collapse;">
	<tr>
		<th>번호</th>
		<th>글쓴이</th>
		<th>제목</th>
		<th>내용</th>
		<th>동록일</th>
		<th>조회수</th>
	</tr>
	<c:forEach var="data" items="${rs.rows}">
		<tr>
			<td>${data.num }</td>
			<td>${data.name }</td>
			<td>${data.subject }</td>
			<td><c:set value="${fn:escapeXml(data.content)}" var="content"></c:set>${fn:substring(content,0,50) }<c:if test="${fn:length(content)>50}">...</c:if></td>
			<!-- escapeXml : 태그 무력화 -->
			<td>${data.regdate }</td>
			<td>${data.readcnt }</td>
		</tr>
	</c:forEach>
</table>
