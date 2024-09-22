%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOCODEUR : Programme principal r�alisant un vocodeur de phase 
% et permettant de :
%
% 1- modifier le tempo (la vitesse de "prononciation")
%   sans modifier le pitch (fr�quence fondamentale de la parole)
%
% 2- modifier le pitch 
%   sans modifier la vitesse 
%
% 3- "robotiser" une voix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% R�cup�ration d'un signal audio
%--------------------------------

% [y,Fs]=audioread('Audio/Diner.wav');   %signal d'origine
% [y,Fs]=audioread('Audio/Extrait.wav');   %signal d'origine
% [y,Fs]=audioread('Audio/Halleluia.wav');   %signal d'origine
[y,Fs]=audioread('Audio/extrait_cours.wav');

% Remarque : si le signal est en st�r�o, ne traiter qu'une seule voie � la
% fois

% D�finition des vecteurs
%------------------------
n = length(y);  % le nombre total d'�chantillons

f = [0:n-1]*Fs/n; % fr�quences associ�es � chaque point dans la transform�e de Fourier du signal y
t = [0:n-1]/Fs; %  temps en secondes pour chaque point d'�chantillonnage dans le signal y

Y = (1/n)*fft(y); %calcule de la transform�e de Fourier rapide (FFT) du signal y et la normalise en divisant par n

y = y(:,1);

% Courbes (�volution au cours du temps, spectre et spectrogramme)
%--------
% Cr�ation d'une figure pour afficher les trois graphiques
figure; 

% Affichage du signal dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(t, y); % Trac� du signal 'y' en fonction du temps 't'
title('�volution du signal au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Amplitude'); % �tiquette de l'axe des y

% Affichage du spectre du signal
subplot(3,1,2); % Deuxi�me sous-graphique
plot(f, abs(Y)); % Trac� de la magnitude de la FFT de 'y' en fonction de la fr�quence 'f'
title('Spectre du signal'); % Titre du graphique
xlabel('Fr�quence (Hz)'); % �tiquette de l'axe des x
ylabel('Magnitude'); % �tiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x � la moiti� de la fr�quence d'�chantillonnage

