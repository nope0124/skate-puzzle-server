module ApplicationHelper
    def display_stage(board)
        html_output = ""
        arrays = board.split("\r\n")
        arrays.each do |array|
            array.each_char do |char|
                file_name = "NotFloor.PNG"
                if char == "."
                    file_name = "IceFloor.PNG"
                elsif char == "x"
                    file_name = "IceBlock.PNG"
                elsif char == "o"
                    file_name = "SnowFloor.PNG"
                elsif char == "S"
                    file_name = "PenguinOnSnowFloor.PNG"
                elsif char == "G"
                    file_name = "GoalFloor.PNG"
                elsif char == "@"
                    file_name = "SnowBall.PNG"
                end
                html_output += image_tag(file_name)
            end
            html_output += "<br>"
        end
        html_output.html_safe
    end
end
