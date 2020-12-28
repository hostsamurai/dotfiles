local M = require 'moses'


-- Utilities -----------------------------------------------------------

function flatten(acc, val)
  if M.isArray(val) then
    return M(val)
      :reduce(flatten, acc)
      :value()
  end

  return M(acc):append({val}):value()
end


-- Types ---------------------------------------------------------------

local record Chord
  prefixes: {string}
  key: string 

  to_str: function(): string
  to_path: function(): string
  keys: function(): {string}
end

local record Command
  value: function()
  description: string
end

local record Mapping
  accessor: Chord
  value: Command | Layer

  flatten_accessor: function(): {string}
  map: function()
end

local record Layer
  chord: Chord
  name: string
  mappings: {Mapping}

  describe: function()
  get_all_pairings: function()
end


-- Type Implementations ------------------------------------------------

function Chord.new(o): Chord
  local self: Chord = setmetatable(o or {}, {__index = Chord })
  return self
end

--- Get all keys as a string
-- @treturn string
function Chord:to_str(): string
  local keysstr = M.concat(self:keys(), '')
  return keysstr
end

--- Retrieve all keys as a path
-- @treturn string
function Chord:to_path(): string
  local path = M(self.prefixes or {})
    :append({ self.key })
    -- FIXME: only do this if path has more than one key
    :concat('.')
    :value()
  local safe_path = string.gsub(path, "%.([^A-Za-z])", "[%1]")

  return safe_path
end

--- Get all keys as a list
-- @treturn {string}
function Chord:keys(): {string}
  local keys = M(self.prefixes or {})
    :append({ self.key })
    :value()

  return keys
end

function Mapping.new(o): Mapping
  local self: Mapping = setmetatable(o or {}, {__index = Mapping })
  return self
end

--- Return a list of keys
-- @treturn {string}
function Mapping:flatten_accessor(): {string}
  local keys = self.accessor:keys()
  return keys
end

--- Create and execute commands to map keys to commands.
function Mapping:map()
  local keys = self.accessor:to_str()
  local cmdfn = self.value[1]

  if M(val):keys():contains('name') then
    error('"name" key is not allowed.')
  end

  cmdfn(keys)
end 

function Layer.new(o): Layer
  local self: Layer = setmetatable(o or {}, { __index = Layer })
  return self
end

--- Extract all layer descriptions.
-- Filters out all layer descriptions, maintaining the tree structure 
-- of the keybinding tree.
function Layer:describe()
  local mappings = M(self.mappings or {})
    :map(function(map, key)
      if M(map):keys():contains('name'):value() then 
        local nested_layer = Layer.new({
          chord = Chord.new({ prefixes = self.chord:keys(), key = key }),
          name = map.name,
          mappings = M(map):omit('name'):value()
        })

        return nested_layer:describe()
      end

      return map[2]
    end)
    :value()

  return M.extend({ name = self.name }, mappings)
end

--- Returns a flat list of keybindings
function Layer:get_all_pairings()
  local parent_chord = Chord.new(self.chord)

  local chords_and_commands = M(self.mappings)
    :map(function(map, chord)
      local map_chord = Chord.new({ prefixes = parent_chord:keys(),  key = chord })

      if M(map):keys():contains('name'):value() then
        local nested_layer = Layer.new({ 
          chord = map_chord, 
          name = map.name, 
          mappings = M(map):omit('name'):value() 
        })
        return nested_layer:get_all_pairings()
      end
    
      local m = Mapping.new({ accessor = map_chord, value = map })
      return m
    end)
    :values()
    :reduce(flatten, {})
    :value()

  return chords_and_commands
end

--- Maps and describes keybindings.
-- @param map_tree
function init(map_tree)
  local leader_map = {}

  M(map_tree):each(function(layer, key)
    local l = Layer.new({ 
      name     = layer.name,
      mappings = M(layer):omit('name'):value(),
      chord    = Chord.new({ key = key })
    })
    local pairings     = l:get_all_pairings()
    local descriptions = l:describe()

    -- Map all keybindings
    M.each(pairings, function(m) m:map() end)
    -- Assign descriptions to each keybinding
    leader_map[key] = descriptions
  end)

  return leader_map
end

return {
  init = init
}
