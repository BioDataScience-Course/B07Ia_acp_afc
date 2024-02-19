# Vérifications de crabs_pca.qmd
crabs <- parse_rmd("../../crabs_pca.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes crabs_pca est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("crabs_pca.qmd"))
  # La version compilée HTML du carnet de notes crabs_pca est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("crabs_pca.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document crabs_pca est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Exploration des données", "ACP sur les variables brutes",
    "ACP sur des indices calculés", "Discussion et conclusions", "Référence")
    %in% (rmd_node_sections(crabs) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes crabs_pca ne sont pas toutes
  # présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "importpca", "scatmat", "descpcacomment", "pca",
    "screepca", "screepcacomment", "crabs2", "pca2", "screepca2",
    "screepca2comment", "loadingspca2", "loadingspca2comment", "newvar",
    "scorespca2", "scorespca2comment")
    %in% rmd_node_label(crabs)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent dans
  # crabs_pca.qmd
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(crabs))))
  # Un ou plusieurs labels de chunks sont dupliqués dans crabs_pca.qmd
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans crabs_pca ?", {
  expect_true(crabs[[1]]$author != "___")
  expect_true(!grepl("__", crabs[[1]]$author))
  expect_true(grepl("^[^_]....+", crabs[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", crabs[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", crabs[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'importpca' : importation et skim de `crabs`", {
  expect_true(is_identical_to_ref("importpca", "names"))
  # Les colonnes dans le tableau `crabs` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'importpca'.

  expect_true(is_identical_to_ref("importpca", "classes"))
  # La nature des variables (classe) dans le tableau `crabs` est incorrecte
  # Vérifiez le chunk d'importation des données `importca`.

  expect_true(is_identical_to_ref("importpca", "nrow"))
  # Le nombre de lignes dans le tableau `crabs` est incorrect
  # Vous devez avoir 200 lignes pour 4 fois 50 crabes mesurés.
})

test_that("Chunks 'scatmat', 'descpcacomment' : description des données", {
  expect_true(is_identical_to_ref("scatmat"))
  # Le graphique produit par le chunk 'scatmat' n'est pas celui attendu.
  # Avez-vous utilisé GGally::ggscatmat() ?
  # Avez-vous réalisé le graphique des 5 variables quantitatives d'intérêt ?

  expect_true(is_identical_to_ref("descpcacomment"))
  # L'interprétation des tableaux descriptifs des données et du graphique sont
  # (partiellement) fausses dans le chunk 'descpcacomment'
  # Vous devez cochez les phrases qui décrivent les données d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'pca', 'screepca', 'screepcacomment' : ACP, graphique des éboulis et commentaires", {
  expect_true(is_identical_to_ref("pca"))
  # L'objet `crabs_pca` n'est pas créé ou il est incorrect.
  # Si les tests précédents relatifs à l'importation et au remaniement des
  # données `crabs` ont réussi, vérifiez le code dans ce chunk 'pca' par rapport
  # à la consigne.
  # Avez-vous standardisé les données ?
  # Assurez-vous de bien assigner le résultat à la variable `crabs_pca`.

  expect_true(is_identical_to_ref("screepca"))
  # Le graphique produit par le chunk 'screepca' n'est pas celui attendu.
  # Vous devez réaliser le graphique des éboulis de l'ACP en utilisant une
  # variante de chart()

  expect_true(is_identical_to_ref("screepcacomment"))
  # L'interprétation de l'ACP et du graphique des éboulis est (partiellement)
  # fausse dans le chunk 'screepcacomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'crabs2' : calcul des ratios dans `crabs2`", {
  expect_true(is_identical_to_ref("crabs2", "names"))
  # Les colonnes dans le tableau `crabs2` ne sont pas celles attendues
  # Vous devez diviser les variables quantitatives par 'length'.

  expect_true(is_identical_to_ref("crabs2", "classes"))
  # La nature des variables (classe) dans le tableau `crabs2` est incorrecte
  # Vérifiez votre calcul des ratios.

  expect_true(is_identical_to_ref("crabs2", "nrow"))
  # Le nombre de lignes dans le tableau `crabs2` est incorrect
  # Vous devez avoir 200 lignes pour 4 fois 50 crabes mesurés.
})

test_that("Chunks 'pca2', 'screepca2', 'screepca2comment' : ACP 2, graphique des éboulis et commentaires", {
  expect_true(is_identical_to_ref("pca2"))
  # L'objet `crabs_pca2` n'est pas créé ou il est incorrect.
  # Si les tests précédents relatifs au calcul des ratios dans `crabs2` ont
  # réussi, vérifiez le code dans ce chunk 'pca2' par rapport à la consigne.
  # Avez-vous standardisé les données ?
  # Vous ne devez pas utiliser le ration length/length qui vaut toujours 1 et
  # n'est donc pas informatif !
  # Assurez-vous de bien assigner le résultat à la variable `crabs_pca2`.

  expect_true(is_identical_to_ref("screepca2"))
  # Le graphique produit par le chunk 'screepca2' n'est pas celui attendu.
  # Vous devez réaliser le graphique des éboulis de l'ACP 2 en utilisant une
  # variante de chart()

  expect_true(is_identical_to_ref("screepca2comment"))
  # L'interprétation de l'ACP 2 et du graphique des éboulis est (partiellement)
  # fausse dans le chunk 'screepca2comment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'loadingspca2', 'loadingspca2comment' : graphique des variables de l'ACP 2", {
  expect_true(is_identical_to_ref("loadingspca2"))
  # Le graphique des variables de votre seconde ACP n'est pas celui attendu.
  # Assurez-vous de bien utiliser `crabs_pac2`

  expect_true(is_identical_to_ref("loadingspca2comment"))
  # L'interprétation du graphique des variables de l'ACP 2 est (partiellement)
  # fausse dans le chunk 'loadingspca2comment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'newvar' : calcul de la variable sp_sex", {
  expect_true(is_identical_to_ref("newvar", "names"))
  # Les colonnes dans le tableau `crabs2` ne sont pas celles attendues
  # Vous devez calculer une nouvelle variable 'sp_sex' qui combine 'species' et
  # 'sex'.

  expect_true(is_identical_to_ref("newvar", "classes"))
  # La nature des variables (classe) dans le tableau `crabs2` est incorrecte
  # Vérifiez votre calcul de la variable 'sp_sex'.

  expect_true(is_identical_to_ref("newvar", "nrow"))
  # Le nombre de lignes dans le tableau `crabs2` est incorrect
  # Vous devez avoir 200 lignes pour 4 fois 50 crabes mesurés.
})

test_that("Chunks 'scorespca2', 'scorespca2comment' : graphique des individus de l'ACP 2", {
  expect_true(is_identical_to_ref("scorespca2"))
  # Le graphique des individus de votre seconde ACP n'est pas celui attendu.
  # Assurez-vous de bien utiliser `crabs_pac2`

  expect_true(is_identical_to_ref("scorespca2comment"))
  # L'interprétation du graphique des individus de l'ACP 2 est (partiellement)
  # fausse dans le chunk 'scorespca2comment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("La partie discussion et conclusions est-elle remplie ?", {
  expect_true(!(rmd_select(crabs, by_section("Discussion et conclusions")) |>
      as_document() |> grepl("...Votre discussion ici...", x = _,
        fixed = TRUE) |> any()))
  # La discussion et les conclusions ne sont pas faites
  # Remplacez "...Votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})
