import 'package:http/http.dart';
import 'dart:convert';

class Account {
  String url;
  int amount;
  List<dynamic> accountList;


  Account({this.url});
  Account.transaction({this.url , this.amount});

  Future<void> getAccount() async{
    Response response = await get('http://us-central1-momentumtest-bfdef.cloudfunctions.net/app/api/v1/account/$url');
    accountList = jsonDecode(response.body);
    print(accountList);
  }

  void addUserAccount() async{
    Response response = await  put('http://us-central1-momentumtest-bfdef.cloudfunctions.net/app/api/v1/account/$url' ,body: {
      'name': 'Acc No',
      'accountNumber': '3425635',
      'balance': '0.0',
      'overdraft' : '0.0',
    });
    print(response.body);

  }

  void depositToAccount() async {
      Response response = await  post('http://us-central1-momentumtest-bfdef.cloudfunctions.net/app/api/v1/account/$url' ,body: {
        'balance': '$amount'
      });
    }

  void withDrawFromAccount() async {
    Response response = await  post('http://us-central1-momentumtest-bfdef.cloudfunctions.net/app/api/v1/account/$url' ,body: {
      'balance': '$amount'
    });
  }
}