<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 블로그 검색 결과</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function() {
    	
    	 
        $('#searchBtn').click(function() {
            var query = $('#query').val();
            
            if (query == '') {
                alert('검색어를 입력하세요.');
            } else {
            	// Controller 호출하는 ajax 코드
                $.ajax({
                    url : 'blogSearch',
                    type : 'GET',
                    data : { query : query },
                    success : function(result) {
                        var html = '';
                        for (var i = 0; i < result.length; i++) {
                            var item = result[i];
                            html += '<div style="border: 1px solid gray; padding: 10px; margin-bottom: 10px;">';
                            html += '<h3>' + item.title + '</h3>';
                            html += '<p>' + item.description + '</p>';
                            html += '<a href="' + item.link + '">' + item.link + '</a>';
                            html += '</div>';
                        }
                        $('#result').html(html);
                    },
                    error : function(xhr, status, error) {
                        alert('에러 발생');
                    }
                }); 
            }//if-else
            	
         
        });//click
        
     
    });
</script>
</head>
<body>
    <h1>네이버 블로그 검색 결과</h1>
    <input type="text" id="query" placeholder="검색어를 입력하세요.">
    <button id="searchBtn">검색</button>
    <hr color="red">
    
    <div id="result"></div>
</body>
</html>