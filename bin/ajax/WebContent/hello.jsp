<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("UTF-8");%> <!-- ajax 객체는 무조건 UTF-8로 인코딩 해야 한다. -->
<h3>안녕하세요 <font color="blue">${param.name }</font>입니다.</h3>