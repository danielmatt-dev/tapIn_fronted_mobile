import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScreen extends StatefulWidget {
  const NFCScreen({super.key});

  @override
  State<NFCScreen> createState() => _NFCScreenState();
}

class _NFCScreenState extends State<NFCScreen> {
  List<String> messages = [];

  void _startSession() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);
      if (ndef == null || ndef.cachedMessage == null) {
        setState(() {
          messages = ['No NDEF data'];
        });
        return;
      }

      final records = ndef.cachedMessage!.records;
      final decodedMessages = records.map((record) {
        final payload = record.payload;

        return utf8.decode(payload.sublist(3));
      }).toList();

      setState(() {
        messages = decodedMessages;
      });

      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leer NFC')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...messages.map((m) => Text(m)),
            ElevatedButton(
              onPressed: _startSession,
              child: const Text('Leer tarjeta NFC'),
            ),
          ],
        ),
      ),
    );
  }
}