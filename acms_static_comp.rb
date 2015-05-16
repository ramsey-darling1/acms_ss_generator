#Grab a website from a URL and write it to static html files
#built as a component for acms
#@rdar

require 'net/http'

def acms_comp(url,src)
   uri = URI(url)
   res = Net::HTTP.get(uri) 
   File.open(src,'w') do |f|
      f.write(res) 
   end
end

acms_comp("http://192.168.33.10/","src/index.html")
