import 'package:flutter/material.dart';
import 'package:catalog/local_data/models/orderModel.dart';
import 'package:catalog/local_data/models/vinylModel.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailPage extends StatefulWidget {
  final VinylModel vinylModel;

  const DetailPage({super.key, required this.vinylModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController textAddressReader = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();

  int counter = 1;
  int _selectedConditionIndex = 0;
  bool isPlaying = false;

  @override
  void dispose() {
    textAddressReader.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  String get album => widget.vinylModel.albumName;
  String get artist => widget.vinylModel.artist;
  double get price => widget.vinylModel.price;
  String get image => widget.vinylModel.image;
  String get desc => widget.vinylModel.description;
  List<String> get conditions => widget.vinylModel.conditions;

  void _togglePlay() async {
    try {
      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play(AssetSource(widget.vinylModel.previewUrl));
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    } catch (e) {
      print("Ошибка при проигрывании файла: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Не удалось найти файл в ассетах")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1a1a),
      appBar: AppBar(
          backgroundColor: const Color(0xff2d2d2d),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.amber)),
          title: const Text('Vinyl Details', style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoVinylDescription(),
              const SizedBox(height: 16),
              audioPreview(),
              const SizedBox(height: 24),
              const Text("Condition:", style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              conditionSelector(),
              const SizedBox(height: 24),
              counterProduct(),
              const SizedBox(height: 24),
              makeOrder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoVinylDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)))),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(album, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(artist, style: const TextStyle(fontSize: 16, color: Colors.amber)),
                  const SizedBox(height: 10),
                  Text("\$${price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 22, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Text(desc, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget audioPreview() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
            color: Colors.amber,
            iconSize: 42,
            onPressed: _togglePlay,
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Listen Preview", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("30 sec sample", style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget conditionSelector() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: conditions.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return ChoiceChip(
              label: Text(conditions[index]),
              selected: _selectedConditionIndex == index,
              onSelected: (val) => setState(() => _selectedConditionIndex = index),
              selectedColor: Colors.amber,
              labelStyle: TextStyle(color: _selectedConditionIndex == index ? Colors.black : Colors.white),
            );
          }),
    );
  }

  Widget counterProduct() {
    return Row(children: [
      const Text("Quantity: ", style: TextStyle(color: Colors.white)),
      IconButton(icon: const Icon(Icons.remove, color: Colors.amber), onPressed: () => setState(() { if(counter > 1) counter--; })),
      Text("$counter", style: const TextStyle(color: Colors.white, fontSize: 18)),
      IconButton(icon: const Icon(Icons.add, color: Colors.amber), onPressed: () => setState(() => counter++)),
    ]);
  }

  Widget makeOrder() {
    return Column(
      children: [
        TextField(
          controller: textAddressReader,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Delivery Address',
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                if (textAddressReader.text.isEmpty) return;

                OrderModel order = OrderModel(
                    nameProduct: "$artist - $album",
                    countProduct: counter,
                    sumProduct: price * counter,
                    speciecLevel: conditions[_selectedConditionIndex],
                    clientAdress: textAddressReader.text);

                _showConfirmationDialog(order);
              },
              child: const Text('BUY NOW', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }

  void _showConfirmationDialog(OrderModel order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff2d2d2d),
        title: const Text('Confirm', style: TextStyle(color: Colors.white)),
        content: Text('Buy ${order.nameProduct} for \$${order.sumProduct.toStringAsFixed(2)}?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(onPressed: () async {
            Navigator.pop(context);
            try {
              await audioPlayer.play(AssetSource('music/confirmed.mp3'));}catch (e){print('Ошибка звука подтверждения!: $e');
            }
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Your order is confirmed!'),
            backgroundColor: Colors.green,),
            );
            },
            child: const Text('Yes', style: TextStyle(color: Colors.amber))),
        ],
      ),
    );
  }
}