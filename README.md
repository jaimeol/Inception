# 🐳 Inception

**Inception** is a 42 school project focused on creating a secure, modular, and automated infrastructure using **Docker Compose**. The environment includes a WordPress site backed by a MariaDB database, all containerized and following best practices for security, automation, and persistent data.

---

## 📁 Project Structure

```
Inception/
├── Makefile
├── secrets/
│ ├── db_password.txt
│ ├── db_root_password.txt
│ ├── wp_admin_user.txt
│ ├── wp_admin_password.txt
│ ├── wp_admin_email.txt
│ ├── wp_user.txt
│ ├── wp_user_password.txt
│ └── wp_user_email.txt
├── srcs/
│ ├── .env
│ ├── docker-compose.yaml
│ └── requirements/
│ ├── mariadb/
│ ├── nginx/
│ └── wordpress/
└── data/
├── mariadb/
└── wordpress/
```



---

## ⚙️ Services

| Service     | Description                                          |
|-------------|------------------------------------------------------|
| **NGINX**   | Handles HTTPS (TLSv1.2/1.3) and serves WordPress     |
| **WordPress** | CMS written in PHP connected to MariaDB           |
| **MariaDB** | Relational database storing WordPress data          |

---

## 🗂️ Volumes

Persistent data is stored in:

- `/home/<login>/data/mariadb/`
- `/home/<login>/data/wordpress/`

These paths ensure data persistence across container restarts and meet 42 subject requirements.

---

## 🔐 Secrets

Sensitive credentials (e.g., database passwords, WP admin info) are securely managed using **Docker secrets**, located in the `secrets/` directory and injected during container initialization.

---

## 🚀 Usage

### 🛠️ Build and start all services

```bash
make
```

🛑 Stop all services
```bash
make down
```
🧹 Remove all data and volumes

⚠️This will remove your local wordpress and mariadb volumes and will ask for sudo password


```bash
make rmdata
```

🔄 Restart everything from scratch

```bash
make re
```

🌐 Access

⚠️You must configure your /etc/hosts in order to access login.42.fr

 - Visit WordPress at: https://login.42.fr (or your configured domain)

 - Admin credentials are defined in the secrets/ directory.

💡 If the WordPress installation screen shows up, check your secrets and initialization scripts.
