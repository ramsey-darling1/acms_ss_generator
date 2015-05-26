#Grab a website from a URL and write it to static html files
#built as a component for acms
#@rdar

require 'net/http'
require 'oga'

def acms_comp_main(url,src)
   uri = URI(url)
   res = Net::HTTP.get(uri) #pull down the main page
   links = URI::extract(res,'http') #grab all the links
   subpages = grab_subpage_links(links) #pull down the subpages
   write_subpages(subpages) #write the subpages
   write_main(res,src) #write the main page
end

def grab_subpage_links(links)
   #grab all linked subpages
   subpages = []
   if links.count > 0
       links.each do |link|
            if link.length > 7
                sub_uri = URI(link)
                subpages << Net::HTTP.get(sub_uri)
            end
       end
   end
   return subpages
end

def write_main(res,src)
   #write main file
   File.open(src,'w') do |f|
      f.write(res) 
   end
end

def write_subpages(subpages)
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
end

acms_comp_main("http://192.168.33.10/","src/index.html")
