import 'package:flutter/material.dart';

int add(int a, int b,) => a + b;

int add2({required int a , int b =0, int? c}) => a+b+c!;

/*
List<int> getEven(List<int>? x){
  List<int> re = [];
  for(var a in x!){
    if(a%2 == 0){
      re.add(a);
    }
  }
}
*/

List<int> toSquare(List<int>? x){
  return x!.map((a)=> a*a).toList();
}

class Product{
  final String? id;
  final String? name;
  final int? price;

  Product({required this.name, required this.id,this.price});

}

class Point{

}

void main() {

  //Khai báo kiểu dữ liệu cũng giống như các ngôn ngữ khác

  // //các từ khóa ở ngôn ngữ khác
  // var name = "FPT University";
  // // Đây là kiểu khai báo động(tại thời điểm chạy thì biến sẽ nhận kiểu dữ liệu đó)
  // //Sau khi gán thì nó không thể gán lại một kiểu dữ liệu khác
  // int i = 7;
  // var kq = i + 6.2;
  // print("Kết quả là ${kq}");
  // final kq; + 1; //giá trị hằng số sau khi gán
  // const gt = 5; // Đây là giá trị hằng số trước runtime
  // dynamic giaTriDong; // đây là kiểu giá trị giống như var nhưng có thể thay đổi nhiều lần

  //Kiểu dữ liệu String
  //Có thể gán 1 biểu thức và số ngay ở String bằng cách dùng ${}--> với biểu thức và $abc khi là số

  //else if và switch giống Java

  //Khai báo danh sách
 /* var x =[5,6,7,8];
  for(var i =0;i<x.length;i++){
    print(x[i]);
  }
  print("---------------------------");
  for(var a in x){
    print("${a},");
  }
  print("---------------------------");
  x.forEach((a) => print("$a"));

  int a = 10;
  int b = 18;
  String? z;
  print(z??"Z chưa được điền");

  print("${add2(a:4,b:6,c:8)}");
*/

  Product p = new Product(id: "ga01", name: "Gà quay");
  // p.name = "Tôm hùm"; // nếu không để private thì có thể truy xuất từ bên ngoài
  print(p.name);

}



  // This widget is the root of your application.


