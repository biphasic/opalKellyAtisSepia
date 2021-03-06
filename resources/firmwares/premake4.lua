if _ACTION == 'uninstall' then
    os.rmdir('/usr/local/share/opalKellyAtisSepia')
else
    local download = function(prefix, targetName, sourceName, sudo)
        if os.isfile(path.join(prefix, targetName)) then
            return 0
        else
            if os.is('linux') then
                local result = os.execute(
                    (sudo and 'sudo' or '')
                    .. ' wget -q -P '
                    .. prefix
                    .. ' '
                    .. '134.157.180.96/opalKellyAtisSepia/firmwares/'
                    .. sourceName
                )
                if result == 0 and targetName ~= sourceName then
                    os.execute((sudo and 'sudo' or '') .. ' mv ' .. path.join(prefix, sourceName) .. ' ' .. path.join(prefix, targetName))
                end
                return result
            elseif os.is('macosx') then
                return os.execute(
                    (sudo and 'sudo' or '')
                    .. ' curl -s "'
                    .. '134.157.180.144:3002/firmwares/'
                    .. sourceName
                    .. '" -o "'
                    .. path.join(prefix, targetName)
                    .. '"'
                )
            end
        end
    end

    os.mkdir('/usr/local/share/opalKellyAtisSepia')
    if download('/usr/local/share/opalKellyAtisSepia', 'atis.1.1.1.bit', 'atis.1.1.1.bit', false) ~= 0 then
        print(
            string.char(27)
            .. '[31mFirmwares download failed. Make sure that you are connected to the Vision Institute local network.'
            .. string.char(27)
            .. '[0m'
        )
        os.exit()
    end
    print(string.char(27) .. '[32mFirmwares installed.' .. string.char(27) .. '[0m')
end
