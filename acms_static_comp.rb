#Grab a website from a URL and write it to static html files
#built as a component for acms
#@rdar

require 'net/http'
require 'oga'

def acms_comp(url,src)
   subpages = []
   uri = URI(url)
   res = Net::HTTP.get(uri) #pull down the main page
   links = URI::extract(res,'http') #grab all the links
   #grab all linked subpages
   if links.count > 0
       links.each do |link|
            sub_uri = URI(link)
            subpages << Net::HTTP.get(sub_uri)
       end
   end
   #write subpages
   if subpages.count > 0
       count = 0
       subpages.each do |subpage|
           sub_file = "subpages/subpage-#{count}.html"
            #TO DO: replace link in href of main file to subpages
           File.open(sub_file,'w') do |sf|
               sf.write(subpage)
           end
           count += 1
       end
   end
   #write main file
   File.open(src,'w') do |f|
      f.write(res) 
   end
end

acms_comp("http://192.168.33.10/","src/index.html")
