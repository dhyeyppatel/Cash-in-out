import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/helper.dart';

class TestConnectionScreen extends StatefulWidget {
  const TestConnectionScreen({Key? key}) : super(key: key);

  @override
  _TestConnectionScreenState createState() => _TestConnectionScreenState();
}

class _TestConnectionScreenState extends State<TestConnectionScreen> {
  bool _isLoading = false;
  String _resultMessage = '';
  bool _isSuccess = false;

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _resultMessage = '';
      _isSuccess = false;
    });

    try {
      // First check connectivity
      final connectivityResult = await checkApiConnectivity();
      
      if (!connectivityResult['isConnected']) {
        setState(() {
          _isLoading = false;
          _resultMessage = connectivityResult['errorMessage'];
          _isSuccess = false;
        });
        return;
      }
      
      // Test the connection to the test endpoint
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/test_connection.php'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _isLoading = false;
          _resultMessage = 'Connection successful! Server time: ${data['timestamp']}';
          _isSuccess = true;
        });
      } else {
        setState(() {
          _isLoading = false;
          _resultMessage = 'Server error: ${response.statusCode}';
          _isSuccess = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _resultMessage = 'Error: ${e.toString().replaceAll('Exception: ', '')}';
        _isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test API Connection'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current API URL:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                Constants.baseUrl,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _testConnection,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Test Connection'),
              ),
              SizedBox(height: 30),
              if (_resultMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isSuccess ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _isSuccess ? Icons.check_circle : Icons.error,
                        color: _isSuccess ? Colors.green : Colors.red,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        _resultMessage,
                        style: TextStyle(
                          color: _isSuccess ? Colors.green.shade900 : Colors.red.shade900,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}