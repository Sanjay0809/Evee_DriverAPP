import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool colorbutton = false;
  @override
  void initState() {
    checkmodule();
    super.initState();
  }

  checkmodule() {
    if (ownermodule == '0') {
      ischeckownerordriver == 'driver';
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Material(
      child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  // height: media.width * 1.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/landimage.png'),
                          fit: BoxFit.fitHeight)),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            ischeckownerordriver = 'driver';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(media.width * thirty),
                              color: buttonColor,
                              boxShadow: [
                                BoxShadow(color: buttonColor, spreadRadius: 1),
                              ],
                            ),
                            child: MyText(
                              text: languages[choosenLanguage]
                                  ['text_login_driver'],
                              size: media.width * fourteen,
                              fontweight: FontWeight.bold,
                              color: (isDarkTheme == true)
                                  ? Colors.black
                                  : textColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            ischeckownerordriver = 'owner';
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(media.width * thirty),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: buttonColor, spreadRadius: 1),
                              ],
                            ),
                            child: MyText(
                              text: languages[choosenLanguage]
                                  ['text_login_owner'],
                              size: media.width * fourteen,
                              color: Colors.black,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
