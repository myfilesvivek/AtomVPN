import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';

import '../theme/theme_helper.dart';

class CountDownTimer extends StatefulWidget {
  final String duration;
  CountDownTimer({super.key, required this.duration});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  String _durationString = "00:00:00"; // Initial value from server
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;


  int _prevHours = 0;
  int _prevMinutes = 0;
  int _prevSeconds = 0;


  void initState() {
    _fetchDurationFromServer();

    super.initState();
  }

  // Simulate fetching the duration string from the server
  void _fetchDurationFromServer() {
    Future.delayed(Duration(milliseconds: 0), () {
      // This is where you'd get the updated string from the server
      setState(() {
        _durationString = widget.duration; // Simulate new duration from server
        _updateTimeParts();
      });

      // Continue fetching the updated string from the server
      _fetchDurationFromServer();
    });
  }

  // Update the time parts (hours, minutes, seconds)
  void _updateTimeParts() {
    List<String> parts = _durationString.split(":");
    setState(() {
      int newHours = int.parse(parts[0]);
      int newMinutes = int.parse(parts[1]);
      int newSeconds = int.parse(parts[2]);

      // Update previous values only if they change
      if (newHours != _hours) {
        _prevHours = _hours;
        _hours = newHours;
      }

      if (newMinutes != _minutes) {
        _prevMinutes = _minutes;
        _minutes = newMinutes;
      }

      if (newSeconds != _seconds) {
        _prevSeconds = _seconds;
        _seconds = newSeconds;
      }
    });

  }

  // Widget to format and display the numbers as two-digit
  Widget _buildAnimatedCounter(int currentValue, int prevValue) {
    return   AnimatedFlipCounter(
      value: currentValue,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
     mainAxisAlignment: MainAxisAlignment.center,
      textStyle: theme.textTheme.displayMedium,
      wholeDigits: 2,
    );

    //   AnimatedFlipCounter(
    //   value: currentValue,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.easeInOut,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   textStyle: theme.textTheme.displayMedium,
    //   wholeDigits: 2, // Ensuring 2-digit format for the displayed numbers
    // );
  }


  // Text(
  // '${duration}',
  // textAlign: TextAlign.center,
  // style: theme.textTheme.displayMedium,
  // ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
       
        children: [
          // Hours
          Column(
            children: [
              _buildAnimatedCounter(_hours, _prevHours),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              ":",
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium,
            ),
          ), // Separator

          // Minutes
          Column(
            children: [
              _buildAnimatedCounter(_minutes, _prevMinutes),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              ":",
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium,
            ),
          ), // Separator

          // Seconds
          Column(
            children: [
              _buildAnimatedCounter(_seconds, _prevSeconds),
            ],
          ),
        ],
      ),
    );
  }
}
