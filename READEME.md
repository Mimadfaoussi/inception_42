# Inception Project

This project involves creating a small Docker-based infrastructure consisting of **NGINX**, **WordPress**, and **MariaDB** services. The infrastructure complies with specific constraints, including the use of **Docker Compose**, custom configurations, and security measures like TLS.

---

## Project Overview

- **NGINX**: Acts as the reverse proxy and the only entry point into the infrastructure, listening on port 443 with TLSv1.2 or TLSv1.3.
- **WordPress**: A PHP-based CMS served by NGINX and connected to MariaDB for dynamic content management.
- **MariaDB**: A relational database system for storing WordPress data.
- **Volumes**: Ensure persistent storage for WordPress files and MariaDB databases.
- **Docker Compose**: Used to manage multi-container deployment and configuration.

---

## Setup Instructions

### Prerequisites

- Docker and Docker Compose installed on the host machine.
- Basic understanding of Docker, NGINX, WordPress, and MariaDB.



### Steps to Set Up the Infrastructure

1. **Clone the Repository**:
   ```bash
   git@github.com:Mimadfaoussi/inception_42.git
   cd inception_42.git
   ```

2. **Prepare the Environment**:
   - Create an `.env` file inside the srcs directory  with the following variables :
     ```dotenv
     WORDPRESS_DB_NAME=wordpress
     WORDPRESS_DB_USER=wordpress_user
     WORDPRESS_DB_PASSWORD=wordpress_pass
     WORDPRESS_DB_HOST=mariadb

     DOMAIN_NAME=mfaoussi.42.fr
     WORDPRESS_TITLE=MyAwesomeSite
     WORDPRESS_ADMIN_USER=myrootad142
     WORDPRESS_ADMIN_PASSWORD=secure_password123
     WORDPRESS_ADMIN_EMAIL=admin@mfaoussi.42.fr
     WORDPRESS_USER=regular_user
     WORDPRESS_USER_PASSWORD=user_password123
     WORDPRESS_USER_EMAIL=user@mfaoussi.42.fr

     MYSQL_DB_HOST=mariadb
     MYSQL_ROOT_PASSWORD=root_password
     MYSQL_DATABASE=wordpress
     MYSQL_USER=wordpress_user
     MYSQL_PASSWORD=wordpress_pass
     MYSQL_ADMIN_USER=site_admin
     MYSQL_ADMIN_PASSWORD=admin_secure_pass
     ```



3. **Build and Start the Services**:
   ```bash
   make up
   ```

4. **Verify the Setup**:
   - we need to alter the /etc/hosts file to include our custom domain name to map to the 127.0.0.1
   - Access WordPress at `mfaoussi.42.fr`.
   - Log in with the admin credentials specified in `.env`.

---

## Configuration Details

### NGINX
- Acts as the reverse proxy for WordPress.
- Listens on port 443 with TLS enabled.
- Custom `nginx.conf` handles static files and forwards PHP requests to WordPress.

### WordPress
- Runs using PHP-FPM on port 9000.
- Automatically installs WordPress and sets up the database on first launch.
- Two users are created:
  - Administrator: `site_admin` (custom username without "admin").
  - Regular user: `regular_user`.

### MariaDB
- Stores WordPress data.
- Initialized using `init_db.sh`, which creates the database and users specified in the `.env` file.

### Volumes
- **MariaDB**: `/home/mfaoussi/data/mariadb` for database storage.
- **WordPress**: `/home/mfaoussi/data/wordpress` for website files.

---

## How to Interact with the Services

### Access MariaDB
   From within the container:
   ```bash
   docker exec -it mariadb mysql -u root -p
   ```

### Access WordPress
- Navigate to `https://mfaoussi.42.fr`.
- Log in using the credentials specified in `.env`.


---

## Credits
- **Inception Project by 42 Network**.

