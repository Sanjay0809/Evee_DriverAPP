import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';
import 'history.dart';

class HistoryDetails extends StatefulWidget {
  const HistoryDetails({Key? key}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

String complaintDesc = '';
int complaintType = 0;

class _HistoryDetailsState extends State<HistoryDetails> {
  String _error = '';

  @override
  void initState() {
    makecomplaint = 0;
    makecomplaintbool = false;
    _isLoading = false;
    _tripStops = myHistory[selectedHistory]['requestStops']['data'];
    getData();
    super.initState();
  }

  List _tripStops = [];

  bool _showOptions = false;

  getData() async {
    setState(() {
      complaintType = 0;
      complaintDesc = '';
      generalComplaintList = [];
    });

    await getGeneralComplaint("request");
    setState(() {
      _isLoading = false;
      if (generalComplaintList.isNotEmpty) {
        complaintType = 0;
      }
    });
  }

  int makecomplaint = 0;
  bool makecomplaintbool = false;
  bool _isLoading = false;
  TextEditingController complaintText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  media.width * 0.05,
                  MediaQuery.of(context).padding.top + media.width * 0.05,
                  media.width * 0.05,
                  0),
              height: media.height * 1,
              width: media.width * 1,
              color: page,
              //history details
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: media.width * 0.05),
                        width: media.width * 0.9,
                        alignment: Alignment.center,
                        child: MyText(
                          text: languages[choosenLanguage]['text_tripsummary'],
                          size: media.width * sixteen,
                          fontweight: FontWeight.bold,
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
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: media.height * 0.02,
                          ),
                          Container(
                            width: media.width * 0.9,
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: languages[choosenLanguage]['text_location']
                                  .toString()
                                  .toUpperCase(),
                              size: media.width * fourteen,
                              fontweight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: media.width * 0.05,
                                width: media.width * 0.05,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green),
                                child: Container(
                                  height: media.width * 0.025,
                                  width: media.width * 0.025,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.06,
                              ),
                              Expanded(
                                child: MyText(
                                  text: myHistory[selectedHistory]
                                      ['pick_address'],
                                  size: media.width * twelve,
                                  // maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.02,
                          ),
                          Column(
                            children: _tripStops
                                .asMap()
                                .map((i, value) {
                                  return MapEntry(
                                      i,
                                      (i < _tripStops.length - 1)
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height:
                                                          media.width * 0.06,
                                                      width: media.width * 0.06,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.red
                                                              .withOpacity(
                                                                  0.1)),
                                                      child: MyText(
                                                        text:
                                                            (i + 1).toString(),
                                                        size: media.width *
                                                            twelve,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.05,
                                                    ),
                                                    Expanded(
                                                      child: MyText(
                                                        text: _tripStops[i]
                                                            ['address'],
                                                        size: media.width *
                                                            twelve,
                                                        // maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.02,
                                                ),
                                              ],
                                            )
                                          : Container());
                                })
                                .values
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: media.width * 0.06,
                                width: media.width * 0.06,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withOpacity(0.1)),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: const Color(0xFFFF0000),
                                  size: media.width * eighteen,
                                ),
                              ),
                              SizedBox(
                                width: media.width * 0.05,
                              ),
                              Expanded(
                                child: MyText(
                                  text: myHistory[selectedHistory]
                                      ['drop_address'],
                                  size: media.width * twelve,
                                  // maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.04,
                          ),
                          Container(
                            padding: EdgeInsets.all(media.width * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: media.width * 0.05,
                                      width: media.width * 0.05,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF00E688)),
                                      child: Icon(
                                        Icons.done,
                                        size: media.width * 0.04,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_assigned'],
                                        size: media.width * twelve,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: MyText(
                                        text:
                                            '${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['accepted_at'].toString().split(' ').toList()[3]}',
                                        size: media.width * twelve,
                                        color: textColor.withOpacity(0.4),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: media.width * 0.025),
                                  height: 1,
                                  width: media.width * 0.15,
                                  color: const Color(0xFF00E688),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: media.width * 0.05,
                                      width: media.width * 0.05,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF00E688)),
                                      child: Icon(
                                        Icons.done,
                                        size: media.width * 0.04,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_started'],
                                        size: media.width * twelve,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: MyText(
                                        text:
                                            '${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['trip_start_time'].toString().split(' ').toList()[3]}',
                                        size: media.width * twelve,
                                        color: textColor.withOpacity(0.4),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: media.width * 0.025),
                                  height: 1,
                                  width: media.width * 0.15,
                                  color: const Color(0xFF00E688),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: media.width * 0.05,
                                      width: media.width * 0.05,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF00E688)),
                                      child: Icon(
                                        Icons.done,
                                        size: media.width * 0.04,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.17,
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_completed'],
                                        size: media.width * twelve,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: media.width * 0.16,
                                      child: MyText(
                                        text:
                                            '${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[2]} ${myHistory[selectedHistory]['completed_at'].toString().split(' ').toList()[3]}',
                                        size: media.width * twelve,
                                        color: textColor.withOpacity(0.4),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.width * 0.04,
                          ),
                          Container(
                            // margin: EdgeInsets.all(media.width * 0.02),
                            padding: EdgeInsets.all(media.width * 0.03),
                            decoration: BoxDecoration(color: page, boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.3,
                                  spreadRadius: 0.5,
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: media.width * 0.13,
                                  width: media.width * 0.13,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              (userDetails['role'] == 'owner')
                                                  ? myHistory[selectedHistory]
                                                              ['driverDetail']
                                                          ['data']
                                                      ['profile_picture']
                                                  : myHistory[selectedHistory]
                                                          ['userDetail']['data']
                                                      ['profile_picture']),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: media.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: (userDetails['role'] == 'owner')
                                          ? myHistory[selectedHistory]
                                              ['driverDetail']['data']['name']
                                          : myHistory[selectedHistory]
                                              ['userDetail']['data']['name'],
                                      size: media.width * eighteen,
                                      color: textColor,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: media.width * 0.06,
                                          child: (myHistory[selectedHistory]
                                                      ['payment_opt'] ==
                                                  '1')
                                              ? Image.asset(
                                                  'assets/images/cash.png',
                                                  fit: BoxFit.contain,
                                                )
                                              : (myHistory[selectedHistory]
                                                          ['payment_opt'] ==
                                                      '2')
                                                  ? Image.asset(
                                                      'assets/images/wallet.png',
                                                      fit: BoxFit.contain,
                                                    )
                                                  : (myHistory[selectedHistory]
                                                              ['payment_opt'] ==
                                                          '0')
                                                      ? Image.asset(
                                                          'assets/images/card.png',
                                                          fit: BoxFit.contain,
                                                          color: textColor,
                                                        )
                                                      : Container(),
                                        ),
                                        SizedBox(
                                          width: media.width * 0.01,
                                        ),
                                        MyText(
                                          text: (myHistory[selectedHistory]
                                                      ['payment_opt'] ==
                                                  '1')
                                              ? languages[choosenLanguage]
                                                  ['text_cash']
                                              : (myHistory[selectedHistory]
                                                          ['payment_opt'] ==
                                                      '2')
                                                  ? languages[choosenLanguage]
                                                      ['text_wallet']
                                                  : (myHistory[selectedHistory]
                                                              ['payment_opt'] ==
                                                          '0')
                                                      ? languages[
                                                              choosenLanguage]
                                                          ['text_card']
                                                      : '',
                                          size: media.width * twelve,
                                          fontweight: FontWeight.w600,
                                          color: textColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MyText(
                                      text: (userDetails['role'] == 'owner')
                                          ? myHistory[selectedHistory]
                                                      ['ride_user_rating'] !=
                                                  null
                                              ? myHistory[selectedHistory]
                                                      ['ride_user_rating']
                                                  .toString()
                                              : '-'
                                          : myHistory[selectedHistory]
                                                  ['ride_driver_rating']
                                              .toString(),
                                      size: media.width * eighteen,
                                      fontweight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: media.width * twenty,
                                      color: (isDarkTheme == true)
                                          ? const Color(0xffFF0000)
                                          : buttonColor,
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.03,
                          ),
                          Container(
                            padding: EdgeInsets.all(media.width * 0.04),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_reference'],
                                          size: media.width * fourteen,
                                        ),
                                        SizedBox(
                                          height: media.width * 0.02,
                                        ),
                                        MyText(
                                          text: myHistory[selectedHistory]
                                              ['request_number'],
                                          size: media.width * twelve,
                                          fontweight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_rideType'],
                                          size: media.width * fourteen,
                                        ),
                                        SizedBox(
                                          height: media.width * 0.02,
                                        ),
                                        MyText(
                                          text: (myHistory[selectedHistory]
                                                      ['is_rental'] ==
                                                  false)
                                              ? languages[choosenLanguage]
                                                  ['text_regular']
                                              : languages[choosenLanguage]
                                                  ['text_rental'],
                                          size: media.width * twelve,
                                          fontweight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: media.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_distance'],
                                          size: media.width * fourteen,
                                        ),
                                        SizedBox(
                                          height: media.width * 0.02,
                                        ),
                                        MyText(
                                          text: myHistory[selectedHistory]
                                                  ['total_distance'] +
                                              ' ' +
                                              myHistory[selectedHistory]
                                                  ['unit'],
                                          size: media.width * twelve,
                                          fontweight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                              ['text_duration'],
                                          size: media.width * fourteen,
                                        ),
                                        SizedBox(
                                          height: media.width * 0.02,
                                        ),
                                        MyText(
                                          text:
                                              '${myHistory[selectedHistory]['total_time']} mins',
                                          size: media.width * twelve,
                                          fontweight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: media.height * 0.02,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(
                                    text: languages[choosenLanguage]
                                        ['text_tripfare'],
                                    size: media.width * fourteen,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: media.height * 0.03,
                              ),
                              (myHistory[selectedHistory]['is_rental'] == true)
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          bottom: media.width * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                            text: languages[choosenLanguage]
                                                ['text_ride_type'],
                                            size: media.width * fourteen,
                                          ),
                                          MyText(
                                            text: myHistory[selectedHistory]
                                                ['rental_package_name'],
                                            size: media.width * fourteen,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_baseprice'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        text: myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['base_price']
                                                .toString(),
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_distprice'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        text: myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['distance_price']
                                                .toString(),
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_timeprice'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        text: myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['time_price']
                                                .toString(),
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              (myHistory[selectedHistory]['requestBill']['data']
                                          ['cancellation_fee'] !=
                                      0)
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: languages[choosenLanguage]
                                                  ['text_cancelfee'],
                                              size: media.width * fourteen,
                                            ),
                                            MyText(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              text: myHistory[selectedHistory]
                                                              ['requestBill']
                                                          ['data']
                                                      [
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  myHistory[selectedHistory]
                                                                  [
                                                                  'requestBill']
                                                              ['data']
                                                          ['cancellation_fee']
                                                      .toString(),
                                              size: media.width * twelve,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.03,
                                              bottom: media.width * 0.03),
                                          height: 1.5,
                                          color: const Color(0xffE0E0E0),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              (myHistory[selectedHistory]['requestBill']['data']
                                          ['airport_surge_fee'] !=
                                      0)
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: languages[choosenLanguage]
                                                  ['text_surge_fee'],
                                              size: media.width * fourteen,
                                            ),
                                            MyText(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              text: myHistory[selectedHistory]
                                                              ['requestBill']
                                                          ['data']
                                                      [
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  myHistory[selectedHistory]
                                                                  [
                                                                  'requestBill']
                                                              ['data']
                                                          ['airport_surge_fee']
                                                      .toString(),
                                              size: media.width * twelve,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.03,
                                              bottom: media.width * 0.03),
                                          height: 1.5,
                                          color: const Color(0xffE0E0E0),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                                ['text_waiting_price'] +
                                            ' (' +
                                            myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['waiting_charge_per_min']
                                                .toString() +
                                            ' x ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['calculated_waiting_time']
                                                .toString() +
                                            ' mins' +
                                            ')',
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        text: myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['waiting_charge']
                                                .toString(),
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_convfee'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        text: myHistory[selectedHistory]
                                                    ['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data']
                                                    ['admin_commision']
                                                .toString(),
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              (myHistory[selectedHistory]['requestBill']['data']
                                          ['promo_discount'] !=
                                      null)
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              text: languages[choosenLanguage]
                                                  ['text_discount'],
                                              size: media.width * fourteen,
                                              color: Colors.red,
                                            ),
                                            MyText(
                                              // ignore: prefer_interpolation_to_compose_strings
                                              text: myHistory[selectedHistory]
                                                              ['requestBill']
                                                          ['data']
                                                      [
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  myHistory[selectedHistory]
                                                                  [
                                                                  'requestBill']
                                                              ['data']
                                                          ['promo_discount']
                                                      .toString(),
                                              size: media.width * twelve,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.03,
                                              bottom: media.width * 0.03),
                                          height: 1.5,
                                          color: const Color(0xffE0E0E0),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_taxes'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        text:
                                            // ignore: prefer_interpolation_to_compose_strings
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data'][
                                                    'requested_currency_symbol'] +
                                                ' ' +
                                                '${myHistory[selectedHistory]['requestBill']['data']['service_tax']} ',
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_totalfare'],
                                        size: media.width * fourteen,
                                      ),
                                      MyText(
                                        text:
                                            // ignore: prefer_interpolation_to_compose_strings
                                            myHistory[selectedHistory]
                                                        ['requestBill']['data'][
                                                    'requested_currency_symbol'] +
                                                ' ' +
                                                '${'${myHistory[selectedHistory]['requestBill']['data']['total_amount']} '} ',
                                        size: media.width * twelve,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: media.width * 0.03,
                                        bottom: media.width * 0.03),
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  //make complaints
                  Container(
                    padding: EdgeInsets.all(media.width * 0.05),
                    child: Button(
                        onTap: () {
                          setState(() {
                            _error = '';

                            makecomplaintbool = true;
                            makecomplaint = 1;
                            complaintText.text = '';
                          });
                        },
                        text: languages[choosenLanguage]
                            ['text_make_complaints']),
                  ),
                ],
              ),
            ),
            (makecomplaintbool == true)
                ? Positioned(
                    child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: media.height * 1,
                    width: media.width * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                      children: [
                        SizedBox(
                          height: media.height * 0.1,
                        ),
                        Container(
                          padding: EdgeInsets.all(media.width * 0.03),
                          height: media.width * 0.12,
                          width: media.width * 1,
                          decoration: BoxDecoration(color: topBar, boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                          // color: topBar,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    makecomplaintbool = false;
                                    makecomplaint = 1;
                                  });
                                },
                                child: (makecomplaint == 1)
                                    ? MyText(
                                        text: 'Cancel',
                                        size: media.width * fourteen,
                                        color: const Color(0xffFF0000),
                                      )
                                    : SizedBox(
                                        height: media.width * 0.06,
                                        width: media.width * 0.06,
                                        child: const Icon(
                                          Icons.close,
                                          // size: media.width * twentyfour,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: media.width * 0.25,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_make_complaints'],
                                size: media.width * sixteen,
                                color: (isDarkTheme == true)
                                    ? Colors.black
                                    : textColor,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              width: media.width * 1,
                              padding: EdgeInsets.all(media.width * 0.04),
                              color: page,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: (makecomplaint == 1)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: media.width * 0.05,
                                              ),
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_why_report'],
                                                size: media.width * sixteen,
                                                fontweight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: media.width * 0.03,
                                              ),
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_we_apriciate'],
                                                size: media.width * fourteen,
                                                color:
                                                    textColor.withOpacity(0.3),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.03,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (_showOptions == false) {
                                                      _showOptions = true;
                                                    } else {
                                                      _showOptions = false;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: media.width * 0.05,
                                                      right:
                                                          media.width * 0.05),
                                                  height: media.width * 0.12,
                                                  width: media.width * 0.9,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                          color: borderLines,
                                                          width: 1.2)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      MyText(
                                                        text: generalComplaintList[
                                                                complaintType]
                                                            ['title'],
                                                        size: media.width *
                                                            fourteen,
                                                      ),
                                                      RotatedBox(
                                                        quarterTurns:
                                                            (_showOptions ==
                                                                    true)
                                                                ? 2
                                                                : 0,
                                                        child: Container(
                                                          height: media.width *
                                                              0.07,
                                                          width: media.width *
                                                              0.07,
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/chevron-down.png'),
                                                                  fit: BoxFit
                                                                      .contain)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.05,
                                              ),
                                              (_showOptions == true)
                                                  ? Container(
                                                      padding: EdgeInsets.all(
                                                          media.width * 0.02),
                                                      margin: EdgeInsets.only(
                                                          bottom: media.width *
                                                              0.05),
                                                      height: media.width * 0.3,
                                                      width: media.width * 0.9,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            width: 1.2,
                                                            color: borderLines),
                                                        color: page,
                                                      ),
                                                      child:
                                                          SingleChildScrollView(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        child: Column(
                                                          children:
                                                              generalComplaintList
                                                                  .asMap()
                                                                  .map((i,
                                                                      value) {
                                                                    return MapEntry(
                                                                        i,
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              complaintType = i;
                                                                              _showOptions = false;
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                media.width * 0.7,
                                                                            padding:
                                                                                EdgeInsets.only(top: media.width * 0.025, bottom: media.width * 0.025),
                                                                            decoration:
                                                                                BoxDecoration(border: Border(bottom: BorderSide(width: 1.1, color: (i == generalComplaintList.length - 1) ? Colors.transparent : borderLines))),
                                                                            child:
                                                                                MyText(
                                                                              text: generalComplaintList[i]['title'],
                                                                              size: media.width * fourteen,
                                                                            ),
                                                                          ),
                                                                        ));
                                                                  })
                                                                  .values
                                                                  .toList(),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                width: media.width * 0.9,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: (_error == '')
                                                            ? borderLines
                                                            : Colors.red,
                                                        width: 1.2)),
                                                child: MyTextField(
                                                  textController: complaintText,
                                                  hinttext: languages[
                                                              choosenLanguage]
                                                          ['text_complaint_2'] +
                                                      ' (' +
                                                      languages[choosenLanguage]
                                                          ['text_complaint_3'] +
                                                      ')',
                                                  maxline: 5,
                                                  onTap: (val) {
                                                    if (val.length >= 10 &&
                                                        _error != '') {
                                                      setState(() {
                                                        _error = '';
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              if (_error != '')
                                                Container(
                                                  width: media.width * 0.9,
                                                  padding: EdgeInsets.only(
                                                      top: media.width * 0.025,
                                                      bottom:
                                                          media.width * 0.025),
                                                  child: MyText(
                                                    text: _error,
                                                    size:
                                                        media.width * fourteen,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                            ],
                                          )
                                        : (makecomplaint == 2)
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: media.width * 0.3,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: media.width * 0.13,
                                                    width: media.width * 0.13,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: const Color(
                                                          0xffFF0000),
                                                      gradient: LinearGradient(
                                                          colors: <Color>[
                                                            const Color(
                                                                0xffFF0000),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                          ],
                                                          begin:
                                                              FractionalOffset
                                                                  .topCenter,
                                                          end: FractionalOffset
                                                              .bottomCenter),
                                                    ),
                                                    child: Icon(
                                                      Icons.done,
                                                      size: media.width * 0.09,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: media.width * 0.03,
                                                  ),
                                                  MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_thanks_let'],
                                                    size: media.width * sixteen,
                                                    fontweight: FontWeight.w700,
                                                  ),
                                                  SizedBox(
                                                    height: media.width * 0.03,
                                                  ),
                                                  MyText(
                                                    text: languages[
                                                            choosenLanguage][
                                                        'text_thanks_feedback'],
                                                    size:
                                                        media.width * fourteen,
                                                    color: textColor
                                                        .withOpacity(0.4),
                                                  )
                                                ],
                                              )
                                            : Container(),
                                  ),
                                  Button(
                                      onTap: () async {
                                        if (makecomplaint == 1) {
                                          if (complaintText.text.length >= 10) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            complaintDesc = complaintText.text;
                                            dynamic result;
                                            result =
                                                await makeRequestComplaint();
                                            if (result == 'success') {
                                              setState(() {
                                                makecomplaint = 2;
                                                _isLoading = false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              _error = languages[
                                                      choosenLanguage]
                                                  ['text_complaint_text_error'];
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            makecomplaintbool = false;
                                            makecomplaint = 1;
                                          });
                                        }
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_continue'])
                                ],
                              )),
                        )
                      ],
                    ),
                  ))
                : Container(),
            (_isLoading == true)
                ? const Positioned(top: 0, child: Loading())
                : Container(),
            //no internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        internetTrue();
                      },
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
