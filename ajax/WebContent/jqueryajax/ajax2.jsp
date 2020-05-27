<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<fmt:requestEncoding value="UTF-8" /><!-- ajax 객체는 무조건 UTF-8로 인코딩 해야 한다. -->
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/classdb" user="scott" password="1234" />
<sql:query var="rs" dataSource="${conn}">select id, pass, name from member where id = ? and pass = ?<sql:param>${param.id }</sql:param> <sql:param>${param.pass }</sql:param>
</sql:query>
<c:if test="${!empty rs.rows }"> <%-- rs나 rs.row가 비어있냐? --%>
<h1>반갑습니다. ${rs.rows[0].name }님</h1>
</c:if>
<c:if test="${empty rs.rows }">
<h1>아이디 or 비밀번호가 틀립니다.</h1>
</c:if>