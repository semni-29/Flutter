//자동차 클래스 구현
/*
1. Car 클래스 속성

|    이름   |  자료형  |  의미   |
|----------|--------|--------|
| maxSpeed |  int   | 최고속도 |
|  price   |  num   |  가격   | 
|   name   | String |  이름   |

==================================
2. Car 객체의 속성값

| maxSpeed |  price  | name  |
|----------|---------|-------|
|   320    | 100,000 |  BMW  |
|   250    |  70,000 |  BENZ | 
|   200    |  80,000 |  FORD |

*/

/*
void main(){
  Car bmw    = Car(320, 100000, 'BMW');
  Car toyota = Car(250,  70000, 'BENZ');
  Car ford   = Car(200,  80000, 'FORD');

  bmw.saleCar();
  bmw.saleCar();
  bmw.saleCar();
  print(bmw.price);
}

class Car {
  int maxSpeed;
  num price;
  String name;

  Car(int maxSpeed, num price, String name){
    this.maxSpeed = maxSpeed;
    this.price = price;
    this.name = name;
  }

  num saleCar(){
    price = price * 0.9;
    return price;
  }
}
*/


/*
void main() {
  Car bmw    = Car(320, 100000, 'BMW');
  Car toyota = Car(250,  70000, 'BENZ');
  Car ford   = Car(200,  80000, 'FORD');

  bmw.saleCar();
  bmw.saleCar();
  bmw.saleCar();
  print(bmw.price); // 가격이 계속 10%씩 할인됨
}

class Car {
  int maxSpeed;
  num price;
  String name;

  Car(this.maxSpeed, this.price, this.name);

  int saleCar() {
    price = (price * 0.9).toInt(); // 10% 할인
    return price.toInt();
  }
}
*/
void main() {
  Car bmw = Car(320, 100000, 'BMW');
  //Car toyota = Car(250, 70000, 'BENZ');
  //Car ford = Car(200, 80000, 'FORD');
  bmw.saleCar();
  bmw.saleCar();
  bmw.saleCar();
  print(bmw.price);
}

class Car {
  int? maxSpeed;
  num? price;
  String? name;
  Car(int this.maxSpeed , num this.price , String this.name);
  num? saleCar(){
    price = price! * 0.9 ;
    return price;
  }
}
