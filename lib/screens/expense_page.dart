import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internship_assignment/data/data.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  var mygetxStorage=GetStorage();
  final myData=MyData();
  int numberOfItem=0;
  // ignore: prefer_typing_uninitialized_variables
  var finalExpense;

  List<dynamic>_searchUser=[];
  List<dynamic>_allUsers=[];
  
  @override
  void initState(){
    mygetxStorage=myData.getData();
    final printList=mygetxStorage.read('data');
    _allUsers=printList['expenseList'];
    _searchUser=_allUsers;
    super.initState();
  }
  void _runFilter(String keyword){
    List <dynamic>results=[];
    if(keyword.isEmpty){
      results=_allUsers;
    }else{
      results=_allUsers.where((user) =>user["expenseName"].toLowerCase().contains(keyword.toLowerCase())).toList();
    }
    setState(() {
      _searchUser=results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Expense'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
               TextField(
                onChanged: (value) => _runFilter(value),
                decoration:InputDecoration(
                  hintText: "Search",
                  border:  OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
               ),
              const SizedBox(height: 20,),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:_searchUser.length,
                  itemBuilder:(context,index){
                    return Card(
                      shape:const RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                      child: ListTile(
                        title: Text(_searchUser[index]['expenseName']),
                      ),
                    );
                      
                  }),
              ),
              
        
        
          ],),
        )
    );
    
  }
  
}