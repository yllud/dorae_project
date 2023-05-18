<!-- page01_other2.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=uez2akrxoe&submodules=geocoder"></script>
<script type="text/javascript" src="../resources/js/MarkerClustering.js"></script>
<script type="text/javascript"
	src="${path}/resources/js/jquery-3.6.4.js"></script>
<script>
	$(function() {
		$("#header").load("../header.jsp"); // 헤더 추가
		//$("#sidebar").load("sidemenu.jsp"); // 사이드바 추가
		
		var map; // 전역 변수로 선언
		var markers = []; // 전역 변수로 선언
		
		// 네이버 지도 API를 로드합니다.
		map = new naver.maps.Map('map', {
			zoom : 7,
			minZoom: 7,
			mapTypeId: 'normal',
			center : new naver.maps.LatLng(36.5566103, 127.9783882), // 대한민국 중심
			zoomControl : true,
			zoomControlOptions : {
				position : naver.maps.Position.TOP_LEFT,
				style : naver.maps.ZoomControlStyle.SMALL
			}
		});//new map
		
		//region순서 : 강원도 - 경기도 - 경상남도 - 경상북도 - 광주 - 대구 - 대전 - 부산
		//			- 서울 - 울산 - 인천 - 전남 - 전북 - 제주도 - 충남 - 충북 - 세종
	    urlPrefix = '../resources/data/region';
	    urlSuffix = '.json',
	    regionGeoJson = [],
	    loadCount = 0;
				
	    var gangwon = new naver.maps.LatLng(37.880962, 128.3009629),
		geonggi = new naver.maps.LatLng(37.767167, 127.190292),
		gyeongsang_nam = new naver.maps.LatLng(35.509787, 128.364734),
		gyeongsang_buk = new naver.maps.LatLng(36.528503, 128.664734),
		gwangju = new naver.maps.LatLng(35.126033, 126.831302),
		daegu = new naver.maps.LatLng(35.798838, 128.583052),
		daejeon = new naver.maps.LatLng(36.321655, 127.378953),
		busan = new naver.maps.LatLng(35.1797865, 129.0750194),
		seoul = new naver.maps.LatLng(37.587167, 126.890292),
		ulsan = new naver.maps.LatLng(35.519301, 129.239078),
		incheon = new naver.maps.LatLng(37.469221, 126.573234),
		jeolla_nam  = new naver.maps.LatLng(37.0006890, 126.5930664),
		jeolla_buk  = new naver.maps.LatLng(35.816705, 127.144185),
		jeju = new naver.maps.LatLng(33.4090628, 126.534361),
		chung_nam = new naver.maps.LatLng(36.657229, 126.779757),
		chung_buk = new naver.maps.LatLng(36.528503, 127.929344),
		sejong = new naver.maps.LatLng(36.48750, 127.28167);
	    
	
		
		//줌레벨이 바뀔때마다 호출
		map.addListener('zoom_changed', function () {
   			checkZoomLevel();
		 	});//zoom_changed
		
		 	//dataLayer
		naver.maps.Event.once(map, 'init', function () {
		    for (var i = 1; i < 18; i++) {
		        var keyword = i +'';
		        if (keyword.length === 1) {
		            keyword = '0'+ keyword;
		        }
		        $.ajax({
		            url: urlPrefix + keyword + urlSuffix,
		            success: function(idx) {
		                return function(geojson) {
		                    regionGeoJson[idx] = geojson;

		                    loadCount++;

		                    if (loadCount === 17 && map.getZoom() <= 7 ) {
		                        startDataLayer();
		                    }
		                }
		            }(i - 1)
		        });
		    }
		});//map-event once
		
		// 입력받은 주소로 지도 이동하기
        function moveToAddress() {
            var address = document.getElementById('addressInput').value;
            var geocoder = new naver.maps.Service.Geocoder();

            geocoder.addressToCoord(address, function(result, status) {
                if (status === naver.maps.Service.Status.ERROR) {
                    console.log("주소 변환 오류");
                    return;
                }

                var coords = result.v2.addresses[0].x + ", " + result.v2.addresses[0].y;

                var center = new naver.maps.LatLng(result.v2.addresses[0].y, result.v2.addresses[0].x);
                map.setCenter(center);
                map.setZoom(14);
            });
        }		
		
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
		
		    map.data.addListener('click', function(e) {
		        var feature = e.feature;
		        console.log(feature);
		        console.log(feature.getProperty('area1'));
		       	var area = feature.getProperty('area1');
		        //var location = new naver.maps.LatLng(e.coord.lat(), e.coord.lng())
		        //map.setCenter(location);
				if(area === "강원도"){
					map.setCenter(gangwon);
		        	map.setZoom(9);
				} else if(area === "경기도"){
		        	map.setCenter(geonggi);
		        	map.setZoom(9);
		        } else if(area === "경상남도"){
		        	map.setCenter(gyeongsang_nam);
		        	map.setZoom(9);
		        } else if(area === "경상북도"){
		        	map.setCenter(gyeongsang_buk);
		        	map.setZoom(9);
		        } else if(area === "광주광역시"){
		        	map.setCenter(gwangju);
		        	map.setZoom(12);
		        } else if(area === "대구광역시"){
		        	map.setCenter(daegu);
		        	map.setZoom(11);
		        } else if(area === "대전광역시"){
		        	map.setCenter(daejeon);
		        	map.setZoom(11);
		        } else if(area === "부산광역시"){
		        	map.setCenter(busan);
		        	map.setZoom(11);
		        } else if(area === "서울특별시"){
		        	map.setCenter(seoul);
		        	map.setZoom(11);
		        } else if(area === "울산광역시"){
		        	map.setCenter(ulsan);
		        	map.setZoom(11);
		        } else if(area === "인천광역시"){
		        	map.setCenter(incheon);
		        	map.setZoom(11);
		        } else if(area === "전라남도"){
		        	map.setCenter(jeolla_nam);
		        	map.setZoom(9);
		        } else if(area === "전라북도"){
		        	map.setCenter(jeolla_buk);
		        	map.setZoom(9);
		        } else if(area === "제주특별자치도"){
		        	map.setCenter(jeju);
		        	map.setZoom(11);
		        } else if(area === "충청남도"){
		        	map.setCenter(chung_nam);
		        	map.setZoom(9);
		        } else if(area === "충청북도"){
		        	map.setCenter(chung_buk);
		        	map.setZoom(9);
		        } else if(area === "세종특별자치시"){
		        	map.setCenter(sejong);
		        	map.setZoom(11);
		        }
				/*
		        if (feature.getProperty('focus') !== true) {
		            feature.setProperty('focus', true);
		        } else {
		            feature.setProperty('focus', false);
		        } //지역레이터 클릭 시 초록색으로 fill*/
		    });//click addListener
		
		    map.data.addListener('mouseover', function(e) {
		        var feature = e.feature,
		            regionName = feature.getProperty('area1');
		        tooltip.css({
		            display: '',
		            left: e.offset.x,
		            top: e.offset.y
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
		    if (currentZoom < 10) {
		        console.log("줌 레벨이 9 미만입니다.");
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
		
		$.ajax({
			url : "playDetail2",
			success : function(x) {
				/*
				$(window).on("load", function() {
				    if (navigator.geolocation) {
				        //navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
				        //http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
				        //chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
				        
				        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
				    } else {
				        var center = map.getCenter();
				        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
				        infowindow.open(map, center);
				    }
				});//window load fun
				
				*/
				
				function addMarkers(x, map) {
					for (var i = 0; i < x.length; i++) {
					  	var lat = parseFloat(x[i].latitude);
					    var lng = parseFloat(x[i].longitude);
						marker = new naver.maps.Marker({
							position : new naver.maps.LatLng(lat, lng),
							draggable : true,
							map : map
						});
						markers.push(marker);
						addMarkerToList(markers[i]);
					}//for
					
					var marker1 = {
						style : "circle",
						radius : 5,
						fillColor : "red",
						fillOpacity : 1,
						strokeColor : "black",
						strokeStyle : "solid",
						strokeWeight : 3
					}, marker2 = {
						style : "circle",
						radius : 15,
						fillColor : "blue",
						fillOpacity : 1,
						strokeColor : "black",
						strokeStyle : "solid",
						strokeWeight : 3
					}, marker3 = {
						content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-4.png);background-size:contain;"></div>',
						size : N.Size(40, 40),
						anchor : N.Point(20, 20)
					}, //묶인 마커의 수
					marker4 = {
						url : 'http://static.naver.net/maps/img/icons/sp_pins_default_v3_over.png',
						size : new naver.maps.Size(24, 37),
						origin : new naver.maps.Point(90, 0),
						anchor : new naver.maps.Point(12, 37)
					}, //네이버 지도 기본 핀 이미지
					marker5 = {
						content : '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(../resources/img/cluster-marker-5.png);background-size:contain;"></div>',
						size : N.Size(40, 40),
						anchor : N.Point(20, 20)
					};
					var markerClustering = new MarkerClustering({
						minClusterSize : 2,
						maxZoom : 13,
						map : map,
						markers : markers,
						disableClickZoom : false,
						gridSize : 120,
						icons : [ marker1, marker2, marker3,
								marker4, marker5 ],
						indexGenerator : [ 10, 20, 30, 61, 100 ],
						stylingFunction : function(clusterMarker, count) {
							$(clusterMarker.getElement()).find(
									'div:first-child').text(count);
						}
					}); //markerClustering
				}//addMarkers
				
				//마커 리스트
				function addMarkerToList(marker) {
				  // 마커 정보를 추출하여 목록에 추가
				  var markerList = document.getElementById('marker-list');
				  var listItem = document.createElement('li');
				  listItem.textContent = marker.title; // 예시로 제목을 목록에 표시
				  markerList.appendChild(listItem);
				} //addMarkerToList
			}//success
		})//ajax
		$('#banner').load("mainImg.jsp");
	})
</script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<link rel="stylesheet" href="../resources/css/sidemenu.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="map-container">
		<div id="map">
			<div id="banner"><input type="text"></div>
			<div class="left-side-bar">
		        <div class="status-ico">
		            <span>▶</span>
		            <span>▼</span>
		        </div>
	    	<input id="address_input" type="text">
	        <div id="result">테스트테스트</div>
		</div>
		
    </div>
	</div>
	
</body>
</html>
