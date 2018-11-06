gem 'gmail'

require 'gmail'
require 'set'

puts "Getting old emails..."
emails_sent = Set[]
File.open("emails.txt").each do |line|
  emails_sent.add(line.strip())
end

puts "These are the old emails:"
emails_sent.each do |y|
  puts y
end
puts "Done"

def writeToFile(email, time, article)
  File.write('emails.txt', [email, time, article].join(",") + "\n", File.size('emails.txt'), mode: 'a')
end

def sendEmail(gmail, email)
  gmail.deliver do
    to email
    cc ""
    subject "Accomodation for an EPFL Student"
    text_part do
      body %{Hi!

La traduction française est au bas de l'email.

I saw your room and I am interested in renting it. I will be a Master's student at EPFL (Data Science) - my @epfl.ch email is in CC. I don't smoke, nor drink, only (wine) on rare occasions. I am very professional and I need a place where to sleep as most of the day I will probably learn and work from a cafe, or a coworking space as I freelance part-time.

I will be doing an internship with Google this summer in the US, so I will come to Lausanne on the 23rd September. Therefore, I would like to start the lease on 23rd September 2018 and continue all the way through the whole university year (June 2019). If we agree, I can send you money for the first month of the lease on PayPal, Revolut app or Wire Transfer.

If you want to learn more about me you can also check out my LinkedIn page https://www.linkedin.com/in/rusucosmin Facebook: https://www.facebook.com/cr.rusucosmin or personal page: https://resume.dutylabs.ro/.

Whether or not it is a positive response, I look forward to your response!

Best regards,
Cosmin

-- Français

J'ai vu ta chambre et je suis intéressé à la louer. Je serai étudiant à la maîtrise à l'EPFL (Data Science) - mon email @ epfl.ch est en CC. Je ne fume pas, je ne bois pas, seulement (du vin) en de rares occasions. Je suis très professionnel et j'ai besoin d'un endroit où dormir car la majeure partie de la journée je vais probablement apprendre et travailler à partir d'un café, ou d'un espace de coworking en tant que freelance à temps partiel.

Je vais faire un stage chez Google cet été aux Etats-Unis, je vais donc venir à Lausanne le 23 septembre. Par conséquent, je voudrais commencer le bail le 23 septembre 2018 et continuer tout au long de l'année universitaire (juin 2019). Si nous sommes d'accord, je peux vous envoyer de l'argent pour le premier mois du bail par PayPal, par l'application Revolut ou par virement bancaire.

Si vous voulez en savoir plus sur moi, vous pouvez également consulter mon LinkedIn https://www.linkedin.com/in/rusucosmin Facebook: https://www.facebook.com/cr.rusucosmin ou ma page personnelle: https://resume.dutylabs.ro/.

Que ce soit une réponse positive ou non, j'attends ton réponse avec impatience!

Amicalement,
Cosmin

}
    end
  end
  puts "Sent email to " + email
  File.write('emails.txt', email + "\n", File.size('emails.txt'), mode: 'a')
end

gmail = Gmail.connect('your-email', 'your-password')

File.open("ads.txt").each_slice(6) do |chunk|
  puts chunk.join(" ")
  email = chunk[4].split(' ')[1].strip()
  if (!email.end_with?(".com") and !email.end_with?(".ch") and !email.end_with?(".fr") and !email.end_with?(".org") and !email.end_with?(".net") and !email.end_with?(".be") and !email.end_with?(".it"))
    puts "This email does not look good, please add the correct suffix or click enter"
    puts email
    x = gets
    puts "Correct email: "
    correct = email + x.strip()
    puts correct
    if !emails_sent.member?(correct)
      sendEmail(gmail, correct)
      emails_sent.add(correct)
    end
  else
    puts "Good email: "
    puts email
    if !emails_sent.member?(email)
      sendEmail(gmail, email)
      emails_sent.add(email)
    end
  end
end
