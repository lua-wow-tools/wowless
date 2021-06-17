local function mixin(t, ...)
  for _, kv in ipairs({...}) do
    for k, v in pairs(kv) do
      t[k] = v
    end
  end
  return t
end

local function tappend(t, t2)
  for _, v in ipairs(t2) do
    table.insert(t, v)
  end
  return t
end

local function preprocess(tree)
  local newtree = {}
  for k, v in pairs(tree) do
    local attrs = mixin({}, v.attributes)
    local kids = tappend({}, v.children or {})
    local supertypes = { [k] = true }
    local text = v.text
    local t = v
    while t.extends do
      supertypes[t.extends] = true
      t = tree[t.extends]
      mixin(attrs, t.attributes)
      tappend(kids, t.children or {})
      text = text or t.text
    end
    newtree[k] = mixin({}, v, {
      attributes = attrs,
      children = kids,
      supertypes = supertypes,
      text = text,
    })
  end
  return newtree
end

local lang = preprocess({
  absdimension = {
    attributes = {
      x = {
        required = true,
        type = 'number',
      },
      y = {
        required = true,
        type = 'number',
      },
    },
  },
  absinset = {
    attributes = {
      bottom = {
        type = 'number',
      },
      left = {
        type = 'number',
      },
      right = {
        type = 'number',
      },
      top = {
        type = 'number',
      },
    },
  },
  absvalue = {
    attributes = {
      val = {
        type = 'number',
      },
    },
  },
  actor = {
    attributes = {
      mixin = {
        type = 'string',
      },
      name = {
        type = 'string',
      },
      virtual = {
        type = 'bool',
      },
    },
    children = {
      'scripts',
    },
  },
  alpha = {
    attributes = {
      fromalpha = {
        type = 'number',
      },
      toalpha = {
        type = 'number',
      },
    },
    extends = 'animation',
  },
  anchor = {
    attributes = {
      point = {
        type = 'string',
      },
      relativekey = {
        type = 'string',
      },
      relativepoint = {
        type = 'string',
      },
      relativeto = {
        type = 'string',
      },
      x = {
        type = 'number',
      },
      y = {
        type = 'number',
      },
    },
    children = {
      'offset',
    },
  },
  anchors = {
    children = {
      'anchor',
    },
  },
  animationgroup = {
    attributes = {
      looping = {
        type = 'string',
      },
      settofinalalpha = {
        type = 'bool',
      },
    },
    children = {
      'animation',
      'scripts',
    },
    extends = 'layoutframe',
  },
  animation = {
    attributes = {
      childkey = {
        type = 'string',
      },
      duration = {
        type = 'number',
      },
      enddelay = {
        type = 'number',
      },
      order = {
        type = 'number',
      },
      parentkey = {
        type = 'string',
      },
      smoothing = {
        type = 'string',
      },
      startdelay = {
        type = 'number',
      },
      target = {
        type = 'string',
      },
    },
    children = {
      'keyvalues',
      'scripts',
    },
  },
  animations = {
    children = {
      'animationgroup',
    },
  },
  attribute = {
    attributes = {
      name = {
        type = 'string',
      },
      type = {
        type = 'string',
      },
      value = {
        type = 'string',
      },
    },
  },
  attributes = {
    children = {
      'attribute',
    },
  },
  backdrop = {
    attributes = {
      edgefile = {
        type = 'string',
      },
      tile = {
        type = 'bool',
      },
    },
    children = {
      'edgesize',
    },
  },
  barcolor = {
    extends = 'color',
  },
  bartexture = {
    extends = 'texture',
  },
  binding = {
    attributes = {
      category = {
        type = 'string',
      },
      custombindingid = {
        type = 'string',
      },
      debug = {
        type = 'bool',
      },
      default = {
        type = 'string',
      },
      header = {
        type = 'string',
      },
      hidden = {
        type = 'bool',
      },
      name = {
        type = 'string',
      },
      runonup = {
        type = 'bool',
      },
    },
    text = true,
  },
  bindings = {
    children = {
      'binding',
      'modifiedclick',
    },
  },
  blingtexture = {
    extends = 'texture',
  },
  browser = {
    attributes = {
      imefont = {
        type = 'string',
      },
    },
    extends = 'frame',
  },
  button = {
    attributes = {
      motionscriptswhiledisabled = {
        type = 'bool',
      },
      registerforclicks = {
        type = 'stringlist',
      },
      text = {
        type = 'string',
      },
    },
    children = {
      'buttonfont',
      'buttontext',
      'disabledtexture',
      'highlighttexture',
      'normaltexture',
      'pushedtextoffset',
      'pushedtexture',
    },
    extends = 'frame',
  },
  buttonfont = {
    attributes = {
      justifyh = {
        type = 'string',
      },
      style = {
        type = 'string',
      },
    },
    virtual = true,
  },
  buttontext = {
    extends = 'fontstring',
  },
  checkbutton = {
    attributes = {
      checked = {
        type = 'bool',
      },
    },
    children = {
      'checkedtexture',
      'disabledcheckedtexture',
    },
    extends = 'button',
  },
  checkedtexture = {
    extends = 'texture',
  },
  checkout = {
    attributes = {
      imefont = {
        type = 'string',
      },
    },
    extends = 'frame',
  },
  cinematicmodel = {
    extends = 'frame',
  },
  color = {
    attributes = {
      a = {
        type = 'number',
      },
      b = {
        type = 'number',
      },
      color = {
        type = 'string',
      },
      g = {
        type = 'number',
      },
      r = {
        type = 'number',
      },
    },
  },
  colorselect = {
    children = {
      'colorvaluetexture',
      'colorvaluethumbtexture',
      'colorwheeltexture',
      'colorwheelthumbtexture',
    },
    extends = 'frame',
  },
  colorvaluetexture = {
    extends = 'texture',
  },
  colorvaluethumbtexture = {
    extends = 'texture',
  },
  colorwheeltexture = {
    extends = 'texture',
  },
  colorwheelthumbtexture = {
    extends = 'texture',
  },
  containedalertframe = {
    -- TODO support as an intrinsic instead
    extends = 'button',
  },
  controlpoint = {
    attributes = {
      offsetx = {
        type = 'number',
      },
      offsety = {
        type = 'number',
      },
    },
  },
  controlpoints = {
    children = {
      'controlpoint',
    },
  },
  cooldown = {
    attributes = {
      drawedge = {
        type = 'bool',
      },
      hidecountdownnumbers = {
        type = 'bool',
      },
      reverse = {
        type = 'bool',
      },
    },
    children = {
      'blingtexture',
      'edgetexture',
      'swipetexture',
    },
    extends = 'frame',
  },
  dimension = {
    children = {
      'absdimension',
    },
    virtual = true,
  },
  disabledcheckedtexture = {
    extends = 'texture',
  },
  disabledfont = {
    extends = 'buttonfont',
  },
  disabledtexture = {
    extends = 'texture',
  },
  dressupmodel = {
    attributes = {
      modelscale = {
        type = 'number',
      },
    },
    extends = 'frame',
  },
  dropdowntogglebutton = {
    -- TODO intrinsic
    extends = 'button',
  },
  edgesize = {
    extends = 'value',
  },
  edgetexture = {
    extends = 'texture',
  },
  editbox = {
    attributes = {
      autofocus = {
        type = 'bool',
      },
      bytes = {
        type = 'number',
      },
      countinvisibleletters = {
        type = 'bool',
      },
      historylines = {
        type = 'number',
      },
      ignorearrows = {
        type = 'bool',
      },
      invisiblebytes = {
        type = 'number',
      },
      letters = {
        type = 'number',
      },
      multiline = {
        type = 'bool',
      },
      numeric = {
        type = 'bool',
      },
      visiblebytes = {
        type = 'number',
      },
    },
    children = {
      'fontstring',
      'highlightcolor',
    },
    extends = 'frame',
  },
  eventbutton = {
    -- TODO intrinsic
    extends = 'button',
  },
  eventeditbox = {
    -- TODO intrinsic
    extends = 'editbox',
  },
  eventframe = {
    -- TODO intrinsic
    extends = 'frame',
  },
  fogofwarframe = {
    extends = 'frame',
  },
  font = {
    attributes = {
      filter = {
        type = 'bool',
      },
      fixedsize = {
        type = 'bool',
      },
      font = {
        type = 'string',
      },
      height = {
        type = 'number',
      },
      inherits = {
        type = 'string',
      },
      justifyh = {
        type = 'string',
      },
      justifyv = {
        type = 'string',
      },
      monochrome = {
        type = 'bool',
      },
      name = {
        type = 'string',
      },
      outline = {
        type = 'string',
      },
      spacing = {
        type = 'number',
      },
      virtual = {
        type = 'bool',
      },
    },
    children = {
      'color',
      'shadow',
    },
  },
  fontfamily = {
    attributes = {
      name = {
        type = 'string',
      },
      virtual = {
        type = 'bool',
      },
    },
    children = {
      'member',
    },
  },
  fontheight = {
    extends = 'value',
  },
  fontstring = {
    -- TODO deal with font mixin
    attributes = {
      font = {
        type = 'string',
      },
      justifyh = {
        type = 'string',
      },
      justifyv = {
        type = 'string',
      },
      maxlines = {
        type = 'number',
      },
      nonspacewrap = {
        type = 'bool',
      },
      spacing = {
        type = 'number',
      },
      text = {
        type = 'string',
      },
      wordwrap = {
        type = 'bool',
      },
    },
    children = {
      'color',
      'fontheight',
      'shadow',
    },
    extends = 'layoutframe',
  },
  frame = {
    attributes = {
      clampedtoscreen = {
        type = 'bool',
      },
      clipchildren = {
        type = 'bool',
      },
      debugid = {
        type = 'number',
      },
      dontsaveposition = {
        type = 'bool',
      },
      enablekeyboard = {
        type = 'bool',
      },
      enablemouse = {
        type = 'bool',
      },
      enablemouseclicks = {
        type = 'bool',
      },
      enablemousemotion = {
        type = 'bool',
      },
      enablemousewheel = {
        type = 'bool',
      },
      flattenrenderlayers = {
        type = 'bool',
      },
      framelevel = {
        type = 'number',
      },
      framestrata = {
        type = 'string',
      },
      hyperlinksenabled = {
        type = 'bool',
      },
      id = {
        type = 'number',
      },
      intrinsic = {
        type = 'bool',
      },
      movable = {
        type = 'bool',
      },
      parent = {
        type = 'string',
      },
      propagatehyperlinkstoparent = {
        type = 'bool',
      },
      protected = {
        type = 'bool',
      },
      resizable = {
        type = 'bool',
      },
      toplevel = {
        type = 'bool',
      },
      securemixin = {
        type = 'string',
      },
      useparentlevel = {
        type = 'bool',
      },
    },
    children = {
      'animations',
      'attributes',
      'backdrop',
      'frames',
      'hitrectinsets',
      'layers',
      'resizebounds',
      'scripts',
      'titleregion',
    },
    extends = 'layoutframe',
  },
  frames = {
    children = {
      'frame',
    },
  },
  gametooltip = {
    extends = 'frame',
  },
  gradient = {
    attributes = {
      orientation = {
        type = 'string',
      },
    },
    children = {
      'maxcolor',
      'mincolor',
    },
  },
  highlightcolor = {
    extends = 'color',
  },
  highlightfont = {
    extends = 'buttonfont',
  },
  highlighttexture = {
    extends = 'texture',
  },
  hitrectinsets = {
    attributes = {
      bottom = {
        type = 'number',
      },
      left = {
        type = 'number',
      },
      right = {
        type = 'number',
      },
      top = {
        type = 'number',
      },
    },
    children = {
      'absinset',
    },
  },
  include = {
    attributes = {
      file = {
        required = true,
        type = 'string',
      },
    },
  },
  keyvalue = {
    attributes = {
      key = {
        type = 'string',
      },
      type = {
        type = 'string',
      },
      value = {
        type = 'string',
      },
    },
  },
  keyvalues = {
    children = {
      'keyvalue',
    },
  },
  layer = {
    attributes = {
      level = {
        required = true,
        type = 'string',
      },
      texturesublevel = {
        type = 'number',
      },
    },
    children = {
      'fontstring',
      'line',
      'texture',
    },
  },
  layers = {
    children = {
      'layer',
    },
  },
  layoutframe = {
    attributes = {
      alpha = {
        type = 'number',
      },
      hidden = {
        type = 'bool',
      },
      ignoreparentalpha = {
        type = 'bool',
      },
      ignoreparentscale = {
        type = 'bool',
      },
      inherits = {
        type = 'stringlist',
      },
      mixin = {
        type = 'stringlist',
      },
      name = {
        type = 'string',
      },
      parentarray = {
        type = 'string',
      },
      parentkey = {
        type = 'string',
      },
      scale = {
        type = 'number',
      },
      setallpoints = {
        type = 'bool',
      },
      virtual = {
        type = 'bool',
      },
    },
    children = {
      'anchors',
      'color',
      'keyvalues',
      'size',
    },
    virtual = true,
  },
  line = {
    attributes = {
      alphamode = {
        type = 'string',
      },
      atlas = {
        type = 'string',
      },
      thickness = {
        type = 'number',
      },
    },
    extends = 'layoutframe',
  },
  linescale = {
    attributes = {
      fromscalex = {
        type = 'number',
      },
      fromscaley = {
        type = 'number',
      },
      toscalex = {
        type = 'number',
      },
      toscaley = {
        type = 'number',
      },
    },
    children = {
      'origin',
    },
    extends = 'animation',
  },
  maskedtexture = {
    attributes = {
      childkey = {
        type = 'string',
      },
    },
  },
  maskedtextures = {
    children = {
      'maskedtexture',
    },
  },
  masktexture = {
    attributes = {
      hwrapmode = {
        type = 'string',
      },
      vwrapmode = {
        type = 'string',
      },
    },
    children = {
      'maskedtextures',
    },
    extends = 'texture',
  },
  maxcolor = {
    extends = 'color',
  },
  maxresize = {
    extends = 'dimension',
  },
  member = {
    attributes = {
      alphabet = {
        type = 'string',
      },
    },
    children = {
      'font',
    },
  },
  messageframe = {
    attributes = {
      displayduration = {
        type = 'number',
      },
      fadeduration = {
        type = 'number',
      },
      fadepower = {
        type = 'number',
      },
      insertmode = {
        type = 'string',
      },
    },
    children = {
      'fontstring',
    },
    extends = 'frame',
  },
  mincolor = {
    extends = 'color',
  },
  minimap = {
    extends = 'frame',
  },
  minresize = {
    extends = 'dimension',
  },
  modelscene = {
    children = {
      'viewinsets',
    },
    extends = 'frame',
  },
  modifiedclick = {
    attributes = {
      action = {
        type = 'string',
      },
      default = {
        type = 'string',
      },
    },
  },
  movieframe = {
    extends = 'frame',
  },
  normalfont = {
    extends = 'buttonfont',
  },
  normaltexture = {
    extends = 'texture',
  },
  offscreenframe = {
    extends = 'frame',
  },
  offset = {
    attributes = {
      x = {
        type = 'number',
      },
      y = {
        type = 'number',
      },
    },
    children = {
      'absdimension',
    },
  },
  onarrowpressed = {
    extends = 'scripttype',
  },
  onattributechanged = {
    extends = 'scripttype',
  },
  onbuttonupdate = {
    extends = 'scripttype',
  },
  onchar = {
    extends = 'scripttype',
  },
  onclick = {
    extends = 'scripttype',
  },
  oncolorselect = {
    extends = 'scripttype',
  },
  oncursorchanged = {
    extends = 'scripttype',
  },
  ondisable = {
    extends = 'scripttype',
  },
  ondoubleclick = {
    extends = 'scripttype',
  },
  ondragstart = {
    extends = 'scripttype',
  },
  ondragstop = {
    extends = 'scripttype',
  },
  ondressmodel = {
    extends = 'scripttype',
  },
  oneditfocusgained = {
    extends = 'scripttype',
  },
  oneditfocuslost = {
    extends = 'scripttype',
  },
  onenable = {
    extends = 'scripttype',
  },
  onenter = {
    extends = 'scripttype',
  },
  onenterpressed = {
    extends = 'scripttype',
  },
  onerror = {
    extends = 'scripttype',
  },
  onescapepressed = {
    extends = 'scripttype',
  },
  onevent = {
    extends = 'scripttype',
  },
  onexternallink = {
    extends = 'scripttype',
  },
  onfinished = {
    extends = 'scripttype',
  },
  ongamepadbuttondown = {
    extends = 'scripttype',
  },
  ongamepadbuttonup = {
    extends = 'scripttype',
  },
  onhide = {
    extends = 'scripttype',
  },
  onhyperlinkclick = {
    extends = 'scripttype',
  },
  onhyperlinkenter = {
    extends = 'scripttype',
  },
  onhyperlinkleave = {
    extends = 'scripttype',
  },
  oninputlanguagechanged = {
    extends = 'scripttype',
  },
  onkeydown = {
    extends = 'scripttype',
  },
  onkeyup = {
    extends = 'scripttype',
  },
  onleave = {
    extends = 'scripttype',
  },
  onload = {
    extends = 'scripttype',
  },
  onmodelcleared = {
    extends = 'scripttype',
  },
  onmodelloaded = {
    extends = 'scripttype',
  },
  onmousedown = {
    extends = 'scripttype',
  },
  onmoviefinished = {
    extends = 'scripttype',
  },
  onmoviehidesubtitle = {
    extends = 'scripttype',
  },
  onmovieshowsubtitle = {
    extends = 'scripttype',
  },
  onmouseup = {
    extends = 'scripttype',
  },
  onmousewheel = {
    extends = 'scripttype',
  },
  onplay = {
    extends = 'scripttype',
  },
  onreceivedrag = {
    extends = 'scripttype',
  },
  onrequestnewsize = {
    extends = 'scripttype',
  },
  onscrollrangechanged = {
    extends = 'scripttype',
  },
  onshow = {
    extends = 'scripttype',
  },
  onsizechanged = {
    extends = 'scripttype',
  },
  onspacepressed = {
    extends = 'scripttype',
  },
  onstop = {
    extends = 'scripttype',
  },
  ontabpressed = {
    extends = 'scripttype',
  },
  ontextchanged = {
    extends = 'scripttype',
  },
  ontextset = {
    extends = 'scripttype',
  },
  ontooltipaddmoney = {
    extends = 'scripttype',
  },
  ontooltipcleared = {
    extends = 'scripttype',
  },
  ontooltipsetdefaultanchor = {
    extends = 'scripttype',
  },
  ontooltipsetframestack = {
    extends = 'scripttype',
  },
  ontooltipsetitem = {
    extends = 'scripttype',
  },
  ontooltipsetspell = {
    extends = 'scripttype',
  },
  ontooltipsetunit = {
    extends = 'scripttype',
  },
  onupdate = {
    extends = 'scripttype',
  },
  onvaluechanged = {
    extends = 'scripttype',
  },
  onverticalscroll = {
    extends = 'scripttype',
  },
  origin = {
    attributes = {
      point = {
        type = 'string',
      },
    },
    children = {
      'offset',
    },
  },
  path = {
    attributes = {
      curve = {
        type = 'string',
      },
    },
    children = {
      'controlpoints',
    },
    extends = 'animation',
  },
  playermodel = {
    extends = 'frame',
  },
  postclick = {
    extends = 'scripttype',
  },
  preclick = {
    extends = 'scripttype',
  },
  pushedtextoffset = {
    extends = 'dimension',
  },
  pushedtexture = {
    extends = 'texture',
  },
  rect = {
    attributes = {
      llx = {
        type = 'number',
      },
      lly = {
        type = 'number',
      },
      lrx = {
        type = 'number',
      },
      lry = {
        type = 'number',
      },
      ulx = {
        type = 'number',
      },
      uly = {
        type = 'number',
      },
      urx = {
        type = 'number',
      },
      ury = {
        type = 'number',
      },
    },
  },
  resizebounds = {
    children = {
      'maxresize',
      'minresize',
    },
  },
  rotation = {
    attributes = {
      degrees = {
        type = 'number',
      },
    },
    extends = 'animation',
  },
  scale = {
    attributes = {
      fromscalex = {
        type = 'number',
      },
      fromscaley = {
        type = 'number',
      },
      scalex = {
        type = 'number',
      },
      scaley = {
        type = 'number',
      },
      toscalex = {
        type = 'number',
      },
      toscaley = {
        type = 'number',
      },
    },
    children = {
      'origin',
    },
    extends = 'animation',
  },
  scenariopoiframe = {
    extends = 'frame',
  },
  scopedmodifier = {
    attributes = {
      forbidden = {
        type = 'bool',
      },
      fulllockdown = {
        type = 'bool',
      },
      scriptsusegivenenv = {
        type = 'bool',
      },
    },
    children = {
      'actor',
      'layoutframe',
    },
  },
  script = {
    attributes = {
      file = {
        type = 'string',
      },
    },
    text = true,
  },
  scripts = {
    children = {
      'scripttype',
    },
  },
  scripttype = {
    attributes = {
      autoenableinput = {
        type = 'bool',
      },
      ['function'] = {
        type = 'string',
      },
      inherit = {
        type = 'string',
      },
      intrinsicorder = {
        type = 'string',
      },
      method = {
        type = 'string',
      },
    },
    text = true,
    virtual = true,
  },
  scrollchild = {
    children = {
      'frame',
    },
  },
  scrollframe = {
    children = {
      'scrollchild',
    },
    extends = 'frame',
  },
  scrollingmessageframe = {
    -- TODO intrinsic
    extends = 'frame',
  },
  shadow = {
    attributes = {
      x = {
        type = 'number',
      },
      y = {
        type = 'number',
      },
    },
    children = {
      'color',
      'offset',
    },
  },
  simplehtml = {
    children = {
      'fontstring',
    },
    extends = 'frame',
  },
  size = {
    attributes = {
      x = {
        type = 'number',
      },
      y = {
        type = 'number',
      },
    },
    children = {
      'absdimension',
    },
  },
  slider = {
    attributes = {
      defaultvalue = {
        type = 'number',
      },
      maxvalue = {
        type = 'number',
      },
      minvalue = {
        type = 'number',
      },
      obeystepondrag = {
        type = 'bool',
      },
      orientation = {
        type = 'string',
      },
      stepsperpage = {
        type = 'number',
      },
      valuestep = {
        type = 'number',
      },
    },
    children = {
      'thumbtexture',
    },
    extends = 'frame',
  },
  statusbar = {
    attributes = {
      defaultvalue = {
        type = 'number',
      },
      drawlayer = {
        type = 'string',
      },
      maxvalue = {
        type = 'number',
      },
      minvalue = {
        type = 'number',
      },
      reversefill = {
        type = 'bool',
      },
    },
    children = {
      'barcolor',
      'bartexture',
    },
    extends = 'frame',
  },
  swipetexture = {
    extends = 'texture',
  },
  tabardmodel = {
    extends = 'frame',
  },
  texcoords = {
    attributes = {
      bottom = {
        type = 'number',
      },
      left = {
        type = 'number',
      },
      right = {
        type = 'number',
      },
      top = {
        type = 'number',
      },
    },
    children = {
      'rect',
    },
  },
  texture = {
    attributes = {
      alphamode = {
        type = 'string',
      },
      atlas = {
        type = 'string',
      },
      desaturated = {
        type = 'bool',
      },
      horiztile = {
        type = 'bool',
      },
      file = {
        type = 'string',
      },
      nonblocking = {
        type = 'bool',
      },
      snaptopixelgrid = {
        type = 'bool',
      },
      texelsnappingbias = {
        type = 'number',
      },
      useatlassize = {
        type = 'bool',
      },
      verttile = {
        type = 'bool',
      },
    },
    children = {
      'animations',
      'color',
      'gradient',
      'scripts',
      'texcoords',
    },
    extends = 'layoutframe',
  },
  thumbtexture = {
    extends = 'texture',
  },
  titleregion = {
    extends = 'layoutframe',
  },
  translation = {
    attributes = {
      offsetx = {
        type = 'number',
      },
      offsety = {
        type = 'number',
      },
    },
    extends = 'animation',
  },
  ui = {
    attributes = {
      ['xmlns'] = {
        type = 'string',
      },
      ['xmlns:xsi'] = {
        type = 'string',
      },
      ['xsi:schemalocation'] = {
        type = 'string',
      },
    },
    children = {
      'font',
      'fontfamily',
      'include',
      'layoutframe',
      'scopedmodifier',
      'script',
    },
  },
  unitpositionframe = {
    extends = 'frame',
  },
  value = {
    children = {
      'absvalue',
    },
  },
  viewinsets = {
    attributes = {
      bottom = {
        type = 'number',
      },
      left = {
        type = 'number',
      },
      right = {
        type = 'number',
      },
      top = {
        type = 'number',
      },
    },
  },
  worldframe = {
    extends = 'frame',
  },
})

