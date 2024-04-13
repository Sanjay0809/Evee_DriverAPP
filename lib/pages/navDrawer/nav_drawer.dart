import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/settings.dart';
import 'package:flutter_driver/pages/NavigatorPages/support.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../NavigatorPages/bankdetails.dart';
import '../NavigatorPages/driverdetails.dart';
import '../NavigatorPages/driverearnings.dart';
import '../NavigatorPages/editprofile.dart';
import '../NavigatorPages/history.dart';
import '../NavigatorPages/makecomplaint.dart';
import '../NavigatorPages/managevehicles.dart';
import '../NavigatorPages/myroutebookings.dart';
import '../NavigatorPages/notification.dart';
import '../NavigatorPages/referral.dart';
import '../NavigatorPages/sos.dart';
import '../NavigatorPages/walletpage.dart';
import '../login/landingpage.dart';
import '../login/login.dart';
import '../onTripPage/map_page.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // ignore: unused_field
  final bool _isLoading = false;
  // ignore: unused_field
  final String _error = '';

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

  @override
  void initState() {
    if (userDetails['chat_id'] != null && chatStream == null) {
      streamAdminchat();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: valueNotifierHome.value,
        builder: (context, value, child) {
          return SizedBox(
            width: media.width * 0.8,
            child: Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Drawer(
                  backgroundColor: page,
                  child: SizedBox(
                    width: media.width * 0.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: media.width * 0.05 +
                                        MediaQuery.of(context).padding.top,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: media.width * 0.2,
                                          width: media.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userDetails[
                                                          'profile_picture']),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: media.width * 0.025,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: media.width * 0.45,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: media.width * 0.3,
                                                    child: MyText(
                                                      text: userDetails['name'],
                                                      size: media.width *
                                                          eighteen,
                                                      fontweight:
                                                          FontWeight.w600,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      var val = await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const EditProfile()));
                                                      if (val) {
                                                        setState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                          media.width * 0.01),
                                                      width: media.width * 0.15,
                                                      decoration: BoxDecoration(
                                                          color: textColor
                                                              .withOpacity(0.1),
                                                          border: Border.all(
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.15)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(media
                                                                          .width *
                                                                      0.01)),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.edit,
                                                              size:
                                                                  media.width *
                                                                      fourteen,
                                                              color: textColor
                                                              // const Color(0xFFFF0000),
                                                              ),
                                                          Expanded(
                                                            child: MyText(
                                                                text: languages[
                                                                        choosenLanguage]
                                                                    [
                                                                    'text_edit'],
                                                                size: media
                                                                        .width *
                                                                    twelve,
                                                                maxLines: 1,
                                                                color: textColor
                                                                // const Color(0xFFFF0000),
                                                                ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: media.width * 0.01,
                                            ),
                                            SizedBox(
                                              width: media.width * 0.45,
                                              child: MyText(
                                                text: userDetails['mobile'],
                                                size: media.width * fourteen,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: media.width * 0.02),
                                    width: media.width * 0.7,
                                    child: Column(
                                      children: [
                                        userDetails['role'] != 'owner' &&
                                                userDetails[
                                                        'enable_my_route_booking_feature'] ==
                                                    '1' &&
                                                userDetails['transport_type'] !=
                                                    'delivery'
                                            ? InkWell(
                                                onTap: () async {
                                                  var nav = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyRouteBooking()));
                                                  if (nav != null) {
                                                    if (nav) {
                                                      setState(() {});
                                                    }
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  media.width *
                                                                      0.01,
                                                                  media.width *
                                                                      0.025,
                                                                  media.width *
                                                                      0.025,
                                                                  media.width *
                                                                      0.025),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/myroute.png',
                                                                fit: BoxFit
                                                                    .contain,
                                                                width: media
                                                                        .width *
                                                                    0.06,
                                                                color: textColor
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.025,
                                                              ),
                                                              ShowUp(
                                                                delay: 200,
                                                                child: SizedBox(
                                                                    width: media
                                                                            .width *
                                                                        0.45,
                                                                    child:
                                                                        MyText(
                                                                      text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_my_route'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      size: media
                                                                              .width *
                                                                          sixteen,
                                                                      color: textColor
                                                                          .withOpacity(
                                                                              0.8),
                                                                    )),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        // SizedBox(width: media.width*0.05,),
                                                        if (userDetails[
                                                                'my_route_address'] !=
                                                            null)
                                                          Container(
                                                            padding: EdgeInsets.only(
                                                                left: media
                                                                        .width *
                                                                    0.005,
                                                                right: media
                                                                        .width *
                                                                    0.005),
                                                            height:
                                                                media.width *
                                                                    0.05,
                                                            width: media.width *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .circular(media
                                                                          .width *
                                                                      0.025),
                                                              color: (userDetails[
                                                                          'enable_my_route_booking'] ==
                                                                      1)
                                                                  ? Colors.green
                                                                      .withOpacity(
                                                                          0.4)
                                                                  : Colors.grey
                                                                      .withOpacity(
                                                                          0.6),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  (userDetails[
                                                                              'enable_my_route_booking'] ==
                                                                          1)
                                                                      ? MainAxisAlignment
                                                                          .end
                                                                      : MainAxisAlignment
                                                                          .start,
                                                              children: [
                                                                Container(
                                                                  height: media
                                                                          .width *
                                                                      0.045,
                                                                  width: media
                                                                          .width *
                                                                      0.045,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: (userDetails['enable_my_route_booking'] ==
                                                                            1)
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                        top: media.width * 0.01,
                                                        left:
                                                            media.width * 0.09,
                                                      ),
                                                      child: Container(
                                                        color: textColor
                                                            .withOpacity(0.1),
                                                        height: 1,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const History()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_enable_history'],
                                          icon: Icons.view_list_outlined,
                                        ),
                                        //Notifications

                                        (userDetails['role'] != 'owner')
                                            ? ValueListenableBuilder(
                                                valueListenable:
                                                    valueNotifierNotification
                                                        .value,
                                                builder:
                                                    (context, value, child) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const NotificationPage()));
                                                      setState(() {
                                                        userDetails[
                                                            'notifications_count'] = 0;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: media.width *
                                                              0.02),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .notifications_none,
                                                                size: media
                                                                        .width *
                                                                    0.075,
                                                                color: textColor
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.025,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: (userDetails['notifications_count'] ==
                                                                            0)
                                                                        ? media.width *
                                                                            0.55
                                                                        : media.width *
                                                                            0.495,
                                                                    child:
                                                                        ShowUp(
                                                                      delay:
                                                                          200,
                                                                      child:
                                                                          MyText(
                                                                        text: languages[choosenLanguage]['text_notification']
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        size: media.width *
                                                                            sixteen,
                                                                        color: textColor
                                                                            .withOpacity(0.8),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      (userDetails['notifications_count'] ==
                                                                              0)
                                                                          ? Container()
                                                                          : Container(
                                                                              height: 20,
                                                                              width: 20,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: buttonColor,
                                                                              ),
                                                                              child: Text(
                                                                                userDetails['notifications_count'].toString(),
                                                                                style: GoogleFonts.notoSans(fontSize: media.width * fourteen, color: (isDarkTheme) ? Colors.black : buttonText),
                                                                              ),
                                                                            ),
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_right_rounded,
                                                                        size: media.width *
                                                                            0.05,
                                                                        color: textColor
                                                                            .withOpacity(0.8),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: media.width *
                                                                  0.02,
                                                              left:
                                                                  media.width *
                                                                      0.09,
                                                            ),
                                                            child: Container(
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.1),
                                                              height: 1,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : Container(),

                                        //wallet page

                                        userDetails['owner_id'] == null &&
                                                userDetails[
                                                        'show_wallet_feature_on_mobile_app'] ==
                                                    '1'
                                            ? NavMenu(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const WalletPage()));
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_enable_wallet'],
                                                icon: Icons.payment,
                                              )
                                            : Container(),

                                        //Earnings
                                        NavMenu(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DriverEarnings()));
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_earnings'],
                                          image: 'assets/images/earing.png',
                                        ),

                                        //manage vehicle

                                        userDetails['role'] == 'owner'
                                            ? NavMenu(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ManageVehicles()));
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_manage_vehicle'],
                                                image:
                                                    'assets/images/updateVehicleInfo.png',
                                              )
                                            : Container(),

                                        //manage Driver
                                        userDetails['role'] == 'owner'
                                            ? NavMenu(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const DriverList()));
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_manage_drivers'],
                                                image:
                                                    'assets/images/managedriver.png',
                                              )
                                            : Container(),

                                        //bank details
                                        userDetails['owner_id'] == null &&
                                                userDetails[
                                                        'show_bank_info_feature_on_mobile_app'] ==
                                                    "1"
                                            ? NavMenu(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const BankDetails()));
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_updateBank'],
                                                icon: Icons
                                                    .account_balance_outlined,
                                              )
                                            : Container(),

                                        //sos
                                        userDetails['role'] != 'owner'
                                            ? NavMenu(
                                                onTap: () async {
                                                  var nav = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Sos()));
                                                  if (nav) {
                                                    setState(() {});
                                                  }
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_sos'],
                                                icon: Icons
                                                    .connect_without_contact,
                                              )
                                            : Container(),

                                        //makecomplaints
                                        NavMenu(
                                          icon: Icons.toc,
                                          text: languages[choosenLanguage]
                                              ['text_make_complaints'],
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MakeComplaint()));
                                          },
                                        ),

                                        //settings
                                        NavMenu(
                                          onTap: () async {
                                            var nav = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SettingsPage()));
                                            if (nav) {
                                              setState(() {});
                                            }
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_settings'],
                                          icon: Icons.settings,
                                        ),

                                        //support
                                        ValueListenableBuilder(
                                            valueListenable:
                                                valueNotifierChat.value,
                                            builder: (context, value, child) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SupportPage()));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: media.width * 0.025),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .support_agent,
                                                              size:
                                                                  media.width *
                                                                      0.075,
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.5)),
                                                          SizedBox(
                                                            width: media.width *
                                                                0.025,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: (unSeenChatCount == '0')
                                                                    ? media.width *
                                                                        0.55
                                                                    : media.width *
                                                                        0.495,
                                                                child: ShowUp(
                                                                  delay: 200,
                                                                  child: MyText(
                                                                    text: languages[
                                                                            choosenLanguage]
                                                                        [
                                                                        'text_support'],
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    size: media
                                                                            .width *
                                                                        sixteen,
                                                                    color: textColor
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  (unSeenChatCount ==
                                                                          '0')
                                                                      ? Container()
                                                                      : Container(
                                                                          height:
                                                                              20,
                                                                          width:
                                                                              20,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                buttonColor,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            unSeenChatCount,
                                                                            style:
                                                                                GoogleFonts.notoSans(fontSize: media.width * fourteen, color: (isDarkTheme) ? Colors.black : buttonText),
                                                                          ),
                                                                        ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_right_rounded,
                                                                    size: media
                                                                            .width *
                                                                        0.05,
                                                                    color: textColor
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: media.width *
                                                              0.01,
                                                          left: media.width *
                                                              0.09,
                                                        ),
                                                        child: Container(
                                                          color: textColor
                                                              .withOpacity(0.1),
                                                          height: 1,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),

                                        //referral page
                                        userDetails['owner_id'] == null &&
                                                userDetails['role'] == 'driver'
                                            ? NavMenu(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ReferralPage()));
                                                },
                                                text: languages[choosenLanguage]
                                                    ['text_enable_referal'],
                                                icon: Icons
                                                    .offline_share_outlined,
                                              )
                                            : Container(),

                                        //logout
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              logout = true;
                            });
                            valueNotifierHome.incrementNotifier();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: media.width * 0.25,
                            ),
                            height: media.width * 0.13,
                            width: media.width * 0.8,
                            color: Colors.grey.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: (languageDirection == 'ltr')
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: media.width * 0.05,
                                  color: textColor,
                                ),
                                SizedBox(
                                  width: media.width * 0.025,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                      ['text_sign_out'],
                                  size: media.width * sixteen,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
