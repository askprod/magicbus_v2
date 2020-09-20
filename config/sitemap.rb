SitemapGenerator::Sitemap.default_host = "http://www.magicbusworld.com" # Your Domain Name
SitemapGenerator::Sitemap.public_path = 'public/'

SitemapGenerator::Sitemap.create do
    add "fr/discover"
    add "fr/travel"
    add "fr/share"
    add "fr/story"
    add "fr/faq"

    add "discover"
    add "travel"
    add "share"
    add "story"
    add "faq"
end