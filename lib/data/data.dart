import 'package:get_storage/get_storage.dart';

class MyData{
  late var _getxInData=GetStorage();

  void setData(getxInData){
    _getxInData=getxInData;

  }


  GetStorage getData(){
    print(_getxInData);
    return _getxInData;
  }
}