import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_jwt_token/core/injectable/injectable.dart';
import 'package:my_jwt_token/feature/auth_screen_feature/presentation/controller/code_email_controller/code_email_controller_cubit.dart';
import 'package:my_jwt_token/feature/main_screen_feature/presentation/main_screen.dart';

class EmailCodePage extends StatelessWidget {
  EmailCodePage({super.key});

  final codeEmailControllerCubit = getIt<CodeEmailControllerCubit>();

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
                Center(child: Icon(Icons.thumb_up_outlined, size: 50)),
                SizedBox(height: 50),
                Text('Введите код из Email-письма'),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 255,
                  onSubmitted: (text) {
                    codeEmailControllerCubit.confirmCode(
                      text,
                        (){
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                              (route) => false,
                          );
                        }
                    );
                    },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                BlocBuilder<CodeEmailControllerCubit, CodeEmailControllerState>(
                  bloc: codeEmailControllerCubit,
                  builder: (context, state) {
                    if (state is CodeEmailControllerError) {
                      return Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<CodeEmailControllerCubit, CodeEmailControllerState>(
          bloc: codeEmailControllerCubit,
          builder: (context, state) {
            if (state is CodeEmailControllerLoading) {
              return Visibility(
                visible: true,
                child: Container(
                  color: Colors.white.withAlpha(150),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
