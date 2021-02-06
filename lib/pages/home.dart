import 'package:band_names/models/band_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bandas = [
    Band(id: '1', name: 'Therion', votes: 5),
    Band(id: '2', name: 'Metallica', votes: 3),
    Band(id: '3', name: 'Epica', votes: 7),
    Band(id: '4', name: 'The doors', votes: 6),
    Band(id: '5', name: 'Rolling stones', votes: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarCustom(),
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (BuildContext context, int index) {
          return bandTile(bandas[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addNewBand();
        },
      ),
    );
  }

  // ========================== AppBar de la aplicación =======================
  Widget _appBarCustom() {
    return AppBar(
      elevation: 2.0,
      title: Text(
        'Band Names',
        style: TextStyle(color: Colors.black87),
      ),
      backgroundColor: Colors.white,
    );
  }

  // ======================== ListTile de las bandas ==========================
  Widget bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.red,
        ),
        child: Row(
          children: [
            Icon(Icons.delete, size: 28, color: Colors.white),
            Text(
              'Eliminar',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            banda.name.substring(0, 2),
          ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.name),
        trailing: Text(
          '${banda.votes}',
          style: TextStyle(fontSize: 20.0),
        ),
        onTap: () {
          print(banda.name);
        },
      ),
    );
  }

  // Función para agregar bandas
  addNewBand() {
    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nombre de banda:'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textController.text),
              child: Text('Agregar'),
              elevation: 3,
            )
          ],
        );
      },
    );
  }

  // Función para enviar los datos del inputDialog
  void addBandToList(String name) {
    if (name.length > 0) {
      this.bandas.add(
            new Band(
              id: DateTime.now().toString(),
              name: name,
              votes: 5,
            ),
          );
    }

    setState(() {});
    Navigator.pop(context);
  }
}
