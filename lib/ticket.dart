import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget{
  final List<List<String>> gridState;
  final String name;
  Ticket({
    @required this.gridState,
    this.name,
  }) :  assert(gridState != null);

  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket>{
  @override
  Widget build(BuildContext context) {
    return _buildTicketBody();
  }
  Widget _buildTicketBody(){
    const int gridStateBreadth = 9;
    const int gridStateLength = 3;
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16.0/6.0,
          child:  Center(
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridStateBreadth),
              itemBuilder: _buildGridItems,
              itemCount: gridStateBreadth * gridStateLength,
            ),
          ),

        ),
        Center(
          child: Text(widget.name, style: TextStyle(fontSize: 30),),
        )
      ],
    );
  }
  Widget _buildGridItems(BuildContext context, int index){
    const int gridStateBreadth = 9;
    int x = (index / gridStateBreadth).floor();
    int y = (index % gridStateBreadth);
    return GestureDetector(
      onTap: (){

      },
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Center(
                child: _buildGridItem(x, y, constraints),
              );
            },
          ),
        ),
      ),
    );
  }
  Widget _buildGridItem(int x, int y, BoxConstraints constraints){
    String character = widget.gridState[x][y];
    if(character == '*')
    {
      return Icon(Icons.clear, size: constraints.maxWidth,);
    }
    else if(character == ''){
      return Text('');
    }
    else{
      return Text(character, style: TextStyle(
        fontSize: constraints.maxWidth/2,
      ),);
    }
  }
}