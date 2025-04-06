import 'dart:convert';

void main(){
  var scores = [
                {'score':40},
                {'score':80},
                {'score':100, 'overtime':true, 'special_guest':null}
              ];

  var jsonText = jsonEncode(scores);
  print(jsonText == '[{"score":40},{"score":80},'
                    '{"score":100,"overtime":true,"special_guest":null}]'); //문자열 사이에 공백이 있으면 false로 출력됨.
}

//**왜 false가 출력되는가? < 마지막 print 조심
//- 코드에서 jsonEncode(scores)를 수행하면, Dart의 jsonEncode() 함수는 내부적으로 공백 없는 문자열을 생성합니다.
//- JSON 문자열을 생성할 때 공백을 포함하지 않는 표준 JSON 형식을 사용.
