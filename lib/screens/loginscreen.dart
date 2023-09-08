
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internship_assignment/screens/expense_page.dart';
import '../data/data.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _recvMail=TextEditingController();
  final getxStorageData=GetStorage();

  Future fetchData(String mail)async{
      var dio=Dio();
      try{
         var response=await dio.post("https://staging.thenotary.app/doLogin",data:{'email' : mail});
         if(response.statusCode==200){
          final recievedData=response.data;
          final myList=getxStorageData.write('data', recievedData);
          final myData=MyData();
          myData.setData(getxStorageData);
          if(context.mounted){
             Navigator.of(context).push(MaterialPageRoute(builder:(context) =>const ExpensePage(),));
          }
          return myList;
         }
      }on Exception catch(e){
        debugPrint('Some error has been occured');

        _showAlertDialog(context,e);
        return ;
      }

  }
  GetStorage get(){
    final getterGetx=getxStorageData;
    return getterGetx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

            const SizedBox(height: 100,),

            TextField(
              controller:_recvMail ,
              
              decoration:const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(borderSide: BorderSide())
                
              ),
            ),
            ElevatedButton(
              onPressed:()async{

                String mail=_recvMail.text.toString();
                await fetchData(mail);
              },
              child:const Text("Login"))
        ]
        ),
    );
  }
    void _showAlertDialog(BuildContext context,e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Some error Occured'),
          content:const Text(' check internet connection or Email'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child:const  Text('OK'),
            ),
          ],
        );
      },
    );
  }
}