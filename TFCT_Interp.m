function y = TFCT_Interp(X,t,Nov)
    % y = TFCT_Interp(X, t, hop)
    % Interpolation du vecteur issu de la TFCT
    %
    % X : matrice issue de la TFCT
    % t : vecteur des temps (valeurs réelles) sur lesquels on interpole
    % Pour chaque valeur de t (et chaque colonne), on interpole le module du
    % spectre et on détermine la différence de phase entre 2 colonnes successives de X
    %
    % y : la sortie est une matrice où chaque colonne correspond à l'interpolation
    % de la colonne correspondante de X en préservant le saut de phase d'une colonne à l'autre

    [nl,nc] = size(X); % récupération des dimensions de X

    N = 2*(nl-1);       % calcul de N (= Nfft en principe)

    % Initialisations
    %----------------------
    % Spectre interpolé
    y = zeros(nl, length(t)); 

    % Phase initiale
    phi = angle(X(:,1));      

    % Déphasage entre chaque échantillon de la TF
    dphi0 = zeros(nl,1);      
    dphi0(2:nl) = (2*pi*Nov)./(N./(1:(N/2)));

    % Premier indice de la colonne interpolée à calculer
    % (première colonne de Y). Cet indice sera incrémenté
    % dans la boucle
    Ncy = 1;         

    % On ajoute à X une colonne de zéros pour éviter le problème de
    % X( : , Ncx2) en fin de boucle (Ncx2 peut être égal à nc+1)
    X = [X,zeros(nl,1)];      

    % Boucle pour l'interpolation
    %
    %Pour chaque valeur de t, on calcule la nouvelle colonne de Y à partir de 2
    %colonnes successives de X
    for idx = 1:length(t)
        tvalue = t(idx); % Valeur actuelle de t

        % Détermine les indices des colonnes de X pour l'interpolation
        Ncx1 = max(1, min(nc, floor(tvalue)));  % permet de s'assurer que les indices ne dépassent pas les limites de X
        Ncx2 = min(nc, Ncx1 + 1);                % permet de s'assurer que les indices ne dépassent pas les limites de X

        % Calcul des coefficients pour l'interpolation
        beta = tvalue - floor(tvalue);
        alpha = 1 - beta;

        % Interpolation linéaire du module
        My = alpha * abs(X(:, Ncx1)) + beta * abs(X(:, Ncx2));

        % Mise à jour et normalisation de la phase
        dphi = angle(X(:, Ncx2)) - angle(X(:, Ncx1)) - dphi0;
        dphi = dphi - 2 * pi * round(dphi / (2 * pi));
        phi = phi + dphi + dphi0;

        % Assemble la colonne interpolée de Y
        y(:, Ncy) = My .* exp(1j * phi);

        % Passe à la prochaine colonne interpolée
        Ncy = Ncy + 1;
    end
end