# 🛒 My Restaurant - Boutique Flutter (Projet BLOC 2)

![Aperçu du Projet](./flutter_boutique.png)

## 🎯 Vision du Projet
Ce projet est une application de E-commerce développée avec Flutter. L'objectif est d'allier une interface fluide à une architecture solide, en suivant la méthodologie **TDD (Test Driven Development)** et les principes du **Clean Code**.

---

## 🏗️ Architecture & Organisation (Qui fait quoi ?)

Pour maîtriser le flux de données, nous utilisons l'analogie d'un **Restaurant** :

| Fichier | Emplacement | Rôle (Analogie) | Pourquoi c'est important ? |
| :--- | :--- | :--- | :--- |
| **main.dart** | `lib/` | **Le Directeur** | Il vérifie les clés du resto (`.env`) et lance l'ouverture. |
| **product.dart** | `lib/models/` | **La Fiche Technique** | Définit ce qu'est un "Plat" (nom, prix, photo). |
| **api_service.dart** | `lib/services/` | **Le Fournisseur** | Il fait le trajet jusqu'à l'entrepôt (API) pour ramener les produits. |
| **splash_screen.dart** | `lib/screens/` | **Le Hall d'entrée** | Fait patienter le client 2 sec avec un joli logo orange. |
| **home_screen.dart** | `lib/screens/` | **Le Menu / La Salle** | Affiche la liste des plats une fois qu'ils ont été livrés. |

---

## 🍽️ Concept : My Restaurant (Logique du Code)

* **Models (`lib/models`)** : Les fiches recettes (Ingrédients d'un plat).
* **Services (`lib/services`)** : Le livreur (récupère les stocks via API externe).
* **Supabase** : Le siège social (stocke les clients et les commandes).
* **Screens (`lib/screens`)** : La salle de restauration (l'interface utilisateur).

---

## 🛡️ Infrastructure & Sécurité

* **🔐 Sécurité** : Utilisation d'un fichier `.env` pour les clés API Supabase (masqué par `.gitignore`).
* **📊 Conception (MCD)** : Modélisation via **Looping** pour définir les relations entre Utilisateurs, Produits, Panier et Historique.
* **🚀 Main** : Initialisation asynchrone de Supabase et chargement des variables d'environnement au démarrage.

---

## 🛠️ État d'avancement du Chantier

### ✅ Étape 0 : Infrastructure (Fait)
- [x] Setup du projet Flutter et intégration `supabase_flutter`.
- [x] Configuration du `main.dart` (Chargement `.env` et Router).
- [x] Modélisation de la BDD sur Looping.

### ✅ Étape 1 : Modélisation & Qualité (Fait)
- [x] **Model (product.dart)** : Création du moule avec factory `fromJson`.
- [x] **Clean Code** : Nommage explicite et typage fort (Prix en `double`).
- [x] **TDD** : Mise en place des tests unitaires pour valider les modèles.

### ⏳ Étape 2 : Services & Flux (En cours)
- [x] **ApiService** : Récupération des données réelles depuis Platzi API.
- [x] **Interface** : Création de la `ListView` (Home Screen).
- [ ] **Gestion du Panier** : Simulation d'achat et historique (CRUD).

---

## 📚 Dictionnaire de Pro (Récapitulatif)

| Mot-clé | Analogie Restaurant | Ce que ça fait vraiment |
| :--- | :--- | :--- |
| **Stateless** | Déco fixe (Table) | Widget qui ne change jamais d'aspect. |
| **Stateful** | Caisse (Argent bouge) | Widget qui se redessine via `setState`. |
| **final** | Plat servi (fixé) | Valeur fixée une seule fois à l'exécution. |
| **const** | Réglage usine (Gravité) | Valeur immuable connue à la compilation. |
| **factory** | Traducteur de commande | Crée un objet structuré à partir du JSON brut. |
| **@override** | Spécialité du chef | Remplace une fonction de base par la nôtre. |

---

## 🧪 Qualité & Tests
Pour garantir que nos "recettes" sont toujours bonnes, nous lançons les tests :
```bash
flutter test 
