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
    	 // 추천검색어
        $.ajax({
            url : 'list',
            type : 'GET',
            success : function(result) {
                 $('#recommend').html(result);
            	},
            error : function(xhr, status, error) {
                console.log('에러 발생');
            }
        });
    	 
        $('#searchBtn').click(function() {
            var query = $('#query').val();
            
            if (query == '') {
                alert('검색어를 입력하세요.');
            } else {
            	// RestController 호출하는 ajax 코드
                $.ajax({
                    url : '../search',
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
            	
         // HashtagController 호출하는 ajax 코드_검색어 db저장
            	$.ajax({
                	url : 'saveHashtag',
                	type : 'GET',
                	data : { keyword : query },
                	success : function(result) {
                    	console.log(result);
               		},
                	error : function(xhr, status, error) {
                		console.log('에러 발생');
                }
            });
        });//click
        
     // 추천 검색어 클릭 시 검색
        $('#recommend').on('click', 'a', function(e) {
            e.preventDefault();
            var query = $(this).text();
            $('#query').val(query);
            $('#searchBtn').trigger('click');
        });
    });
</script>
</head>
<body>
    <h1>네이버 블로그 검색 결과</h1>
    <input type="text" id="query" placeholder="검색어를 입력하세요.">
    <button id="searchBtn">검색</button>
    <hr color="red">
    <h3>추천 검색어</h3>
    <div id="recommend">
    
    </div>
    <hr color="red">
    <div id="result"></div>
</body>
</html>