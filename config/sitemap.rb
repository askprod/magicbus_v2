SitemapGenerator::Sitemap.default_host = "http://www.magicbusworld.com" # Your Domain Name
SitemapGenerator::Sitemap.public_path = 'public/'

SitemapGenerator::Sitemap.create do
    add "fr/discover"
    add "fr/travel"
    add "fr/share"
    add "fr/story"
    add "fr/faq"

    add "en/discover"
    add "en/travel"
    add "en/share"
    add "en/story"
    add "en/faq"
end