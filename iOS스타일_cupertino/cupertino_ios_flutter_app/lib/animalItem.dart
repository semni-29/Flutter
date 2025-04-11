/// 동물 정보를 나타내는 클래스
class Animal {
  final String imagePath;     /// 동물 이미지 경로
  final String animalName;    /// 동물 이름
  final String kind;          /// 동물 종류 (예: 포유류, 곤충 등)
  final bool flyExist;        /// 날 수 있는지 여부 (기본값: false)

  /// 생성자: 필수 값은 required 키워드로 명시
  Animal({
    required this.animalName,
    required this.kind,
    required this.imagePath,
    this.flyExist = false, // 기본값 설정
  });
}
