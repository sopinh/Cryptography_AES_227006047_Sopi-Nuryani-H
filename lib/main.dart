import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ctrlText = TextEditingController();
final ctrlKey = TextEditingController();

var cipherText = 'null';
var plainText = 'null';
encrypt.Encrypted? encrypted;

//  final key = encrypt.Key.fromSecureRandom(32);
var key = encrypt.Key.fromUtf8(ctrlKey.text);
// var encrypter = encrypt.Encrypter(encrypt.AES(key));
var iv = encrypt.IV.fromSecureRandom(16);

Encrypter getEncrypter() {
  return encrypt.Encrypter(encrypt.AES(key));
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void encryptText(String text) {
    final plainText = text;
    encrypted = getEncrypter().encrypt(plainText, iv: iv);

    cipherText = encrypted!.base64;
    debugPrint('CipherText');
    setState(() {});
    // debugPrint(encrypted.base64);
    debugPrint(cipherText);
  }

  void decryptText() {
    final decrypted = getEncrypter().decrypt(encrypted!, iv: iv);
    plainText = decrypted;
    debugPrint('PlainText');

    setState(() {});
    debugPrint(decrypted);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '227006047 - Sopi Nuryani H',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 157, 203, 241),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 100, 165),
          title: Center(
            child: Text(
              'AES 32',
              style: GoogleFonts.breeSerif(fontSize: 30),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Welcome!',
                  style: GoogleFonts.vollkorn(fontSize: 25),
                ),
                const SizedBox(height: 8),
                const Text('AES (Advanced Encryption Standard) merupakan algoritma kriptografi modern simetris'),
                const SizedBox(height: 10),

                Container(
                  color: const Color.fromARGB(255, 82, 153, 210),
                  child: const Column(
                    children: [
                      Text('Note: Untuk melakukan enkripsi harus mengisi Secret Key sebanyak 32 karakter.'),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: ctrlText,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Plaintext',
                      hintText: 'Masukkan text yang akan dienkripsi',
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: ctrlKey,
                    maxLength: 32,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Secret Key',
                      hintText: 'Masukkan secret key',
                    ),
                    onChanged: (value) {
                      key = encrypt.Key.fromUtf8(value);
                      // encrypter = encrypt.Encrypter(encrypt.AES(key));
                      // debugPrint(key.base64.toString());
                      // debugPrint(value.toString());
                      setState(() {});
                      const Spacer();
                    },
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: (ctrlText.text.isNotEmpty) && (ctrlKey.text.length == 32)
                            ? () {
                                encryptText(ctrlText.text);
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 30, 108, 171),
                          disabledBackgroundColor: const Color.fromARGB(255, 91, 162, 221),
                        ),
                        child: Text(
                          "Encrypt",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Untuk memberi jarak antara tombol
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () {
                          decryptText();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 30, 108, 171),
                        ),
                        child: Text(
                          "Decrypt",
                          style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white70)),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 20),
                // Text(encrypt.Key.fromUtf8(ctrlKey.text).base64),
                // const SizedBox(height: 20),
                // Text(iv.base64),
                // const SizedBox(height: 20),
                const Spacer(),
                Container(
                  color: const Color.fromARGB(255, 131, 184, 227),
                  width: 1000,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        'Encrypt Result:',
                        style: GoogleFonts.roboto(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ciphertext: $cipherText',
                        style: GoogleFonts.acme(),
                        textScaler: const TextScaler.linear(1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: const Color.fromARGB(255, 131, 184, 227),
                  width: 1000,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text('Decrypt Result:', style: GoogleFonts.roboto()),
                      const SizedBox(height: 20),
                      Text(
                        'Plaintext: $plainText',
                        style: GoogleFonts.acme(),
                        textScaler: const TextScaler.linear(1.5),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
