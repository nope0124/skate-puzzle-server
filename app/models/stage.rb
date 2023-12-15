class Stage < ApplicationRecord
  has_many :user_stage_progresses

  validate :square_board
  validate :can_solve

  private

  def square_board
    board_array = board.split("\r\n")
    length = board_array.length
    s_flag = false
    g_flag = false
  
    board_array.each_with_index do |row, i|
      unless row.length == length
        errors.add(:base, 'ステージは正方形でなければなりません')
        return
      end
  
      row.chars.each_with_index do |char, j|
        unless ['.', 'x', 'o', 'S', 'G', '@'].include?(char)
          errors.add(:base, "不正な文字が含まれています: #{char}")
        end
  
        if char == 'S'
          if s_flag
            errors.add(:base, '複数のスタート地点があります')
          else
            s_flag = true
          end
        end
  
        if char == 'G'
          if g_flag
            errors.add(:base, '複数のゴール地点があります')
          else
            g_flag = true
          end
        end
      end
    end
    errors.add(:base, 'スタート地点がありません') unless s_flag
    errors.add(:base, 'ゴール地点がありません') unless g_flag
  end

  def can_solve
    board_array = board.split("\r\n")
    length = board_array.length
    
    w = h = length
    sx = sy = nil
    gx = gy = nil
    board_array.each_with_index do |row, y|
      x = row.index('S')
      if x
        sx, sy = x, y
        break
      end
    end

    board_array.each_with_index do |row, y|
      x = row.index('G')
      if x
        gx, gy = x, y
        break
      end
    end

    if sx.nil? or gx.nil?
      errors.add(:base, 'スタートまたはゴール地点がありません')
      return
    end

    que = []
    dist = Array.new(length) { Array.new(length, -1) }
    dist[sy][sx] = 0
    que.push([sx, sy])

    while !que.empty?
      x, y = que.shift
      [[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
        nx, ny = x, y
        loop do
          break if nx + dx < 0 || ny + dy < 0 || nx + dx >= w || ny + dy >= h
          break if board_array[ny + dy][nx + dx] == '#' || board_array[ny + dy][nx + dx] == 'x'
          if ['S', 'G', 'o'].include?(board_array[ny + dy][nx + dx])
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
    if dist[gy][gx] == -1
      errors.add(:base, 'ゴールできません')
    end
  end
end