% Affichage du spectrogramme du signal
subplot(3,1,3); % Troisi�me sous-graphique
spectrogram(y, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Fr�quence (Hz)'); % �tiquette de l'axe des y


% Ecoute
%-------
sound(y, Fs);
% pause;

%-------------------------------
% 1- MODIFICATION DE LA VITESSE
% (sans modification du pitch)
%-------------------------------
% PLUS LENT
rapp = 2/3;   %peut �tre modifi�
ylent = PVoc(y,rapp,1024); 

% D�finition des vecteurs
%------------------------
nlent = length(ylent);  % le nombre total d'�chantillons

flent = [0:nlent-1]*Fs/nlent; % fr�quences associ�es � chaque point dans la transform�e de Fourier du signal ylent
tlent = [0:nlent-1]/Fs; %  temps en secondes pour chaque point d'�chantillonnage dans le signal ylent

Ylent = (1/nlent)*fft(ylent); %calcule de la transform�e de Fourier rapide (FFT) du signal ylent et la normalise en divisant par nlent

% �coute du signal ralenti
%-------
% sound(ylent, Fs);
% pause; % Pause pour la dur�e du signal


% Courbes
%--------
% Courbes pour le signal ralenti (ylent)
%----------------------------------------
% Cr�ation d'une figure pour afficher les trois graphiques
figure; 

% Affichage du signal ralenti dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(tlent, ylent); % Trac� du signal 'ylent' en fonction du temps 'tlent'
title('�volution du signal ralenti au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Amplitude'); % �tiquette de l'axe des y

% Affichage du spectre du signal ralenti
subplot(3,1,2); % Deuxi�me sous-graphique
plot(flent, abs(Ylent)); % Trac� de la magnitude de la FFT de 'ylent' en fonction de la fr�quence 'flent'
title('Spectre du signal ralenti'); % Titre du graphique
xlabel('Fr�quence (Hz)'); % �tiquette de l'axe des x
ylabel('Magnitude'); % �tiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x � la moiti� de la fr�quence d'�chantillonnage

% Affichage du spectrogramme du signal ralenti
subplot(3,1,3); % Troisi�me sous-graphique
spectrogram(ylent, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal ralenti'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Fr�quence (Hz)'); % �tiquette de l'axe des y


%
% PLUS RAPIDE
rapp = 3/2;   %peut �tre modifi�
yrapide = PVoc(y,rapp,1024); 

% D�finition des vecteurs pour le signal acc�l�r�
%-----------------------------------------------
nrapide = length(yrapide); % le nombre total d'�chantillons pour le signal acc�l�r�

frapide = [0:nrapide-1]*Fs/nrapide; % fr�quences associ�es � chaque point dans la transform�e de Fourier du signal yrapide
trapide = [0:nrapide-1]/Fs; % temps en secondes pour chaque point d'�chantillonnage dans le signal yrapide

Yrapide = (1/nrapide)*fft(yrapide); % calcul de la transform�e de Fourier rapide (FFT) du signal yrapide et la normalise en divisant par nrapide

% �coute du signal acc�l�r�
%---------------------------
% sound(yrapide, Fs);
% pause; % Pause pour la dur�e du signal

% Courbes pour le signal acc�l�r� (yrapide)
%-------------------------------------------
% Cr�ation d'une figure pour afficher les trois graphiques
figure;

% Affichage du signal acc�l�r� dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(trapide, yrapide); % Trac� du signal 'yrapide' en fonction du temps 'trapide'
title('�volution du signal acc�l�r� au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Amplitude'); % �tiquette de l'axe des y

% Affichage du spectre du signal acc�l�r�
subplot(3,1,2); % Deuxi�me sous-graphique
plot(frapide, abs(Yrapide)); % Trac� de la magnitude de la FFT de 'yrapide' en fonction de la fr�quence 'frapide'
title('Spectre du signal acc�l�r�'); % Titre du graphique
xlabel('Fr�quence (Hz)'); % �tiquette de l'axe des x
ylabel('Magnitude'); % �tiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x � la moiti� de la fr�quence d'�chantillonnage

% Affichage du spectrogramme du signal acc�l�r�
subplot(3,1,3); % Troisi�me sous-graphique
spectrogram(yrapide, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal acc�l�r�'); % Titre du graphique
xlabel('Temps (s)'); % �tiquette de l'axe des x
ylabel('Fr�quence (Hz)'); % �tiquette de l'axe des y

%%
%----------------------------------
% 2- MODIFICATION DU PITCH
% (sans modification de vitesse)
%----------------------------------
% Param�tres g�n�raux:
%---------------------
% Nombre de points pour la FFT/IFFT
Nfft = 256;

% Nombre de points (longueur) de la fen�tre de pond�ration 
% (par d�faut fen�tre de Hanning)
Nwind = Nfft;

% Augmentation 
%--------------
a = 2;  b = 3;  %peut �tre modifi�
yvoc_high = PVoc(y, a/b, Nfft, Nwind);
yvoc_high_resampled = resample(yvoc_high, a, b); % R�-�chantillonnage du signal temporel afin de garder la m�me vitesse

% D�finition des vecteurs pour le signal � pitch augment�
%--------------------------------------------------------
nhigh = length(yvoc_high_resampled); % Nombre total d'�chantillons

fhigh = [0:nhigh-1]*Fs/nhigh; % Fr�quences associ�es � chaque point dans la FFT du signal
thigh = [0:nhigh-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage

Yhigh = (1/nhigh)*fft(yvoc_high_resampled); % Calcul de la FFT et normalisation

% �coute du signal � pitch augment�
%-----------------------------------
% sound(yvoc_high_resampled, Fs);
% pause;

% Visualisation du signal � pitch augment�
%-----------------------------------------
figure;

% �volution temporelle
subplot(3,1,1);
plot(thigh, yvoc_high_resampled);
title('�volution du signal � pitch augment�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fhigh, abs(Yhigh));
title('Spectre du signal � pitch augment�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yvoc_high_resampled, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal � pitch augment�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');

%Diminution 
%------------

a = 3;  b = 2;   %peut �tre modifi�
yvoc_low = PVoc(y, a/b, Nfft, Nwind);
yvoc_low_resampled = resample(yvoc_low, a, b); % R�-�chantillonnage du signal temporel afin de garder la m�me vitesse

% D�finition des vecteurs pour le signal � pitch diminu�
%-------------------------------------------------------
nlow = length(yvoc_low_resampled); % Nombre total d'�chantillons

flow = [0:nlow-1]*Fs/nlow; % Fr�quences associ�es � chaque point dans la FFT du signal
tlow = [0:nlow-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage

Ylow = (1/nlow)*fft(yvoc_low_resampled); % Calcul de la FFT et normalisation

% �coute du signal � pitch diminu�
%----------------------------------
% sound(yvoc_low_resampled, Fs);
% pause;

% Visualisation du signal � pitch diminu�
%----------------------------------------
figure;

% �volution temporelle
subplot(3,1,1);
plot(tlow, yvoc_low_resampled);
title('�volution du signal � pitch diminu�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(flow, abs(Ylow));
title('Spectre du signal � pitch diminu�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yvoc_low_resampled, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal � pitch diminu�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');

%-------------------------------------------------------------
%Possibilit� : Somme de l'original et du signal modifi�
%par exemple pour faire un duo
%Attention : on doit prendre le m�me nombre d'�chantillons pour faire la
%somme (--> tronquer le plus "long")
%Remarque : vous pouvez mettre un coefficient � ypitch pour qu'il
%intervienne + ou - dans la somme...
% Tronquer le plus long des deux signaux

longueurMin = min(length(y), length(yvoc_high_resampled));
y_tronque = y(1:longueurMin);
yvoc_high_tronque = yvoc_high_resampled(1:longueurMin);

% Coefficient pour ajuster l'intervention du signal modifi� dans la somme
coef = 0.5; % Ajuster ce coefficient selon le besoin

% Somme du signal original et du signal modifi�
y_combine = y_tronque + coef * yvoc_high_tronque;

% �coute du Signal Combin�
% sound(y_combine, Fs);
% pause;

% D�finition des vecteurs pour le signal combin�
n_combine = length(y_combine);
f_combine = [0:n_combine-1]*Fs/n_combine;
t_combine = [0:n_combine-1]/Fs;
Y_combine = (1/n_combine)*fft(y_combine);

% Cr�ation d'une figure pour les graphiques du signal combin�
figure;

% �volution temporelle
subplot(3,1,1);
plot(t_combine, y_combine);
title('�volution temporelle du signal combin�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(f_combine, abs(Y_combine));
title('Spectre du signal combin�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(y_combine, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal combin�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');

%-----------------------------------------------------------------


%%
%----------------------------
% 3- ROBOTISATION DE LA VOIX
%-----------------------------
% Choix de la fr�quence porteuse (2000, 1000, 500, 200)
Fc = 500;   %peut �tre modifi�

yrob = Rob(y,Fc,Fs);

% �coute du Signal Robotis�
% sound(yrob, Fs); % �coute du signal robotis�

% Courbes du signal robotis�

% D�finition des vecteurs pour le signal robotis�
nrob = length(yrob); % Nombre total d'�chantillons pour le signal robotis�
frob = [0:nrob-1]*Fs/nrob; % Fr�quences associ�es � chaque point dans la FFT du signal
trob = [0:nrob-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage
Yrob = (1/nrob)*fft(yrob); % Calcul de la FFT et normalisation

% Cr�ation d'une figure pour les graphiques du signal robotis�
figure;

% �volution temporelle
subplot(3,1,1);
plot(trob, yrob);
title('�volution temporelle du signal robotis�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(frob, abs(Yrob));
title('Spectre du signal robotis�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yrob, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal robotis�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');


%----------------------------
% 4- SATURATION DE LA VOIX
%----------------------------

ysat = Saturation(y, 30); % Appliquer un effet de saturation mod�r�
% sound(ysat, Fs); % �couter le r�sultat
% Cr�ation d'une figure pour les graphiques du signal satur�
figure;

% D�finition des vecteurs pour le signal satur�
nsat = length(ysat); % Nombre total d'�chantillons pour le signal satur�
fsat = [0:nsat-1]*Fs/nsat; % Fr�quences associ�es � chaque point dans la FFT du signal
tsat = [0:nsat-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage
Ysat = (1/nsat)*fft(ysat); % Calcul de la FFT et normalisation

% �volution temporelle
subplot(3,1,1);
plot(tsat, ysat);
title('�volution temporelle du signal satur�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fsat, abs(Ysat));
title('Spectre du signal satur�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(ysat, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal satur�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');


%----------------------------
% 5- Reverb DE LA VOIX
%----------------------------

yreverb = Reverb(y, 0.5, 50, Fs);  % 50 ms de d�lai
% sound(yreverb, Fs); % �couter le r�sultat
% Cr�ation d'une figure pour les graphiques du signal avec r�verb�ration
figure;

% D�finition des vecteurs pour le signal avec r�verb�ration
nreverb = length(yreverb); % Nombre total d'�chantillons pour le signal r�verb�r�
freverb = [0:nreverb-1]*Fs/nreverb; % Fr�quences associ�es � chaque point dans la FFT du signal
treverb = [0:nreverb-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage
Yreverb = (1/nreverb)*fft(yreverb); % Calcul de la FFT et normalisation

% �volution temporelle
subplot(3,1,1);
plot(treverb, yreverb);
title('�volution temporelle du signal r�verb�r�');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(freverb, abs(Yreverb));
title('Spectre du signal r�verb�r�');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yreverb, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal r�verb�r�');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');


%----------------------------
% 6- Effet Retro/bitcrushed DE LA VOIX
%----------------------------


% Application de l'effet de Bitcrusher
ybitcrushed = Bitcrusher(y, 4);
% sound(ybitcrushed, Fs);

% Calculs n�cessaires pour la visualisation
nbitcrushed = length(ybitcrushed); % Nombre total d'�chantillons pour le signal bitcrushed
fbitcrushed = [0:nbitcrushed-1]*Fs/nbitcrushed; % Fr�quences associ�es � chaque point dans la FFT du signal
tbitcrushed = [0:nbitcrushed-1]/Fs; % Temps en secondes pour chaque point d'�chantillonnage
Ybitcrushed = (1/nbitcrushed)*fft(ybitcrushed); % Calcul de la FFT et normalisation

% Cr�ation d'une figure pour les graphiques du signal bitcrushed
figure;

% �volution temporelle
subplot(3,1,1);
plot(tbitcrushed, ybitcrushed);
title('�volution temporelle du signal bitcrushed');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fbitcrushed, abs(Ybitcrushed));
title('Spectre du signal bitcrushed');
xlabel('Fr�quence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(ybitcrushed, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal bitcrushed');
xlabel('Temps (s)');
ylabel('Fr�quence (Hz)');
