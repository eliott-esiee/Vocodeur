%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VOCODEUR : Programme principal réalisant un vocodeur de phase 
% et permettant de :
%
% 1- modifier le tempo (la vitesse de "prononciation")
%   sans modifier le pitch (fréquence fondamentale de la parole)
%
% 2- modifier le pitch 
%   sans modifier la vitesse 
%
% 3- "robotiser" une voix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Récupération d'un signal audio
%--------------------------------

% [y,Fs]=audioread('Audio/Diner.wav');   %signal d'origine
% [y,Fs]=audioread('Audio/Extrait.wav');   %signal d'origine
% [y,Fs]=audioread('Audio/Halleluia.wav');   %signal d'origine
[y,Fs]=audioread('Audio/extrait_cours.wav');

% Remarque : si le signal est en stéréo, ne traiter qu'une seule voie à la
% fois

% Définition des vecteurs
%------------------------
n = length(y);  % le nombre total d'échantillons

f = [0:n-1]*Fs/n; % fréquences associées à chaque point dans la transformée de Fourier du signal y
t = [0:n-1]/Fs; %  temps en secondes pour chaque point d'échantillonnage dans le signal y

Y = (1/n)*fft(y); %calcule de la transformée de Fourier rapide (FFT) du signal y et la normalise en divisant par n

y = y(:,1);

% Courbes (évolution au cours du temps, spectre et spectrogramme)
%--------
% Création d'une figure pour afficher les trois graphiques
figure; 

% Affichage du signal dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(t, y); % Tracé du signal 'y' en fonction du temps 't'
title('Évolution du signal au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Amplitude'); % Étiquette de l'axe des y

% Affichage du spectre du signal
subplot(3,1,2); % Deuxième sous-graphique
plot(f, abs(Y)); % Tracé de la magnitude de la FFT de 'y' en fonction de la fréquence 'f'
title('Spectre du signal'); % Titre du graphique
xlabel('Fréquence (Hz)'); % Étiquette de l'axe des x
ylabel('Magnitude'); % Étiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x à la moitié de la fréquence d'échantillonnage

