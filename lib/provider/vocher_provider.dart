import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class VoucherProvider with ChangeNotifier {
  String noVoucher = '';
  DateTime tanggal = DateTime.now();
  String mingguKe = '';
  String kendaraan = '';
  String nopol = '';
  double jumlah = 0.0;
  String mengajukan = '';
  String mengetahui = '';
  String menyetujui = '';


  void updateVoucher(
      {
      required String noVoucher,
      required String mingguKe,
      required String kendaraan,
      required String nopol,
      required double jumlah,
      required String mengajukan,
      required String mengetahui,
      required String menyetujui}) {
    this.noVoucher = noVoucher;
    this.mingguKe = mingguKe;
    this.kendaraan = kendaraan;
    this.nopol = nopol;
    this.jumlah = jumlah;
    this.mengajukan = mengajukan;
    this.mengetahui = mengetahui;
    this.menyetujui = menyetujui;
    notifyListeners();
  }

  String getFormatedDate(){
    return DateFormat('dd-MM-yyyy').format(tanggal);
  }
}
