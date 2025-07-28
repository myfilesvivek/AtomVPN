
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/screens/servers_bottomsheet_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/custom_image_view.dart';
import '../theme/app_decoration.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import '../utils/app_exports.dart';

import '../services/vpn_engine.dart';
import '../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/vpn_serverlist_item_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _homeController = Get.put(HomeController());

  late Stream<VpnStatus?> vpnStatusStream;

  late AnimationController _animationController;
  late ScrollController _scrollController;
  late Animation<double> _scrollAnimation;
  late Animation<Offset> _zigZagAnimation;

  // Regular expression to extract the number and the unit
  RegExp regExp = RegExp(r"(\d+(\.\d+)?)\s?([kKmMgG]?[bB])");

  @override
  void initState() {
    // TODO: implement initState

    // Initialize ScrollController
    _scrollController = ScrollController();

    // Initialize AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2800), // Duration for the full scroll
    );

    // Define an animation that will scroll the image horizontally
    _scrollAnimation = TweenSequence([
      // First scroll from 0% to 40% of the total scroll
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 0.4).chain(CurveTween(curve: Curves.linear)),
        weight: 4, // 4 parts of the total duration
      ),
      // First pause (no movement)
      TweenSequenceItem(
        tween: ConstantTween(0.4), // Pause at 40% of the scroll
        weight: 1, // 1 part of the total duration (for the pause)
      ),
      // Scroll from 40% to 70% of the total scroll
      TweenSequenceItem(
        tween:
            Tween(begin: 0.4, end: 0.7).chain(CurveTween(curve: Curves.linear)),
        weight: 3,
      ),
      // Second pause (no movement)
      TweenSequenceItem(
        tween: ConstantTween(0.7), // Pause at 70% of the scroll
        weight: 1,
      ),
      // Final scroll from 70% to 100% of the total scroll
      TweenSequenceItem(
        tween:
            Tween(begin: 0.7, end: 1.0).chain(CurveTween(curve: Curves.linear)),
        weight: 3,
      ),
    ]).animate(_animationController);

    // Zig-zag animation for both horizontal and vertical movement
    _zigZagAnimation = TweenSequence([
      // Move diagonally (left-right and up)
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(100, -50), // Move right and up
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 4,
      ),
      // Pause when scrolling pauses
      TweenSequenceItem(
        tween: ConstantTween(Offset(100, -50)), // Pause
        weight: 1,
      ),
      // Move diagonally (left-right and down)
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(100, -50),
          end: Offset(200, 50), // Move further right and down
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 3,
      ),
      // Pause again
      TweenSequenceItem(
        tween: ConstantTween(Offset(200, 50)), // Pause
        weight: 1,
      ),
      // Move back to center
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset(200, 50),
          end: Offset(300, 0), // Move right and center
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 3,
      ),
    ]).animate(_animationController);

    // Add a listener to animate scrolling
    _animationController.addListener(() {
      if (_homeController.vpnState.value != VpnEngine.vpnDisconnected &&
          _homeController.vpnState.value != VpnEngine.vpnConnected) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;

        _scrollController.jumpTo(_scrollAnimation.value * maxScrollExtent);
      }
    });

    // Repeat the animation indefinitely

    // checkVPNConnectionOnLaunch();

    vpnStatusStream = VpnEngine.vpnStatusSnapshot();

    // Check VPN status on app launch after termination
    VpnEngine.checkVpnStatusOnLaunch().then((status) {
      print("VPN status on launch APP RESTART : $status");
      _homeController.vpnState.value =
          status.toLowerCase(); // Set the initial VPN state
    });

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _homeController.vpnState.value = event;
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(
        () => SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 26.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 490.h,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Visibility(
                          visible: _homeController.vpnState.value !=
                                  VpnEngine.vpnDisconnected &&
                              _homeController.vpnState.value !=
                                  VpnEngine.vpnConnected,
                          child: SingleChildScrollView(
                            controller: _scrollController,

                            scrollDirection:
                                Axis.horizontal, // Horizontal scroll direction

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/connecting_map.svg',
                                  fit: BoxFit.cover,
                                  width: 800, // The width of the image
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _homeController.vpnState.value !=
                                  VpnEngine.vpnDisconnected &&
                              _homeController.vpnState.value !=
                                  VpnEngine.vpnConnected,
                          child: AnimatedBuilder(
                              animation: _zigZagAnimation,
                              builder: (context, child) {
                                return Positioned(
                                  left: _zigZagAnimation.value
                                      .dx, // Move horizontally (left-right)
                                  top: 100 +
                                      _zigZagAnimation.value
                                          .dy, // Move vertically (up-down)
                                  child: Image.asset(
                                    'assets/images/location_pin.png',
                                    width: 38, // Marker image size
                                    height: 38,
                                  ),
                                );
                              }),
                        ),
                        CustomImageView(
                          imagePath: 'assets/svg/world_map.svg',
                          height: 216.h,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: 0),
                          alignment: Alignment.topCenter,
                        )
                            .animate(
                                target: _homeController.vpnState.value ==
                                        VpnEngine.vpnDisconnected
                                    ? 1
                                    : 0)
                            .fadeIn(duration: 900.ms, curve: Curves.easeIn)
                            .scaleXY(
                                begin:
                                    1.1, // Start zoomed out (150% of original size)
                                end: 1.0, // End at original size (100%)
                                duration:
                                    800.ms, // Duration of the zoom-out effect
                                curve: Curves.easeIn),

                        CustomImageView(
                          imagePath: 'assets/svg/connected_map.svg',
                          height: 240.h,
                          width: double.maxFinite,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10),
                          fit: BoxFit.cover,
                        )
                            .animate(
                              target: _homeController.vpnState.value ==
                                      VpnEngine.vpnConnected
                                  ? 1
                                  : 0,
                            )
                            .fadeIn(duration: 800.ms, curve: Curves.easeIn),

                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 65,
                            ),
                            child: RippleWave(
                              childTween: Tween(begin: 1, end: 1),
                              child: Container(),
                              color: Color.fromRGBO(41, 110, 200, 10),
                              repeat: true,
                              duration: const Duration(milliseconds: 600),
                            ),
                          ),
                        )
                            .animate(
                                target: _homeController.vpnState.value !=
                                            VpnEngine.vpnDisconnected &&
                                        _homeController.vpnState.value !=
                                            VpnEngine.vpnConnected
                                    ? 1
                                    : 0)
                            .fadeIn(duration: 200.ms),

                        GestureDetector(
                          onTap: () {
                            _homeController.connectToVpn();
                          },
                          child: CustomImageView(
                            imagePath: _homeController.getButtonImage,
                            height: 400.h,
                            width: double.maxFinite,
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(top: 70.h),
                          ),
                        ),
                        _buildStatusSection(context),
                        // StreamBuilder(
                        //   stream: VpnEngine.vpnStageSnapshot(),
                        //   builder: (context, snapshot) {
                        //     return Align(
                        //       alignment: Alignment.center,
                        //       child: Text(
                        //         "${snapshot.data ?? "No data"}",
                        //         style:
                        //         CustomTextStyles.titleSmallInterBluegray70004,
                        //       ),
                        //     );
                        //   }
                        // ),
                        Visibility(
                          visible: _homeController.vpnState.value ==
                              VpnEngine.vpnConnected,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Connecting Time",
                              style:
                                  CustomTextStyles.titleSmallInterBluegray70004,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _homeController.vpnState.value ==
                              VpnEngine.vpnConnected,
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: StreamBuilder<VpnStatus?>(
                                  stream: vpnStatusStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return CountDownTimer(
                                          duration: '00:00:00');
                                    }
                                    return CountDownTimer(
                                      duration:
                                          '${snapshot.data?.duration ?? '00:00:00'}',
                                    );
                                  })),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSpeedSection(context),
                  SizedBox(height: 22.h),
                  _buildGlobeSection(context),
                  // SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 64.h,
      leading: AppbarLeadingIconbutton(
        imagePath: 'assets/svg/menu_icon.svg',
        onTap: () => Get.to(() => NetworkTestScreen()),
        margin: EdgeInsets.only(
          left: 24.h,
          top: 4.h,
          bottom: 8.h,
        ),
      ),
      centerTitle: true,
      title: CustomImageView(
        imagePath: 'assets/images/atm.png',
        height: 26.h,
        width: 26.h,
        fit: BoxFit.contain,
        radius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildGlobeSection(BuildContext context) {
    if (_homeController.vpnState.value != VpnEngine.vpnDisconnected &&
        _homeController.vpnState.value != VpnEngine.vpnConnected) {
      _animationController.repeat(reverse: true); // Start animation if active
    } else {
      _animationController.stop(); // Stop animation if inactive
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 22.h,
        right: 22.h,
        bottom: 4.h,
      ),
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    showDragHandle: true,
                    backgroundColor: appTheme.teal50,
                    context: context,
                    builder: (context) => ServersBottomsheetScreen());
              },
              child: Container(
                padding: _homeController.selectedVpn.value.hostName.isNotEmpty
                    ? EdgeInsets.all(12.h)
                    : EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 16.h,
                      ),
                decoration:
                    _homeController.selectedVpn.value.hostName.isNotEmpty
                        ? AppDecoration.outlineBluegray70099.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder18,
                          )
                        : AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder18,
                          ),
                width: double.maxFinite,
                child: Row(
                  children: [
                    if (_homeController.selectedVpn.value.hostName.isNotEmpty)
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22.h,
                        child: CustomImageView(
                            imagePath:
                                'assets/flags/${_homeController.selectedVpn.value.countryShort.toLowerCase()}.png',
                            height: 40.h,
                            width: 40.h,
                            radius: BorderRadius.circular(
                              30.h,
                            )),
                      ),
                    if (_homeController.selectedVpn.value.hostName.isEmpty)
                      CustomImageView(
                        imagePath: 'assets/svg/img_globe.svg',
                        height: 36.h,
                        width: 36.h,
                      ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_homeController
                                .selectedVpn.value.hostName.isNotEmpty)
                              Text(
                                "${_homeController.selectedVpn.value.countryLong}",
                                style: CustomTextStyles.titleMediumBluegray700,
                              ),
                            if (_homeController
                                .selectedVpn.value.hostName.isEmpty)
                              Text("Optional Location",
                                  style: theme.textTheme.titleSmall),
                            SizedBox(height: 4.h),
                            if (_homeController
                                .selectedVpn.value.hostName.isNotEmpty)
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Text(
                                      "${_homeController.selectedVpn.value.ip}",
                                      style: CustomTextStyles
                                          .bodySmallBluegray70001,
                                    ),
                                    Container(
                                        height: 4.h,
                                        width: 4.h,
                                        margin: EdgeInsets.only(left: 6.h),
                                        decoration: BoxDecoration(
                                          color: appTheme.blueGray70001
                                              .withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            2.h,
                                          ),
                                        )),
                                    CustomImageView(
                                      imagePath: _homeController
                                          .getSpeedNetworkImage(_homeController
                                              .selectedVpn.value.speed),
                                      height: 8.h,
                                      width: 10.h,
                                      margin: EdgeInsets.only(left: 6.h),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text(
                                        formatBytes(
                                            _homeController
                                                .selectedVpn.value.speed,
                                            0),
                                        style: CustomTextStyles
                                            .bodySmallBluegray70001,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (_homeController
                                .selectedVpn.value.hostName.isEmpty)
                              Text("Not Connected",
                                  style:
                                      CustomTextStyles.bodySmallBluegray700a3)
                          ]),
                    ),
                    SizedBox(width: 16.h),
                    CustomImageView(
                      imagePath: 'assets/svg/arrow_right.svg',
                      height: 28.h,
                      width: 28.h,
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }

  /// Section Widget
  Widget _buildStatusSection(BuildContext context) {
    return Visibility(
      visible: _homeController.vpnState.value != VpnEngine.vpnDisconnected,
      child: IntrinsicHeight(
        child: SizedBox(
          height: 24.h,
          child: _homeController.vpnState.value != VpnEngine.vpnConnected
              ? Container(
                  decoration: AppDecoration.outlineTealA,
                  child: Text(
                    "${_homeController.vpnState.value.replaceAll('_', ' ').capitalizeFirst}",
                    textAlign: TextAlign.center,
                    style: _homeController.vpnState.value == VpnEngine.vpnReconnect ? CustomTextStyles.titleMediumInterYellow : CustomTextStyles.titleMediumInterBlue80001,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageView(
                      imagePath: 'assets/svg/checkmark_connected.svg',
                      height: 14.h,
                      width: 14.h,
                    ),
                    SizedBox(width: 4.h),
                    Container(
                      decoration: AppDecoration.outlineTealA,
                      child: Text(
                        "Connected",
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleMediumInterBlue80001,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSpeedSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 22.h),
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          left: 62.h,
          right: 70.h,
        ),
        child: StreamBuilder<VpnStatus?>(
            stream: vpnStatusStream,
            builder: (context, snapshot) {
              if (snapshot.data == null) return Container();
              print(snapshot.data!.byteIn);
              // Find matches
              RegExpMatch? downloadMatch =
                  regExp.firstMatch(snapshot.data!.byteIn.toString());

              // Group 1 is the number, Group 3 is the unit
              String? number = downloadMatch?.group(1)!; // 78.6
              String? unit = downloadMatch?.group(3)!; // kB

              RegExpMatch? uploadMatch =
                  regExp.firstMatch(snapshot.data!.byteOut.toString());

              // Group 1 is the number, Group 3 is the unit
              String? numberUpload = uploadMatch?.group(1)!;
              String? unitUpload = uploadMatch?.group(3)!;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    // width: 83.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: 'assets/svg/download_arrow.svg',
                          height: 18.h,
                          width: 18.h,
                          // margin: EdgeInsets.only(top: 6.h),
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Download",
                                  style:
                                      CustomTextStyles.bodySmallBluegray70004,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${number ?? "0"}",
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      SizedBox(width: 4.h),
                                      Text(
                                        "${unit ?? "kB"}",
                                        style: CustomTextStyles
                                            .bodySmallBluegray700048,
                                      )
                                    ],
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
                    height: 33.h, // Specify the height for the VerticalDivider
                    child: VerticalDivider(
                      color: Colors.black38,
                      thickness: 1,
                      width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 5.h,
                  ),
                  Flexible(
                    //width: 83.h,
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: 'assets/svg/upload_arrow.svg',
                          height: 18.h,
                          width: 18.h,
                        ),
                        SizedBox(width: 8.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upload",
                                style: CustomTextStyles.bodySmallBluegray70004,
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Text(
                                      "${numberUpload ?? "0"}",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    SizedBox(width: 4.h),
                                    Text(
                                      "${unitUpload ?? "kB"}",
                                      style: CustomTextStyles
                                          .bodySmallBluegray700048,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    )
        .animate()
        .animate(
            target: _homeController.vpnState.value == VpnEngine.vpnConnected
                ? 1
                : 0)
        .fadeIn(duration: Duration(milliseconds: 500)) // Fade in over 1 second
        .slide(
          begin: Offset(0, 1), // Start from below
          end: Offset(0, 0),
          curve: Curves.easeInOut, // End at original position
          duration: Duration(milliseconds: 700),
        );
  }
}
