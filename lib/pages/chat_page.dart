import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';
import '../widget/chat_bubble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({Key? key}) : super(key: key);
   static String id = 'ChatPage';
TextEditingController controller = TextEditingController();
   ScrollController _scrollController = new ScrollController();



@override
  Widget build(BuildContext context) {
   var email =ModalRoute.of(context)!.settings.arguments;
    CollectionReference messages =FirebaseFirestore.instance.collection('messages');

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt',descending: true).snapshots(),
        builder: ( context, snapshot) {
          if(snapshot.hasData){
            List<Message> messagesList=[];
            for(int i=0 ;i <snapshot.data!.docs.length; i++){
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  title: Text('Chat'),
                  backgroundColor: Colors.purple[700],
                ),
                body:Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                          controller: _scrollController,
                        itemCount: messagesList.length,
                          itemBuilder: (context,index){
                            return messagesList[index].id == email ?
                            ChatBubble(message: messagesList[index],)
                            :ChatBubbleForFriend(message: messagesList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller:controller ,
                        onSubmitted: (data){
                          messages.add({
                            'message' :data,
                            'CreatedAt' : DateTime.now(),
                             'id' : email ,
                          });
                          controller.clear();
                          _scrollController.animateTo(
                           0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Send message',
                          suffixIcon: Icon(
                            Icons.send,color: Colors.purple,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.purple)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.purple)
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            );
          }else{
            return Text('is Loading...');
          }

    }

    );}

  }


