import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FoodSearch extends StatelessWidget {
  final String value;

  FoodSearch({Key key, this.value}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Api Filter list Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new ExamplePage(value: value),
    );
  }
}

class ExamplePage extends StatefulWidget {
  final String value;

  ExamplePage({ Key key, this.value}) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Food Selection' );

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames("${widget.value}");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: new IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.portrait,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'user');
              // do something
            },
          )
        ]
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        print(filteredNames[i]);
        if (filteredNames[i].toLowerCase().contains(_searchText.toLowerCase())) {

          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
            title: Text(filteredNames[index]),
            onTap: () {
              print(filteredNames[index]);
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('test',arguments: filteredNames[index]);
            }
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Food Selection' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames(String keyword) async {
    final response = await dio.get('https://api.edamam.com/search?', queryParameters: {'q':keyword,'app_id':'0f173f2d','app_key':'7f7c43904a7d3d0c838e23c33fb29470'});
    print(response.data['hits'][2]['recipe']['label']);
    print(response.data['hits'].length);
    List tempList = new List();
    for (int i = 0; i < response.data['hits'].length; i++) {
      tempList.add(response.data['hits'][i]['recipe']['label']);
    }
    print(tempList);
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }


}