% Affichage du spectrogramme du signal
subplot(3,1,3); % Troisième sous-graphique
spectrogram(y, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Fréquence (Hz)'); % Étiquette de l'axe des y


% Ecoute
%-------
sound(y, Fs);
% pause;

%-------------------------------
% 1- MODIFICATION DE LA VITESSE
% (sans modification du pitch)
%-------------------------------
% PLUS LENT
rapp = 2/3;   %peut être modifié
ylent = PVoc(y,rapp,1024); 

% Définition des vecteurs
%------------------------
nlent = length(ylent);  % le nombre total d'échantillons

flent = [0:nlent-1]*Fs/nlent; % fréquences associées à chaque point dans la transformée de Fourier du signal ylent
tlent = [0:nlent-1]/Fs; %  temps en secondes pour chaque point d'échantillonnage dans le signal ylent

Ylent = (1/nlent)*fft(ylent); %calcule de la transformée de Fourier rapide (FFT) du signal ylent et la normalise en divisant par nlent

% Écoute du signal ralenti
%-------
% sound(ylent, Fs);
% pause; % Pause pour la durée du signal


% Courbes
%--------
% Courbes pour le signal ralenti (ylent)
%----------------------------------------
% Création d'une figure pour afficher les trois graphiques
figure; 

% Affichage du signal ralenti dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(tlent, ylent); % Tracé du signal 'ylent' en fonction du temps 'tlent'
title('Évolution du signal ralenti au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Amplitude'); % Étiquette de l'axe des y

% Affichage du spectre du signal ralenti
subplot(3,1,2); % Deuxième sous-graphique
plot(flent, abs(Ylent)); % Tracé de la magnitude de la FFT de 'ylent' en fonction de la fréquence 'flent'
title('Spectre du signal ralenti'); % Titre du graphique
xlabel('Fréquence (Hz)'); % Étiquette de l'axe des x
ylabel('Magnitude'); % Étiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x à la moitié de la fréquence d'échantillonnage

% Affichage du spectrogramme du signal ralenti
subplot(3,1,3); % Troisième sous-graphique
spectrogram(ylent, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal ralenti'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Fréquence (Hz)'); % Étiquette de l'axe des y


%
% PLUS RAPIDE
rapp = 3/2;   %peut être modifié
yrapide = PVoc(y,rapp,1024); 

% Définition des vecteurs pour le signal accéléré
%-----------------------------------------------
nrapide = length(yrapide); % le nombre total d'échantillons pour le signal accéléré

frapide = [0:nrapide-1]*Fs/nrapide; % fréquences associées à chaque point dans la transformée de Fourier du signal yrapide
trapide = [0:nrapide-1]/Fs; % temps en secondes pour chaque point d'échantillonnage dans le signal yrapide

Yrapide = (1/nrapide)*fft(yrapide); % calcul de la transformée de Fourier rapide (FFT) du signal yrapide et la normalise en divisant par nrapide

% Écoute du signal accéléré
%---------------------------
% sound(yrapide, Fs);
% pause; % Pause pour la durée du signal

% Courbes pour le signal accéléré (yrapide)
%-------------------------------------------
% Création d'une figure pour afficher les trois graphiques
figure;

% Affichage du signal accéléré dans le domaine temporel
subplot(3,1,1); % Premier sous-graphique
plot(trapide, yrapide); % Tracé du signal 'yrapide' en fonction du temps 'trapide'
title('Évolution du signal accéléré au cours du temps'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Amplitude'); % Étiquette de l'axe des y

% Affichage du spectre du signal accéléré
subplot(3,1,2); % Deuxième sous-graphique
plot(frapide, abs(Yrapide)); % Tracé de la magnitude de la FFT de 'yrapide' en fonction de la fréquence 'frapide'
title('Spectre du signal accéléré'); % Titre du graphique
xlabel('Fréquence (Hz)'); % Étiquette de l'axe des x
ylabel('Magnitude'); % Étiquette de l'axe des y
xlim([0 Fs/2]); % Limite l'axe des x à la moitié de la fréquence d'échantillonnage

% Affichage du spectrogramme du signal accéléré
subplot(3,1,3); % Troisième sous-graphique
spectrogram(yrapide, 256, 250, 256, Fs, 'yaxis'); % Calcul et affichage du spectrogramme
title('Spectrogramme du signal accéléré'); % Titre du graphique
xlabel('Temps (s)'); % Étiquette de l'axe des x
ylabel('Fréquence (Hz)'); % Étiquette de l'axe des y

%%
%----------------------------------
% 2- MODIFICATION DU PITCH
% (sans modification de vitesse)
%----------------------------------
% Paramètres généraux:
%---------------------
% Nombre de points pour la FFT/IFFT
Nfft = 256;

% Nombre de points (longueur) de la fenêtre de pondération 
% (par défaut fenêtre de Hanning)
Nwind = Nfft;

% Augmentation 
%--------------
a = 2;  b = 3;  %peut être modifié
yvoc_high = PVoc(y, a/b, Nfft, Nwind);
yvoc_high_resampled = resample(yvoc_high, a, b); % Ré-échantillonnage du signal temporel afin de garder la même vitesse

% Définition des vecteurs pour le signal à pitch augmenté
%--------------------------------------------------------
nhigh = length(yvoc_high_resampled); % Nombre total d'échantillons

fhigh = [0:nhigh-1]*Fs/nhigh; % Fréquences associées à chaque point dans la FFT du signal
thigh = [0:nhigh-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage

Yhigh = (1/nhigh)*fft(yvoc_high_resampled); % Calcul de la FFT et normalisation

% Écoute du signal à pitch augmenté
%-----------------------------------
% sound(yvoc_high_resampled, Fs);
% pause;

% Visualisation du signal à pitch augmenté
%-----------------------------------------
figure;

% Évolution temporelle
subplot(3,1,1);
plot(thigh, yvoc_high_resampled);
title('Évolution du signal à pitch augmenté');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fhigh, abs(Yhigh));
title('Spectre du signal à pitch augmenté');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yvoc_high_resampled, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal à pitch augmenté');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');

%Diminution 
%------------

a = 3;  b = 2;   %peut être modifié
yvoc_low = PVoc(y, a/b, Nfft, Nwind);
yvoc_low_resampled = resample(yvoc_low, a, b); % Ré-échantillonnage du signal temporel afin de garder la même vitesse

% Définition des vecteurs pour le signal à pitch diminué
%-------------------------------------------------------
nlow = length(yvoc_low_resampled); % Nombre total d'échantillons

flow = [0:nlow-1]*Fs/nlow; % Fréquences associées à chaque point dans la FFT du signal
tlow = [0:nlow-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage

Ylow = (1/nlow)*fft(yvoc_low_resampled); % Calcul de la FFT et normalisation

% Écoute du signal à pitch diminué
%----------------------------------
% sound(yvoc_low_resampled, Fs);
% pause;

% Visualisation du signal à pitch diminué
%----------------------------------------
figure;

% Évolution temporelle
subplot(3,1,1);
plot(tlow, yvoc_low_resampled);
title('Évolution du signal à pitch diminué');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(flow, abs(Ylow));
title('Spectre du signal à pitch diminué');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yvoc_low_resampled, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal à pitch diminué');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');

%-------------------------------------------------------------
%Possibilité : Somme de l'original et du signal modifié
%par exemple pour faire un duo
%Attention : on doit prendre le même nombre d'échantillons pour faire la
%somme (--> tronquer le plus "long")
%Remarque : vous pouvez mettre un coefficient à ypitch pour qu'il
%intervienne + ou - dans la somme...
% Tronquer le plus long des deux signaux

longueurMin = min(length(y), length(yvoc_high_resampled));
y_tronque = y(1:longueurMin);
yvoc_high_tronque = yvoc_high_resampled(1:longueurMin);

% Coefficient pour ajuster l'intervention du signal modifié dans la somme
coef = 0.5; % Ajuster ce coefficient selon le besoin

% Somme du signal original et du signal modifié
y_combine = y_tronque + coef * yvoc_high_tronque;

% Écoute du Signal Combiné
% sound(y_combine, Fs);
% pause;

% Définition des vecteurs pour le signal combiné
n_combine = length(y_combine);
f_combine = [0:n_combine-1]*Fs/n_combine;
t_combine = [0:n_combine-1]/Fs;
Y_combine = (1/n_combine)*fft(y_combine);

% Création d'une figure pour les graphiques du signal combiné
figure;

% Évolution temporelle
subplot(3,1,1);
plot(t_combine, y_combine);
title('Évolution temporelle du signal combiné');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(f_combine, abs(Y_combine));
title('Spectre du signal combiné');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(y_combine, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal combiné');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');

%-----------------------------------------------------------------


%%
%----------------------------
% 3- ROBOTISATION DE LA VOIX
%-----------------------------
% Choix de la fréquence porteuse (2000, 1000, 500, 200)
Fc = 500;   %peut être modifié

yrob = Rob(y,Fc,Fs);

% Écoute du Signal Robotisé
% sound(yrob, Fs); % Écoute du signal robotisé

% Courbes du signal robotisé

% Définition des vecteurs pour le signal robotisé
nrob = length(yrob); % Nombre total d'échantillons pour le signal robotisé
frob = [0:nrob-1]*Fs/nrob; % Fréquences associées à chaque point dans la FFT du signal
trob = [0:nrob-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage
Yrob = (1/nrob)*fft(yrob); % Calcul de la FFT et normalisation

% Création d'une figure pour les graphiques du signal robotisé
figure;

% Évolution temporelle
subplot(3,1,1);
plot(trob, yrob);
title('Évolution temporelle du signal robotisé');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(frob, abs(Yrob));
title('Spectre du signal robotisé');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yrob, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal robotisé');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');


%----------------------------
% 4- SATURATION DE LA VOIX
%----------------------------

ysat = Saturation(y, 30); % Appliquer un effet de saturation modéré
% sound(ysat, Fs); % Écouter le résultat
% Création d'une figure pour les graphiques du signal saturé
figure;

% Définition des vecteurs pour le signal saturé
nsat = length(ysat); % Nombre total d'échantillons pour le signal saturé
fsat = [0:nsat-1]*Fs/nsat; % Fréquences associées à chaque point dans la FFT du signal
tsat = [0:nsat-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage
Ysat = (1/nsat)*fft(ysat); % Calcul de la FFT et normalisation

% Évolution temporelle
subplot(3,1,1);
plot(tsat, ysat);
title('Évolution temporelle du signal saturé');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fsat, abs(Ysat));
title('Spectre du signal saturé');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(ysat, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal saturé');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');


%----------------------------
% 5- Reverb DE LA VOIX
%----------------------------

yreverb = Reverb(y, 0.5, 50, Fs);  % 50 ms de délai
% sound(yreverb, Fs); % Écouter le résultat
% Création d'une figure pour les graphiques du signal avec réverbération
figure;

% Définition des vecteurs pour le signal avec réverbération
nreverb = length(yreverb); % Nombre total d'échantillons pour le signal réverbéré
freverb = [0:nreverb-1]*Fs/nreverb; % Fréquences associées à chaque point dans la FFT du signal
treverb = [0:nreverb-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage
Yreverb = (1/nreverb)*fft(yreverb); % Calcul de la FFT et normalisation

% Évolution temporelle
subplot(3,1,1);
plot(treverb, yreverb);
title('Évolution temporelle du signal réverbéré');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(freverb, abs(Yreverb));
title('Spectre du signal réverbéré');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(yreverb, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal réverbéré');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');


%----------------------------
% 6- Effet Retro/bitcrushed DE LA VOIX
%----------------------------


% Application de l'effet de Bitcrusher
ybitcrushed = Bitcrusher(y, 4);
% sound(ybitcrushed, Fs);

% Calculs nécessaires pour la visualisation
nbitcrushed = length(ybitcrushed); % Nombre total d'échantillons pour le signal bitcrushed
fbitcrushed = [0:nbitcrushed-1]*Fs/nbitcrushed; % Fréquences associées à chaque point dans la FFT du signal
tbitcrushed = [0:nbitcrushed-1]/Fs; % Temps en secondes pour chaque point d'échantillonnage
Ybitcrushed = (1/nbitcrushed)*fft(ybitcrushed); % Calcul de la FFT et normalisation

% Création d'une figure pour les graphiques du signal bitcrushed
figure;

% Évolution temporelle
subplot(3,1,1);
plot(tbitcrushed, ybitcrushed);
title('Évolution temporelle du signal bitcrushed');
xlabel('Temps (s)');
ylabel('Amplitude');

% Spectre
subplot(3,1,2);
plot(fbitcrushed, abs(Ybitcrushed));
title('Spectre du signal bitcrushed');
xlabel('Fréquence (Hz)');
ylabel('Magnitude');
xlim([0 Fs/2]);

% Spectrogramme
subplot(3,1,3);
spectrogram(ybitcrushed, 256, 250, 256, Fs, 'yaxis');
title('Spectrogramme du signal bitcrushed');
xlabel('Temps (s)');
ylabel('Fréquence (Hz)');
