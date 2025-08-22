import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

String formatDateTimeHelper(String rawDateTime) {
  try {
    final dateTime = DateTime.parse(rawDateTime);
    final formattedDate = DateFormat("dd MMM yy").format(dateTime);
    final formattedTime = DateFormat("h:mm a").format(dateTime);
    return "$formattedDate · $formattedTime";
  } catch (e) {
    return rawDateTime;
  }
}

String formatDateHelper(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
}

bool isSameDate(DateTime d1, DateTime d2) {
  return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
}

String formatDateWithRelativeLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final entryDate = DateTime(date.year, date.month, date.day);
  final difference = today.difference(entryDate).inDays;

  String baseDate =
      "${date.day.toString().padLeft(2, '0')} "
      "${_monthShortName(date.month)} "
      "${date.year.toString().substring(2)}";
  if (difference < 0) {
    return baseDate;
  }
  String label;
  if (difference == 0) {
    label = "Today";
  } else if (difference == 1) {
    label = "Yesterday";
  } else if (difference < 7) {
    label = "$difference days ago";
  } else if (difference < 30) {
    final weeks = (difference / 7).floor();
    label = weeks == 1 ? "1 week ago" : "$weeks weeks ago";
  } else if (difference < 365) {
    final months = (difference / 30).floor();
    label = months == 1 ? "1 month ago" : "$months months ago";
  } else {
    final years = (difference / 365).floor();
    label = years == 1 ? "1 year ago" : "$years years ago";
  }
  return "$label · $baseDate";
}

String _monthShortName(int month) {
  const months = [
    "", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month];
}

/// Checks if the API server is reachable
/// Returns a map with isConnected status and errorMessage
Future<Map<String, dynamic>> checkApiConnectivity() async {
  try {
    // First check internet connectivity
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        return {
          'isConnected': false,
          'errorMessage': 'No internet connection. Please check your network settings.'
        };
      }
    } on SocketException catch (_) {
      return {
        'isConnected': false,
        'errorMessage': 'No internet connection. Please check your network settings.'
      };
    }
    
    // Then check API server connectivity using test_connection.php
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/test_connection.php'),
    ).timeout(const Duration(seconds: 5));
    
    if (response.statusCode == 200) {
      return {'isConnected': true, 'errorMessage': ''};
    } else {
      return {
        'isConnected': false,
        'errorMessage': 'Server error: ${response.statusCode}. Please try again later.'
      };
    }
  } catch (e) {
    return {
      'isConnected': false,
      'errorMessage': 'Cannot connect to server. Please check your connection or server address.'
    };
  }
}

String getMonthShortName(int month) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[month - 1];
}

String getInitials(String name) {
  if (name.trim().isEmpty) return '';

  List<String> words = name.trim().split(RegExp(r'\s+'));
  if (words.length >= 2) {
    return (words[0][0] + words[1][0]).toUpperCase();
  } else {
    return name.trim().substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

String formatAmount(String amount) {
  try {
    final number = double.parse(amount.replaceAll(',', ''));
    final absNumber = number.abs();
    final formatter = NumberFormat('#,##,##,###.##', 'en_IN');
    return formatter.format(absNumber);
  } catch (e) {
    return amount;
  }
}

String buildRelativeTime(String time) {
  try {
    final parsedDate = DateTime.parse(time);
    return formatDateWithRelativeLabel(parsedDate);
  } catch (e) {
    return time;
  }
}
