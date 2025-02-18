import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocherbbmt/pages/pdf_page.dart';
import 'package:vocherbbmt/provider/vocher_provider.dart';

class InputPage extends StatefulWidget {
  InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController vocherController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController mingguController = TextEditingController();
  final TextEditingController kendaraanControlle = TextEditingController();
  final TextEditingController nopolController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController mengajukanController = TextEditingController();
  final TextEditingController mengetahuiController = TextEditingController();
  final TextEditingController menyetujuiController = TextEditingController();

  String? iselected;
  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  final List<String> dataKendaran = [
    'Mobil',
    'Motor',
  ];
  final List<String> dataNopol = [
    'BN 1729 WN',
    'A 8660 ZS',
  ];

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<VoucherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('INPUT BBM'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              MyTextField(
                keyboartType: TextInputType.number,
                controller: vocherController,
                titleLabel: 'No.Vocher',
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                keyboartType: TextInputType.number,
                controller: mingguController,
                titleLabel: 'Minggu Ke',
              ),
              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.all(1.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(
                          
                        ), // Ini akan memberi border standar
                    enabledBorder: OutlineInputBorder(
                      
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  hint: Text('Pilih Nomor Polisi'),
                  isExpanded: true,
                  value: iselected,
                  onChanged: (value) {
                    setState(() {
                      iselected = value;
                      nopolController.text = value.toString();
                      print(nopolController);
                    });
                  },
                  items: dataNopol
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e'),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                keyboartType: TextInputType.number,
                controller: jumlahController,
                titleLabel: 'Jumlah',
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                keyboartType: TextInputType.name,
                controller: mengajukanController,
                titleLabel: 'Yang Mengajukan',
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                keyboartType: TextInputType.name,
                controller: mengetahuiController,
                titleLabel: 'Yang Mengetahui',
              ),
              SizedBox(
                height: 15,
              ),
              MyTextField(
                keyboartType: TextInputType.name,
                controller: menyetujuiController,
                titleLabel: 'Yang Menyetujui',
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (() {
                      vocherController.clear();
                      tanggalController.clear();
                      mingguController.clear();
                      kendaraanControlle.clear();
                      nopolController.clear();
                      jumlahController.clear();
                      mengajukanController.clear();
                      mengetahuiController.clear();
                      menyetujuiController.clear();
                    }),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        double harga =
                            double.tryParse(jumlahController.text) ?? 0.0;
                        dataProvider.updateVoucher(
                            noVoucher: vocherController.text,
                            mingguKe: mingguController.text,
                            kendaraan: kendaraanControlle.text,
                            nopol: nopolController.text,
                            jumlah: harga,
                            mengajukan: mengajukanController.text,
                            mengetahui: mengetahuiController.text,
                            menyetujui: menyetujuiController.text);
                        print('generate Data');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PDFViewerPage(),
                            ));
                      },
                      child: Text("Generate & Preview")),
                ],
              ),
              SizedBox(height: 40,),
              Text('Powered by Jibran', style: TextStyle(color: Colors.grey, ),)
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  String titleLabel;
  late TextEditingController controller;
  TextInputType keyboartType;
  MyTextField({
    required this.keyboartType,
    required this.controller,
    required this.titleLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboartType,
      textCapitalization: TextCapitalization.characters,
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
          label: Text(titleLabel),
          hintText: 'Masukan $titleLabel di sini',
          labelStyle: TextStyle(),
          border: OutlineInputBorder()),
    );
  }
}
