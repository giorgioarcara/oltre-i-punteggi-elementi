-- Rende in LaTeX un blocco Div {.citazione} (epigrafe/citazione fuori testo)
-- come ambiente "citazione" e uno Span {.attribuzione} al suo interno come
-- riga di attribuzione allineata a destra sotto la citazione.

function Div(el)
  if el.classes:includes("citazione") then
    if FORMAT:match("latex") then
      local result = {pandoc.RawBlock("latex", "\\begin{citazione}")}
      for _, block in ipairs(el.content) do
        table.insert(result, block)
      end
      table.insert(result, pandoc.RawBlock("latex", "\\end{citazione}"))
      return result
    end
  end
  return el
end

function Span(el)
  if el.classes:includes("attribuzione") then
    if FORMAT:match("latex") then
      local result = {pandoc.RawInline("latex", "\\citeattrib{")}
      for _, inline in ipairs(el.content) do
        table.insert(result, inline)
      end
      table.insert(result, pandoc.RawInline("latex", "}"))
      return result
    end
  end
  return el
end
