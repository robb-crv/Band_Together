BandTogether

Contributors

- Amarelli Alessandro
- Caravelli Roberto
- Coluzzi Andrea


Installazione: 

L'applicazione richiede l'installazione di elasticsearch: 

da riga di comando lanciare i seguenti comandi:


  git clone https://github.com/Linuxbrew/brew.git ~/.linuxbrew
  
  sh ~/.linuxbrew/bin/brew install elasticsearch
  
  sh ~/.linuxbrew/bin/elasticsearch 

successivamente, per installare le gemme ed effettuare le migration 

 bundle install
 rails db:migrate
 
A questo punto avviamo il server con il comando   
 
 rails s

il comando rails s seleziona di default la porta 3000, dunque aprire il browser e inserire url: localhost:3000


Descrizione:

BandTogether è una Web Application basata su framework Ruby on Rails, in cui gli utenti possono creare Band musicali, reclutare membri tramite annunci e organizzare eventi.

L'utente, al fine di usufruire dei servizi della piattaforma, deve autenticarsi; l'autenticazione può essere effettuata tramite la piattaforma stessa o attraverso servizi esterni come Google o Facebook , basati su protocollo oauth, con chiamate REST alle API di questi ultimi; (in caso di non autenticazione, l'utente non potrà interagire con alcun tipo di servizio)

All'atto dell'autenticazione dovrà fornire varie informazioni, oltre ai dati personali, tra le quali: 

- genere musicale
- strumento suonato

In questo modo, potrà creare la propria rete "social" tramite following di altri utenti e creazioni/partecipazioni di band musicali; 
Una volta loggato, l'utente sarà reindirizzato sulla home page su cui verrà informato di tutti i nuovi eventi programmate dagli Utenti e le Band a lui collegate tramite following;  

L'inserimento di Annunci, permette all'utente, creatore di una band, di reclutare musiciti adeguati alle caratteristiche della Band 
La piattaforma prevede inoltre un sistema di ratings relative a Band e Utenti, basate sulle esperienze avute con questi ultimi


Gli Utenti si dividono in:

- Admin (con privilegi massimi, tra i quali l'accesso al pannello di gestione del sistema che permette di effettuare inserimenti, cancellazioni e aggiornamenti al DB) 

- Generic User (con privilegi base, ovvero modifiche del proprio profilo, creazione di band e annunci, following di utenti e band, visualizzaizone di Band e Utenti)

- Band Member (Generic user membr di una band; può visualizzare gli eventi della band tramite il calendario e lasciare recensioni alla stessa e agli utenti che ne fanno parte)

- Band Manager(Generic user creatore di una band; può modificare le info della band, pubblicare gli annunci ad essa relativi e creare evneti)
