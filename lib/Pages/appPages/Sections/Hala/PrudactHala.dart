import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halaapp/models/PrudactDesgineAnimation.dart';
import 'package:halaapp/provider/CartProvider.dart';
import 'package:halaapp/provider/TotalPrudact.dart';
import 'package:provider/provider.dart';

import '../../../../models/CartProvider.dart';
import '../../../../models/CloseWidget.dart';
import '../../Cart/CartPage.dart';

class PrudactPageForHalaMart extends StatefulWidget {
  Map DataFromCollection;

  PrudactPageForHalaMart({super.key, required this.DataFromCollection});
  @override
  State<PrudactPageForHalaMart> createState() => _PrudactPageForHalaMartState();
}
String? numOfPrudacts;
class _PrudactPageForHalaMartState extends State<PrudactPageForHalaMart> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    final Provaider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /*SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.DataFromCollection['ImageUrl'],
                placeholder: (context, url) => const CircularProgressIndicator(color: Colors.red),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            leading:
            actions: [

            ],
          ),*/
          SliverAppBar(expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                  imageUrl: widget.DataFromCollection['Image'],
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

          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
           if(index.isOdd){return GridView2(Prudact: widget.DataFromCollection);}
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
               child: Center(child: Text(widget.DataFromCollection['Name'],
                 style: const TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),)));}
          },childCount:2 )),
        ],
      ),
    );
  }
}








