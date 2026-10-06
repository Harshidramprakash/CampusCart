// Cart specific interactions (if we were using pure AJAX cart without reload)
// Currently, the cart updates use form submits, but this file is included for structure
// and can handle any cart UI enhancements.

document.addEventListener('DOMContentLoaded', () => {
    // Basic confirmation for removal
    const removeButtons = document.querySelectorAll('.btn-danger');
    removeButtons.forEach(btn => {
        if(btn.innerText.includes('Remove')) {
            btn.addEventListener('click', (e) => {
                if(!confirm('Are you sure you want to remove this item from your cart?')) {
                    e.preventDefault();
                }
            });
        }
    });
});
