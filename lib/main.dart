import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool mapToggle=false;
  Position currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePosition();
  }

  void updatePosition(){
    Geolocator().getCurrentPosition().then((currLoc){
      setState(() {
        currentLocation=currLoc;
        mapToggle=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: new FloatingActionButton(onPressed:(){
          setState(() {
            updatePosition();
          });
        },
        child: new Icon(Icons.my_location),
          tooltip: 'Actualizar su posición',
        ),
        appBar: new AppBar(title: new Text('Mapa PUCP')),
        body: mapToggle?
        new FlutterMap(
            options: new MapOptions(
                center:
                new LatLng(-12.0693438,-77.08),
                minZoom: 10.0,
                zoom:16.0
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                  "https://api.mapbox.com/styles/v1/flavioontaneda/cjss9ud8aad211fs869s2p535/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZmxhdmlvb250YW5lZGEiLCJhIjoiY2pzczlrc2dwMXFrdTN5cGdvOTJsdnR2dCJ9.BsRlclChRI961I1slYzxUQ",
                  additionalOptions: {
                    'accesToken':'pk.eyJ1IjoiZmxhdmlvb250YW5lZGEiLCJhIjoiY2pzczlrc2dwMXFrdTN5cGdvOTJsdnR2dCJ9.BsRlclChRI961I1slYzxUQ',
                    //'id':'mapbox.mapbox-streets-v7'
                  }
              ),
              new MarkerLayerOptions(
                  markers: [
                    new Marker(
                        width: 45.0,
                        height: 45.0,
                        point: new LatLng(-12.072713, -77.079550),
                        builder: (BuildContext context){
                          return new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45.0,
                              onPressed: (){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Aulario PUCP"),backgroundColor: Theme.of(context).primaryColor,));
                                //print('Marker Tapped');
                              },
                            ),
                          );
                        }
                    ),
                    new Marker(
                        width: 45.0,
                        height: 45.0,
                        point: new LatLng(-12.072146, -77.080153),
                        builder: (BuildContext context){
                          return new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45.0,
                              onPressed: (){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Complejo de Innovación Académica"),
                                  backgroundColor: Theme.of(context).primaryColor,));
                                //print('Marker Tapped');
                              },
                            ),
                          );
                        }
                    ),
                    new Marker(
                        width: 25.0,
                        height: 25.0,
                        point: new LatLng(currentLocation.latitude,currentLocation.longitude),
                        builder: (BuildContext context){
                          return new Container(
                            child: IconButton(
                              icon: Icon(Icons.person_pin_circle),
                              color: Colors.blueAccent,
                              iconSize: 25.0,
                              onPressed: (){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Usted está aquí"),
                                  backgroundColor: Theme.of(context).primaryColor,));
                                //print('Marker Tapped');
                              },
                            ),
                          );
                        }
                    )
                  ]
              )
            ]):
        new Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
