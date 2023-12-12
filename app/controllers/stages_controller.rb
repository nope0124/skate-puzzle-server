class StagesController < ApplicationController
  def new
    @stage = Stage.new
    if params[:gen].present?
      @num = params[:num].to_i
      dist, board = get_stage(@num)
      @dist = dist
      @stage.board = board
    end
  end

  def create
    @stage = Stage.new(stage_params)
    @stage.save
    redirect_to stages_path
  end

  def index
    @stages = Stage.all
  end

  def show
    @stage = Stage.find(params[:id])
  end

  def edit
    @stage = Stage.find(params[:id])
  end

  def update
    @stage = Stage.find(params[:id])
    @stage.update(stage_params)
    redirect_to stage_path(@stage.id)
  end

  private
  def stage_params
    params.require(:stage).permit(:board)
  end

  def solve(h, w, sx, sy, c)
    board = Array.new(h) { '.' * w }
    h.times do |i|
      w.times do |j|
        board[i][j] = c.chars.sample
      end
    end

    board[sy][sx] = 'S'
    board[h - 1][w - 1] = 'G'

    que = []
    dist = Array.new(h) { Array.new(w, -1) }
    dist[sy][sx] = 0
    que.push([sx, sy])

    while !que.empty?
      x, y = que.shift
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
        nx, ny = x, y
        loop do
          break if nx + dx < 0 || ny + dy < 0 || nx + dx >= w || ny + dy >= h
          break if board[ny + dy][nx + dx] == '#' || board[ny + dy][nx + dx] == 'x'
          if ['S', 'G', 'o'].include?(board[ny + dy][nx + dx])
            nx += dx
            ny += dy
            break
          end
          nx += dx
          ny += dy
        end
        if dist[ny][nx] == -1
          dist[ny][nx] = dist[y][x] + 1
          que.push([nx, ny])
        end
      end
    end
    [dist, board]
  end

  def get_stage(num)
    Random.srand(Time.now.to_i)
    c = "....................xx"
    h = w = num
    sx, sy = 0, 0
    gx, gy = h - 1, w - 1

    start_time = Time.now
    duration = 3.0
    border = 3

    loop do
      dist, board = solve(h, w, sx, sy, c)  # solveメソッドは適宜実装

      cnt = 0
      h.times do |i|
        w.times do |j|
          cnt += 1 if dist[i][j] != -1
        end
      end

      current_time = Time.now
      elapsed_time = current_time - start_time
      border = 4 if elapsed_time > duration
        
      next if cnt <= h * w / border || dist[gy][gx] <= h

      dist.each do |row|
        puts row.join(' ')
      end
      puts "\n"
      puts board
      board_string = board.map { |row| row }.join("\r\n")
      return dist[gy][gx], board_string
    end
  end
end
