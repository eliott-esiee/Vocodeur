function ysat = Saturation(y, niveauSaturation)
    % Saturation - Applique un effet de saturation au signal audio 'y'.
    %
    % y : Signal audio d'entrée.
    % niveauSaturation : Niveau de saturation à appliquer (valeurs typiques entre 0 et 1).

    % Application d'une fonction non linéaire pour la saturation
    ysat = tanh(niveauSaturation * y);
end
