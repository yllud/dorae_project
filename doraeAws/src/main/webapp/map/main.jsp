<!-- page01_other4.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
tr{
text-align: center;
}
.btn-0{
margin:20px;
padding: 10px;
width:300px;
height:70px;
border:none;
border-radius:20px;
font-family: 'NanumSquare', sans-serif;
font-size: 16pt;
color: white;
background-color: #ff9900;
}
</style>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe"></script>
<script src="https://openapi.map.naver.com/openapi/v3/maps-geocoder.js"></script>
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/MarkerClustering.js"></script>
<script type="text/javascript" src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/js/jquery-3.6.4.js"></script>
<script>
	$(window).on('load', function() {
		$('body').scrollTop(0); // 스크롤 위치 초기화
		$("#header").load("../header/header.jsp");
		
		var map; // 전역 변수로 선언
		var markers = []; // 전역 변수로 선언
		var temp_marker; 
		
		var isLogin = false; //로그인여부
		var delist1 = []; //play
		var delist2 = []; //stage
		var mylist = []; //myBook
		var userEmail; //로그인 이메일
		var click = "all";
		
		var startIndex = 0; // 시작 인덱스
		var dataCount = 10; // 한 번에 가져올 데이터 개수
		var endIndex = dataCount; // 끝 인덱스
		
		$('#btn_map').click(function() {
			$('#banner').animate({
				opacity : 0
			}, 1000, function() {
				$(this).remove(); // 애니메이션이 끝난 후 요소를 삭제
			});
		});
		
		$('#btn_check').click(function() {
			if(userEmail != null){
				$.ajax({
				    url: "../map/select_myPreference",
				    type: "GET",
				    data: { email: userEmail },
				    success: function(response) {
				    	console.log(response);
				        if(response == []){
				        	window.location.href = "recommend.jsp";
				        }
				        else{
				        	// 스크롤을 내리는 코드
			                $('html, body').animate({
			                    scrollTop: $("#result").offset().top
			                }, 500);
				        }
				    },
				    error: function() {
				        alert("데이터를 불러오는 중에 오류가 발생했습니다.");
				    }
				});
			}
			else{
				alert("로그인이 필요한 기능입니다!");
				window.location.href = "../login/login.jsp";
			}
		});
		
		function snsPopup(playName, stageName, playId) {
			console.log("값넘겨주기!!! >>> " + playName + ", " + stageName + ", " + playId);
			var url = "sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName) + "&playId=" + encodeURIComponent(playId);
			//var url = "sns_share.jsp?playName=" + encodeURIComponent(playName) + "&stageName=" + encodeURIComponent(stageName)  + "&latitude=" + encodeURIComponent(share_lat)  + "&longitude=" + encodeURIComponent(share_lng);
		    window.open(url, "_blank", "width=500,height=500");
		}
		
		// 네이버 지도 API를 로드합니다.
		map = new naver.maps.Map('map', {
			zoom : 7,
			minZoom: 7,
			maxZoom: 17,
			mapTypeId: 'normal',
			center : new naver.maps.LatLng(36.0566103, 125.9783882), // 대한민국 중심
			mapDataControl: false,
			zoomControl : true,
			zoomControlOptions : {
				position : naver.maps.Position.TOP_RIGHT,
				style : naver.maps.ZoomControlStyle.SMALL
			}
		});//new map
		
		//로그인 세션이 있다면 isLogin=true, mylist[]값 받아오기
		<% if (session.getAttribute("email") != null) { %>
			userEmail = '<%= session.getAttribute("email") %>';
			isLogin = true;
			console.log("로그인 완료함!! >>>> " + userEmail);
		//세션이 없다면 북마크 none 있다면 북마크 리스트에 있는지 확인한 후
			
			$.ajax({
            type: 'GET',
            url: "../book/select_my",
            data: { email: userEmail },
            dataType: 'json',
            async: false, // 동기적으로 실행하여 for문 내에서 결과를 처리
            success: function(response) {
                mylist = response;
                console.log(mylist);
            },
            error: function(xhr, status, error) {
                console.log(error);
            }
        });
        <% } else { %>
        	console.log("로그인 안되어있음!");
        <% } %>
        
      //스크롤 이벤트 핸들러
        $('#infolist').on('scroll', function() {
            // 현재 스크롤 위치
            console.log("스크롤 하고 있는 중");
            var scrollPosition = $('#infolist').scrollTop();

            // 스크롤 가능한 전체 높이 (infolist의 높이)
            var contentHeight = $('#infolist').prop('scrollHeight');

            // 스크롤 영역의 높이 (infolist의 높이)
            var scrollAreaHeight = $('#infolist').height();

            // 스크롤이 infolist의 끝에 도달하면 추가 데이터를 가져옴
            if (scrollPosition >= contentHeight - scrollAreaHeight) {
                // 추가 데이터 가져오기
                console.log("스크롤 infolist의 끝에 도달!!");
                startIndex += dataCount;
                endIndex += dataCount;
                
                if(click == "all"){
                	if(dataCount > delist1.length){
    					console.log("delist1의 길이 >>> " + delist1.length);
                    	dataCount = delist1.length;
                    	console.log("dataCount의 값 >>> " + dataCount);
                    }
                    addItems();
                }
                else if(click == "area"){
                	
                }
            }
        });
      
        $('#infolist').on('click', '.bookIcon', function() {
		    if (isLogin == true) {
		        var bookmarkImg = $(this);
		        var bookmarkCount = $(this).siblings('.bookmarkCount');
		        //var bookmarkCount = $(this).data('count');
		        var playId = bookmarkImg.closest('table').find('a').data('play-id');
		        
		        // 이미지 소스 변경 추후 수정예정
		        if (bookmarkImg.attr('src') === 'https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg') {
		        	// 북마크 추가
		        	var count = parseInt(bookmarkCount.text()) + 1;
			        bookmarkCount.text(count);
		            $.ajax({
		                url: "../book/insert_book",
		                method: "POST",
		                data: { 
		                    play_id: playId,
		                    email: userEmail
		                },
		                success: function(response) {
		                    bookmarkImg.attr('src', 'https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_selected.jpg');
		                },
		                error: function(xhr, status, error) {
		                    console.log('북마크 추가 중 에러가 발생했습니다.');
		                }
		            });
		        } else {
		            // 북마크 삭제
		            var count = parseInt(bookmarkCount.text()) - 1;
			        bookmarkCount.text(count);
		            $.ajax({
		                url: "../book/delete_book",
		                method: "POST",
		                data: { 
		                    play_id: playId,
		                    email: userEmail
		                },
		                success: function(response) {
		                    bookmarkImg.attr('src', 'https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg');
		                },
		                error: function(xhr, status, error) {
		                    console.log('북마크 삭제 중 에러가 발생했습니다.');
		                }
		            });
		        }
		        console.log("bookIcon 클릭! >>> " + playId);
		    } else {
		        alert('로그인 후 이용 가능합니다');
		    }
		});
		
      	//공유 아이콘 클릭 이벤트
		$('#infolist').on('click', '.shareIcon', function() {
		    var row = $(this).closest('table');
		    var playName = row.find('b').text();
		    var stageName = row.find('tr:nth-last-child(2) td').text();
		    var playId = row.find('a').data('play-id');
		    
		    snsPopup(playName, stageName, playId);
		});
      	
		//infolist 테이블 추가
		function addItems() {
			if(click == "all"){
				infoWindow.close();
				click = "all";
				var table = "";
				if(startIndex == 0)
				{
					$('#infolist').scrollTop(0); // 스크롤 위치 초기화
					$('#infolist').empty(); // infolist 비우기

					// 테이블 생성
					table += "<br><h3 style='text-align:center; margin-top:10px;'><전체지역> 검색결과 " + delist1.length + "개</h3>";
				}
				if(endIndex <= delist1.length){
					console.log("startIndex 값 : " + startIndex);
					console.log("dataCount 값 : " + dataCount);
					console.log("endIndex 값 : " + endIndex);
					for (var i = startIndex; i < endIndex; i++) {
						if (i >= delist1.length) {
				            break;
				        }
					    table += '<table id="infotable"><tr><td><img id="poster" src="' + delist1[i].poster + '"></td></tr>';
					    table += "<tr><td><a href='../search/playDetail?play_id=" + delist1[i].play_id + "' data-play-id='" + delist1[i].play_id + "'><b>" + delist1[i].play_name + '</b></a></td></tr>';
					    table += '<tr><td>' + delist1[i].play_start + " ~ " + delist1[i].play_end + '</td></tr>';
					    for (var j = 0; j < delist2.length; j++) {
					        if (delist1[i].stage_id == delist2[j].stage_id) {
					            table += '<tr><td>' + delist2[j].stage_name + '</td></tr>';
					            break;
					        }
					    }
					    table += "<tr><td style='text-align:right'>";
					    if (isLogin == true){
					        var hasBookmark = false;
					        for (var k = 0; k < mylist.length; k++) {
					            if (delist1[i].play_id == mylist[k].play_id) {
					                table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_selected.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
					                hasBookmark = true;
					                break;
					            }
					        }
					        if (!hasBookmark) {
					            table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
					        }
					    } else {
					    	console.log("로그인 되어있지않습니다!!");
					        table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
					    }
	                    $.ajax({
	                        type: 'GET',
	                        url: '../book/select_count',
	                        data: { play_id: delist1[i].play_id },
	                        async: false, // 동기적으로 실행하여 for문 내에서 결과를 처리
	                        success: function(response) {
	                        	var cnt = response;
	                            table += "<span class='bookmarkCount'>" + cnt + "</span> ";
	                        },
	                        error: function(xhr, status, error) {
	                        	table += "0";  
	                            console.log("북마크 카운트 ajax 실패!");
	                        }
	                    });
	                    table += "<img class='shareIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-share.png' style='width:35px; padding-top:10px;' alt='sns공유'></td></tr>";
	                    table += '</table>';
				    } //for
				    // 테이블 추가
				    $('#infolist').append(table);
				}//if문
			}
			
		}//addItems
		
		//마커 클릭 이벤트 함수
		function addMarkerClickListener(marker, index) {
			naver.maps.Event.addListener(marker, 'click', function() {
				handleMarkerClick(marker);
				
		  	});
		}//addMarkerClickListener
		
		function handleMarkerClick(marker) {
			click = "marker";
			var markerPosition = marker.getPosition();
			var stgname;
			
			for (var i = 0; i < delist2.length; i++) {
				if(delist2[i].latitude == markerPosition.lat() && delist2[i].longitude == markerPosition.lng()) {
					stgname = delist2[i].stage_name;
				}
			}
			var infowindow = new naver.maps.InfoWindow({
		        content: "<div style='padding-top:10px;'>" + stgname + "</div>"
		    });
			infowindow.close();
		    console.log("마커 좌표 : " + markerPosition.lat() + ", " + markerPosition.lng());
		    
		    var selectedPerformances = [];
		    for (var i = 0; i < delist2.length; i++) {
		    	var latitude = parseFloat(delist2[i].latitude);
		      	var longitude = parseFloat(delist2[i].longitude);
		      	
		      	if (latitude == markerPosition.lat() && longitude == markerPosition.lng()) {
		        	var stageId = delist2[i].stage_id;
		        	for (var j = 0; j < delist1.length; j++) {
		          		if (stageId == delist1[j].stage_id) {
		            		selectedPerformances.push({
		              			playinfo: delist1[j]
		            		});
		          		}
		        	}
	        	}
		    }
		    
		    if (selectedPerformances.length > 0) {
		    	//테이블 생성
		    	var table = "";
				$('#infolist').scrollTop(0); // 스크롤 위치 초기화
				$('#infolist').empty(); // infolist 비우기
				table += "<br><h3 style='text-align:center; margin-top:10px;'>" + stgname + "</h3>";
		    	
		      	for (var i = 0; i < selectedPerformances.length; i++) {
		        	var playinfo = selectedPerformances[i].playinfo;
	        		table += '<table id="infotable"><tr><td><img id="poster" src="' + playinfo.poster + '"></td></tr>';
	        		table += "<tr><td><a href='../search/playDetail?play_id=" + playinfo.play_id + "' data-play-id='" + playinfo.play_id + "'><b>" + playinfo.play_name + '</b></a></td></tr>';
			        table += '<tr><td>' + playinfo.play_start + ' ~ ' + playinfo.play_end + '</td></tr>';
			        table += '<tr><td>' + stgname + '</td></tr>';
			        table += "<tr><td style='text-align:right'>";
			        table += "<tr><td style='text-align:right'>";
			        if (isLogin == true) {
			            var hasBookmark = false;
			            for (var k = 0; k < mylist.length; k++) {
			                if (playinfo.play_id == mylist[k].play_id) {
			                    table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_selected.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
			                    hasBookmark = true;
			                    break;
			                }
			            }
			            if (!hasBookmark) {
			                table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
			            }
			        } else {
			            table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
			        }
                    $.ajax({
                        type: 'GET',
                        url: '../book/select_count',
                        data: { play_id: playinfo.play_id },
                        async: false, // 동기적으로 실행하여 for문 내에서 결과를 처리
                        success: function(response) {
                        	var cnt = response;
                            table += "<span class='bookmarkCount'>" + cnt + "</span> ";
                        },
                        error: function(xhr, status, error) {
                        	table += "0";  
                            console.log("북마크 카운트 ajax 실패!");
                        }
                    });
                    table += "<img class='shareIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-share.png' style='width:35px; padding-top:10px;' alt='sns공유'></td></tr>";
                    table += '</table>';
			    } //for
			    table += '<br><br><br>';
	    
			    // 테이블 추가
			    $('#infolist').html(table);
	    	}//if selectedPerformances.length > 0
		    //infowindow.setContent("<div style='padding:10px;'>" + stageName + "</div>");
	        infowindow.open(map, marker);
		}
		
		//지도에 마커 추가
		function addMarkers() {
			//console.log("addMarkers delist2 호출!!!!! >> " + list2[0].latitude);
			for (var i = 0; i < delist1.length; i++) {
				var playItem = delist1[i];
			    var stageItem = delist2.find(function(stage) {
			    	return stage.stage_id == playItem.stage_id;
			    });
			    if (stageItem) {
			        var lat = parseFloat(stageItem.latitude);
			        var lng = parseFloat(stageItem.longitude);
			        var existingMarker = markers.find(function(marker) {
			        	return marker.getPosition().lat() == lat && marker.getPosition().lng() == lng;
			        });

			        if (!existingMarker) {
			          	var marker = new naver.maps.Marker({
				            position: new naver.maps.LatLng(lat, lng),
				            draggable: false,
				            map: map
			          	});
			          	markers.push(marker);
			          	addMarkerClickListener(marker, i);
		          	}
		        }
		    }
		}
		
		$.ajax({
			url : "infoList",
			contentType: "application/json; charset=UTF-8",
			dataType: "json", // 데이터 형식을 JSON으로 지정
			success : function(data) {
				var response = data;

				// delist1과 delist2 추출
				delist1 = response.delist1; //play 불러와짐 확인완료.
				delist2 = response.delist2; //stage 불러와짐 확인완료.

				console.log("delist1 길이 : " + delist1.length);
				console.log("delist2 길이 : " + delist2.length);
				
				addItems();
				addMarkers(); //시작하자마자 마커 추가
				
				var marker1 = {
					url: 'http://static.naver.net/maps/img/icons/sp_pins_default_v3_over.png',
				    size: new naver.maps.Size(24, 37),
				    origin: new naver.maps.Point(90, 0),
				    anchor: new naver.maps.Point(12, 37)
				}; //네이버 지도 기본 핀 이미지
			    
				var marker2 = {
				    content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/cluster-marker-2.png);background-size:contain;"></div>',
				    size: N.Size(40, 40),
				    anchor: N.Point(20, 20)
				}; //묶인 마커의 수
				var marker3 = {
				    content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/cluster-marker-3.png);background-size:contain;"></div>',
				    size: N.Size(40, 40),
				    anchor: N.Point(20, 20)
				};
				var marker4 = {
				    content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/cluster-marker-4.png);background-size:contain;"></div>',
				    size: N.Size(40, 40),
				    anchor: N.Point(20, 20)
				};

				var markerClustering = new MarkerClustering({
				    minClusterSize: 2,
				    maxZoom: 13,
				    map: map,
				    markers: markers,
				    disableClickZoom: false,
				    gridSize: 120,
				    icons: [marker1, marker2, marker3, marker4],
				    indexGenerator: [1, 10, 50, 100],
				    stylingFunction: function (clusterMarker, count) {
				    	if (count > 1) {
				        	$(clusterMarker.getElement()).find('div:first-child').text(count);
				      	}
				    }
				}); //markerClustering
			}, //success
			error : function() {
				alert('실패@@@');
			}
		});//ajax
			
		//region순서 : 강원도 - 경기도 - 경상남도 - 경상북도 - 광주 - 대구 - 대전 - 부산
		//			- 서울 - 울산 - 인천 - 전남 - 전북 - 제주도 - 충남 - 충북 - 세종
	    urlPrefix = '../resources/data/region';
	    urlSuffix = '.json',
	    regionGeoJson = [],
	    loadCount = 0;
				
	    var gangwon = new naver.maps.LatLng(37.780962, 128.0009629),
		geonggi = new naver.maps.LatLng(37.567167, 126.980292),
		gyeongsang_nam = new naver.maps.LatLng(35.309787, 127.864734),
		gyeongsang_buk = new naver.maps.LatLng(36.388503, 128.204734),
		gwangju = new naver.maps.LatLng(35.126033, 126.831302),
		daegu = new naver.maps.LatLng(35.798838, 128.583052),
		daejeon = new naver.maps.LatLng(36.321655, 127.378953),
		busan = new naver.maps.LatLng(35.1797865, 129.0750194),
		seoul = new naver.maps.LatLng(37.517167, 126.790292),
		ulsan = new naver.maps.LatLng(35.519301, 129.239078),
		incheon = new naver.maps.LatLng(37.509221, 126.573234),
		jeolla_nam  = new naver.maps.LatLng(34.9006890, 126.5530664),
		jeolla_buk  = new naver.maps.LatLng(35.756705, 126.804185),
		jeju = new naver.maps.LatLng(33.4090628, 126.534361),
		chung_nam = new naver.maps.LatLng(36.557229, 126.379757),
		chung_buk = new naver.maps.LatLng(36.548503, 127.529344),
		sejong = new naver.maps.LatLng(36.48050, 127.28167);
	    
	    var infoWindow = new naver.maps.InfoWindow({
	        anchorSkew: true
	    });//infoWindow

	    map.setCursor('pointer');

	    function searchCoordinateToAddress(latlng) {
	        infoWindow.close(); //열려있는 infoWindow가 있다면 닫기

	        naver.maps.Service.reverseGeocode({
	            coords: latlng,
	            orders: [
	                naver.maps.Service.OrderType.ADDR,
	                naver.maps.Service.OrderType.ROAD_ADDR
	            ].join(',')
	        }, function(status, response) {
	            if (status == naver.maps.Service.Status.ERROR) {
	                return alert('네이버 MAP 서비스 오류!');
	            }
	            var items = response.v2.results,
	                address = '',
	                htmlAddresses = [];

	            for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	                item = items[i];
	                address = makeAddress(item) || '';
	                addrType = item.name == 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

	                htmlAddresses.push(addrType +' '+ address);
	            }
	            //추후 주석처리예정
	            infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                '<h4 style="margin-top:5px;">클릭된 좌표</h4>',
	                htmlAddresses.join('<br />'),
	                '</div>'
	            ].join('\n'));
	            
				map.setCenter(latlng);
				map.setZoom(14);
	            infoWindow.open(map, latlng);
	            
	         	// 클릭 시 infoWindow를 닫도록 설정
	            naver.maps.Event.addListener(infoWindow, 'click', function() {
	                infoWindow.close();
	            });
	        });	     
	    }//searchCoordinateToAddress
	    
	 	// 공연장 이름 검색
	    function searchStageName(address) {
	    	var existing = false;
	        for (var i = 0; i < delist2.length; i++) {
	            var stageName = delist2[i].stage_name.trim();
	            var add = address.trim();
	            // 공연장 이름에 유사한 부분이 있는지 확인
	            if (stageName.includes(address)) {
	                var latitude = parseFloat(delist2[i].latitude);
	                var longitude = parseFloat(delist2[i].longitude);
	                
	                // 이미 만들어진 공연장 마커를 찾음
	                var existingMarker = markers.find(function(marker) {
	                    return marker.getPosition().lat() === latitude && marker.getPosition().lng() === longitude;
	                });

	                if (existingMarker) {
	                    handleMarkerClick(existingMarker);
	                    existing = true;
	                    return 0;
	                }
	            }
	        }
	        if(existing == false){
	        	alert("검색결과가 없습니다!");
	        }
	    }
	    
	    function searchAddressToCoordinate(address) {
	        naver.maps.Service.geocode({
	            query: address
	        }, function(status, response) {
	            if (status == naver.maps.Service.Status.ERROR) {
	                return alert('API오류가 발생했습니다');
	            }
	            if (response.v2.meta.totalCount == 0) {
	            	//주소 입력결과 없음.
	            	searchStageName(address);
	                return 0;
	            }

	            var item = response.v2.addresses[0];
	            var point = new naver.maps.Point(item.x, item.y);
	            var htmlAddresses = [];

	            if (item.roadAddress) {
	                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	            }
	            if (item.jibunAddress) {
	                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	            }
	            if (item.englishAddress) {
	                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	            }
	            // 주소와 좌표를 출력하는 HTML 생성
	            infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                '<h4 style="margin-top:5px;">검색 주소 : ' + address + '</h4>',
	                htmlAddresses.join('<br />'),
	                '</div>'
	            ].join('\n'));

	            map.setCenter(point);
	            map.setZoom(14);
	            infoWindow.open(map, point);
	            console.log("주소 입력받음!!");
	            //console.log("infolist:", infolist);
	        });
	    }
	    $('#address').on('keydown', function(e) {
            var keyCode = e.which;

            if (keyCode == 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
            }
        });
	    
	    function initGeocoder() {
	        map.addListener('click', function(e) {
	            searchCoordinateToAddress(e.coord);
	        });
	        //searchAddressToCoordinate
	    }//initGeocoder
	    
	    function makeAddress(item) {
	        if (!item) {
	            return;
	        }
	        var name = item.name,
	            region = item.region,
	            land = item.land,
	            isRoadAddress = name == 'roadaddr';

	        var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

	        if (hasArea(region.area1)) {
	            sido = region.area1.name;
	        }
	        if (hasArea(region.area2)) {
	            sigugun = region.area2.name;
	        }
	        if (hasArea(region.area3)) {
	            dongmyun = region.area3.name;
	        }
	        if (hasArea(region.area4)) {
	            ri = region.area4.name;
	        }
	        if (land) {
	            if (hasData(land.number1)) {
	                if (hasData(land.type) && land.type == '2') {
	                    rest += '산';
	                }
	                rest += land.number1;

	                if (hasData(land.number2)) {
	                    rest += ('-' + land.number2);
	                }
	            }
	            if (isRoadAddress == true) {
	                if (checkLastString(dongmyun, '면')) {
	                    ri = land.name;
	                } else {
	                    dongmyun = land.name;
	                    ri = '';
	                }
	                if (hasAddition(land.addition0)) {
	                    rest += ' ' + land.addition0.value;
	                }
	            }
	        }
	        return [sido, sigugun, dongmyun, ri, rest].join(' ');
	    }//makeAddress
	    
	    function hasArea(area) {
	        return !!(area && area.name && area.name !== '');
	    }//hasArea
	    
	    function hasData(data) {
	        return !!(data && data !== '');
	    }//hasData

	    function checkLastString (word, lastString) {
	        return new RegExp(lastString + '$').test(word);
	    }//checkLastString

	    function hasAddition (addition) {
	        return !!(addition && addition.value);
	    }//hasAddition

	    naver.maps.onJSContentLoaded = initGeocoder;
		
		//줌레벨이 바뀔때마다 호출
		map.addListener('zoom_changed', function () {
   			checkZoomLevel();
		});//zoom_changed
		
		//dataLayer
		naver.maps.Event.once(map, 'init', function () {
		    for (var i = 1; i < 18; i++) {
		        var keyword = i +'';
		        if (keyword.length == 1) {
		            keyword = '0'+ keyword;
		        }//if
		        $.ajax({
		            url: urlPrefix + keyword + urlSuffix,
		            success: function(idx) {
		                return function(geojson) {
		                    regionGeoJson[idx] = geojson;
		                    loadCount++;
		                    if (loadCount == 17 && map.getZoom() <= 7 ) {
		                        startDataLayer();
		                    }//if
		                }//return fun
		            }(i - 1)//sucess
		        });//ajax
		    }
		});//map-event once
		
		// 입력받은 주소로 지도 이동하기
        function moveToAddress() {
            var address = document.getElementById('addressInput').value;
            var geocoder = new naver.maps.Service.Geocoder();

            geocoder.addressToCoord(address, function(result, status) {
                if (status == naver.maps.Service.Status.ERROR) {
                    console.log("주소 변환 오류");
                    return;
                }
                var coords = result.v2.addresses[0].x + ", " + result.v2.addresses[0].y;

                var center = new naver.maps.LatLng(result.v2.addresses[0].y, result.v2.addresses[0].x);
                map.setCenter(center);
                map.setZoom(14);
            });//addressToCoord
            
        }//moveToAddress	
		
		function startDataLayer() {
		    map.data.setStyle(function(feature) {
		        var styleOptions = {
		            fillColor: '#ff0000',
		            fillOpacity: 0.0001,
		            strokeColor: '#ff0000',
		            strokeWeight: 2,
		            strokeOpacity: 0.4
		        };
		        if (feature.getProperty('focus')) {
		            styleOptions.fillOpacity = 0.6;
		            styleOptions.fillColor = '#0f0';
		            styleOptions.strokeColor = '#0f0';
		            styleOptions.strokeWeight = 4;
		            styleOptions.strokeOpacity = 1;
		        }
		        
		        return styleOptions;
		    });//setStyle
		    
		    // 기존에 추가된 레이어 제거
		    map.data.forEach(function(feature) {
		    	map.data.removeFeature(feature); //데이터가 있다면 삭제
		    });
		    
		    regionGeoJson.forEach(function(geojson) {
		        map.data.addGeoJson(geojson);
		    });
		
		    //지역 클릭 시
		    map.data.addListener('click', function(e) {
		    	var filteredList = []; //선택된 지역의 공연리스트
		    	startIndex = 0;
		    	dataCount = 10;
		        var feature = e.feature;
		       	var area = feature.getProperty('area1');
		       	
				if(area == "강원도"){
					map.setCenter(gangwon);
		        	map.setZoom(9);
				} else if(area == "경기도"){
		        	map.setCenter(geonggi);
		        	map.setZoom(9);
		        } else if(area == "경상남도"){
		        	map.setCenter(gyeongsang_nam);
		        	map.setZoom(9);
		        } else if(area == "경상북도"){
		        	map.setCenter(gyeongsang_buk);
		        	map.setZoom(9);
		        } else if(area == "광주광역시"){
		        	map.setCenter(gwangju);
		        	map.setZoom(12);
		        } else if(area == "대구광역시"){
		        	map.setCenter(daegu);
		        	map.setZoom(11);
		        } else if(area == "대전광역시"){
		        	map.setCenter(daejeon);
		        	map.setZoom(11);
		        } else if(area == "부산광역시"){
		        	map.setCenter(busan);
		        	map.setZoom(11);
		        } else if(area == "서울특별시"){
		        	map.setCenter(seoul);
		        	map.setZoom(11);
		        } else if(area == "울산광역시"){
		        	map.setCenter(ulsan);
		        	map.setZoom(11);
		        } else if(area == "인천광역시"){
		        	map.setCenter(incheon);
		        	map.setZoom(11);
		        } else if(area == "전라남도"){
		        	map.setCenter(jeolla_nam);
			        	map.setZoom(9);
		        } else if(area == "전라북도"){
		        	map.setCenter(jeolla_buk);
		        	map.setZoom(9);
		        } else if(area == "제주특별자치도"){
		        	map.setCenter(jeju);
		        	map.setZoom(11);
		        } else if(area == "충청남도"){
		        	map.setCenter(chung_nam);
		        	map.setZoom(9);
		        } else if(area == "충청북도"){
		        	map.setCenter(chung_buk);
		        	map.setZoom(9);
		        } else if(area == "세종특별자치시"){
		        	map.setCenter(sejong);
		        	map.setZoom(11);
		        }

				 for (var i = 0; i < delist2.length; i++) {
			        var stageInfo = delist2[i];
			        
					var area_string = stageInfo && stageInfo.address ? stageInfo.address.split(" ") : [];
        			var area_name = area_string[0] || "";
			        
			        if(area_name == area){
			        	//console.log("area값이 같다!!!" + area_name + ", " + stageInfo.stage_name);
			        	filteredList.push({
			                stageinfo: delist2[i]
			            });
			        }
			    }
				
			    if (filteredList.length > 0) {
			    	click = "area";
			    	var count = 0;
			    	var table = "";
			    	$('#infolist').scrollTop(0); // 스크롤 위치 초기화
			    	$('#infolist').empty(); // infolist 비우기
			    	
			    	for (var i = 0; i < filteredList.length; i++) {
			            var stageinfo = filteredList[i].stageinfo;
			            for(var j=0; j<delist1.length; j++){
			            	if(stageinfo.stage_id == delist1[j].stage_id){
			            		table += '<table id="infotable"><tr><td><img id="poster" src="' + delist1[j].poster + '"></td></tr>';
			            		table += "<tr><td><a href='../search/playDetail?play_id=" + delist1[j].play_id + "' data-play-id='" + delist1[j].play_id + "'><b>" + delist1[j].play_name + '</b></a></td></tr>';
						        table += '<tr><td>' + delist1[j].play_start + ' ~ ' + delist1[j].play_end + '</td></tr>';
					            table += '<tr><td>' + stageinfo.stage_name + '</td></tr>';
					            table += "<tr><td style='text-align:right'>"
				            	if (isLogin == true) {
				            	    var hasBookmark = false;
				            	    for (var k = 0; k < mylist.length; k++) {
				            	        if (delist1[j].play_id == mylist[k].play_id) {
				            	            table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_selected.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
				            	            hasBookmark = true;
				            	            break;
				            	        }
				            	    }
				            	    if (!hasBookmark) {
				            	        table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
				            	    }
				            	} else {
				            	    table += "<img class='bookIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-book_none.jpg' style='width:35px; padding-top:15px;' alt='북마크'>";
				            	}
		                        $.ajax({
		                            type: 'GET',
		                            url: '../book/select_count',
		                            data: { play_id: delist1[j].play_id },
		                            async: false, // 동기적으로 실행하여 for문 내에서 결과를 처리
		                            success: function(response) {
		                            	var cnt = response;
		                                table += "<span class='bookmarkCount'>" + cnt + "</span> ";
		                            },
		                            error: function(xhr, status, error) {
		                            	table += "0";  
		                                console.log("북마크 카운트 ajax 실패!");
		                            }
		                        });
		                        table += "<img class='shareIcon' src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-share.png' style='width:35px; padding-top:10px;' alt='sns공유'></td></tr>";
		                        table += '</table>';
		                        count++;
			            	}
			            }//for ㅓ문       	
			        }//for i문
			    	table = "<br><h3 style='text-align:center'><" + area + "> 검색결과 " + count + "개</h3>" + table;
			    	$('#infolist').html(table);			    	
			    } else {
			    	$('#infolist').scrollTop(0); // 스크롤 위치 초기화
			    	$('#infolist').empty(); // infolist 비우기
			    	table = "<br><h3 style='text-align:center; margin-top:10px;'><" + area + " 검색결과></h3>" + "<br><br><br><br><br><br><br><br><br><br><h4 style='text-align:center; color:gray;'>검색결과 없음</h4>";
			    	table += "<br><br><br><br><br><br><br><br><br><br><br><br><br><br>";
			    	$('#infolist').html(table);
			    }	        
				
		    });//click addListener
		
		    map.data.addListener('mouseover', function(e) {
		        var feature = e.feature,
		            regionName = feature.getProperty('area1');
		        tooltip.css({
		            display: '',
		            left: e.offset.x,
		            top: e.offset.y,
		            fontSize: '19px', // 원하는 글꼴 크기로 설정
		           	fontWeight: 'bold' // 원하는 폰트 굵기로 설정
		        }).text(regionName);
		        map.data.overrideStyle(feature, {
		            fillOpacity: 0.25,
		            strokeWeight: 3,
		            strokeOpacity: 1
		        });
		    });//mouseover addListener
		    
		    map.data.addListener('mouseout', function(e) {
		        tooltip.hide().empty();
		        map.data.revertStyle();
		    });//mouseout addListener
		}//startdataLayer
		
		var infowindow = new naver.maps.InfoWindow();
		
		function checkZoomLevel() {
		    var currentZoom = map.getZoom();
	        console.log("현재 줌레벨 : " + map.getZoom());
		    if (currentZoom < 10) {
		        map.data.setStyle(function(feature) {
		            var styleOptions = {
		                visible: true,
		                fillColor: '#ff0000',
		                fillOpacity: 0.0001,
		                strokeColor: '#ff0000',
		                strokeWeight: 2,
		                strokeOpacity: 0.4
		            };
		            if (feature.getProperty('focus')) {
		                styleOptions.fillOpacity = 0.25;
		                styleOptions.fillColor = '#ff0000';
		                styleOptions.strokeColor = '#ff0000';
		                styleOptions.strokeWeight = 3;
		                styleOptions.strokeOpacity = 1;
		            }
		            return styleOptions;
		        });//setStyle
		    } else {
		        console.log("줌 레벨이 11 이상입니다.");
		        map.data.setStyle(function(feature) {
		            var styleOptions = {
		                visible: false
		            };
		            if (feature.getProperty('focus')) {
		                styleOptions.visible = true;
		            }
		            return styleOptions;
		        }); //setStyle
		    }//else
		}//checkZoomLevel
				
		var tooltip = $('<div style="position:absolute;z-index:1000;padding:5px 10px;background-color:#fff;border:solid 2px #000;font-size:14px;pointer-events:none;display:none;"></div>');
		tooltip.appendTo(map.getPanes().floatPane);
		

		$('#result').empty();
		
		if(userEmail != null){
			$.ajax({
			    url: "../map/select_myPreference",
			    type: "GET",
			    data: { email: userEmail },
			    success: function(response) {
			    	console.log(response);
			        if(response != []){
			        	$.ajax({
						    url: "../map/select_recommendPlay",
						    type: "GET",
						    data: { email: userEmail },
						    success: function(response) {
						        $('#result').html(response); // 응답 데이터를 HTML로 설정합니다.
						    },
						    error: function() {
						        alert("데이터를 불러오는 중에 오류가 발생했습니다.");
						    }
						});
			        }else{
			        	$('#result').html("<a href='../map/recommend.jsp'><button class='btn-0' style='margin:20px; width:200px; height:70px;'>맞춤설정하러가기</button></a>")
			        }
			    },
			    error: function() {
			        alert("데이터를 불러오는 중에 오류가 발생했습니다.");
			    }
			});
		}
		else{
			$('#result').html("<a href='../login/login.jsp'><button class='btn-0'>로그인 후 맞춤설정하러가기</button></a>")
		}
	});
