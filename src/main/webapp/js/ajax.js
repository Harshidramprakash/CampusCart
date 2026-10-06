// AJAX implementations

function checkEmailAvailability() {
    const emailInput = document.getElementById('regEmail');
    const email = emailInput.value.trim();
    const errorDiv = document.getElementById('email-error');
    const successDiv = document.getElementById('email-success');
    const submitBtn = document.getElementById('regSubmitBtn');

    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        errorDiv.innerText = '';
        successDiv.innerText = '';
        return;
    }

    // Use Fetch API
    fetch('check-email?email=' + encodeURIComponent(email))
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                if (data.exists) {
                    errorDiv.innerText = data.message;
                    successDiv.innerText = '';
                    submitBtn.disabled = true;
                } else {
                    errorDiv.innerText = '';
                    successDiv.innerText = data.message;
                    submitBtn.disabled = false;
                }
            }
        })
        .catch(err => console.error('Error checking email:', err));
}

function searchProducts() {
    const query = document.getElementById('searchInput').value.trim();
    const grid = document.getElementById('productsGrid');
    
    // If empty, we could reload the page or fetch all products. 
    // Here we'll just redirect to clear search or fetch via AJAX.
    if (!query) {
        window.location.href = 'products';
        return;
    }

    fetch('search-products?query=' + encodeURIComponent(query))
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                updateProductsGrid(data.data);
            }
        })
        .catch(err => console.error('Error searching products:', err));
}

function updateProductsGrid(products) {
    const grid = document.getElementById('productsGrid');
    grid.innerHTML = '';

    if (products.length === 0) {
        grid.innerHTML = '<p>No products found matching your search.</p>';
        return;
    }

    products.forEach(p => {
        const card = document.createElement('div');
        card.className = 'product-card';
        
        // Disable button logic
        let buttonHtml = '';
        if (p.stock > 0) {
            buttonHtml = `<form action="cart" method="POST" style="display:inline;">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${p.productId}">
                <button type="submit" class="btn btn-primary">Add to Cart</button>
            </form>`;
        } else {
            buttonHtml = `<span class="out-of-stock">Out of Stock</span>`;
        }

        card.innerHTML = `
            <img src="${p.imageUrl}" alt="${p.name}" class="product-img">
            <div class="product-info">
                <span class="category-tag">${p.category}</span>
                <h3>${p.name}</h3>
                <p class="price">₹${p.price}</p>
                
                <div class="product-actions">
                    <a href="products?action=detail&id=${p.productId}" class="btn btn-outline">View Details</a>
                    ${buttonHtml}
                </div>
            </div>
        `;
        grid.appendChild(card);
    });
}
