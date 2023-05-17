const container = document.querySelector('.container'); // 특정 name,id,class를 제한하지 않고 css선택자를 사용하여 요소를 찾는다. 스크립트의 최상단 요소만 로직에 포함
const seats = document.querySelectorAll('.row .seat:not(.occupied'); // 배열과 비슷한 객체인 nodeList를 반환 -  for문 또는 forEach문을 사용
const count = document.getElementById('count');
const price = document.getElementById('price');
const fee = document.getElementById('fee');
const total = document.getElementById('total');
const showSelect = document.getElementById('show');
const seat_num = document.getElementById('seat_num');

	// 티켓가격 변수
let ticketPrice = +showSelect.value; 

	// localstorage에서 데이터 가져오기, UI 채우기 ---지울 가능성 있음
function populateUI() {

	// localStorage에서 'selectedSeats'를 키로 가지고 있는 값(JSON.stringify(seatsIndex))을 가져와 변수 selectedSeats에 저장한다 
	// JSON.parse() 메서드는 JSON 문자열의 구문을 분석하고, 그 결과에서 JavaScript 값이나 객체를 생성한다
  const selectedSeats = JSON.parse(localStorage.getItem('selectedSeats'));

	// 조건문은 'selectedSeats'가 존재하는 경우에만 실행된다.
  if (selectedSeats !== null && selectedSeats.length > 0) {
  
	// 부분에서는 seats 배열의 모든 요소를 순회하며 콜백 함수를 반복 호출한다.
	// 호출되는 콜백 함수는 localStorage에서 가져온 selectedSeats의 인덱스가 0 이상이면 해당하는 요소에 'selected' 클래스를 부여한다
    seats.forEach((seat, index) => {
      if (selectedSeats.indexOf(index) > -1) {
        seat.classList.add('selected');
      }
    });
  }  else {
        seats.forEach(seat => {
            seat.classList.remove('selected');
        })
    }
  const selectedShowIndex = localStorage.getItem('selectedShowIndex');
  if (selectedShowIndex !== null) {
    showSelect.selectedIndex = selectedShowIndex;
  }
}
populateUI();

	// 공연 인덱스와 value값(가격)을 함수의 매개변수로 받아 localStorage에 저장하기
	// (localStorage: 브라우저 세션 간에 공유되는 저장된 데이터 setItem을 통해 저장하고, getItem을 통해 데이터를 불러온다)
function setShowData(showIndex, showPrice) {
  localStorage.setItem('selectedShowIndex', showIndex);
  localStorage.setItem('selectedShowPrice', showPrice);
}

	// total과 count 업데이트
function updateSelectedCount() {

	// 좌석 클릭 이벤트로 선택된 좌석을 selectedSeats로 저장시킨다.
  const selectedSeats = document.querySelectorAll('.row .seat.selected');

	// 앞서 초기화했던 변수 selectedSeats들을 [...selectedSeats]로 스프레드 문법을 사용해 개별적 값을 만든 후, 배열로 만든다.  
	// map을 통해 반복문을 돌며 배열 안의 요소들을 [...seats].indexOf(seat)와 1대 1로 짝지어준다.
  const seatsIndex = [...selectedSeats].map(seat => { return [...seats].indexOf(seat); });
  
  	// 선택된 좌석의 배열 개수
  const selectedSeatsCount = selectedSeats.length;
  
	// setItem에 키: 'selectedSeats', 값: JSON.stringify(seatsIndex)를 설정해준다 -JSON.stringify(): JavaScript 값이나 객체를 JSON 문자열로 변환
  localStorage.setItem('selectedSeats', JSON.stringify(seatsIndex));

	// text부분에 나타낼 정보(선택된 좌석, 가격, 수수료, 총 합계)
  count.innerText = selectedSeatsCount;
  price.innerText = selectedSeatsCount * ticketPrice;
  fee.innerText = selectedSeatsCount * 1000;
  total.innerText = selectedSeatsCount * ticketPrice + selectedSeatsCount * 1000;
}



	// 공연선택 이벤트
showSelect.addEventListener('change', (e) => {
  ticketPrice = +e.target.value;
  setShowData(e.target.selectedIndex, e.target.value);
  updateSelectedCount();
});

	// 좌석클릭 이벤트(container를 이벤트 위임으로서 사용- 단 조건문 사용해서 범위를 seat로 한정)
container.addEventListener('click', (e) => {
	// classList로 해당 DOM이 가진 class 목록을 확인할 수 있음
  if (e.target.classList.contains('seat') && !e.target.classList.contains('occupied')) {
  	
  	// toggle로 classList에 해당 클래스명이 있다면 제거하고 없다면 추가
    e.target.classList.toggle('selected'); // 좌석색깔 변경
    updateSelectedCount();
	}
});

	// intial count and total
updateSelectedCount();
