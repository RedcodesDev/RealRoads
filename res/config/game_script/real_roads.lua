local button = nil
local window = nil

function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function get_files(dir)
    local files = {}
    for file in io.popen([[dir "]]..dir..[[" /b /a-d]]):lines() do
        files[#files + 1] = file
    end
    return files
end

function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint  .. k ..  "= "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent-2) .. "}"
    return toprint
end

function data()
    return {
        guiUpdate = function()

            if not button then

                local image = api.gui.comp.ImageView.new("ui/button.tga")
                button = api.gui.comp.ToggleButton.new(image)
                button:onToggle(function()
                    print("toggle")
                    if not window then
                        print("window")
                        local layout = api.gui.layout.BoxLayout.new("VERTICAL")
                        local title = api.gui.comp.TextView.new("Real Roads")
                        local fileButtonText = api.gui.comp.TextView.new("Read file")
                        local fileButton = api.gui.comp.Button.new(fileButtonText, false)
                        fileButton:onClick(function()
                            print("Clicked")
                        end)

                        local files = get_files("roaddata")
                        local list = api.gui.comp.List.new(true, api.gui.util.Orientation.VERTICAL, false)
                        for i = 1, #files do
                            local file = files[i]
                            local text = api.gui.comp.TextView.new(file)
                            local textButton = api.gui.comp.Button.new(text, false)
                            list:addItem(textButton)
                        end

                        layout:addItem(title)
                        layout:addItem(fileButton)
                        layout:addItem(list)

                        window = api.gui.comp.Window.new("Real Roads", layout)
                        window:setIcon("ui/button.tga")
                        window:setPosition(math.floor(1920 / 2), math.floor(1080 / 2))
                    else
                        print("no window")
                        window:remove()
                        window = nil
                    end
                end)

                local menu = api.gui.util.getById("menu.construction"):getLayout()

                menu:addItem(button)

            end
        end
    }
end