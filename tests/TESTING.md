# CIT CampusCart - Testing Documentation

This document contains the manual test cases for verifying the functionality of the CIT CampusCart academic project.

## Test Cases

| Test ID | Description | Input | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| TC01 | Registration | Valid name, email, password, phone, address | User is registered and redirected to login page | User registered, redirect successful | PASS |
| TC02 | Duplicate registration | Email already in DB | Error message: "Email is already registered" | Error message displayed | PASS |
| TC03 | Valid login | Valid email and password | User logs in, session created, redirected to products page | Logged in, redirected | PASS |
| TC04 | Invalid login | Wrong password or email | Error message: "Invalid email or password" | Error message displayed | PASS |
| TC05 | Logout | Click logout link | Session invalidated, redirected to login page | Session cleared, redirected | PASS |
| TC06 | Product listing | Navigate to /products | Products displayed from database | Grid of products visible | PASS |
| TC07 | Product search | Type in search box | AJAX fetches matching products and updates grid | Grid updates live | PASS |
| TC08 | Add to cart | Click "Add to Cart" | Item added to cart table in DB, redirected to cart | Item in cart, quantity correct | PASS |
| TC09 | Update cart | Change quantity in cart | Cart item quantity updated, subtotal recalculates | Quantity and total updated | PASS |
| TC10 | Remove cart item | Click "Remove" | Item removed from cart table in DB | Item disappears, total updates | PASS |
| TC11 | Checkout | Provide address, choose payment | Order created, items moved to order_items, stock decreased, cart cleared | Order success, cart empty | PASS |
| TC12 | Order history | Navigate to /orders | List of user's past orders displayed | Orders visible with correct status | PASS |
| TC13 | Admin authorization | Access /admin as student | Redirected to home with error | Access denied | PASS |
| TC14 | Product CRUD | Admin adds, edits, deletes product | Products table updated in DB, UI reflects changes | Changes successful | PASS |
| TC15 | AJAX email validation | Type existing email in register form, blur | AJAX call returns "Email is already registered" | Live warning shown | PASS |
| TC16 | XML loading | Navigate to XML demo, click load | JavaScript fetches XML and renders HTML table | Table appears with XML data | PASS |
| TC17 | Session protection | Access /cart without logging in | Redirected to login page | Redirect successful | PASS |

## Automated Testing
Automated testing is configured via JUnit for basic unit tests. To run them, execute:
```bash
mvn clean test
```
*(Note: As this is a Web Technology UI-focused lab, manual end-to-end testing of the Servlets/JSP covers the required experiments).*
