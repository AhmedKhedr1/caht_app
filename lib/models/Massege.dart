import 'package:chatapp/Widgets/constant.dart';

class Massege{

 final String massege;
 final String id;
  Massege(this.massege, this.id);

factory Massege.fromjson(jsondata){
  return Massege(jsondata[KMassege],jsondata['id']);
}

}