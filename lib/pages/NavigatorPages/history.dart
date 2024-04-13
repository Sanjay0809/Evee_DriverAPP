import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/loadingPage/loading.dart';
import 'package:flutter_driver/pages/login/login.dart';
import 'package:flutter_driver/pages/onTripPage/map_page.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../login/landingpage.dart';
import '../noInternet/nointernet.dart';
import 'historydetails.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

dynamic selectedHistory;

class _HistoryState extends State<History> {
  int _showHistory = 1;
  bool _isLoading = true;
  dynamic isCompleted;

  @override
  void initState() {
    _isLoading = true;
    _getHistory();

    super.initState();
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

//get history
  _getHistory() async {
    if (mounted) {
      setState(() {
        myHistoryPage.clear();
        myHistory.clear();
      });
    }
    var val = await getHistory('is_completed=1');
    if (val == 'logout') {
      navigateLogout();
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
        child: Directionality(
      textDirection:
          (languageDirection == 'rtl') ? TextDirection.rtl : TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            height: media.height * 1,
            width: media.width * 1,
            color: page,
            padding: EdgeInsets.fromLTRB(
                media.width * 0.05, media.width * 0.05, media.width * 0.05, 0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: media.width * 0.05),
                      width: media.width * 1,
                      alignment: Alignment.center,
                      child: MyText(
                        text: languages[choosenLanguage]['text_enable_history'],
                        size: media.width * twenty,
                        fontweight: FontWeight.w600,
                      ),
                    ),
                    Positioned(
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                Icon(Icons.arrow_back_ios, color: textColor)))
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  padding: EdgeInsets.all(media.width * 0.01),
                  height: media.width * 0.12,
                  width: media.width * 0.85,
                  decoration: BoxDecoration(
                      color: page,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 2,
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            myHistory.clear();
                            myHistoryPage.clear();
                            _showHistory = 0;
                            _isLoading = true;
                          });

                          await getHistory('is_later=1');
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Container(
                            height: media.width * 0.1,
                            alignment: Alignment.center,
                            width: media.width * 0.28,
                            decoration: BoxDecoration(
                                borderRadius: (_showHistory == 0)
                                    ? BorderRadius.circular(12)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                      color: (_showHistory == 0)
                                          ? Colors.black.withOpacity(0.2)
                                          : page,
                                      spreadRadius: 2,
                                      blurRadius: 2)
                                ],
                                color: (_showHistory == 0) ? textColor : page),
                            child: MyText(
                                text: languages[choosenLanguage]
                                    ['text_upcoming'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w600,
                                color: (_showHistory == 0) ? page : textColor)),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            myHistory.clear();
                            myHistoryPage.clear();
                            _showHistory = 1;
                            _isLoading = true;
                          });

                          await getHistory('is_completed=1');
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Container(
                            height: media.width * 0.1,
                            alignment: Alignment.center,
                            width: media.width * 0.26,
                            decoration: BoxDecoration(
                                borderRadius: (_showHistory == 1)
                                    ? BorderRadius.circular(12)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                      color: (_showHistory == 1)
                                          ? Colors.black.withOpacity(0.2)
                                          : page,
                                      spreadRadius: 2,
                                      blurRadius: 2)
                                ],
                                color: (_showHistory == 1) ? textColor : page),
                            child: MyText(
                                text: languages[choosenLanguage]
                                    ['text_completed'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w600,
                                color: (_showHistory == 1) ? page : textColor)),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            myHistory.clear();
                            myHistoryPage.clear();
                            _showHistory = 2;
                            _isLoading = true;
                          });

                          await getHistory('is_cancelled=1');
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: Container(
                            height: media.width * 0.1,
                            alignment: Alignment.center,
                            width: media.width * 0.27,
                            decoration: BoxDecoration(
                                borderRadius: (_showHistory == 2)
                                    ? BorderRadius.circular(12)
                                    : null,
                                boxShadow: [
                                  BoxShadow(
                                      color: (_showHistory == 2)
                                          ? Colors.black.withOpacity(0.2)
                                          : page,
                                      spreadRadius: 2,
                                      blurRadius: 2)
                                ],
                                color: (_showHistory == 2) ? textColor : page),
                            child: MyText(
                                text: languages[choosenLanguage]
                                    ['text_cancelled'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w600,
                                color: (_showHistory == 2) ? page : textColor)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.1,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      (myHistory.isNotEmpty)
                          ? Column(
                              children: myHistory
                                  .asMap()
                                  .map((i, value) {
                                    return MapEntry(
                                        i,
                                        (_showHistory == 1)
                                            ?
                                            //completed rides
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      selectedHistory = i;

                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const HistoryDetails()));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: media.width *
                                                              0.025,
                                                          bottom: media.width *
                                                              0.05,
                                                          left: media.width *
                                                              0.015,
                                                          right: media.width *
                                                              0.015),
                                                      width: media.width * 0.85,
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              media.width *
                                                                  0.025,
                                                              media.width *
                                                                  0.05,
                                                              media.width *
                                                                  0.025,
                                                              media.width *
                                                                  0.05),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .all(media
                                                                            .width *
                                                                        0.02),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color:
                                                                            topBar,
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              textColor.withOpacity(0.1),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(media.width *
                                                                                0.01)),
                                                                child: MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'request_number'],
                                                                  size: media
                                                                          .width *
                                                                      fourteen,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: (isDarkTheme ==
                                                                          true)
                                                                      ? Colors
                                                                          .black
                                                                      : textColor,
                                                                ),
                                                              ),
                                                              MyText(
                                                                text: myHistory[
                                                                        i][
                                                                    'accepted_at'],
                                                                size: media
                                                                        .width *
                                                                    twelve,
                                                                fontweight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: textColor
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.025,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: media
                                                                        .width *
                                                                    0.13,
                                                                width: media
                                                                        .width *
                                                                    0.13,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(userDetails['role'] ==
                                                                                'owner'
                                                                            ? myHistory[i]['driverDetail']['data'][
                                                                                'profile_picture']
                                                                            : myHistory[i]['userDetail']['data'][
                                                                                'profile_picture']),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: media
                                                                            .width *
                                                                        0.3,
                                                                    child:
                                                                        MyText(
                                                                      text: userDetails['role'] ==
                                                                              'owner'
                                                                          ? myHistory[i]['driverDetail']['data']
                                                                              [
                                                                              'name']
                                                                          : myHistory[i]['userDetail']['data']
                                                                              [
                                                                              'name'],
                                                                      size: media
                                                                              .width *
                                                                          eighteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Image.asset(
                                                                      (myHistory[i]['transport_type'] ==
                                                                              'taxi')
                                                                          ? 'assets/images/taxiride.png'
                                                                          : 'assets/images/deliveryride.png',
                                                                      height: media
                                                                              .width *
                                                                          0.05,
                                                                      width: media
                                                                              .width *
                                                                          0.1,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.05,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: media
                                                                        .width *
                                                                    0.05,
                                                                width: media
                                                                        .width *
                                                                    0.05,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .green),
                                                                child:
                                                                    Container(
                                                                  height: media
                                                                          .width *
                                                                      0.025,
                                                                  width: media
                                                                          .width *
                                                                      0.025,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.06,
                                                              ),
                                                              Expanded(
                                                                child: MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'pick_address'],
                                                                  // maxLines: 1,
                                                                  size: media
                                                                          .width *
                                                                      twelve,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: media
                                                                        .width *
                                                                    0.06,
                                                                width: media
                                                                        .width *
                                                                    0.06,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .red
                                                                        .withOpacity(
                                                                            0.1)),
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: const Color(
                                                                      0xFFFF0000),
                                                                  size: media
                                                                          .width *
                                                                      eighteen,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                              Expanded(
                                                                child: MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'drop_address'],
                                                                  // maxLines: 1,
                                                                  size: media
                                                                          .width *
                                                                      twelve,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 75,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .credit_card,
                                                                        color:
                                                                            textColor),
                                                                    SizedBox(
                                                                      width: media
                                                                              .width *
                                                                          0.01,
                                                                    ),
                                                                    MyText(
                                                                      text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_paymentmethod'],
                                                                      size: media
                                                                              .width *
                                                                          fourteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 25,
                                                                  child: Row(
                                                                    children: [
                                                                      MyText(
                                                                        text: (myHistory[i]['payment_opt'] ==
                                                                                '1')
                                                                            ? languages[choosenLanguage]['text_cash']
                                                                            : (myHistory[i]['payment_opt'] == '2')
                                                                                ? languages[choosenLanguage]['text_wallet']
                                                                                : (myHistory[i]['payment_opt'] == '0')
                                                                                    ? languages[choosenLanguage]['text_card']
                                                                                    : '',
                                                                        size: media.width *
                                                                            fourteen,
                                                                        color: textColor
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 75,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .timer_sharp,
                                                                        color:
                                                                            textColor),
                                                                    SizedBox(
                                                                      width: media
                                                                              .width *
                                                                          0.01,
                                                                    ),
                                                                    MyText(
                                                                      text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_duration'],
                                                                      size: media
                                                                              .width *
                                                                          fourteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 25,
                                                                  child: Row(
                                                                    children: [
                                                                      MyText(
                                                                        text: (myHistory[i]['total_time'] <
                                                                                50)
                                                                            ? '${myHistory[i]['total_time']} mins'
                                                                            : '${(myHistory[i]['total_time'] / 60).round()} hr',
                                                                        size: media.width *
                                                                            fourteen,
                                                                        color: textColor
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 75,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .route_sharp,
                                                                        color:
                                                                            textColor),
                                                                    SizedBox(
                                                                      width: media
                                                                              .width *
                                                                          0.01,
                                                                    ),
                                                                    MyText(
                                                                      text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_distance'],
                                                                      size: media
                                                                              .width *
                                                                          fourteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 25,
                                                                  child: Row(
                                                                    children: [
                                                                      MyText(
                                                                        text: (myHistory[i]['total_time'] <
                                                                                50)
                                                                            ? myHistory[i]['total_distance'] +
                                                                                myHistory[i]['unit']
                                                                            : myHistory[i]['total_distance'] + myHistory[i]['unit'],
                                                                        size: media.width *
                                                                            fourteen,
                                                                        color: textColor
                                                                            .withOpacity(0.5),
                                                                      ),
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                flex: 75,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .receipt,
                                                                        color:
                                                                            textColor),
                                                                    SizedBox(
                                                                      width: media
                                                                              .width *
                                                                          0.01,
                                                                    ),
                                                                    MyText(
                                                                      text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_total'],
                                                                      size: media
                                                                              .width *
                                                                          fourteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 25,
                                                                  child: MyText(
                                                                    maxLines: 1,
                                                                    text:
                                                                        // ignore: prefer_interpolation_to_compose_strings
                                                                        myHistory[i]['requestBill']['data']['requested_currency_symbol'] +
                                                                            ' ' +
                                                                            myHistory[i]['requestBill']['data']['total_amount'].toString(),
                                                                    size: media
                                                                            .width *
                                                                        fourteen,
                                                                    fontweight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ))
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : (_showHistory == 2)
                                                ?
                                                //cancelled rides
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: media.width *
                                                                0.025,
                                                            bottom:
                                                                media.width *
                                                                    0.05,
                                                            left: media.width *
                                                                0.015,
                                                            right: media.width *
                                                                0.015),
                                                        width:
                                                            media.width * 0.85,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                media.width *
                                                                    0.025,
                                                                media.width *
                                                                    0.05,
                                                                media.width *
                                                                    0.025,
                                                                media.width *
                                                                    0.05),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .all(media
                                                                              .width *
                                                                          0.02),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              topBar,
                                                                          border: Border
                                                                              .all(
                                                                            color:
                                                                                textColor.withOpacity(0.1),
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(media.width * 0.01)),
                                                                  child: MyText(
                                                                    text: myHistory[
                                                                            i][
                                                                        'request_number'],
                                                                    size: media
                                                                            .width *
                                                                        fourteen,
                                                                    fontweight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: (isDarkTheme ==
                                                                            true)
                                                                        ? Colors
                                                                            .black
                                                                        : textColor,
                                                                  ),
                                                                ),
                                                                MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'accepted_at'],
                                                                  size: media
                                                                          .width *
                                                                      twelve,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: textColor
                                                                      .withOpacity(
                                                                          0.3),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.025,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: media
                                                                          .width *
                                                                      0.13,
                                                                  width: media
                                                                          .width *
                                                                      0.13,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(userDetails['role'] == 'owner'
                                                                              ? myHistory[i]['driverDetail']['data']['profile_picture']
                                                                              : myHistory[i]['userDetail']['data']['profile_picture']),
                                                                          fit: BoxFit.cover)),
                                                                ),
                                                                SizedBox(
                                                                  width: media
                                                                          .width *
                                                                      0.02,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: media
                                                                              .width *
                                                                          0.5,
                                                                      child:
                                                                          MyText(
                                                                        text: userDetails['role'] ==
                                                                                'owner'
                                                                            ? myHistory[i]['driverDetail']['data']['name']
                                                                            : myHistory[i]['userDetail']['data']['name'],
                                                                        size: media.width *
                                                                            eighteen,
                                                                        fontweight:
                                                                            FontWeight.w600,
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        (myHistory[i]['transport_type'] ==
                                                                                'taxi')
                                                                            ? 'assets/images/taxiride.png'
                                                                            : 'assets/images/deliveryride.png',
                                                                        height: media.width *
                                                                            0.05,
                                                                        width: media.width *
                                                                            0.1,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.05,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: media
                                                                          .width *
                                                                      0.05,
                                                                  width: media
                                                                          .width *
                                                                      0.05,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .green),
                                                                  child:
                                                                      Container(
                                                                    height: media
                                                                            .width *
                                                                        0.025,
                                                                    width: media
                                                                            .width *
                                                                        0.025,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.8)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: media
                                                                          .width *
                                                                      0.06,
                                                                ),
                                                                SizedBox(
                                                                  width: media
                                                                          .width *
                                                                      0.5,
                                                                  child: MyText(
                                                                    text: myHistory[
                                                                            i][
                                                                        'pick_address'],
                                                                    // maxLines: 1,
                                                                    size: media
                                                                            .width *
                                                                        twelve,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .all(media
                                                                              .width *
                                                                          0.01),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(media.width *
                                                                              0.01)),
                                                                  child: MyText(
                                                                    text: languages[
                                                                            choosenLanguage]
                                                                        [
                                                                        'text_cancelled'],
                                                                    size: media
                                                                            .width *
                                                                        twelve,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            (myHistory[i][
                                                                        'drop_address'] !=
                                                                    null)
                                                                ? Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: media.width *
                                                                            0.01,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                media.width * 0.06,
                                                                            width:
                                                                                media.width * 0.06,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(shape: BoxShape.circle, color: Colors.red.withOpacity(0.1)),
                                                                            child:
                                                                                Icon(
                                                                              Icons.location_on_outlined,
                                                                              color: const Color(0xFFFF0000),
                                                                              size: media.width * eighteen,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                media.width * 0.05,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                MyText(
                                                                              text: myHistory[i]['drop_address'],
                                                                              size: media.width * twelve,
                                                                              // maxLines: 1,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : (_showHistory == 0)
                                                    ?
                                                    //upcoming rides
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: media.width *
                                                                0.025,
                                                            bottom:
                                                                media.width *
                                                                    0.05,
                                                            left: media.width *
                                                                0.015,
                                                            right: media.width *
                                                                0.015),
                                                        width:
                                                            media.width * 0.85,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                media.width *
                                                                    0.025,
                                                                media.width *
                                                                    0.05,
                                                                media.width *
                                                                    0.025,
                                                                media.width *
                                                                    0.05),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: page,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2,
                                                                  spreadRadius:
                                                                      2,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.2))
                                                            ]),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'request_number'],
                                                                  size: media
                                                                          .width *
                                                                      sixteen,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: (isDarkTheme ==
                                                                          true)
                                                                      ? Colors
                                                                          .black
                                                                      : textColor,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.02,
                                                            ),
                                                            Row(
                                                              children: [
                                                                MyText(
                                                                  text: myHistory[
                                                                          i][
                                                                      'trip_start_time'],
                                                                  size: media
                                                                          .width *
                                                                      fourteen,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                (myHistory[i][
                                                                            'is_round_trip'] ==
                                                                        1)
                                                                    ? MyText(
                                                                        text:
                                                                            ' TO ${myHistory[i]['return_time']}',
                                                                        size: media.width *
                                                                            fourteen,
                                                                        fontweight:
                                                                            FontWeight.w600,
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.02,
                                                            ),
                                                            (myHistory[i][
                                                                        'userDetail'] !=
                                                                    null)
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        bottom: media.width *
                                                                            0.05),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              media.width * 0.16,
                                                                          width:
                                                                              media.width * 0.16,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: NetworkImage(myHistory[i]['userDetail']['data']['profile_picture']), fit: BoxFit.cover)),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              media.width * 0.02,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: media.width * 0.3,
                                                                              child: MyText(
                                                                                text: myHistory[i]['userDetail']['data']['name'],
                                                                                size: media.width * eighteen,
                                                                                fontweight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Image.network(
                                                                                myHistory[i]['vehicle_type_image'].toString(),
                                                                                height: media.width * 0.1,
                                                                                width: media.width * 0.1,
                                                                                fit: BoxFit.contain,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            // SizedBox(
                                                            //   height:
                                                            //       media.width *
                                                            //           0.02,
                                                            // ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 60,
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .receipt,
                                                                          color:
                                                                              textColor),
                                                                      SizedBox(
                                                                        width: media.width *
                                                                            0.01,
                                                                      ),
                                                                      MyText(
                                                                        text: languages[choosenLanguage]
                                                                            [
                                                                            'text_totalfare'],
                                                                        size: media.width *
                                                                            fourteen,
                                                                        fontweight:
                                                                            FontWeight.w600,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 30,
                                                                    child:
                                                                        MyText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      text:
                                                                          '${userDetails['currency_symbol']} ${myHistory[i]['request_eta_amount'].toString()}',
                                                                      size: media
                                                                              .width *
                                                                          fourteen,
                                                                      fontweight:
                                                                          FontWeight
                                                                              .w600,
                                                                      maxLines:
                                                                          1,
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.02,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: media
                                                                          .width *
                                                                      0.05,
                                                                  width: media
                                                                          .width *
                                                                      0.05,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: const Color(
                                                                              0xffFF0000)
                                                                          .withOpacity(
                                                                              0.3)),
                                                                  child:
                                                                      Container(
                                                                    height: media
                                                                            .width *
                                                                        0.025,
                                                                    width: media
                                                                            .width *
                                                                        0.025,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Color(
                                                                            0xffFF0000)),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: media
                                                                          .width *
                                                                      0.05,
                                                                ),
                                                                SizedBox(
                                                                    width: media
                                                                            .width *
                                                                        0.7,
                                                                    child:
                                                                        MyText(
                                                                      text: myHistory[
                                                                              i]
                                                                          [
                                                                          'pick_address'],
                                                                      size: media
                                                                              .width *
                                                                          twelve,
                                                                    )),
                                                              ],
                                                            ),
                                                            (myHistory[i][
                                                                        'drop_address'] !=
                                                                    null)
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: media.width *
                                                                            0.05),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              media.width * 0.05,
                                                                          width:
                                                                              media.width * 0.05,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: const Color(0xff319900).withOpacity(0.3)),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                media.width * 0.025,
                                                                            width:
                                                                                media.width * 0.025,
                                                                            decoration:
                                                                                const BoxDecoration(shape: BoxShape.circle, color: Color(0xff319900)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              media.width * 0.05,
                                                                        ),
                                                                        SizedBox(
                                                                            width: media.width *
                                                                                0.7,
                                                                            child:
                                                                                MyText(
                                                                              text: myHistory[i]['drop_address'],
                                                                              size: media.width * twelve,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.02,
                                                            ),
                                                            Button(
                                                              onTap: () async {
                                                                setState(() {
                                                                  _isLoading =
                                                                      true;
                                                                });
                                                                var val = await readyToPickup(
                                                                    myHistory[i]
                                                                        ['id']);
                                                                if (val ==
                                                                    'success') {
                                                                  setState(() {
                                                                    _isLoading =
                                                                        false;
                                                                    Navigator.pushAndRemoveUntil(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const Maps()),
                                                                        (route) =>
                                                                            false);
                                                                  });
                                                                }
                                                              },
                                                              text: languages[
                                                                      choosenLanguage]
                                                                  [
                                                                  'text_ready_to_pickup'],
                                                              color: online,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Container());
                                  })
                                  .values
                                  .toList(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: media.width * 0.7,
                                  width: media.width * 0.7,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/noorder.png'),
                                          fit: BoxFit.contain)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: media.width * 0.07,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.2,
                                        child: MyText(
                                            text: languages[choosenLanguage]
                                                ['text_noorder'],
                                            textAlign: TextAlign.center,
                                            fontweight: FontWeight.w800,
                                            size: media.width * sixteen),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                      //load more button
                      (myHistoryPage['pagination'] != null)
                          ? (myHistoryPage['pagination']['current_page'] <
                                  myHistoryPage['pagination']['total_pages'])
                              ? InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    dynamic val;
                                    if (_showHistory == 0) {
                                      val = await getHistoryPages(
                                          'is_later=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                    } else if (_showHistory == 1) {
                                      val = await getHistoryPages(
                                          'is_completed=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                    } else if (_showHistory == 2) {
                                      val = await getHistoryPages(
                                          'is_cancelled=1&page=${myHistoryPage['pagination']['current_page'] + 1}');
                                    }
                                    if (val == 'logout') {
                                      navigateLogout();
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(media.width * 0.025),
                                    margin: EdgeInsets.only(
                                        bottom: media.width * 0.05),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: page,
                                        border: Border.all(
                                            color: borderLines, width: 1.2)),
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
                ))
              ],
            ),
          ),
          (_isLoading)
              ? const Positioned(top: 0, child: Loading())
              : Container(),
          //no internet
          (internet == false)
              ? Positioned(
                  top: 0,
                  child: NoInternet(
                    onTap: () {
                      setState(() {
                        internetTrue();
                      });
                    },
                  ))
              : Container(),
        ],
      ),
    ));
  }
}
