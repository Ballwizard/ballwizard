import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette, ColorPicker;
import 'package:flutter/material.dart';

/// Calculates the best way to display a certain upload date
///
/// Example: if the video was uploaded 50 hours ago it will be simplified / rounded to 2 days ago
String calculateBestDateFormat(DateTime targetDate) {
  // dateDifference is in milliseconds, so we have to convert it to a nicer format
  int dateDifference =
      DateTime.timestamp().difference(targetDate).inMilliseconds;

  // time spans in milliseconds
  const TO_YEARS = 1000 * 3600 * 24 * 365;
  const TO_MONTHS = TO_YEARS / 12;
  const TO_WEEKS = TO_MONTHS / 4;
  const TO_DAYS = TO_WEEKS / 7;
  const TO_HOURS = TO_DAYS / 24;
  const TO_MINUTES = TO_HOURS / 60;

  // time spans and their names
  List<Map<String, dynamic>> timeSpans = [
    {"duration": TO_YEARS, "name": "year"},
    {"duration": TO_MONTHS, "name": "month"},
    {"duration": TO_WEEKS, "name": "week"},
    {"duration": TO_DAYS, "name": "day"},
    {"duration": TO_HOURS, "name": "hour"},
    {"duration": TO_MINUTES, "name": "minute"},
  ];

  // this loop iterates for every time span and finds the optimal time span format to display to the user
  for (int i = 0; i < timeSpans.length; i++) {
    // select a time span from timeSpans
    Map<String, dynamic> timeSpan = timeSpans[i];

    if (dateDifference / timeSpan["duration"] > 0.67) {
      // calculate rounded duration in every time span in timeSpans
      int timeValue = (dateDifference / timeSpan["duration"]).round();

      // return in format = value time_span_name/s ago (for example 12 minutes ago)
      return "$timeValue ${timeValue == 1 ? timeSpan["name"] : timeSpan["name"] + "s"} ago";
    }
  }
  // if video was uploaded less than 40.2 seconds ago (none of the above conditions were met), it will display as a few seconds ago
  return "few seconds ago";
}

class CardElement extends StatelessWidget {
  final String title;
  final int views;
  final DateTime dateOfCreation;
  final FundamentalVariant variant;
  final String? thumbnail;
  final bool large;

  const CardElement({
    super.key,
    required this.title,
    required this.views,
    required this.dateOfCreation,
    //required this.markdown,
    this.variant = FundamentalVariant.light,
    this.thumbnail,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool useLightFont = variant == FundamentalVariant.dark;

    return FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.66,
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.66 * 2 / 3,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15), bottom: Radius.zero),
                      color: Colors.black),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.66 * 1 / 3,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(15)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Fonts.medium,
                          ),
                          Row(
                            children: [
                              Text(views.toString() + " views",
                                  style: Fonts.smallLight),
                              Text(" - ", style: Fonts.smallLight),
                              Text(calculateBestDateFormat(DateTime.utc(2022)),
                                  style: Fonts.smallLight),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
