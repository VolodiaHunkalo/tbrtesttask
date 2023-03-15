import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.phone,
    required this.choosenCountry,
  });

  final String? phone;
  final String choosenCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: phone!.length == 14
            ? Colors.white
            : const Color.fromRGBO(244, 245, 245, 0.4),
      ),
      child: FloatingActionButton(
        onPressed: phone!.length == 14
            ? () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        height: 180,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My congratulations, you successfully added phone number for country $choosenCountry',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Okay"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            : null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: Center(
          child: Icon(Icons.arrow_forward,
              color: phone!.length == 14
                  ? const Color.fromRGBO(89, 76, 116, 1)
                  : const Color.fromRGBO(120, 134, 184, 1)),
        ),
      ),
    );
  }
}
