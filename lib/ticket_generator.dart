import 'dart:math';

class ListGenerator{
  static int rows = 3;
  static int cols = 9;
  static List<List<String>> generateTicketList(){
    ListGenerator generator = new ListGenerator();
    List<List<String>> ticket = generator.populateList();
    List<List<int>> numbersUsed = [[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1],[-1,-1,-1]];
    Random rand = new Random();
    for(int row = 0; row<rows;row++){
      for(int col = 0; col < cols; col++){
        if(ticket[row][col] == '*'){
          bool numberChosen = false;
          while(!numberChosen){
            int additer = rand.nextInt(10);
            bool numberAlreadyChosen = false;
            for(int i=0;i<3;i++){
              if(additer == numbersUsed[col][i]){
                numberAlreadyChosen = true;
                break;
              }
            }
            if(numberAlreadyChosen)
              continue;
            ticket[row][col] = (col*10 + additer + 1).toString();
            numbersUsed[col][row] = additer;
            numberChosen = true;
          }
        }
      }
    }
    return ticket;
  }
  List<List<String>> populateList(){
    List<List<String>> ticket = [['','','','','','','','',''],
      ['','','','','','','','',''],
      ['','','','','','','','','']];
    const int rowMax = 5;
    int rowFilled;
    Random rand = new Random();
    for(int row=0;row<rows;row++){
      rowFilled = 0;
      int col = 0;
      while(rowFilled != rowMax){
        if(col == cols)
        {
          col = 0;
          continue;
        }
        if(ticket[row][col] == '*') {
          col++;
          continue;
        }
        bool shouldPopulate = rand.nextBool();
        if(shouldPopulate){
          ticket[row][col] = '*';
          rowFilled++;
        }
        col++;
      }
    }
    return ticket;
  }
}