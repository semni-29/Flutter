//Todo 정보를 담는 모델 클래스
class Todo {
  final String? title;     /// 할 일 제목
  final String? content;   /// 할 일 내용
  int? active;       /// 활성 상태 (0 또는 1로 표현)
  int? id;           /// 고유 ID (DB의 기본 키 등으로 사용 가능)

  /// 생성자: 모든 필드는 선택 사항이며, named parameter로 전달
  Todo({this.title, this.content, this.active, this.id});

  /// 객체를 Map으로 변환하여 DB 저장 등에 활용
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'active': active,
    };
  }

  /// Map 데이터를 Todo 객체로 변환 (fromMap 생성자 추가)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int?,
      title: map['title'] as String?,
      content: map['content'] as String?,
      active: map['active'] as int?,
    );
  }
}
