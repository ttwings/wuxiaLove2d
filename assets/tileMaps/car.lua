return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 5,
  height = 5,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "cdda.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../Graphics/Tilesets/tiles.png",
      imagewidth = 512,
      imageheight = 6272,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 3136,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "块层 1",
      x = 0,
      y = 0,
      width = 5,
      height = 5,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 2885, 0, 0,
        0, 0, 2933, 0, 0,
        0, 0, 3011, 0, 0,
        0, 0, 2885, 0, 0,
        0, 0, 0, 0, 0
      }
    }
  }
}
