import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:vocherbbmt/provider/vocher_provider.dart';
import 'package:intl/intl.dart';

String formatRupiah(num value) {
  final formater =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  return formater.format(value);
}

Future<Uint8List> generatePDF(BuildContext ctx) async {
  final pdf = pw.Document();
  final dataProvider = Provider.of<VoucherProvider>(ctx, listen: false);

  num hargaFormated = dataProvider.jumlah;
  String formtedJumlah = formatRupiah(hargaFormated);

  pw.Widget buildVoucher(PdfColor headerColor, String yangme) {
    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Table(
            border: pw.TableBorder.all(width: 1),
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: headerColor),
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text(
                      'Voucher Pengisian BBM',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.Table(
            border: pw.TableBorder.all(width: 1),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '* Lembar Untuk Yang $yangme ',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('No.Vocher'),
                          pw.SizedBox(width: 65),
                          pw.Text(': BBM/${dataProvider.noVoucher}/2025'),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('Tanggal'),
                          pw.SizedBox(width: 79),
                          pw.Text(': ${dataProvider.getFormatedDate().toString()} '),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('Minggu Ke'),
                          pw.SizedBox(width: 65),
                          pw.Text(': ${dataProvider.mingguKe} '),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('Kendaraan'),
                          pw.SizedBox(width: 64),
                          pw.Text(': Mobil'),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('No Pol'),
                          pw.SizedBox(width: 86),
                          pw.Text(': ${dataProvider.nopol}'),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text('Jumlah'),
                          pw.SizedBox(width: 84),
                          pw.Text(': ${formtedJumlah}'),
                        ]),
                        pw.SizedBox(height: 30),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          children: [
                            pw.Text('Yang Mengajukan'),
                            pw.SizedBox(width: 40),
                            pw.Text('Yang Mengetahui'),
                            pw.SizedBox(width: 40),
                            pw.Text('Yang Menyetujui'),
                          ],
                        ),
                        pw.SizedBox(height: 60),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          children: [
                            pw.Text('${dataProvider.mengajukan}'),
                            pw.SizedBox(width: 40),
                            pw.Text('${dataProvider.mengetahui}'),
                            pw.SizedBox(width: 40),
                            pw.Text('${dataProvider.menyetujui}'),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: [
          buildVoucher(
              PdfColors.green800, 'Mengajukan'), // Voucher pertama warna hijau
          pw.SizedBox(height: 20),
          pw.Divider(height: 10),
          pw.SizedBox(height: 20),
          buildVoucher(
              PdfColors.yellow, 'Menyetujui'), // Voucher kedua warna kuning
        ],
      ),
    ),
  );

  return pdf.save();
}
