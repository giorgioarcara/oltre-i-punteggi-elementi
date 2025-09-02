function Meta(meta)
  -- Update the standard date if it's "today"
  if meta.date == "today" then
    meta.date = os.date("%d %B %Y, %H:%M")
  end

  -- Add a separate key for the last rendered timestamp
  meta.todaytime = os.date("%d %B %Y, %H:%M")

  return meta
end