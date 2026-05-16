# PLAYLOGUE
A community video game review web application inspired by platforms like Metacritic. Built with PHP, PostgreSQL and Docker.
## Tech Stack
- Backend: PHP
- Database: PostgreSQL 17
- Infrastructure: Docker, Docker Compose
- Deployment: Azure VM
- Version control: Git
## Features
- Basic user auth, passwords get hashed and queried from the database.
- Game review submision and display
- Can add games to favorites
- Relational database schema design
- Conteinerized with Docker Compose for consistent environments
- Admin panel for Admin username
## Setup

```bash
git clone https://github.com/Kennedy2514/playlogue.git
cd playlogue
docker-compose up --build
```
