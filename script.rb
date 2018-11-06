gem 'pdf-reader'

require 'pdf-reader'

reader = PDF::Reader.new("/Users/rusucosmin/Desktop/ziuamea.pdf")

text = reader.pages.map do |page|
  page.text.gsub!(/\| \|.*/m, "")
end.join('\n')

text = text.gsub!(/\n(\n)*/, "\n")
text = text.gsub!(/Université de Lausanne.*?KDQGLFDSpe/m, "")
text = text.gsub!(/.*?Location SURSRVpe j.partir du (.*)/, 'Availability: \1')
text = text.gsub!(/.*?Publication de l'annonce le (.*)/, 'Date posted: \1')
text = text.gsub!(/^Remarques : (.*?)(Availability|\z)/m, 'Notes: \1\2')
text = text.gsub!(/Chambre\/Colocation *(.*\S) *fr.([0-9]*) .* *(Oui|Non).*/, 'Landlord: \1, Price: \2 CHF, Furnished: \3')
text = text.gsub!(/^(Dépendante|Colocation(    |\n)|Indépendante).*?([\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*?\.[a-z]+).*?Notes/m, "Type: \\1\nLHBotEmail: \\3\nNotes")

puts text
