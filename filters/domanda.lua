function Div(el)
  if el.classes:includes("domanda") then
    if FORMAT:match("latex") then
      local result = {pandoc.RawBlock("latex", "\\begin{domanda}")}
      for _, block in ipairs(el.content) do
        table.insert(result, block)
      end
      table.insert(result, pandoc.RawBlock("latex", "\\end{domanda}"))
      return result
    end
  end
  return el
end
