import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:vocherbbmt/pages/pdf.dart';
import 'package:vocherbbmt/provider/vocher_provider.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({super.key});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
  final dataProvider = Provider.of<VoucherProvider>(context,listen: false);
  String pdfNameFile = 'VOCHER BBM ${dataProvider.noVoucher}.pdf';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview PDF"),
        actions: [
          IconButton(
              onPressed: () {
                savePDFToFile(context);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: PdfPreview(
        allowPrinting: true,
        canDebug: false, //disable bottom switch
        canChangePageFormat: true,
        allowSharing: true,
        canChangeOrientation: false,
        onError: (context, error) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
              // overflow: TExtOv,
              // locale: ,
            'Error Gagal Menampilkan Preview pdf',
            style: TextStyle(
                color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),
          ),
            ],
          )
        ),
        useActions: true,
        pageFormats: {
          'A4': PdfPageFormat.a4,
          'Letter': PdfPageFormat.letter,
          'F4': PdfPageFormat(595, 935)
        },
        pdfFileName: pdfNameFile,
        build: (format) => generatePDF(context),
      ),
        
    
    );
  }
}

Future<void> savePDFToFile(BuildContext context) async {
  
  final dataProvider = Provider.of<VoucherProvider>(context,listen: false);
  String pdfNameFile = 'VOCHER BBM ${dataProvider.noVoucher}.pdf';
  try {

    Uint8List bytes = await generatePDF(context);

    // Minta izin akses penyimpanan dulu
    if (await Permission.storage.request().isGranted) {
      // Ambil direktori Download
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/${pdfNameFile}');

      // Simpan file PDF 
      await file.writeAsBytes(bytes);

      OpenFile.open(file.path);


      print('📂 PDF berhasil disimpan di: $file');
    } else {
      print('🚫 Izin penyimpanan ditolak!');
    }
  } catch (e) {
    print('❌ Error menyimpan PDF: $e');
  }
}

// Meminta izin untuk akses penyimpanan
Future<void> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    print("Izin diberikan");
  } else if (status.isDenied) {
    print("Izin ditolak");
  } else if (status.isPermanentlyDenied) {
    print("Izin secara permanen ditolak");
    openAppSettings();
  }
}
