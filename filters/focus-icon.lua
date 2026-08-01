function Header(el)
  if el.level == 2 then
    local text = pandoc.utils.stringify(el.content)
    if text:match("^Focus:") then
      local offset = quarto.project.offset or "."
      local icon_path = offset .. "/Figures/target.png"
      local icon = pandoc.Image({}, icon_path, "", {
        height = "1.5em",
        style = "vertical-align:-0.25em; margin-right:0.35em;"
      })
      el.content:insert(1, pandoc.Space())
      el.content:insert(1, icon)
    end
  end
  return el
end
