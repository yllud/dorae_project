<!-- page01.jsp파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
#header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 100;
}

#map {
	width: 100%;
	height: 850px;
	z-index: 1;
	position: relative;
}

:root { -
	-header-height: 0;
}

.banner {
	z-index: 9999; /* 다른 요소들보다 위에 나타나도록 z-index 설정 */
}
</style>
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
		$("#header").load("../header.jsp");

		$.ajax({
			url : "latLngList",
			success : function(x) {
				//region순서 : 강원도 - 경기도 - 경상남도 - 경상북도 - 광주 - 대구 - 대전 - 부산
				//			- 서울 - 울산 - 인천 - 전남 - 전북 - 제주도 - 충남 - 충북 - 세종
			    urlPrefix = '../resources/data/region';
			    urlSuffix = '.json',
			    regionGeoJson = [],
			    loadCount = 0;
				
				// 네이버 지도 API를 로드합니다.
				var map = new naver.maps.Map('map', {
					zoom : 7,
					mapTypeId: 'normal',	
					center : new naver.maps.LatLng(37.5666103,
							126.9783882), // 서울 시청을 지도 중심으로 설정
					zoomControl : true,
					zoomControlOptions : {
						position : naver.maps.Position.TOP_LEFT,
						style : naver.maps.ZoomControlStyle.SMALL
					}
				});
				
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

				                    if (loadCount === 17) {
				                        startDataLayer();
				                    }
				                }
				            }(i - 1)
				        });
				    }
				});
				
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
				    });
				
				    regionGeoJson.forEach(function(geojson) {
				        map.data.addGeoJson(geojson);
				    });
				
				    map.data.addListener('click', function(e) {
				        var feature = e.feature;
				        map.setZoom(9);
				        /*
				        if (feature.getProperty('focus') !== true) {
				            feature.setProperty('focus', true);
				        } else {
				            feature.setProperty('focus', false);
				        }*/
				    });
				
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
				    });
				
				    map.data.addListener('mouseout', function(e) {
				        tooltip.hide().empty();
				        map.data.revertStyle();
				    });
				}
				
				var infowindow = new naver.maps.InfoWindow();

				function onSuccessGeolocation(position) {
				    var location = new naver.maps.LatLng(position.coords.latitude,
				                                         position.coords.longitude);
				    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
				    map.setZoom(10); // 지도의 줌 레벨을 변경합니다.

				    infowindow.setContent('<div style="padding:20px;">' + 'geolocation.getCurrentPosition() 위치' + '</div>');

				    infowindow.open(map, location);
				    console.log('Coordinates: ' + location.toString());
				    console.log("onSuccess 실행!");
				    addMarkers(x, map);
				    map.setZoom(14);
				}

				function onErrorGeolocation() {
				    var center = map.getCenter();

				    //infowindow.setContent('<div style="padding:20px;">' +
				    //    '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
				    console.log("onError 실행!");
				    //infowindow.open(map, center);
				    addMarkers(x, map);
				    map.setZoom(7);
				}

				$(window).on("load", function() {
				    if (navigator.geolocation) {
				        /**
				         * navigator.geolocation 은 Chrome 50 버젼 이후로 HTTP 환경에서 사용이 Deprecate 되어 HTTPS 환경에서만 사용 가능 합니다.
				         * http://localhost 에서는 사용이 가능하며, 테스트 목적으로, Chrome 의 바로가기를 만들어서 아래와 같이 설정하면 접속은 가능합니다.
				         * chrome.exe --unsafely-treat-insecure-origin-as-secure="http://example.com"
				         */
				        navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
				    } else {
				        var center = map.getCenter();
				        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
				        infowindow.open(map, center);
				    }
				});
				
				function addMarkers(x, map) {
					var markers = [];
					for (var i = 0; i < x.length; i++) {
						var lat = x[i].latitude;
						var lng = x[i].longitude;
						marker = new naver.maps.Marker({
							position : new naver.maps.LatLng(lat, lng),
							draggable : true,
							map : map
						});
						markers.push(marker);
					}
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
					});
				}

				//데이터 레이어
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

				                    if (loadCount === 17) {
				                        startDataLayer();
				                    }
				                }
				            }(i - 1)
				        });
				    }
				});
				
				var tooltip = $('<div style="position:absolute;z-index:1000;padding:5px 10px;background-color:#fff;border:solid 2px #000;font-size:14px;pointer-events:none;display:none;"></div>');

				tooltip.appendTo(map.getPanes().floatPane);		
			}
		})
		$('#banner').load("mainImg.jsp");
	})
</script>
<link rel="stylesheet" href="${path}/resources/css/style.css" />
<meta charset="UTF-8">
<title>지도 추천 페이지</title>
</head>
<body>
	<header id="header" class="fixed-top"></header>
	<div id="map">
		<div class="main-top-space"></div>
		<div id="banner"></div>
	</div>
</body>
</html>
