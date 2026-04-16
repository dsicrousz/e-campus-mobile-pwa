import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrSection extends StatelessWidget {
  const QrSection({super.key, required this.compte});
  final Compte compte;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "qr_code",
      child: PrettyQrView.data(
        data: compte.code!,
        decoration: const PrettyQrDecoration(),
      ),
    );
  }
}
