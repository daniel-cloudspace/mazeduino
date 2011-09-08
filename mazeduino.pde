const int up = 0;
const int right = 1;
const int down = 2;
const int left = 3;

const int maze_width = 6;
const int maze_height = 6;

  
char maze_map[] = "\
 _ _ _ _ _ _ \
 A|_|_|_|_|_|\
| |   |_|_|_|\
|_ _| |_|   |\
|_|_| |_| | |\
|_|_|   | | |\
|_|_|_|_ _|B ";


int maze[maze_width][maze_height][4];
int x, y;
int endx, endy;
int orientation = right;

void setup() {
  /**
   * Parse the maze_map file into the maze variable.
   */
  int maze_map_width = maze_width*2+1;
  for(int row = 1; row <= maze_height; row++) {
    for(int column = 0; column < maze_width; column++) {
      // space[0] = top, space[1] = right, space[2] = bottom, space[3] = left
      maze[column][row-1][0] = ((maze_map[(row-1)*maze_map_width+column*2+1] == '_') ? 1 : 0);
      maze[column][row-1][1] = ((maze_map[row*maze_map_width+column*2+2] == '|') ? 1 : 0);
      maze[column][row-1][2] = ((maze_map[row*maze_map_width+column*2+1] == '_') ? 1 : 0);
      maze[column][row-1][3] = ((maze_map[row*maze_map_width+column*2] == '|') ? 1 : 0);
 
      if (maze[column][row-1][2] == 'A') {
        x = column;
        y = row-1;
      } 
      if (maze[column][row-1][2] == 'B') {
        endx = column;
        endy = row-1;
      }
    }
  }
  
  /**
   * Set interrupts for buttons
   */
  attachInterrupt(0, turn_left, FALLING);
  attachInterrupt(1, forward, FALLING);
  attachInterrupt(2, turn_right, FALLING);
}

void loop() {
  
}

void forward() {
  
}
void turn_left() {
  orientation--;
  if (orientation < 0) orientation = 4;
}
void turn_right() {
  orientation = (orientation + 1) % 4; 
}
