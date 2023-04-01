SkyLib.Survival.Profile = SkyLib.Survival.Profile or class()

function SkyLib.Survival.Profile:init()
    log("SkyLib.Survival.Profile : Initialized")

    self._titles_db = {
        [1] = { title = "Rookie", color = Color.white },
        [2] = { title = "Wave 10 Completed", color = Color.white },
        [3] = { title = "Amateur", color = Color.white },
        [4] = { title = "Actually Easy", color = Color.white },
        [5] = { title = "The Undefeated", color = Color.white },
        [6] = { title = "Wave 20 Smashed", color = Color.white },
        [7] = { title = "Pro", color = Color.white },
        [8] = { title = "Chopper Destroyer", color = Color.white },
        [9] = { title = "The Indomitable", color = Color.white },
        [10] = { title = "Wave 30 Destroyed", color = Color.white },
        [11] = { title = "Master", color = Color.white },
        [12] = { title = "Bulldozer Killer", color = Color.white },
        [13] = { title = "The Undying", color = Color.white },
        [14] = { title = "Wave 40 Pulverized", color = Color.white },
        [15] = { title = "Legend", color = Color.white },
        [16] = { title = "Nothing Can Stop Me", color = Color.white },
        [17] = { title = "The Unscathed", color = Color.white },
        [18] = { title = "Wave 50 Was A Joke To Me", color = Color.white },
        [19] = { title = "The Survivor", color = Color.white },
        [20] = { title = "The Madman", color = Color.white },
        [21] = { title = "Wave Crusher", color = Color.white },
        [22] = { title = "WTF ?", color = Color.white },
        [23] = { title = "Developer", color = Color(0.6, 0, 1) },
    }

    self._titles_db = {
        default = {
            "Rookie"
        },
        wave_10 = {
            "Wave 10 Completed",
            "Amateur",
            "Actually Easy",
            "The Undefeated"
        },
        wave_20 = {
            "Wave 20 Smashed",
            "Pro",
            "Chopper Destroyer",
            "The Indomitable"
        },
        wave_30 = {
            "Wave 30 Destroyed",
            "Master",
            "Bulldozer Killer",
            "The Undying"
        },
        wave_40 = {
            "Wave 40 Pulverized",
            "Legend",
            "Nothing Can Stop Me",
            "The Unscathed"
        },
        wave_50 = {
            "Wave 50 Was A Joke To Me",
            "The Survivor"
        },
        wave_100 = {
            "What the fuck?",
            "The Madman",
            "Wave Crusher"
        },
        dev = {
            "Developer"
        },
        tester = {
            "Tester"
        }
    }

    self._titles_db_ids = {}
    self._unlocked_titles = {}

    self:_transform_titles_to_ids()
    self:_give_packages()
end

function SkyLib.Survival.Profile:_transform_titles_to_ids()
    for _, packages in pairs(self._titles_db) do
        for i, title in ipairs(packages) do
            table.insert(self._titles_db_ids, title)
        end
    end
end

function SkyLib.Survival.Profile:_give_packages()
    local steam_id = Steam:userid()
end

function SkyLib.Survival.Profile:_grant_title_package(package_id)
    table.insert(self._unlocked_titles, self._titles_db[package_id])
end