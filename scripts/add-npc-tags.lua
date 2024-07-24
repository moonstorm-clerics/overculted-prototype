-- data --------------------------------------------------------------

local tags = {
  -- Shared tags

  "idle",
  "idle_down", "idle_up", "idle_right",
  "run_down", "run_up", "run_right",

  "grabbed", "_thrown",

  -- "idle", "_jump", "_dead", "run", "air", "_knocked_back", "_dying",
  -- "_landed", "walk", "_jump", "_jump_kick",
  -- "_punch", "_punch_2", "_kick", "_punched", "_kicked",
  -- "_grab", "_grabbed", "_throw", "thrown", "_hit_ground", "_get_up",
}

local existing_tags = {}
for _,t in ipairs(app.sprite.tags) do
  existing_tags[t.name] = t
end

-- add-tags --------------------------------------------------------------

function add_tags()
  for _,t in ipairs(tags) do
    if existing_tags[t] == nil then
      local current_frame_num = app.frame.frameNumber
      local new_frame = app.sprite:newFrame(current_frame_num)
      local new_tag = app.sprite:newTag(new_frame.frameNumber, new_frame.frameNumber)
      new_tag.name = t
      new_tag.color = Color{r=255, g=128, b=32}
    end
  end
end

-- colorize tags --------------------------------------------------------------

local color_wheel = {
  Color{r=250, g=128, b=32}, -- orange
  -- Color{r=250, g=32, b=32}, -- red
  -- Color{r=32, g=250, b=32}, -- green
  -- Color{r=32, g=32, b=250}, -- blue
  Color{r=32, g=250, b=128}, -- ?
  Color{r=32, g=128, b=250}, -- ?
  Color{r=128, g=32, b=250}, -- ?
  Color{r=128, g=250, b=32}, -- ?
  Color{r=250, g=32, b=128}, -- ?
}

function colorize_tags()
  for i, t in ipairs(app.sprite.tags) do
    t.color = color_wheel[i % #color_wheel + 1]
  end
end

-- main --------------------------------------------------------------

app.transaction("add_some_tags", function()
  -- TODO first clone the current frame and move it to the end, so new tags/frames are created at the end
  -- BUG without this fix ^ a bunch of new frames are added to the 'current' animation
  add_tags()
  colorize_tags()
end)
