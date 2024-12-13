import 'package:aquaventures/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ViewProductScreen extends StatelessWidget {
  dynamic data;

  ViewProductScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data['img']), fit: BoxFit.cover),
                ),
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: 'Name:',
              fontSize: 18,
              fontFamily: 'Bold',
              color: Colors.black,
            ),
            TextWidget(
              text: data['name'],
              fontSize: 14,
              fontFamily: 'Medium',
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: 'Description:',
              fontSize: 18,
              fontFamily: 'Bold',
              color: Colors.black,
            ),
            TextWidget(
              text: data['desc'],
              fontSize: 14,
              fontFamily: 'Medium',
              color: Colors.grey,
              maxLines: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              text: 'Note:',
              fontSize: 18,
              fontFamily: 'Bold',
              color: Colors.black,
            ),
            TextWidget(
              text: data['note'],
              fontSize: 14,
              fontFamily: 'Medium',
              color: Colors.grey,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
