import 'package:firstproject/components/my_button.dart';
import 'package:firstproject/components/my_text_field.dart';
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
      backgroundColor: Colors.grey[300], //background color
      body: SafeArea( //to avoid the notch
        child: Center( //to center the content
        child:Column( //to stack widgets on top of each other
          children: [
            const SizedBox(height: 100), //to add space between widgets

            //logo
            Image.asset('lib/images/sggw.png',height: 200,), //to add an image

            const SizedBox(height: 50),

        //welcome back, you've been missed!
            Text(
              'Siema nie chcesz moze se coś poinwentaryzować?',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize:16,
              ), 
            ),

            const SizedBox(height: 25),
        //username textfield
        MyTextField( //to use the textfield from the components folder
          controller: usernameController, //to get what the user typed in the textfield in username
          hintText: 'Username', //i hint to the user to that he should type his username
          obscureText: false,), //here we dont hide the contents of the textfield

        const SizedBox(height: 10),

        //password textfield
        MyTextField(
          controller: passwordController, 
          hintText: 'Password', // i hint to the user to that he should type his password
          obscureText: true,),//here we hide the contents of the textfield
          const SizedBox(height: 25),
        
        //forgot password textfile

        //sign in button
        MyButton(onTap: signUserIn,), 

        //or continue with

        //google button + apple 

        //not a member? sign up

      ])
    )
    )
    );
  }
}