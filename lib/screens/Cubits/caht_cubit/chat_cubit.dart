import 'package:bloc/bloc.dart';
import 'package:chatapp/models/Massege.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Massege>massegelist=[];
  CollectionReference masseges =
      FirebaseFirestore.instance.collection('masseges');
  void sendMessege({required String Message, required var email}) {
    masseges.add({
      'massege': Message,
      'CreatedAt': DateTime.now(),
      'id': email,
    });
  }

  void getmessage() {
    masseges.orderBy('CreatedAt').snapshots().listen(
      (event) {
        massegelist.clear();
    for(var doc in event.docs){
      massegelist.add(Massege.fromjson(doc));
    }
        emit(ChatSucess(masseges: massegelist));
      },
    );
  }
}
