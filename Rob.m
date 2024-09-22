function yrob = Rob(y, Fc, Fs)
    % Rob - Robotise le signal audio 'y' en le modulant avec une fréquence 'Fc'.
    %
    % y : Signal audio d'entrée.
    % Fc : Fréquence porteuse pour la modulation (en Hz).
    % Fs : Fréquence d'échantillonnage du signal audio (en Hz).

    % Durée du signal
    n = length(y);
    t = [0:n-1]/Fs;

    % Création du signal de modulation

    modulateur = exp(-1j * 2 * pi * Fc * t');

    % Modulation du signal original
    yrobcomplex = y .* modulateur;
    yrob = real(yrobcomplex);
end