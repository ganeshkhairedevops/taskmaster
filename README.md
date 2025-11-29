# TaskMaster Pro - Version 3 (Enhanced UI + Authentication)

Beautiful task management system with modern UI, user authentication, and PostgreSQL database.

## Features
- **User Authentication System**
  - User registration and login
  - Session-based authentication
  - Password hashing for security
  - User-specific task isolation
- **Modern UI Design**
  - Glassmorphism UI design
  - Responsive design
  - Real-time statistics dashboard
- **Task Management**
  - Full CRUD task management
  - Priority levels (high, medium, low)
  - Status tracking (pending, in progress, completed)
  - User-specific tasks
- **Backend & Database**
  - PostgreSQL database
  - RESTful API endpoints
  - Health check endpoint

## Quick Start
```bash
docker-compose up -d
```

## Access
- **Application:** http://localhost:5000
- **Database:** localhost:5433

## New in Version 3
- ✅ User registration and login system
- ✅ Session-based authentication
- ✅ Password security with hashing
- ✅ User isolation (each user sees only their tasks)
- ✅ Welcome message and logout functionality
- ✅ Enhanced security with non-root Docker user
- ✅ Database health checks

## API Endpoints
- `POST /register` - User registration
- `POST /login` - User login
- `GET /logout` - User logout
- `GET /api/tasks` - List user's tasks
- `POST /api/tasks` - Create task
- `PUT /api/tasks/{id}` - Update task
- `DELETE /api/tasks/{id}` - Delete task
- `GET /health` - Health check

## Technology Stack
- **Frontend:** HTML, CSS, JavaScript (Vanilla)
- **Backend:** Python Flask, SQLAlchemy ORM
- **Database:** PostgreSQL 15
- **Authentication:** Session-based with Werkzeug password hashing
- **Containerization:** Docker & Docker Compose

## Security Features
- Password hashing using Werkzeug
- Session management
- User data isolation
- Non-root container execution
- Input validation and sanitization
