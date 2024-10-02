part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSucess extends ChatState {
  List<Massege>masseges=[];
  ChatSucess({required this.masseges});
}
