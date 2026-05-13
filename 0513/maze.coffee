# 迷路サイズ
w = 15; h = 9
# 初期化（壁:1, 通路:0）
maze = [Array(w).fill(1) for _ in [0...h]]
# 移動方向（上下左右）
dirs = [[0,1],[1,0],[0,-1],[-1,0]]

# DFSで迷路生成
carve = (x, y) ->
  maze[y][x] = 0
  # 配列をランダムにシャッフル
  shuffled_dirs = dirs.sort -> Math.random() - 0.5
  for [dx, dy] in shuffled_dirs
    nx = x + dx*2; ny = y + dy*2
    if 0 <= ny < h and 0 <= nx < w and maze[ny][nx] is 1
      maze[y+dy][x+dx] = 0; carve nx, ny

# スタート位置
startX = 1; startY = 1; carve startX, startY

# ゴール位置
goalX = w-2; goalY = h-2
maze[startY][startX] = "S"; maze[goalY][goalX] = "G"

# 迷路表示
for row in maze
  line = ""
  for cell in row
    line += switch cell
      when 1 then "█"; when "S" then "S"
      when "G" then "G"; else "  "
  console.log line