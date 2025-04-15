// 할 일(Todo) 객체를 나타내는 모델 클래스
class Todo {
  final String title;   // 할 일 제목
  final String content; // 할 일 상세 내용

  // 생성자
  const Todo(this.title, this.content);

  // 디버깅 및 출력용 toString 오버라이딩 (선택사항)
  @override
  String toString() => 'Todo(title: $title, content: $content)';
}
