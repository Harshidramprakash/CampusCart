# CIT CampusCart

**Student E-Commerce and Campus Marketplace**  
*23CS523 Web Technology Laboratory Project*

## 1. Project Title
CIT CampusCart

## 2. Problem Statement
Students often need academic materials (textbooks, lab coats, instruments) quickly and affordably. Existing external e-commerce platforms have long delivery times and generic products. CampusCart provides a localized marketplace specifically for the college campus.

## 3. Objectives
- Provide a platform for students to buy and sell campus essentials.
- Demonstrate core web technologies (HTML, CSS, JS, Servlets, JSP, JDBC, AJAX, XML).
- Fulfill all 10 experiments of the Web Technology Laboratory syllabus.

## 4. Features
- User registration and authentication.
- Role-based authorization (Student / Admin).
- Product catalog with categories and live search.
- Shopping cart functionality.
- Simulated checkout and order history.
- Admin dashboard for product and order management.
- Live email availability checking via AJAX.
- XML data loading demonstration.

## 5. Technology Stack
- **Frontend:** HTML5, CSS3, JavaScript, AJAX, XML, JSP, JSTL
- **Backend:** Java Servlets (Java EE)
- **Database:** MySQL
- **Build Tool:** Maven
- **Server:** Apache Tomcat 9/10

## 6. System Architecture
The project follows a standard MVC (Model-View-Controller) architecture:
- **Model:** Java beans (`User`, `Product`, `Order`) and DAOs.
- **View:** JSP pages and CSS/JS.
- **Controller:** Java Servlets (`ProductServlet`, `CartServlet`, etc.).

## 7. Database Schema
Core tables: `users`, `products`, `cart`, `orders`, `order_items`.
Foreign keys maintain referential integrity. Passwords are hashed using SHA-256.

## 8. Project Structure
```
src/main/
├── java/com/campuscart/
│   ├── dao/          (Database Access Objects)
│   ├── filter/       (Authentication Filters)
│   ├── model/        (Java Beans)
│   ├── servlet/      (Controllers)
│   └── util/         (Password hashing)
├── resources/
│   └── db.properties (Database credentials)
└── webapp/           (JSP, CSS, JS, XML)
```

## 9. Setup Instructions
1. Install Java JDK 11+, Apache Maven, and MySQL.
2. Clone/extract the project.
3. Execute the `database/schema.sql` script in your MySQL server.
4. Update `src/main/resources/db.properties` with your MySQL credentials.
5. Build the project using Maven.

## 10. Database Configuration
The application uses environment variables for database configuration to ensure security in production:

- `DB_URL`
- `DB_USERNAME`
- `DB_PASSWORD`

For local development, create a `src/main/resources/db.properties` file:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/campuscart_db?useSSL=false
db.username=root
db.password=root
```
This file is intentionally ignored by git to prevent exposing local credentials. An `.env.example` is also provided in the repository.

## 11. Maven Build
*(Note: Maven was unavailable in the test environment, but this is the standard build command)*
Run the following command in the project root:
```bash
mvn clean package
```
This generates `CampusCart.war` in the `target/` directory.

## 12. Tomcat Deployment
1. Copy `target/CampusCart.war` to your Tomcat `webapps/` directory.
2. Start Tomcat (`bin/startup.bat` or `bin/startup.sh`).
3. Open a browser and navigate to: `http://localhost:8080/CampusCart`

## 13. Default Accounts
**Admin Account:**
- Email: `admin@campuscart.com`
- Password: `admin123`

## 14. Testing
Refer to `tests/TESTING.md` for manual test cases and procedures.

## 15. Experiment Mapping
Refer to `EXPERIMENT_MAPPING.md` to see how the syllabus maps to the code.

## 16. Security Features
- Prepared statements prevent SQL Injection.
- Passwords are one-way hashed using SHA-256.
- `AuthenticationFilter` prevents unauthorized access to protected routes.
- Client-side and Server-side form validation.

## 17. Future Enhancements
- Real payment gateway integration (Stripe/Razorpay).
- Email notifications on order placement.
- Peer-to-peer selling (students can list their own used books).
