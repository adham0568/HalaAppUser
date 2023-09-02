import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/provider/CartProvider.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';
import '../../../../models/CartProvider.dart';
import '../../../../models/CloseWidget.dart';
import '../../Cart/CartPage.dart';
import 'PrudactRestaurant.dart';

class PrudactsRust extends StatefulWidget {
  Map DataFromMainCollection;

  PrudactsRust({super.key, required this.DataFromMainCollection});
  @override
  State<PrudactsRust> createState() => _PrudactsRustState();
}
String? numOfPrudacts;
class _PrudactsRustState extends State<PrudactsRust> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.DataFromMainCollection['Image'],
                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Center(child: CloseWidget(w: w,icon: false)),
            ),
            actions: [
              CartWidget(h: w*0.1, w: w*0.1),
            ],
          ),

          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, index) {
            if(index.isOdd){return GridViewRust(Prudact: widget.DataFromMainCollection,Swich: true,Uid: '',WhichPage: false,);}
            else{return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors:
                        [
                          Color.fromRGBO(56, 95, 172, 1),
                          Color.fromRGBO(1, 183, 168, 1)
                        ])),
                width: double.infinity,
                child: Center(child: Text(widget.DataFromMainCollection['Name'],
                  style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),)));}
          },childCount: 2 )),
        ],
      ),
    );
  }
}








