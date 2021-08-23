import 'package:flutter/material.dart';
import 'package:acccount_project/service/account_service.dart';
import 'package:toast/toast.dart';

class AccountDetails extends StatefulWidget {

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {

  TextEditingController _depositController  = TextEditingController();


  depositAmount(String id , int amount){
    Account accountInstance = Account.transaction(url: 'deposit/$id?amount=$amount',amount: amount);
    accountInstance.depositToAccount();
  }


  withDrawFromAccount(String id , int amount) {
    Account accountInstance = Account.transaction(url: 'withdraw/$id?amount=$amount',amount: amount);
    accountInstance.withDrawFromAccount();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }


  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print(data['name']);
    return Scaffold(
      appBar : AppBar(
        title: Text('Account Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(

            children: [


              TextField(controller: _depositController , keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Deposit amount',
                        labelText: 'Deposit',
                        border: OutlineInputBorder()
                    ),
                  ),
              FlatButton.icon(onPressed: ()=>{
                print(data['id'] ),
                print(int.parse(_depositController.text)),
                depositAmount(data['id'] , int.parse(_depositController.text)),
                showToast("Deposit successful", duration: Toast.LENGTH_LONG),
                _depositController.clear(),
              }, icon: Icon(Icons.send), label: Text('Deposit' , ) , color: Colors.red[100],),

              FlatButton.icon(onPressed: ()=>{
                print(data['id'] ),
                print(int.parse(_depositController.text)),
                withDrawFromAccount(data['id'] , int.parse(_depositController.text)),
                showToast("WithDrawl  successful", duration: Toast.LENGTH_LONG),
                _depositController.clear(),
              }, icon: Icon(Icons.send), label: Text('withdraw' , ) , color: Colors.red[100],),

              Card(
                child: ListTile(
                  title: Text('Acc Name : ${data['name']}') ,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('OverDraft : ${data['overdraft']}') ,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('balance  : ${data['balance']}') ,
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Acc Number ${data['accountNumber']}') ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
