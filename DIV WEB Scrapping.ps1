$WebResponse = Invoke-WebRequest "https://www.goretroid.com/collections/retro-game-system/products/retroid-pocket-3-handheld-retro-gaming-system-1"
$price = ($WebResponse.ParsedHtml.DocumentElement.GetElementsByTagName('div') | Where {$_.ClassName -match 'price__sale'}).InnerText
