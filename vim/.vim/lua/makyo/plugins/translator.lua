local _tl_compat53 = ((tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3) and require('compat53.module'); local string = _tl_compat53 and _tl_compat53.string or string; local M = require('moses')




function flatten(acc, val)
   if M.isArray(val) then
      return M(val):
      reduce(flatten, acc):
      value()
   end

   return M(acc):append({ val }):value()
end




local Chord = {}








local Command = {}




local Mapping = {}







local Layer = {}











function Chord.new(o)
   local self = setmetatable(o or {}, { __index = Chord })
   return self
end



function Chord:to_str()
   local keysstr = M.concat(self:keys(), '')
   return keysstr
end



function Chord:to_path()
   local path = M(self.prefixes or {}):
   append({ self.key }):

   concat('.'):
   value()
   local safe_path = string.gsub(path, "%.([^A-Za-z])", "[%1]")

   return safe_path
end



function Chord:keys()
   local keys = M(self.prefixes or {}):
   append({ self.key }):
   value()

   return keys
end

function Mapping.new(o)
   local self = setmetatable(o or {}, { __index = Mapping })
   return self
end



function Mapping:flatten_accessor()
   local keys = self.accessor:keys()
   return keys
end


function Mapping:map()
   local keys = self.accessor:to_str()
   local cmdfn = self.value[1]





   cmdfn(keys)
end

function Layer.new(o)
   local self = setmetatable(o or {}, { __index = Layer })
   return self
end




function Layer:describe()
   local mappings = M(self.mappings or {}):
   map(function(map, key)
      if M(map):keys():contains('name'):value() then
         local nested_layer = Layer.new({
            chord = Chord.new({ prefixes = self.chord:keys(), key = key }),
            name = map.name,
            mappings = M(map):omit('name'):value(),
         })

         return nested_layer:describe()
      end

      return map[2]
   end):
   value()

   return M.extend({ name = self.name }, mappings)
end


function Layer:get_all_pairings()
   local parent_chord = Chord.new(self.chord)

   local chords_and_commands = M(self.mappings):
   map(function(map, chord)
      local map_chord = Chord.new({ prefixes = parent_chord:keys(), key = chord })

      if M(map):keys():contains('name'):value() then
         local nested_layer = Layer.new({
            chord = map_chord,
            name = map.name,
            mappings = M(map):omit('name'):value(),
         })
         return nested_layer:get_all_pairings()
      end

      local m = Mapping.new({ accessor = map_chord, value = map })
      return m
   end):
   values():
   reduce(flatten, {}):
   value()

   return chords_and_commands
end



function init(map_tree)
   local leader_map = {}

   M(map_tree):each(function(layer, key)
      local l = Layer.new({
         name = layer.name,
         mappings = M(layer):omit('name'):value(),
         chord = Chord.new({ key = key }),
      })
      local pairings = l:get_all_pairings()
      local descriptions = l:describe()


      M.each(pairings, function(m)          m:map() end)

      leader_map[key] = descriptions
   end)

   return leader_map
end

return {
   init = init,
}