</script>
<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/sidemenu.css" />
<link rel="stylesheet" href="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/css/page01.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header"></header>
	<div id="map-container">
		<div id="banner" style="display: flex; justify-content: center;">
			<div id="imgBody">
				<img src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/temp-banner3.png" id="main-img"/>
				<div id="main_btn_div" style="position: absolute; top: 52%; left: 62%; transform: translate(-45%, -50%);">
					<ul class="main_ul" style="list-style-type: none; margin-left: 120px; width: auto; display: flex; justify-content: space-between;">
						<li class="main_li" style="width:500px;">
							<button id="btn_check" style="background-color: white; padding: 2%; margin: 2%; width: 400px; height: 300px;">
								<img src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/check.png" style="width: 100%; height: 100%;">
							</button>
							<p style="font-size:18pt;"><b>맞춤추천 공연 보기</b></p>
						</li>
						<li class="main_li" style="width:500px;">
							<button id="btn_map" style="background-color: white; padding: 2%; margin: 2%; width: 400px; height: 300px;">
								<img src="https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/map.png" style="width: 100%; height: 100%;">
							</button>
							<p style="font-size:18pt;"><b>지도로 찾아보기</b></p>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div id="map">
			<div id="side-bar" class="left-side-bar">
				<table id="inputtable" style="height: 50px;">
					<tr style="text-align: center;">
						<td>
							<img src='https://dorae.s3.ap-northeast-2.amazonaws.com/resources/img/icon-map.png' style='width: 40px; margin: 5px; height: 40px;'>
						</td>
						<td><input id="address" type="text" placeholder="주소를 입력해주세요"></td>
					</tr>
				</table>
				<div id="infolist"></div>
			</div>
		</div>
	</div>
	<br><br>
	<div id="result" style="width: 100%; text-align: center;">
	취향에 맞는 공연을 추천해드립니다!<br>
	
	</div>
	<div id="test"></div>
</body>
</html>