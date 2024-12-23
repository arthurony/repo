-- Anime Center BR Extension for Shosetsu
local id = 123456 -- ID único para a extensão
local baseURL = "https://animecenterbr.com"
local name = "Anime Center BR"

local function shrinkURL(url)
    return url:gsub("^" .. baseURL, "")
end

local function expandURL(path)
    return baseURL .. path
end

-- Função para buscar capítulos de uma novel
local function getChapterList(novelID)
    local url = expandURL("/wp-json/wp/v2/posts/" .. novelID)
    local data = GETJson(url)
    local chapters = {}
    local contentHTML = data.content.rendered
    -- Parse manual da lista de capítulos se necessário
    -- Inserir capítulos na tabela chapters
    return chapters
end

-- Função para processar uma novel
local function parseNovel(novelID)
    local url = expandURL("/wp-json/wp/v2/posts/" .. novelID)
    local data = GETJson(url)
    return NovelInfo {
        title = data.title.rendered,
        imageURL = data.featured_media_url or "",
        description = data.content.rendered,
        chapters = getChapterList(novelID)
    }
end

-- Função para processar a lista de novels
local function parseList()
    local url = expandURL("/wp-json/wp/v2/pages/17073")
    local data = GETJson(url)
    local contentHTML = data.content.rendered
    local novels = {}
    -- Parse manual do HTML para extrair títulos e links
    return novels
end

return {
    id = id,
    name = name,
    baseURL = baseURL,
    hasSearch = false,
    listings = {
        Listing("Lista de Novels", true, function(data)
            return parseList()
        end)
    },
    parseNovel = parseNovel
}
