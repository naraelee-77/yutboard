List<Integer> possMoves = new ArrayList<Integer>();  // list of possible moves, derived from yut throws
List<Shape> possSpaces = new ArrayList<Shape>();  // list of possible spaces from a specified space
List<List<Shape>> allSpaces = new ArrayList<List<Shape>>();  // table of every space and corresponding possible moves
boolean showSpaces;

// mapping of all spaces according to move value
int spaces[][] = {
  {0, 1, 2, 3, 4, 5, 19}, 
  {1, 2, 3, 4, 5, 6, 0}, 
  {2, 3, 4, 5, 6, 7, 1}, 
  {3, 4, 5, 6, 7, 8, 2}, 
  {4, 20, 21, 28, 22, 23, 3}, 
  {5, 6, 7, 8, 9, 10, 4}, 
  {6, 7, 8, 9, 10, 11, 5}, 
  {7, 8, 9, 10, 11, 12, 6}, 
  {8, 9, 10, 11, 12, 13, 7}, 
  {9, 24, 25, 28, 26, 27, 8}, 
  {10, 11, 12, 13, 14, 15, 9}, 
  {11, 12, 13, 14, 15, 16, 10}, 
  {12, 13, 14, 15, 16, 17, 11}, 
  {13, 14, 15, 16, 17, 18, 12}, 
  {14, 15, 16, 17, 18, 19, 13, 23}, 
  {15, 16, 17, 18, 19, 29, 14}, 
  {16, 17, 18, 19, 29, 29, 15}, 
  {17, 18, 19, 29, 29, 29, 16}, 
  {18, 19, 29, 29, 29, 29, 17}, 
  {19, 29, 29, 29, 29, 29, 18, 27}, 
  {20, 21, 28, 22, 23, 14, 4}, 
  {21, 28, 22, 23, 14, 15, 20}, 
  {22, 23, 14, 15, 16, 17, 28}, 
  {23, 14, 15, 16, 17, 18, 22}, 
  {24, 25, 28, 26, 27, 19, 9}, 
  {25, 28, 26, 27, 19, 29, 24}, 
  {26, 27, 19, 29, 29, 29, 28}, 
  {27, 19, 29, 29, 29, 29, 26}, 
  {28, 26, 27, 19, 29, 29, 25, 21}, 
  {29, 29, 29, 29, 29, 29, 19}, 
  {30, 0, 1, 2, 3, 4}, 
  {31, 0, 1, 2, 3, 4}, 
  {32, 0, 1, 2, 3, 4},
  {33, 0, 1, 2, 3, 4}
};

// translate all spaces from primitive array to ArrayList
void organize() {
  moves[0] = "";
  for (int i = 0; i < spaces.length - (4 - numPlayers); i++) {
    allSpaces.add(new ArrayList<Shape>());
    for (int space : spaces[i]) {
      allSpaces.get(allSpaces.size() - 1).add(shapes.get(space));
    }
  }
}