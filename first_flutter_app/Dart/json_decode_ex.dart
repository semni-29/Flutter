import 'dart:convert';

void main(){
  var jsonString = '''
    [
      {"score" : 40},
      {"score" : 80}
    ]
  '''; 
  // => jsonString 변수에 저장된 데이터가 JSON형태의 문자열
  // -> 이 데이터를 covert 라이브러리에 있는 jsonDecode()함수에 전달 후, 그 결과를 scores 변수에 저장(아래)
  //    ㄴ jsonDecode() 함수는 JSON 형태의 데이터를 dynamic 형식의 리스트로 변환하여 반환함
  var scores = jsonDecode(jsonString); 
  print(scores is List); //True 출력 => List코드는 scores변수가 리스트가 아니면 False를 반환, 리스트 형식이면 True 반환
                        // score 변수가 리스트인지 True/False로 점검 가능

  var firstScore = scores[0]; //scores 리스트의 첫번째 값을 firstScore변수에 저장 => key(키)와 value(값)가 있는 Map형태
  print(firstScore is Map); //true 출력 => firstScore가 Map인지 점검
  print(firstScore['score'] == 40); //true출력
}
