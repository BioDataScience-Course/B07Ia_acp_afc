# Vérifications de birds_ca.qmd
birds <- parse_rmd("../../birds_ca.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes birds_ca est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("birds_ca.qmd"))
  # La version compilée HTML du carnet de notes birds_ca est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("birds_ca.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document birds_ca est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Description des données", "Ordination",
    "Discussion et conclusions", "Référence")
    %in% (rmd_node_sections(birds) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes birds_ca ne sont pas toutes
  # présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "importca", "raster", "desccacomment", "ca",
    "screeca", "screecacomment", "biplotca", "biplotcacomment")
    %in% rmd_node_label(birds)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent dans
  # birds_ca.qmd
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(birds))))
  # Un ou plusieurs labels de chunks sont dupliqués dans birds_ca.qmd
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans birds_ca ?", {
  expect_true(birds[[1]]$author != "___")
  expect_true(!grepl("__", birds[[1]]$author))
  expect_true(grepl("^[^_]....+", birds[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", birds[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", birds[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'importca' : importation et skim de `birds`", {
  expect_true(is_identical_to_ref("importca", "names"))
  # Les colonnes dans le tableau `birds` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'importca'.

  expect_true(is_identical_to_ref("importca", "classes"))
  # La nature des variables (classe) dans le tableau `birds` est incorrecte
  # Vérifiez le chunk d'importation des données `importca`.

  expect_true(is_identical_to_ref("importca", "rownames"))
  # Les noms des lignes dans le tableau `birds` ne sont pas celles attendues
  # Vous devez transformer en data.frame et ajouter les numéros des stations de
  # 1 à 23 comme nom de lignes avec la fonction rownames().

  expect_true(is_identical_to_ref("importca", "nrow"))
  # Le nombre de lignes dans le tableau `birds` est incorrect
  # Vous devez avoir 23 lignes pour 23 stations.
})

test_that("Chunks 'raster', 'desccacomment' : description des données", {
  expect_true(is_identical_to_ref("raster"))
  # Le graphique produit par le chunk 'raster' n'est pas celui attendu.
  # Avez-vous bien ajouté la variable station à `birds` ?
  # Avez-vous pivoté les variables relatives aux oiseaux en tableau long en
  # indiquant comme variable résultate 'species' et comme dénombrement 'n' ?
  # Avez-vous réalisé un graphique chart de ce tableau long en utilisant un
  # geom_raster() ?

  expect_true(is_identical_to_ref("desccacomment"))
  # L'interprétation des tableaux descriptifs des données et du graphique sont
  # (partiellement) fausses dans le chunk 'desccacomment'
  # Vous devez cochez les phrases qui décrivent les données d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'ca', 'screeca', 'screecacomment' : AFC, graphique des éboulis et commentaires", {
  expect_true(is_identical_to_ref("ca"))
  # L'objet `birds_ca` n'est pas créé ou il est incorrect.
  # Si les tests précédents relatifs à l'importation et au remainement des
  # données `birds` ont réussi, vérifiez le code dans ce chunk 'ca' par rapport
  # à la consigne.
  # Assurez-vous de bien assigner le résultat à la variable `birds_ca`.

  expect_true(is_identical_to_ref("screeca"))
  # Le graphique produit par le chunk 'screeca' n'est pas celui attendu.
  # Vous devez réaliser le graphique des éboulis de l'AFC en utilisant une
  # variante de chart()

  expect_true(is_identical_to_ref("screecacomment"))
  # L'interprétation de l'AFC et du graphique des éboulis est (partiellement)
  # fausse dans le chunk 'screecacomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'biplot', 'biplotcomment' : Biplot de l'AFC et interprétation", {
  expect_true(is_identical_to_ref("biplotca"))
  # Le biplot de l'AFC n'est pas fait ou n'est pas celui attendu dans le chunk
  # 'biplotca'.
  # Avez-vous bien sélectionné le premier plan de l'AFC ?
  # Avez-vous fixé aspect.ratio à 0.6 ?
  # Avez-vous utilisé repel = TRUE ?

  expect_true(is_identical_to_ref("biplotcacomment"))
  # L'interprétation du biplot de l'AFC est (partiellement) fausse dans le
  # chunk 'biplotcomment'
  # Vous devez cochez les phrases qui décrivent le dendrogramme d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("La partie discussion et conclusion est-elle remplie ?", {
  expect_true(!(rmd_select(birds, by_section("Discussion et conclusions")) |>
      as_document() |> grepl("...Votre discussion ici...", x = _,
        fixed = TRUE) |> any()))
  # La discussion et les conclusions ne sont pas faites
  # Remplacez "...Votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})
