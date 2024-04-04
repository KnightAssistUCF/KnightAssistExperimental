// Helpers
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../helpers/typedefs.dart';

class EventModel {
  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sponsoringOrganizationId,
    required this.registeredVolunteerIds,
    required this.profilePicPath,
    required this.startTime,
    required this.endTime,
    required this.checkedInVolunteers,
    required this.feedback,
    required this.eventTags,
    required this.semester,
    required this.maxAttendees,
    required this.s3ImageId,
  });

  final String id;
  final String name;
  final String description;
  final String location;
  final String sponsoringOrganizationId;
  final List<String> registeredVolunteerIds;
  String profilePicPath;
  final DateTime startTime;
  final DateTime endTime;
  final List<CheckedInVolunteerModel> checkedInVolunteers;
  final List<FeedbackModel> feedback;
  final List<String> eventTags;
  final String semester;
  final int maxAttendees;
  final String s3ImageId;

  static EventModel fromJson(JSON json) {
    return EventModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      sponsoringOrganizationId: json['sponsoringOrganization'] as String,
      registeredVolunteerIds: (json['registeredVolunteers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      profilePicPath: json['profilePicPath'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      checkedInVolunteers: (json['checkedInStudents'] as List<dynamic>)
          .map((e) =>
              CheckedInVolunteerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      feedback: (json['feedback'] as List<dynamic>)
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      eventTags:
          (json['eventTags'] as List<dynamic>).map((e) => e as String).toList(),
      semester: json['semester'] as String? ?? '',
      maxAttendees: json['maxAttendees'] as int,
      s3ImageId: json['S3BucketImageDetails'] as String,
    );
  }
}

class CheckedInVolunteerModel {
  CheckedInVolunteerModel({
    required this.id,
    required this.studentId,
    this.checkInTime,
    this.checkOutTime,
    required this.wereHoursAdjusted,
  });

  final String id;
  final String studentId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final bool wereHoursAdjusted;

  static CheckedInVolunteerModel fromJson(JSON json) {
    return CheckedInVolunteerModel(
        id: json['_id'] as String,
        studentId: json['studentId'] as String,
        checkInTime: (json['checkInTime'] != null)
            ? DateTime.parse(json['checkInTime'] as String)
            : null,
        checkOutTime: (json['checkOutTime'] != null)
            ? DateTime.parse(json['checkOutTime'] as String)
            : null,
        wereHoursAdjusted:
            json['wereHoursAdjusted_ForSudent_ForThisEvent'] as bool);
  }
}

class FeedbackModel {
  FeedbackModel({
    required this.id,
    required this.volunteerId,
    required this.eventId,
    required this.volunteerName,
    required this.volunteerEmail,
    required this.eventName,
    required this.rating,
    required this.content,
    required this.wasReadByUser,
    required this.timeSubmitted,
  });
  final String id;
  final String volunteerId;
  final String eventId;
  final String volunteerName;
  final String volunteerEmail;
  final String eventName;
  final num rating;
  final String content;
  final bool wasReadByUser;
  final DateTime timeSubmitted;

  static FeedbackModel fromJson(JSON json) {
    return FeedbackModel(
      id: json['_id'] as String,
      volunteerId: json['studentId'] as String,
      eventId: json['eventId'] as String,
      volunteerName: json['studentName'] as String,
      volunteerEmail: json['studentEmail'] as String,
      eventName: json['eventName'] as String,
      rating: json['rating'] as num,
      content: json['feedbackText'] as String,
      wasReadByUser: json['wasReadByUser'] as bool,
      timeSubmitted: DateTime.parse(json['timeFeedbackSubmitted'] as String),
    );
  }
}

class EventHistoryModel {
  EventHistoryModel({
    required this.id,
    required this.eventName,
    required this.orgName,
    required this.checkIn,
    required this.checkOut,
    required this.hours,
    required this.wasAdjusted,
    this.whoAdjusted,
    this.adjustedTotal,
  });

  final String id;
  final String eventName;
  final String orgName;
  final DateTime checkIn;
  final DateTime checkOut;
  final num hours;
  final bool wasAdjusted;
  final String? whoAdjusted;
  final num? adjustedTotal;

  static EventHistoryModel fromJson(JSON json) {
    String date = json['checkOut'][0].toString().replaceAll('/', '-');
    String time = json['checkOut'][1].toString();

    TimeOfDay fromString(String time) {
      int hh = 0;
      if (time.endsWith('PM')) hh = 12;
      time = time.split(' ')[0];
      return TimeOfDay(
        hour: hh +
            int.parse(time.split(":")[0]) %
                24, // in case of a bad time format entered manually by the user
        minute: int.parse(time.split(":")[1]) % 60,
      );
    }

    TimeOfDay checkOutTime = fromString(time);

    List<String> numbers = [];
    NumberFormat formatter = NumberFormat("00");

    for (String s in date.split('-')) {
      String formattedNumber = formatter.format(double.parse(s));
      numbers.add(formattedNumber);
    }

    String number = numbers.join('-');
    String str = number.split('-').reversed.join('-');
    String remove = number.replaceAll('-', '');

    DateTime checkOutDT = DateTime.parse(str);

    DateTime checkOutFull = DateTime(checkOutDT.year, checkOutDT.month,
        checkOutDT.day, checkOutTime.hour, checkOutTime.minute);

    // format dates from the event history api to be parsed in Dart DateTimes
    String dateCheckIn = json['checkIn'][0].toString().replaceAll('/', '-');
    String timeCheckIn = json['checkIn'][1].toString();
    List<String> numbersCheckIn = [];

    TimeOfDay checkInTime = fromString(timeCheckIn);

    for (String s in dateCheckIn.split('-')) {
      String formattedNumberCheckIn = formatter.format(double.parse(s));
      numbersCheckIn.add(formattedNumberCheckIn);
    }
    String numberCheckIn = numbersCheckIn.join('-');
    String strCheckIn = numberCheckIn.split('-').reversed.join('-');
    String removeCheckIn = numberCheckIn.replaceAll('-', '');

    DateTime checkInDT = DateTime.parse(strCheckIn);

    DateTime checkInFull = DateTime(checkInDT.year, checkInDT.month,
        checkInDT.day, checkInTime.hour, checkInTime.minute);

    return EventHistoryModel(
      id: json['ID'] as String,
      eventName: json['name'] as String,
      orgName: json['org'] as String,
      checkIn: checkInFull,
      checkOut: checkOutFull,
      hours: double.parse(json['hours'] as String),
      wasAdjusted: json['wasAdjusted'] as bool,
      whoAdjusted: json['whoAdjusted'] as String?,
      adjustedTotal: json['adjustedTotal'] as num?,
    );
  }
}
