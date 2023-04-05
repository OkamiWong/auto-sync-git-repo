local logger = hs.logger.new("PeriodicalTasks", "debug")

function shell(command)
    hs.osascript.applescript(string.format([[do shell script "%s"]], command))
end

function syncGitRepos()
    logger.i("Syncing git repos")
    local repos = {"~/my-sources/projects/archived-web-pages", "~/my-sources/projects/zotero-vault"}
    local COMMAND = [[
        cd %s &&
        git add * &&
        git commit -m \"Auto commit by Hammerspoon\" &&
        git push
    ]]
    for _, repo in ipairs(repos) do
        logger.i("Syncing repo: " .. repo)
        shell(string.format(COMMAND, repo))
        logger.i("Successfully synced repo: " .. repo)
    end
    logger.i("Successfully synced git repos")
end

function executeHourlyTasks()
    logger.i("Executing hourly tasks")
    syncGitRepos()
    logger.i("Successfully executed hourly tasks")
end

hs.timer.doEvery(60 * 60, executeHourlyTasks)

-- Debugging
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "D", function()
--     executeHourlyTasks()
-- end)
