import 'package:inventory_app/components/my_button.dart';
import 'package:inventory_app/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController(); //to get what the user typed in the textfield in username
  final passwordController = TextEditingController(); //to get what the user typed in the textfield in password

  //sign user in method
  void signUserIn(){} // this methon in the futher will be used to sign the user in

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset : false, //to avoid the keyboard to resize the page
      backgroundColor: Colors.grey[300], //background color
      body: SafeArea( //to avoid the notch
        child: Center( //to center the content
        child:Column( //to stack widgets on top of each other
          children: [
            const SizedBox(height: 50), //to add space between widgets

            //logo
            Image.asset('lib/images/sggw.png',height: 150,), //to add an image

            const SizedBox(height: 20),

        //welcome back, you've been missed!
            Text(
              'Dzień dobry, witamy w aplikacji',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize:16,
              ), 
            ),

            const SizedBox(height: 25),
        //username textfield
        MyTextField( //to use the textfield from the components folder
          controller: usernameController, //to get what the user typed in the textfield in username
          hintText: 'Nazwa Użytkownika', //i hint to the user to that he should type his username
          obscureText: false,), //here we dont hide the contents of the textfield

        const SizedBox(height: 10),

        //password textfield
        MyTextField(
          controller: passwordController, 
          hintText: 'Hasło', // i hint to the user to that he should type his password
          obscureText: true,),//here we hide the contents of the textfield
          const SizedBox(height: 25),
        

        //sign in button
        MyButton(onTap: signUserIn,), 

      ])
    )
    )
    );
  }
}