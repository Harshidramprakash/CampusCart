# Web Technology Laboratory Experiment Mapping

This document demonstrates how "CIT CampusCart" fulfills all 10 experiments of the 23CS523 Web Technology Laboratory syllabus.

| Experiment | Concept | Implementation in Project | File(s) |
|---|---|---|---|
| **Experiment 1** | Client-side scripting using JavaScript | Client-side form validation for login and registration. Checking empty fields, password match, regex validation. | `js/validation.js`, `register.jsp` |
| **Experiment 2** | Simple web application using Servlet | Multiple Java Servlets handling GET and POST requests to manage routing and business logic. | `LoginServlet.java`, `ProductServlet.java` |
| **Experiment 3** | Simple web application using PHP/JSP | Use of JSP and JSTL for rendering dynamic HTML content based on server data. | `index.jsp`, `products.jsp`, `header.jsp` |
| **Experiment 4** | Cookies and session management | `HttpSession` used for user authentication. Cookies used for "Remember Me" and UI preferences. | `LoginServlet.java`, `LogoutServlet.java`, `AuthenticationFilter.java` |
| **Experiment 5** | Database connectivity using Servlet and JSP/PHP | `DBConnection.java` establishes JDBC connection. DAOs use `PreparedStatement` to interact with MySQL. | `DBConnection.java`, `UserDAO.java` |
| **Experiment 6** | Form validation using AJAX | Live email availability checking during registration; Live product search via Fetch API. | `js/ajax.js`, `CheckEmailServlet.java`, `ProductSearchServlet.java` |
| **Experiment 7** | XML document from server displayed as HTML table | `xml-demo.jsp` uses JavaScript `XMLHttpRequest` to fetch `products.xml` and parse the DOM into a table. | `xml/products.xml`, `xml-demo.jsp` |
| **Experiment 8** | Application using database | Full CRUD operations for Products, Users, Cart, and Orders. | `ProductDAO.java`, `schema.sql`, `AdminServlet.java` |
| **Experiment 9** | E-commerce application | Complete shopping flow: Product listing → Cart → Checkout → Order History. | `CartServlet.java`, `OrderServlet.java`, `checkout.jsp` |
| **Experiment 10** | Testing techniques | Manual testing documentation and test cases provided. | `tests/TESTING.md` |
