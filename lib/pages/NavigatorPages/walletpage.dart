import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/mercadopago.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../login/landingpage.dart';
import '../login/login.dart';
import '../noInternet/nointernet.dart';
import 'flutterwavepayment.dart';
import 'paystackpayment.dart';
import 'razorpaypage.dart';
import 'cashfreepage.dart';
import 'selectwallet.dart';
import 'withdraw.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

dynamic addMoney;
TextEditingController phonenumber = TextEditingController();
TextEditingController amount = TextEditingController();

class _WalletPageState extends State<WalletPage> {
  TextEditingController addMoneyController = TextEditingController();

  bool _isLoading = true;
  bool _addPayment = false;
  bool _choosePayment = false;
  bool _completed = false;
  bool showtoast = false;
  int ischeckmoneytransfer = 0;

  @override
  void initState() {
    getWallet();
    super.initState();
  }

  getWallet() async {
    var val = await getWalletHistory();
    if (val == 'logout') {
      navigateLogout();
    }
    if (mounted) {
      if (val == 'success') {
        _isLoading = false;
        _completed = true;
        valueNotifierHome.incrementNotifier();
      }
    }
  }

  showToast() {
    setState(() {
      showtoast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showtoast = false;
      });
    });
  }

  navigateLogout() {
    if (ownermodule == '1') {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
            (route) => false);
      });
    } else {
      ischeckownerordriver = 'driver';
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      });
    }
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "user", child: Text("User")),
      DropdownMenuItem(value: "driver", child: Text("Driver")),
    ];
    return menuItems;
  }

  String dropdownValue = 'user';
  bool error = false;
  String errortext = '';
  bool ispop = false;

  //show toast for copy

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(media.width * 0.05,
                          media.width * 0.05, media.width * 0.05, 0),
                      height: media.height * 1,
                      width: media.width * 1,
                      color: page,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: media.width * 0.05),
                                width: media.width * 1,
                                alignment: Alignment.center,
                                child: MyText(
                                  text: languages[choosenLanguage]
                                      ['text_enable_wallet'],
                                  size: media.width * twenty,
                                  fontweight: FontWeight.w600,
                                ),
                              ),
                              Positioned(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios,
                                          color: textColor)))
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          (walletBalance.isNotEmpty)
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                                  ['text_availablebalance']
                                              .toString()
                                              .toUpperCase(),
                                          size: media.width * fourteen,
                                          fontweight: FontWeight.w800,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.03,
                                    ),
                                    Container(
                                      height: media.width * 0.1,
                                      width: media.width * 0.9,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: MyText(
                                        text: walletBalance['currency_symbol'] +
                                            ' ' +
                                            walletBalance['wallet_balance']
                                                .toString(),
                                        size: media.width * twenty,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    SizedBox(
                                        width: media.width * 0.9,
                                        child: MyText(
                                            text: languages[choosenLanguage]
                                                    ['text_latest_transitions']
                                                .toString()
                                                .toUpperCase(),
                                            size: media.width * fourteen,
                                            fontweight: FontWeight.w800)),
                                  ],
                                )
                              : Container(),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                (walletHistory.isNotEmpty)
                                    ? Column(
                                        children: walletHistory
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: media.width * 0.02,
                                                        bottom:
                                                            media.width * 0.02),
                                                    width: media.width * 0.9,
                                                    padding: EdgeInsets.all(
                                                        media.width * 0.025),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.grey
                                                            .withOpacity(0.1)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: media.width *
                                                              0.1067,
                                                          width: media.width *
                                                              0.1067,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: topBar),
                                                          alignment:
                                                              Alignment.center,
                                                          child: MyText(
                                                            text: (walletHistory[
                                                                            i][
                                                                        'is_credit'] ==
                                                                    1)
                                                                ? '+'
                                                                : '-',
                                                            size: media.width *
                                                                twentyfour,
                                                            color:
                                                                (isDarkTheme ==
                                                                        true)
                                                                    ? Colors
                                                                        .black
                                                                    : textColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.025,
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              MyText(
                                                                text: walletHistory[
                                                                            i][
                                                                        'remarks']
                                                                    .toString(),
                                                                size: media
                                                                        .width *
                                                                    fourteen,
                                                                maxLines: 1,
                                                                fontweight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              SizedBox(
                                                                height: media
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              MyText(
                                                                text: walletHistory[
                                                                        i][
                                                                    'created_at'],
                                                                size: media
                                                                        .width *
                                                                    ten,
                                                                color: textColor
                                                                    .withOpacity(
                                                                        0.4),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                MyText(
                                                                  // ignore: prefer_interpolation_to_compose_strings
                                                                  text: walletBalance[
                                                                          'currency_symbol'] +
                                                                      ' ' +
                                                                      walletHistory[i]
                                                                              [
                                                                              'amount']
                                                                          .toString(),
                                                                  size: media
                                                                          .width *
                                                                      twelve,
                                                                  color: (walletHistory[i]
                                                                              [
                                                                              'is_credit'] ==
                                                                          1)
                                                                      ? online
                                                                      : verifyDeclined,
                                                                  maxLines: 1,
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : (_completed == true)
                                        ? Container(
                                            height: media.width * 0.1,
                                            width: media.width * 0.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                            ),
                                            child: MyText(
                                              text:
                                                  '${userDetails['currency_symbol']} 0',
                                              size: media.width * twenty,
                                              fontweight: FontWeight.w600,
                                            ),
                                          )
                                        : Container(),

                                //load more button
                                (walletPages.isNotEmpty)
                                    ? (walletPages['current_page'] <
                                            walletPages['total_pages'])
                                        ? InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              var val = await getWalletHistoryPage(
                                                  (walletPages['current_page'] +
                                                          1)
                                                      .toString());
                                              if (val == 'logout') {
                                                navigateLogout();
                                              }

                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  media.width * 0.025),
                                              margin: EdgeInsets.only(
                                                  bottom: media.width * 0.05),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: page,
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2)),
                                              child: MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_loadmore'],
                                                size: media.width * sixteen,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container()
                              ],
                            ),
                          )),
                          SizedBox(
                            height: media.width * 0.2,
                            width: media.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: media.width * 0.01,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                          ['text_recharge_bal']
                                      .toString()
                                      .toUpperCase(),
                                  size: media.width * fourteen,
                                  fontweight: FontWeight.w800,
                                ),
                                SizedBox(
                                  height: media.width * 0.03,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                      ['text_rechage_text'],
                                  size: media.width * twelve,
                                  fontweight: FontWeight.w600,
                                  color: textColor.withOpacity(0.5),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: media.width * 0.15,
                                width: media.width * 0.9,
                                alignment: Alignment.center,
                                color: Colors.grey.withOpacity(0.3),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.02,
                                    right: media.width * 0.02),
                                // color: textColor,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Withdraw()));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.money,
                                                  size: media.width * 0.1,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              3)
                                                          ? buttonColor
                                                          : textColor),
                                              MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_withdraw'],
                                                  size: media.width * sixteen,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              3)
                                                          ? buttonColor
                                                          : textColor)
                                            ],
                                          ),
                                        ),
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        SizedBox(
                                          width: media.width * 0.02,
                                        ),
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        Container(
                                          height: media.width * 0.1,
                                          width: 1,
                                          color: textColor.withOpacity(0.3),
                                        ),
                                      SizedBox(
                                        width: media.width * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _addPayment = true;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.credit_card,
                                              size: media.width * 0.1,
                                              color: (ischeckmoneytransfer == 1)
                                                  ? buttonColor
                                                  : textColor,
                                            ),
                                            MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_addmoney'],
                                                size: media.width * sixteen,
                                                color:
                                                    (ischeckmoneytransfer == 1)
                                                        ? buttonColor
                                                        : textColor)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: media.width * 0.02,
                                      ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        Container(
                                          height: media.width * 0.1,
                                          width: 1,
                                          color: textColor.withOpacity(0.3),
                                        ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        SizedBox(
                                          width: media.width * 0.02,
                                        ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              ispop = true;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.swap_horiz_outlined,
                                                  size: media.width * 0.1,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              2)
                                                          ? buttonColor
                                                          : textColor),
                                              MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_credit_trans'],
                                                  size: media.width * sixteen,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              2)
                                                          ? buttonColor
                                                          : textColor)
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //add payment
                    (_addPayment == true)
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: media.width * 0.05),
                                    width: media.width * 0.9,
                                    padding:
                                        EdgeInsets.all(media.width * 0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                        color: page),
                                    child: Column(children: [
                                      Container(
                                        height: media.width * 0.128,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderLines, width: 1.2),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: media.width * 0.1,
                                                height: media.width * 0.128,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                    ),
                                                    color: Color(0xffF0F0F0)),
                                                alignment: Alignment.center,
                                                child: MyText(
                                                  text: walletBalance[
                                                      'currency_symbol'],
                                                  size: media.width * twelve,
                                                  fontweight: FontWeight.w600,
                                                  color: (isDarkTheme == true)
                                                      ? Colors.black
                                                      : textColor,
                                                )),
                                            SizedBox(
                                              width: media.width * 0.05,
                                            ),
                                            Container(
                                                height: media.width * 0.128,
                                                width: media.width * 0.6,
                                                alignment: Alignment.center,
                                                child: MyTextField(
                                                  textController:
                                                      addMoneyController,
                                                  hinttext:
                                                      languages[choosenLanguage]
                                                          ['text_enteramount'],
                                                  onTap: (val) {
                                                    setState(() {
                                                      addMoney = int.parse(val);
                                                    });
                                                  },
                                                  maxline: 1,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '100';
                                                addMoney = 100;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '100',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '500';
                                                addMoney = 500;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '500',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text =
                                                    '1000';
                                                addMoney = 1000;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '1000',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: media.width * 0.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            onTap: () async {
                                              setState(() {
                                                _addPayment = false;
                                                addMoney = null;
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                addMoneyController.clear();
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_cancel'],
                                            width: media.width * 0.4,
                                          ),
                                          Button(
                                            onTap: () async {
                                              // print(addMoney);
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              if (addMoney != 0 &&
                                                  addMoney != null) {
                                                setState(() {
                                                  _choosePayment = true;
                                                  _addPayment = false;
                                                });
                                              }
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_addmoney'],
                                            width: media.width * 0.4,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                        : Container(),

                    //choose payment method
                    (_choosePayment == true)
                        ? Positioned(
                            child: Container(
                            height: media.height * 1,
                            width: media.width * 1,
                            color: Colors.transparent.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: media.width * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _choosePayment = false;
                                            _addPayment = true;
                                          });
                                        },
                                        child: Container(
                                          height: media.height * 0.05,
                                          width: media.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: page,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.cancel,
                                              color: buttonColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: media.width * 0.025),
                                Container(
                                  padding: EdgeInsets.all(media.width * 0.05),
                                  width: media.width * 0.8,
                                  height: media.height * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: topBar),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          width: media.width * 0.7,
                                          child: MyText(
                                            text: languages[choosenLanguage]
                                                ['text_choose_payment'],
                                            size: media.width * eighteen,
                                            fontweight: FontWeight.w600,
                                            color: (isDarkTheme == true)
                                                ? Colors.black
                                                : textColor,
                                          )),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              (walletBalance['stripe'] == true)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      alignment:
                                                          Alignment.center,
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const SelectWallet()));
                                                          if (val) {
                                                            setState(() {
                                                              _choosePayment =
                                                                  false;
                                                              _addPayment =
                                                                  false;
                                                              addMoney = null;
                                                              addMoneyController
                                                                  .clear();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.25,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/stripe-icon.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                              (walletBalance['paystack'] ==
                                                      true)
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const PayStackPage()));
                                                          if (val) {
                                                            setState(() {
                                                              _isLoading = true;
                                                              _choosePayment =
                                                                  false;
                                                              _addPayment =
                                                                  false;
                                                              addMoney = null;
                                                              addMoneyController
                                                                  .clear();
                                                            });
                                                            await getWallet();
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.25,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/paystack-icon.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                              (walletBalance['flutter_wave'] ==
                                                      true)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      alignment:
                                                          Alignment.center,
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const FlutterWavePage()));
                                                          if (val) {
                                                            setState(() {
                                                              _choosePayment =
                                                                  false;
                                                              _addPayment =
                                                                  false;
                                                              addMoney = null;
                                                              addMoneyController
                                                                  .clear();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.25,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/flutterwave-icon.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                              (walletBalance['razor_pay'] ==
                                                      true)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      alignment:
                                                          Alignment.center,
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const RazorPayPage()));
                                                          if (val) {
                                                            setState(() {
                                                              _choosePayment =
                                                                  false;
                                                              _addPayment =
                                                                  false;
                                                              addMoney = null;
                                                              addMoneyController
                                                                  .clear();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.25,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/razorpay-icon.jpeg'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                              (walletBalance['mercadopago'] ==
                                                      true)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      alignment:
                                                          Alignment.center,
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MercadoPago()));
                                                          if (val != null) {
                                                            if (val) {
                                                              setState(() {
                                                                _isLoading =
                                                                    true;
                                                                _choosePayment =
                                                                    false;
                                                                _addPayment =
                                                                    false;
                                                                addMoney = null;
                                                                addMoneyController
                                                                    .clear();
                                                              });
                                                              await getWallet();
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.35,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/mercadopago.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                              (walletBalance['cash_free'] ==
                                                      true)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.025),
                                                      alignment:
                                                          Alignment.center,
                                                      width: media.width * 0.7,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          var val = await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const CashFreePage()));
                                                          if (val) {
                                                            setState(() {
                                                              _choosePayment =
                                                                  false;
                                                              _addPayment =
                                                                  false;
                                                              addMoney = null;
                                                              addMoneyController
                                                                  .clear();
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: media.width *
                                                              0.25,
                                                          height: media.width *
                                                              0.125,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/cashfree-icon.jpeg'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      ))
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                        : Container(),
                    //no internet

                    (ispop == true)
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: media.width * 0.02),
                                      width: media.width * 1,
                                      padding:
                                          EdgeInsets.all(media.width * 0.025),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderLines, width: 1.2),
                                          color: page),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DropdownButtonFormField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: page,
                                            ),
                                            dropdownColor: page,
                                            value: dropdownValue,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownValue = newValue!;
                                              });
                                            },
                                            items: dropdownItems,
                                            style: GoogleFonts.notoSans(
                                              fontSize: media.width * sixteen,
                                              color: textColor,
                                            ),
                                          ),
                                          TextFormField(
                                            controller: amount,
                                            style: GoogleFonts.notoSans(
                                              fontSize: media.width * sixteen,
                                              color: textColor,
                                              letterSpacing: 1,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText:
                                                  languages[choosenLanguage]
                                                      ['text_enteramount'],
                                              counterText: '',
                                              hintStyle: GoogleFonts.notoSans(
                                                fontSize: media.width * sixteen,
                                                color:
                                                    textColor.withOpacity(0.7),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor.withOpacity(0.2)
                                                    : inputfocusedUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor.withOpacity(0.1)
                                                    : inputUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: phonenumber,
                                            onChanged: (val) {
                                              if (phonenumber.text.length ==
                                                  countries[phcode]
                                                      ['dial_max_length']) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              }
                                            },
                                            // maxLength: countries[phcode]
                                            //     ['dial_max_length'],
                                            style: GoogleFonts.notoSans(
                                              fontSize: media.width * sixteen,
                                              color: textColor,
                                              letterSpacing: 1,
                                            ),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText:
                                                  languages[choosenLanguage]
                                                      ['text_phone_number'],
                                              counterText: '',
                                              hintStyle: GoogleFonts.notoSans(
                                                fontSize: media.width * sixteen,
                                                color:
                                                    textColor.withOpacity(0.7),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor.withOpacity(0.2)
                                                    : inputfocusedUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor.withOpacity(0.1)
                                                    : inputUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.05,
                                          ),
                                          error == true
                                              ? MyText(
                                                  text: errortext,
                                                  color: Colors.red,
                                                  size: media.width * fourteen,
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: media.width * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Button(
                                                  width: media.width * 0.4,
                                                  onTap: () {
                                                    setState(() {
                                                      ispop = false;
                                                      dropdownValue = 'user';
                                                      error = false;
                                                      errortext = '';
                                                      phonenumber.text = '';
                                                      amount.text = '';
                                                    });
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_close']),
                                              SizedBox(
                                                width: media.width * 0.05,
                                              ),
                                              Button(
                                                  width: media.width * 0.4,
                                                  onTap: () async {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    if (phonenumber.text ==
                                                            '' ||
                                                        amount.text == '') {
                                                      setState(() {
                                                        error = true;
                                                        errortext = languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_fill_fileds'];
                                                        _isLoading = false;
                                                      });
                                                    } else {
                                                      var result =
                                                          await sharewalletfun(
                                                              amount:
                                                                  amount.text,
                                                              mobile:
                                                                  phonenumber
                                                                      .text,
                                                              role:
                                                                  dropdownValue);
                                                      if (result == 'success') {
                                                        // navigate();
                                                        setState(() {
                                                          ispop = false;
                                                          dropdownValue =
                                                              'user';
                                                          error = false;
                                                          errortext = '';
                                                          phonenumber.text = '';
                                                          amount.text = '';
                                                          getWallet();
                                                          showToast();
                                                        });
                                                      } else if (result ==
                                                          'logout') {
                                                        navigateLogout();
                                                      } else {
                                                        setState(() {
                                                          error = true;
                                                          errortext =
                                                              result.toString();
                                                          _isLoading = false;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_share']),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    //loader
                    (_isLoading)
                        ? const Positioned(top: 0, child: Loading())
                        : Container(),
                    (showtoast == true)
                        ? PaymentSuccess(
                            onTap: () async {
                              setState(() {
                                showtoast = false;
                                // Navigator.pop(context, true);
                              });
                            },
                            transfer: true,
                          )
                        : Container(),
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                  // _complete = false;
                                  _isLoading = true;
                                  getWallet();
                                });
                              },
                            ))
                        : Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
