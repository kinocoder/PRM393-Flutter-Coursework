import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class LoginViewWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //1.Khai báo form key để truy xuất vào form
    //
    var _formKey = GlobalKey<FormState>();
    var _userName = TextEditingController();
    var _password = TextEditingController();
    return Form(
      key: _formKey,// gán Global key cho form
      child: Column(
        children: [
          TextFormField(
            validator: (value){
              var v = value??'';
              if(v.isEmpty){
                return 'User is require';
              }else{
                return null;
              }
            },
            controller: _userName,
            decoration: InputDecoration(label: Text("Enter username")),
          ),
          SizedBox(height: 12,),
          TextFormField(
            validator: (value){
              var v = value??'';
              if(v.isEmpty){
                return 'Password is require';
              }else{
                return null;
              }
            },
            controller: _password,
            decoration: InputDecoration(label: Text("Enter password")),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Cancel")),
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  //Login
                }
              }, child: Text("Login"))
            ],
          )
        ],
      ),
    );
  }
}
