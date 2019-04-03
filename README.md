# Splity

Splity est une **application mobile de gestion et partage des dépenses entre amis lors de voyages**. Elle est développée en **Swift**, compatible sur les différents appareils IOS.
Cette application a été créée par **Martin CAYUELAS** et **Nathan GUILLAUD** dans le cadre d'un projet à Polytech Montpellier, en 2019.


## Fonctionnalités

- Voyageur
    - Ajouter un voyageur
    - Visualiser les voyageurs
    - Supprimer un voyageur

- Voyage
    - Ajouter un voyage avec ses voyageurs (participants)
    - Ajouter une photo pour un voyage
    -   Depuis la galerie
    -   Depuis l'appareil photo
    - Visualiser les voyages d'un voyageur
    - Visualiser le coût total d'un voyage
    - Quitter un voyage (pour un voyageur)

- Détails d'un voyage
    - Visualiser les détails d'un voyage (titre, date, photo)
    - Visualiser la balance de chaque participant
    - Visualiser la balance d'un voyageur pour un voyage
    - Visualiser le coût total d'un voyageur pour un voyage

- Dépense
    - Visualiser les dépenses d'un voyage
    - Ajouter une dépense pour un voyage
    - Ajouter différents payeurs, pour différents montants
    - Ajouter différents rembourseurs, pour différents montants
    - Ajouter une photo pour une dépense
    -   Depuis la galerie
    -   Depuis l'appareil photo
    - Visualiser les détails d'une dépense
    - Visualiser une dépense
    - Empêcher l'ajout de la dépense si les montants payés et à rembourser ne sont pas égaux

- Gestion des voyageurs
    - Visualiser les participants (participants actifs, participants ayant quitté avec la date de départ)
    - Visualiser les voyageurs qui ne participent pas au voyage
    - Ajouter un nouveau participant au voyage

- Comment équilibrer
    - Visualiser les dettes de chaque voyageur envers les autres afin d'équilibrer la balance (algo d'équilibrage)
    - Rembourser une dette d'un voyageur pour un autre
    - Visualiser le bilan de chaque voyageur pour un voyage
        - Dépense totale
        - Coût total
