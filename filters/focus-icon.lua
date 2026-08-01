local ICON_HEIGHT = "1.5em"
local ICON_RAISE = "-0.5em"  -- negativo = abbassa, positivo = alza (LaTeX e HTML)

function Header(el)
  if el.level == 2 then
    local text = pandoc.utils.stringify(el.content)
    if text:match("^Focus:") then
      local offset = quarto.project.offset or "."
      local icon_path = offset .. "/Figures/target.png"

      if FORMAT:match("latex") then
        local icon = pandoc.RawInline("latex",
          "\\raisebox{" .. ICON_RAISE .. "}{\\includegraphics[height=" .. ICON_HEIGHT .. "]{" .. icon_path .. "}}")
        el.content:insert(1, pandoc.Space())
        el.content:insert(1, icon)
      else
        local valign = FORMAT:match("epub") and "middle" or ICON_RAISE
        local icon = pandoc.Image({}, icon_path, "", {
          height = ICON_HEIGHT,
          style = "vertical-align:" .. valign .. "; margin-right:0.35em;"
        })
        el.content:insert(1, pandoc.Space())
        el.content:insert(1, icon)
      end
    end
  end
  return el
end
