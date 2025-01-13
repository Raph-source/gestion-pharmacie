const apiUrl = "http://localhost:3000"; // Changez cela avec votre URL API

// Se connecter
document.getElementById("login-form").addEventListener("submit", async (e) => {
  e.preventDefault();

  const pseudo = document.getElementById("pseudo").value;
  const mdp = document.getElementById("password").value;

  const response = await fetch(`${apiUrl}/pharmacien/login`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ pseudo, mdp }),
  });

  const data = await response.json();
  if (data.reponse == "succès") {
    alert("Connexion réussie !");
    document.getElementById("login-section").classList.add("hidden");
    document.getElementById("product-section").classList.remove("hidden");
    document.getElementById("sale-section").classList.remove("hidden");
    loadProducts();
  } else {
    alert("Erreur de connexion !");
  }
});

// Charger les produits
async function loadProducts() {
  const response = await fetch(`${apiUrl}/produit/liste-produit`);
  const products = await response.json();

  const productList = document.getElementById("product-list");
  productList.innerHTML = "";

  const productSelect = document.getElementById("product-id");
  productSelect.innerHTML = ""

  products.reponse.forEach((product) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td class="px-4 py-2">${product.nom}</td>
      <td class="px-4 py-2">${product.prix}</td>
      <td class="px-4 py-2">${product.quantite}</td>
      <td class="px-4 py-2">
        <button class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600" onclick="editProduct(${product.id}, '${product.nom}', ${product.prix})">Modifier</button>
        <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600" onclick="deleteProduct(${product.id})">Supprimer</button>
      </td>
    `;
    productList.appendChild(row);

    const productItem = document.createElement("div");
    productItem.className = "flex items-center space-x-2";

    productItem.innerHTML = `
      <input type="checkbox" id="product-${product.id}" data-id="${product.id}" data-quantite="${product.quantite}" class="product-checkbox">
      <label for="product-${product.id}">${product.nom} (Prix: ${product.prix}, Stock: ${product.quantite})</label>
      <input type="number" id="quantity-${product.id}" class="quantity-input border rounded px-2 py-1 w-16" min="1" max="${product.quantite}" value="1" disabled>
    `;

    // Activer ou désactiver l'entrée de quantité selon la sélection
    const checkbox = productItem.querySelector(".product-checkbox");
    const quantityInput = productItem.querySelector(".quantity-input");

    checkbox.addEventListener("change", () => {
      quantityInput.disabled = !checkbox.checked;
      if (!checkbox.checked) quantityInput.value = 1; // Réinitialiser la quantité si désélectionné
    });

    productSelect.appendChild(productItem);
  });
}

// Ajouter un produit
document.getElementById("add-product-btn").addEventListener("click", async () => {
  const nom = prompt("Nom du produit :");
  const prix = prompt("Prix du produit :");
  const quantite = prompt("Quantité :");

  await fetch(`${apiUrl}/produit/ajouter-produit`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ nom, prix, quantite }),
  });

  loadProducts();
});

// Supprimer un produit
async function deleteProduct(id) {
  await fetch(`${apiUrl}/produit/supprimer-produit/${id}`, { method: "DELETE" });
  loadProducts();
}

// Modifier un produit
async function editProduct(id, ancienNom, ancienPrix) {
  let nom = prompt("Nouveau nom :");
  let prix = prompt("Nouveau prix :");
    
  if(nom == '')
    nom = ancienNom

  if(prix == '')
    prix = ancienPrix

  await fetch(`${apiUrl}/produit/modifier-produit/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ nom, prix}),
  });

  loadProducts();
}

  
// Gérer le clic sur le bouton "Vendre"
document.getElementById("sellButton").addEventListener("click", () => {
    const selectedProducts = Array.from(document.querySelectorAll(".product-checkbox:checked")).map(checkbox => {
        const productId = checkbox.dataset.id;
        const quantityInput = document.getElementById(`quantity-${productId}`);
        return {
          id: Number(productId),
          quantite: Number(quantityInput.value)
        };
      });
  
      
    if (selectedProducts.length === 0) {
      alert("Veuillez sélectionner au moins un produit.");
      return;
    }
  
    // Appeler l'API de vente avec les produits sélectionnés
    handleSell(selectedProducts);
  });
  
  // Initialiser la liste des produits
  loadProducts();
  
  // Fonction handleSell (comme dans l'exemple précédent)
  async function handleSell(produits) {    
    const response = await fetch(`${apiUrl}/facture/vente`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({produits: produits}),
      });
    
      const facture = await response.json();
      
    // Afficher la facture
    displayFacture(facture);
    
    //actualiser les produits
    loadProducts();
  }
  
  // Fonction displayFacture (comme dans l'exemple précédent)
  function displayFacture(facture) {
    
    const factureSection = document.getElementById("factureSection");
    const factureDetails = document.getElementById("factureDetails");
    
    factureDetails.innerHTML = "";
    // Construire le contenu de la facture
    let content = `
      <p><strong>Facture ID:</strong> ${facture.reponse.id}</p>
      <p><strong>Date:</strong> ${facture.reponse.date}</p>
      <p><strong>Produits:</strong></p>
      <ul class="list-disc pl-5">
    `;
    
    facture.reponse.produits.forEach((product) => {
      content += `<li>${product.nom} (Prix: ${product.prix} FC, Quantité: ${product.quantite})</li>`;
    });
    
    content += `</ul>
      <p><strong>Total:</strong> ${facture.reponse.prixTotal} FC</p>
    `;
    
    // Injecter le contenu dans la section de la facture
    factureDetails.innerHTML = content;
    
    // Afficher la section de la facture
    factureSection.classList.remove("hidden");
  }
  
  // Fonction d'impression (comme dans l'exemple précédent)
  document.getElementById("printFactureBtn").addEventListener("click", () => {
    const factureSection = document.getElementById("factureSection");
    
    // Préparer le contenu à imprimer
    let cacher = document.getElementById("cacher")
    cacher.hidden = true

    window.print();

    cacher.hidden = false
    
});
  
  
  