local attributeTypes = {
  bool = function(s)
    local x = string.lower(s)
    return x == 'true' or x == 'false'
  end,
  number = function(s)
    return tonumber(s) ~= nil
  end,
  string = function()
    return true
  end,
  stringlist = function()
    return true
  end,
}

local function validateRoot(root)
  local warnings = {}
  local function run(e, tn, tk)
    assert(e._type == 'ELEMENT', 'invalid xml type ' .. e._type .. ' on child of ' .. tn)
    local tname = string.lower(e._name)
    local ty = lang[tname]
    assert(ty, tname .. ' is not a type')
    assert(not ty.virtual, tname .. ' is virtual and cannot be instantiated')
    local extends = false
    for _, k in ipairs(tk) do
      extends = extends or ty.supertypes[k]
    end
    assert(extends, tname .. ' cannot be a child of ' .. tn)
    for k, v in pairs(e._attr or {}) do
      local attr = ty.attributes[string.lower(k)]
      if not attr then
        table.insert(warnings, 'attribute ' .. k .. ' is not supported by ' .. tname)
      elseif not attributeTypes[attr.type](v) then
        table.insert(warnings, 'attribute ' .. k .. ' has invalid value ' .. v)
      end
    end
    if ty.text then
      assert(e._children, 'missing text in ' .. tname)
      for _, kid in ipairs(e._children) do
        assert(kid._type == 'TEXT', 'invalid xml type ' .. kid._type .. ' on ' .. tname)
      end
    else
      for _, kid in ipairs(e._children or {}) do
        if kid._type == 'TEXT' then
          table.insert(warnings, 'ignoring text kid of ' .. tname)
        else
          run(kid, tname, ty.children)
        end
      end
    end
  end
  run(root, 'toplevel', {'bindings', 'ui'})
  return warnings
end

local function validate(filename)
  local h = require('xmlhandler.dom'):new()
  h.options.commentNode = false
  local file = assert(io.open(filename, 'r'))
  local data = file:read('*all')
  file:close()
  require('xml2lua').parser(h):parse(data)
  return validateRoot(h.root)
end

return {
  validate = validate,
}