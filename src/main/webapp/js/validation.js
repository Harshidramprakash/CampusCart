// Client-side validation for forms

function validateLoginForm() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    let isValid = true;

    if (!email) {
        document.getElementById('email-error').innerText = 'Email is required';
        isValid = false;
    } else {
        document.getElementById('email-error').innerText = '';
    }

    if (!password) {
        document.getElementById('password-error').innerText = 'Password is required';
        isValid = false;
    } else {
        document.getElementById('password-error').innerText = '';
    }

    return isValid;
}

function validateRegisterForm() {
    const name = document.getElementById('fullName').value.trim();
    const email = document.getElementById('regEmail').value.trim();
    const password = document.getElementById('regPassword').value;
    const confirm = document.getElementById('confirmPassword').value;
    const phone = document.getElementById('phone').value.trim();
    
    let isValid = true;

    if (name.length < 2) {
        document.getElementById('name-error').innerText = 'Name must be at least 2 characters';
        isValid = false;
    } else {
        document.getElementById('name-error').innerText = '';
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        document.getElementById('email-error').innerText = 'Valid email is required';
        isValid = false;
    } else if (document.getElementById('email-error').innerText === 'Email is already registered') {
        isValid = false;
    } else {
        // Only clear if it's not the server uniqueness error
        if (document.getElementById('email-error').innerText !== 'Email is already registered') {
            document.getElementById('email-error').innerText = '';
        }
    }

    if (password.length < 6) {
        document.getElementById('password-error').innerText = 'Password must be at least 6 characters';
        isValid = false;
    } else {
        document.getElementById('password-error').innerText = '';
    }

    if (password !== confirm) {
        document.getElementById('confirm-error').innerText = 'Passwords do not match';
        isValid = false;
    } else {
        document.getElementById('confirm-error').innerText = '';
    }

    if (phone && !/^\d{10}$/.test(phone)) {
        document.getElementById('phone-error').innerText = 'Phone must be exactly 10 digits';
        isValid = false;
    } else {
        document.getElementById('phone-error').innerText = '';
    }

    return isValid;
}
