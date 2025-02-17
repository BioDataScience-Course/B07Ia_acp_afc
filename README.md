# Analyse en composantes principales et analyse factorielle des correspondances

Ce projet nécessite d’avoir assimilé l’ensemble des notions du septième modules
du cours de science des données biologiques 2. Ce projet correspond au template <https://github.com/BioDataScience-Course/B07Ia_acp_afc>. Il est distribué
sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Présentation des données

### `crabs` du package {MASS}

Le jeu de données `crabs` provient du package {MASS}. Deux cents *Leptograpsus variegatus* (Fabricius, 1793) ont été mesurés. Une page d'aide est disponible pour en apprendre davantage sur ces données.

### `birds` du package {ade4}

Le jeu de données `birds_atlas.csv` provient du package {ade4}. Ce package regroupe plusieurs tableaux de données sous la forme d'une liste. Le tableau `birds` fait partie de `atlas`. Une page d'aide globale est disponible pour l'ensemble des tableaux sous `?ade4::atlas`.

## Objectifs

Ce projet est individuel et cadré. Il doit vous permettre de démontrer les compétences suivantes :

-   être capable d'utiliser et d'interpréter une analyse en composantes principales

-   pouvoir mettre en œuvre et interpréter une analyse factorielle des correspondances

## Consignes

Ce projet est en deux parties. La première partie traite de l'analyse en composantes principales et la seconde de l'analyse factorielle des correspondances. Commencez par compléter le fichier `crabs_pca.qmd`. Ensuite, complétez le fichier `birds_ca.qmd` pour réaliser une AFC.

N'oubliez pas de faire un "Rendu" de vos documents en HTML à la fin pour vérifier que tout fonctionne bien, et utilisez les tests à disposition dans l'onglet "Construire" -> bouton "Construire tout". Corrigez les erreurs éventuelles rencontrées à ce stade avant de clôturer votre travail. Vérifiez également que votre dernier commit a bien été pushé sur GitHub avant la deadline. **Nous ne pouvons pas mettre de points à un document qui ne compile pas sans erreurs ou à un travail qui n'a pas été pushé sur GitHub avant la deadline.**.
