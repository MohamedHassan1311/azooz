import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/client_trips_provider.dart';

class MeshoarHistoryScreen extends StatelessWidget {
  const MeshoarHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ClientTripsProvider>();
    print("### Meshoar history ###");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meshoar History",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          Consumer<ClientTripsProvider>(
            builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 170,
                      child: Card(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 223, 237, 249)
                            : const Color.fromARGB(255, 243, 219, 217),
                        child: const ListTile(
                          title: Text("value.trips[index].name"),
                          subtitle: Text("value.trips[index].date"),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
