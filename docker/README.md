# Docker Development Services

This directory contains Docker Compose configuration for local development services.

## Services

- **PostgreSQL 16** - Relational database
- **Redis 7** - In-memory data store

## Setup

1. Make sure Docker Desktop is installed and running
2. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```
3. (Optional) Customize the `.env` file with your preferred settings

## Usage

Use the `docker-dev.sh` script to manage services:

```bash
# Start all services
./docker-dev.sh start

# Stop all services
./docker-dev.sh stop

# Restart services
./docker-dev.sh restart

# Check status and connection info
./docker-dev.sh status

# View logs
./docker-dev.sh logs

# Follow logs (Ctrl+C to exit)
./docker-dev.sh logs -f

# List containers
./docker-dev.sh ps

# Clean up (removes containers and data)
./docker-dev.sh clean
```

## Connection Information

### PostgreSQL
- **Host**: localhost
- **Port**: 5432 (default)
- **User**: postgres (default)
- **Password**: postgres (default)
- **Database**: development (default)
- **Connection String**: `postgresql://postgres@localhost:5432/development`

### Redis
- **Host**: localhost
- **Port**: 6379 (default)
- **Password**: redis (default)
- **Connection String**: `redis://localhost:6379`

## Data Persistence

Data is persisted in Docker volumes:
- `postgres_data` - PostgreSQL data
- `redis_data` - Redis data

These volumes survive container restarts but will be deleted if you run `./docker-dev.sh clean`.

## Customization

Edit `.env` to customize:
- Database names, users, and passwords
- Port mappings
- Any other environment variables

## Direct Docker Compose Commands

You can also use docker compose directly:

```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# View logs
docker compose logs -f

# Execute commands in containers
docker compose exec postgres psql -U postgres
docker compose exec redis redis-cli
```
