import 'package:flutter/material.dart';
import 'package:acccount_project/service/account_service.dart';
import 'package:toast/toast.dart';

class AccountList extends StatefulWidget {


  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {

  List<dynamic> list;

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  void getData () async {
    Account accountInstance = Account(url: 'findByUserId?userId=UZyMgwSApiN0b148VDrZSAeWkfb2');
      await accountInstance.getAccount();
      setState(() {
        list = accountInstance.accountList;
      });
      print(list.length);
  }

  void addUserAccount() async {
    Account accountInstance = Account(url: 'create?userId=UZyMgwSApiN0b148VDrZSAeWkfb2');
    accountInstance.addUserAccount();
    showToast("Account  successfully Added", duration: Toast.LENGTH_LONG);

  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  viewSingleAccount(index){

    print(list[index]);
    Navigator.pushNamed(context, '/details' , arguments: {
      'id' : list[index]['id'],
      'name' :  list[index]['name'],
      'overdraft' : list[index]['overdraft'],
      'balance' : list[index]['balance'],
      'accountNumber' :list[index]['accountNumber']
    });
        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.person_add), onPressed: ()=>{
          addUserAccount()
        })],
        title: Text('AccountList'),
        centerTitle: true,

      ),
      body: Center(
        child: list != null ? ListView.builder(itemCount : list.length,itemBuilder: (context , index)  {
          return Card(
            child: ListTile(
              title: list[index]['balance'] ==null ? Text('Balance  : ${0}') : Text('Balance  : ${list[index]['balance']}'),
              leading: Text('Acc Name : ${list[index]['name']}' , style: TextStyle(fontSize: 15),),
              onTap: () => {
                viewSingleAccount(index),
              },
            ),
          );
        }) : Center(
        child: CircularProgressIndicator(),
    ),
      ),
    );
  }
}
