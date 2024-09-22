function yreverb = Reverb(y, gain, delay_ms,Fs)
    % y: Signal audio d'entrée
    % gain: Gain de l'écho (0 < gain < 1)
    % delay: Délai de l'écho en échantillons
    % Fs: Fréquence d'échantillonnage du signal

    % Conversion du délai de millisecondes en échantillons
    delay_samples = round(Fs * (delay_ms / 1000));

    % Préparation du signal de sortie
    yreverb = zeros(size(y));
    
    % Application de l'effet de réverbération
    for i = 1:length(y)
        yreverb(i) = y(i);
        if i-delay_samples > 0
            yreverb(i) = yreverb(i) + gain * yreverb(i-delay_samples);
        end
    end
end
