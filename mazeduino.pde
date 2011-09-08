#define fwd_btn A0
#define left_btn A1
#define right_btn A2
#define fwd_led 12
#define left_led 13
#define right_led 11

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
  
  pinMode(fwd_led, OUTPUT);
  pinMode(left_led, OUTPUT);
  pinMode(right_led, OUTPUT);
  pinMode(fwd_btn, INPUT);
  pinMode(left_btn, INPUT);
  pinMode(right_btn, INPUT);
  
  update_display();
}

void loop() {
  if (digitalRead(fwd_btn) == HIGH) {
    forward();
    update_display();
  } else if (digitalRead(left_btn) == HIGH) {
    turn_left();
  } else if (digitalRead(right_btn) == HIGH) {
    turn_right();
  }
  
}

void update_display() {
  int forward = maze[x][y][orientation];
  int left = maze[x][y][(orientation+4)%4];
  int right = maze[x][y][(orientation+1)%4];
  digitalWrite(fwd_led, forward ? HIGH : LOW);
  digitalWrite(left_led, left ? HIGH : LOW);
  digitalWrite(right_led, right ? HIGH : LOW);
}

void forward() {
  if (orientation == up && y > 0 && maze[x][y][0] == 0) y--;
  if (orientation == right && x < maze_width && maze[x][y][1] == 0) x++;
  if (orientation == down && y < maze_height && maze[x][y][2] == 0) y++;
  if (orientation == left && x > 0 && maze[x][y][3] == 0) x--;
}
void turn_left() {
  orientation = (orientation + 4) % 4;
}
void turn_right() {
  orientation = (orientation + 1) % 4; 
}
