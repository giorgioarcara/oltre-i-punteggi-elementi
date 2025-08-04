function Meta(meta)
  if meta.date == "today" then
    meta.date = os.date("%d %B %Y")  -- e.g., "04 August 2025"
  end
  return meta
end
