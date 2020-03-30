module HomeHelper

  def chart_colors
    {
      waiting_start: ["#c6d9ec", "#b3b3ff", "#eeeedd", "#e0ebeb", "#e5e5cc", "#e0ebeb", "#c6d9ec","#9fbfdf", "#6666ff", "#d4d4aa", "#a3c2c2", "#cccc99", "#a3c2c2", "#8cb3d9"],
      in_progress: ["#00ffcc", "#0066ff", "#6600ff", "#99ff66", "#33cccc", "#ff4dff", "#66ccff","#4dffdb", "#3385ff", "#8533ff", "#77ff33", "#47d1d1", "#ff99ff", "#0099e6"],
      delayed: ["#ff471a", "#ff1a75", "#ff3333", "#cc0000", "#ff1a66", "#ff0055", "#d147a3","#e62e00", "#ff0066", "#ff0000", "#990000", "#b3003b", "#b3003b", "#b82e8a"]
    }
  end

end
