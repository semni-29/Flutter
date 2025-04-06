//로또번호 생성기

import 'dart:collection'; // HashSet 이용을 위해 'dart:collection' 라이브러리 import
import 'dart:math' as math; //랜덤함수 이용을 위해 'dart:math'라이브러리 import

void main(){
  var random = math.Random();
  HashSet<int> lottoNumber = HashSet(); //HashSet은 무작위로 정렬되며, 반복 순서가 지정되지 않습니다.

  while(lottoNumber.length < 6){ //6개의 무작위 숫자를 출력. /추가로 lottoSet.length < 7 로 바꾸면 보너스번호까지 7개가 출력된다.
    lottoNumber.add(random.nextInt(45)+1); //nextInt 메서드는 0 이상의 랜덤한 정수를 생성.
    // Random().nextInt(45); => 해당 함수는 0~44까지의 범위중에서 랜덤으로 숫자를 반환함. 
    // 로또 번호는 1~45이므로 +1을 추가함
  }
  print(lottoNumber);
}