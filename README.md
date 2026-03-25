# 🛒 EatSmart - Boutique E-commerce (Flutter & Dart)

![Aperçu du Projet](./flutter_boutique.png)

## 🎯 Vision du Projet
Ce projet est une application mobile de E-commerce développée avec Flutter. L'objectif est de concevoir une interface utilisateur fluide couplée à une architecture logicielle robuste. Le développement suit la méthodologie **TDD (Test Driven Development)** et respecte les principes du **Clean Code** pour garantir la maintenabilité du système.

---

## 🏗️ Architecture & Organisation

Le projet est structuré selon une séparation claire des responsabilités pour faciliter la gestion du flux de données :

| Fichier | Emplacement | Rôle Technique | Description |
| :--- | :--- | :--- | :--- |
| **main.dart** | `lib/` | **Point d'entrée** | Initialise les variables d'environnement (`.env`) et configure le routeur. |
| **product.dart** | `lib/models/` | **Modèle de données** | Définit la structure d'un produit (nom, prix, image). |
| **cart_item.dart** | `lib/models/` | **Modèle de panier** | Associe un produit à une quantité spécifique. |
| **api_service.dart** | `lib/services/` | **Data Provider** | Gère les requêtes HTTP asynchrones vers l'API externe. |
| **cart_service.dart**| `lib/services/` | **Business Logic** | Gère l'état global du panier et la logique métier associée. |
| **home_screen.dart** | `lib/screens/` | **Interface UI** | Présente la liste des produits récupérés via l'API. |
| **cart_screen.dart** | `lib/screens/` | **Interface UI** | Affiche le récapitulatif de la commande et le calcul du total. |

---

## 🍽️ Concept Technique

* **Models (`lib/models`)** : Représentation des objets métiers et gestion de la sérialisation JSON.
* **Services (`lib/services`)** : Couche d'abstraction pour l'accès aux données (API) et la gestion d'état.
* **Supabase / Backend** : Stockage persistant des données utilisateurs et des commandes.
* **Screens (`lib/screens`)** : Composants visuels et gestion de l'expérience utilisateur (UX).

---

## 🛠️ État d'avancement du Projet

### ✅ Phase 1 : Infrastructure & Backend
- [x] Initialisation du projet Flutter et intégration de `supabase_flutter`.
- [x] Configuration du `main.dart` et gestion des variables d'environnement.

### ✅ Phase 2 : Modélisation & Qualité
- [x] **Product Model** : Implémentation du pattern `factory` pour le parsing JSON.
- [x] **TDD** : Mise en place d'une suite de tests unitaires pour valider la logique métier.

### ✅ Phase 3 : Flux de données & Navigation
- [x] **ApiService** : Intégration de l'API externe avec gestion des erreurs.
- [x] **Cart Logic** : Implémentation du `CartService` (Pattern Singleton).
- [x] **Navigation** : Routage dynamique entre le catalogue et le panier.

### ⏳ Phase 4 : Finalisation
- [ ] **Gestion avancée du panier** : Suppression d'articles et mise à jour des quantités.
- [ ] **Persistance locale** : Sauvegarde de l'état du panier entre les sessions.

---

## 📚 Glossaire Technique

| Mot-clé | Définition | Application dans le projet |
| :--- | :--- | :--- |
| **Static** | Membre de classe | Utilisé pour partager des constantes ou des méthodes utilitaires. |
| **Navigator** | API de navigation | Gère la pile d'écrans (`push/pop`) pour la navigation. |
| **Ternaire** | Opérateur conditionnel | Utilisé pour l'affichage conditionnel (ex: panier vide vs plein). |
| **Expanded** | Widget de mise en page | Permet à un composant de saturer l'espace disponible dans une FlexBox. |
| **factory** | Constructeur spécifique | Utilisé pour transformer des données brutes (Map) en objets typés. |

---

## 🧪 Qualité & Tests
La fiabilité du code est assurée par des tests automatisés :
```bash
# Lancer la suite de tests unitaires
flutter test
