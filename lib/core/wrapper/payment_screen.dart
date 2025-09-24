import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart'; // استدعاء مكتبة المفرقعات

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  bool isObscure = true;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cvvController.dispose();
    nameController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  String? getCardTypeImage(String number) {
    if (number.startsWith('4')) return 'assets/visa.png';
    if (number.startsWith('5')) return 'assets/mastercard.png';
    return null;
  }

  void submitPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // بداية تشغيل الانفجارات
      _confettiController.play();

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        _confettiController.stop();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Your payment was completed successfully."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardTypeImage = getCardTypeImage(cardNumberController.text);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Info"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/dWVtU0E9.jpg',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 25),
                  if (cardTypeImage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(cardTypeImage, height: 40),
                    ),
                  TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    decoration: const InputDecoration(
                      labelText: "Card Number",
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.length != 16
                        ? "Enter 16-digit card number"
                        : null,
                    onChanged: (value) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: "CVV",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () => setState(() => isObscure = !isObscure),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    validator: (value) =>
                        value!.length < 3 ? "Enter valid CVV" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Cardholder Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter cardholder name" : null,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : submitPayment,
                    icon: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.payment),
                    label: Text(isLoading ? "Processing..." : "Pay Now"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // مفرقعات على الشاشة
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive, // تناثر في كل الاتجاهات
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple
              ], // ألوان المفرقعات
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              maxBlastForce: 20,
              minBlastForce: 10,
            ),
          ),
        ],
      ),
    );
  }
}
