import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              //commonly used to show that some operation is in progress
              child: CircularProgressIndicator(),
            );
          }
//if there is no messages found, return
          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('no messages found'),
            );
          }
//if there is any error in the message, return
          if (!chatSnapshots.hasError) {
            return const Center(
              child: Text('Something  went wrong....'),
            );
          }

          final loadedMessages = chatSnapshots.data!.docs;
//allows you to create lists that can contain a large number of items, 
//and users can scroll through them to view the entire list.
          return ListView.builder(
            padding: const EdgeInsets.only(
              bottom: 40,
              left: 13,
              right: 13,
            ),
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (ctx, index) {
              Text(loadedMessages[index].data()['text']);
            },
          );
        });
  }
}
