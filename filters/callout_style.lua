-- Darkens callout-note boxes in PDF output:
--   title bar: opacity 0.6 → 0.9, tint !10! → !20!
--   body background: transparent → !5! tint
function RawBlock(el)
  if el.format ~= "latex" then return el end
  if not el.text:find("\\begin{tcolorbox}", 1, true) then return el end
  if not el.text:find("colframe=quarto-callout-note-color-frame", 1, true) then return el end

  el.text = el.text:gsub("opacitybacktitle=0%.6", "opacitybacktitle=0.9")
  el.text = el.text:gsub(
    "colbacktitle=quarto%-callout%-note%-color!10!white",
    "colbacktitle=quarto-callout-note-color!20!white"
  )
  el.text = el.text:gsub("colback=white", "colback=quarto-callout-note-color!5!white")
  el.text = el.text:gsub("opacityback=0", "opacityback=1")
  return el
end
