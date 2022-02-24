import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takecare_user/controllers/DataContollers.dart';
import 'package:takecare_user/controllers/language_controller.dart';
import 'package:takecare_user/pages/otp_verification_page.dart';
import 'package:takecare_user/pages/sign_up_page.dart';
import 'package:takecare_user/public_variables/all_colors.dart';
import 'package:takecare_user/public_variables/notifications.dart';
import 'package:takecare_user/public_variables/size_config.dart';
import 'package:takecare_user/ui/variables.dart';
import 'package:takecare_user/widgets/AnimatedToggleButton.dart';
import 'package:takecare_user/widgets/loading_widget.dart';
import 'package:takecare_user/widgets/text_field_tile.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool english = true;
  bool signIn = true;


  final TextEditingController _mobileNumber = TextEditingController(text: '');
  final TextEditingController _signInPass = TextEditingController(text: '');




  /// Loading
  bool isLoading = false;

  onProgressBar(bool progress)
  {
    setState(() {
      isLoading = progress;
    });
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<DataControllers>(
        builder: (dataControllers) {
          return Stack(
            children: [
              Scaffold(
                body: _bodyUI(size,dataControllers),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dynamicSize(0.08)),
                  child: !signIn
                      ? ElevatedButton(
                    onPressed: () async{

                      if(DataControllers.to.name.value.text.isNotEmpty &&
                          DataControllers.to.password.value.text.isNotEmpty &&
                          DataControllers.to.gender.isNotEmpty )
                      {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) =>
                                    const OtpVerificationPage()
                            ));
                      }
                      else
                      {
                        Fluttertoast.showToast(
                            msg: "Fil up the filed!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Great! Next',
                              style: TextStyle(fontSize: dynamicSize(0.045))),
                        )
                      ],
                    ),
                  )
                      : Container(height: 50),
                ),
              ),

              isLoading?const LoadingWidget():Container()
            ],
          );
        }
    );



  }

  Widget _bodyUI(Size size, DataControllers dataControllers) => SafeArea(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              ///Bottom Image
              Container(
                width: size.width,
                height: size.height,
                alignment: Alignment.bottomLeft,
                child: signIn
                    ? Image.asset('assets/images/medicine.png')
                    : Container(),
              ),

              ///Nurse Image
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  width: size.width,
                  height: dynamicSize(.7),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/nurs.png'),
                          fit: BoxFit.fitHeight)),
                ),
              ),

              ///English Bangla toggle button
              signIn
                  ? GetBuilder<LanguageController>(
                  builder: (languageController) {
                    return Positioned(
                      right: dynamicSize(0.05),
                      top: dynamicSize(0.04),
                      child: AnimatedToggleButton(
                        values: const ['English', 'বাংলা'],
                        toggleValue: languageController.isEnglish.value,
                        width: dynamicSize(.4),
                        height: dynamicSize(0.07),
                        fontSize: dynamicSize(0.035),
                        onToggleCallback: (v) async {
                          setState(() => english = !english);
                        },
                      ),
                    );
                  }
              )
                  : Container(),

              ///Main Content
              Positioned(
                top: signIn ? dynamicSize(.6) : dynamicSize(.66),
                child: signIn ? _loginWidget(size) : _signUpWidget(size),
              ),

              ///Signin Signup Button
              GetBuilder<LanguageController>(
                  builder: (languageController) {
                    return Positioned(
                      top: dynamicSize(.6),
                      child: AnimatedToggleButton(
                        values: [(languageController.sigIn.value), (languageController.signUp.value)],
                        toggleValue: signIn,
                        width: dynamicSize(.85),
                        height: dynamicSize(0.12),
                        fontSize: dynamicSize(0.045),
                        onToggleCallback: (v) async {
                          setState(() => signIn = !signIn);
                        },
                      ),
                    );
                  }
              )
            ],
          ),
        ],
      ),
    ),
  );

  Widget _loginWidget(Size size) => Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      ///White Background
      Container(
        width: dynamicSize(.85),
        height: dynamicSize(0.65),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Colors.grey.shade400,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(dynamicSize(.06)),
              topRight: Radius.circular(dynamicSize(.06)),
              bottomLeft: Radius.circular(dynamicSize(.02)),
              bottomRight: Radius.circular(dynamicSize(.02)),
            )),
      ),

      ///Text Field
      SizedBox(
          width: dynamicSize(.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: dynamicSize(0.1)),
              TextFieldBuilder(
                  controller: _mobileNumber, hintText: 'Mobile Number*'),
              SizedBox(height: dynamicSize(0.02)),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: dynamicSize(0.04)),
                child: Divider(
                    height: 0.0, color: Colors.grey.shade400, thickness: 5),
              ),
              TextFieldBuilder(
                  controller: _signInPass,
                  hintText: 'Password*',
                  obscure: true),
              TextButton(
                onPressed: () {},
                child: Text('Forgot Password?',
                    style: TextStyle(
                        color: Colors.pink, fontSize: dynamicSize(0.035))),
              )
            ],
          )),

      Positioned(
        bottom: -dynamicSize(0.065),
        child: ElevatedButton(
          onPressed: ()  async{
            //isLoading = true;

            if(_mobileNumber.value.text.isNotEmpty  &&
                _signInPass.value.text.isNotEmpty
            )
            {

            }else
            {
              Fluttertoast.showToast(
                  msg: "Fil up the filed!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

              onProgressBar(false);
              // isLoading = false;
            }

            // onProgressBar(false);

            /*
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Dashboard()));*/
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: dynamicSize(0.04),vertical:  dynamicSize(0.04)),
            child: Text('Sign In',
                style: TextStyle(
                    fontSize: dynamicSize(0.045),
                    fontWeight: FontWeight.bold)),
          ),
        ),
      )
    ],
  );

  Widget _signUpWidget(Size size) => Container(
    width: dynamicSize(.9),
    //height: dynamicSize(0.65),
    padding: EdgeInsets.all(dynamicSize(.04)),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.shade400,
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: dynamicSize(.1)),

        ///Heading
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: AllColor.textColor, fontSize: dynamicSize(.05)),
            children: <TextSpan>[
              TextSpan(
                  text: 'Account\n',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: dynamicSize(.07))),
              const TextSpan(text: 'Information'),
            ],
          ),
        ),
        SizedBox(height: dynamicSize(.06)),

        ///Name and Image Field
        Row(
          children: [
            Expanded(
                child:
                BorderTextField(controller: DataControllers.to.name.value, hintText: 'Name*')),
            SizedBox(width: dynamicSize(.05)),
            InkWell(
              onTap: () => _getImage(),
              child: Container(
                alignment: Alignment.center,
                height: dynamicSize(0.15),
                width: dynamicSize(0.15),
                decoration: const BoxDecoration(
                    color: AllColor.blue, shape: BoxShape.circle),
                child: Variables.imageFile == null
                    ? Icon(CupertinoIcons.person_solid,
                    color: Colors.white, size: dynamicSize(.1))
                    : ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(dynamicSize(0.1))),
                    child: Image.file(Variables.imageFile,
                        height: dynamicSize(0.15),
                        width: dynamicSize(0.15),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
        SizedBox(height: dynamicSize(.08)),

        ///Gender
        Row(
          children: Variables.genderList
              .map((item) => Expanded(
              child: InkWell(
                onTap: () => setState(() => DataControllers.to.gender.value = item),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: item == 'Male' || item == 'Female'
                          ? size.width * .02
                          : 0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AllColor.blue),
                      color: item == DataControllers.to.gender.value
                          ? AllColor.blue
                          : Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(size.width * .01))),
                  padding: EdgeInsets.symmetric(
                      vertical: size.width * .025,
                      horizontal: size.width * .04),
                  child: Text(
                    item,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: size.width * .04,
                        color: item == DataControllers.to.gender.value
                            ? Colors.white
                            : AllColor.textColor),
                  ),
                ),
              )))
              .toList(),
        ),
        SizedBox(height: dynamicSize(.08)),

        BorderTextField(
            controller: DataControllers.to.password.value, hintText: 'Password*', obscure: true),
        SizedBox(height: dynamicSize(.02)),
      ],
    ),
  );

  void _getImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: ImageSource.gallery);
    // var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {

      setState(() =>
      Variables.imageFile = File(image.path));

      List<int> imageBytes = Variables.imageFile.readAsBytesSync();
      Variables.base64Image = base64Encode(imageBytes);
      //Variables.base64Image = Base64Encoder().convert(Variables.imageFile.readAsBytesSync());//base64Encode(Variables.imageFile.readAsBytesSync());
      // Variables.base64Image = base64Encode(Variables.imageFile.readAsBytesSync());
      print("image : "+Variables.base64Image);
      // String fileName = _image!.path.split("/").last;
      //print('Image File Name: $fileName');
      //showLoadingDialog(context);
      /*    await userProvider
          .profileImageUpdate(base64Image, fileName)
          .then((value) {
        if (value) {
          showToast('Success');
          Navigator.pop(context);
        } else {
          showToast('Failed!');
          Navigator.pop(context);
        }
      });*/




    } else {
      showToast('Image not selected');
    }
  }
  var userId ;
  var pass ;






}