import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Center(child:
                  Icon(
                    Icons.email_outlined,
                    size: 50,
                  ),
                ),
                SizedBox(height: 50),
                Text('Введите почту'),
                TextField(
                  onSubmitted: (text){
                      print('$text');
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: false,
          child: Container(
            color: Colors.white.withAlpha(150),
            child: Center(
                child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}
