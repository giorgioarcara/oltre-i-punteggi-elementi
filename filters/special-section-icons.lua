local ICON_HEIGHT = "1.5em"
local ICON_RAISE = "-0.5em"  -- negativo = abbassa, positivo = alza (LaTeX e HTML)

local ICONS = {
  { prefix = "Focus:", file = "target.png" },
  { prefix = "Nella pratica clinica:", file = "clinical_practice.png" },
  { prefix = "Errori comuni:", file = "error_warning.png" },
}

function Header(el)
  if el.level == 2 then
    local text = pandoc.utils.stringify(el.content)
    for _, entry in ipairs(ICONS) do
      if text:sub(1, #entry.prefix) == entry.prefix then
        local offset = quarto.project.offset or "."
        local icon_path = offset .. "/Figures/" .. entry.file

        if FORMAT:match("latex") then
          local icon = pandoc.Image({}, icon_path, "", { height = ICON_HEIGHT })
          el.content:insert(1, pandoc.Space())
          el.content:insert(1, pandoc.RawInline("latex", "}"))
          el.content:insert(1, icon)
          el.content:insert(1, pandoc.RawInline("latex", "\\raisebox{" .. ICON_RAISE .. "}{"))
        else
          local valign = FORMAT:match("epub") and "middle" or ICON_RAISE
          local icon = pandoc.Image({}, icon_path, "", {
            class = "special-section-icon",
            height = ICON_HEIGHT,
            style = "vertical-align:" .. valign .. "; margin-right:0.35em;"
          })
          el.content:insert(1, pandoc.Space())
          el.content:insert(1, icon)
        end
        break
      end
    end
  end
  return el
end
