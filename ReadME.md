Since we had some issue with the configuration which I am currenttly working on to resolve, the browser cannot get access to the back-end server. For that reason in order to use the backend you can send requests via the terminal using the -k flag (curl -k -X POST/GET your_request)
---

### **README for Backend**
Here’s the `README.md` file for the **backend** part of your project:

```markdown
# Notes App Backend

This is the backend of the **Notes App**, a RESTful API built with **Spring Boot** and connected to a **PostgreSQL** database. The backend handles all CRUD operations for the notes.

---

## **Features**
- REST API for managing notes.
- Persistent storage using PostgreSQL.
- Deployed on Render.

---

## **Tech Stack**
- **Framework**: Spring Boot
- **Database**: PostgreSQL
- **Deployment**: Render
- **Build Tool**: Maven

---

## **Live API**
Access the live backend here: [Notes App Backend](https://your-render-deployed-url.onrender.com/api/notes)

---

## **Getting Started**

### **1. Prerequisites**
- Java 21 or higher installed. [Download here](https://www.oracle.com/java/technologies/javase-jdk21-downloads.html)
- PostgreSQL installed and running. [Download here](https://www.postgresql.org/download/)
- Maven installed. [Download here](https://maven.apache.org/install.html)

### **2. Clone the Repository**
```bash
git clone https://github.com/your-username/notesapp-backend.git
cd notesapp-backend
