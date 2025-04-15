class People {
  String name;
  double height;
  double weight;
  double? _bmi; // bmi는 private 변수로 설정

  // 생성자
  People(this.name, this.height, this.weight);

  // bmi를 계산하는 getter
  double get bmi {
    // _bmi가 null일 경우에만 계산하도록 함
    _bmi ??= weight / ((height / 100) * (height / 100));
    return _bmi!;
  }
}
