function ybitcrushed = Bitcrusher(y, bitDepth)
    % y: Signal audio d'entrée
    % bitDepth: Profondeur de bit souhaitée (généralement entre 1 et 16)
    % Fs: Fréquence d'échantillonnage

    % Normalisation du signal entre -1 et 1
    y = y / max(abs(y));

    % Calcul du facteur de réduction
    factor = 2^(bitDepth) - 1;

    % Application de l'effet de bitcrushing
    ybitcrushed = round(y * factor) / factor;

    % Réajustement en fonction de la gamme originale
    ybitcrushed = ybitcrushed * max(abs(y));
end
