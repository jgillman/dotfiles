#!/bin/bash
#
# Docker Development Services Management
# Manages PostgreSQL and Redis containers for local development
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILE="${SCRIPT_DIR}/docker-compose.yml"
ENV_FILE="${SCRIPT_DIR}/.env"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

function print_usage() {
    echo "Usage: $0 {start|stop|restart|status|logs|ps|clean}"
    echo ""
    echo "  start    - Start PostgreSQL and Redis containers"
    echo "  stop     - Stop running containers"
    echo "  restart  - Restart containers"
    echo "  status   - Show container status and connection info"
    echo "  logs     - Show container logs (use -f to follow)"
    echo "  ps       - List running containers"
    echo "  clean    - Stop and remove containers and volumes (WARNING: deletes data)"
    echo ""
}

function check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}Error: Docker is not installed or not in PATH${NC}"
        echo "Please install Docker Desktop first"
        exit 1
    fi

    if ! docker info &> /dev/null; then
        echo -e "${YELLOW}Docker daemon is not running${NC}"

        # Check if Docker.app exists
        if [ -d "/Applications/Docker.app" ]; then
            echo -e "${YELLOW}Starting Docker Desktop...${NC}"
            open -a Docker

            # Wait for Docker to start (max 60 seconds)
            echo -e "${BLUE}Waiting for Docker to be ready...${NC}"
            local counter=0
            while ! docker info &> /dev/null && [ $counter -lt 60 ]; do
                printf "."
                sleep 2
                counter=$((counter + 2))
            done
            echo ""

            if docker info &> /dev/null; then
                echo -e "${GREEN}Docker is ready!${NC}"
            else
                echo -e "${RED}Error: Docker failed to start within 60 seconds${NC}"
                echo "Please start Docker Desktop manually and try again"
                exit 1
            fi
        else
            echo -e "${RED}Error: Docker Desktop not found at /Applications/Docker.app${NC}"
            echo "Please install Docker Desktop first"
            exit 1
        fi
    fi
}

function start_services() {
    echo -e "${YELLOW}Starting development services...${NC}"

    # Load .env file if it exists
    if [ -f "${ENV_FILE}" ]; then
        echo -e "${BLUE}Loading environment from ${ENV_FILE}${NC}"
        export $(grep -v '^#' "${ENV_FILE}" | xargs)
    else
        echo -e "${YELLOW}No .env file found, using defaults${NC}"
    fi

    docker compose -f "${COMPOSE_FILE}" up -d

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Services started successfully!${NC}"
        echo ""
        show_status
    else
        echo -e "${RED}Failed to start services${NC}"
        exit 1
    fi
}

function stop_services() {
    echo -e "${YELLOW}Stopping development services...${NC}"
    docker compose -f "${COMPOSE_FILE}" stop

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Services stopped successfully!${NC}"
    else
        echo -e "${RED}Failed to stop services${NC}"
        exit 1
    fi
}

function restart_services() {
    echo -e "${YELLOW}Restarting development services...${NC}"
    docker compose -f "${COMPOSE_FILE}" restart

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Services restarted successfully!${NC}"
        echo ""
        show_status
    else
        echo -e "${RED}Failed to restart services${NC}"
        exit 1
    fi
}

function show_status() {
    echo -e "${BLUE}Container Status:${NC}"
    docker compose -f "${COMPOSE_FILE}" ps
    echo ""

    # Load default values
    POSTGRES_PORT=${POSTGRES_PORT:-5432}
    POSTGRES_USER=${POSTGRES_USER:-postgres}
    POSTGRES_DB=${POSTGRES_DB:-development}
    REDIS_PORT=${REDIS_PORT:-6379}

    echo -e "${BLUE}Connection Information:${NC}"
    echo ""
    echo -e "${GREEN}PostgreSQL:${NC}"
    echo "  Host: localhost"
    echo "  Port: ${POSTGRES_PORT}"
    echo "  User: ${POSTGRES_USER}"
    echo "  Database: ${POSTGRES_DB}"
    echo "  Connection String: postgresql://${POSTGRES_USER}@localhost:${POSTGRES_PORT}/${POSTGRES_DB}"
    echo ""
    echo -e "${GREEN}Redis:${NC}"
    echo "  Host: localhost"
    echo "  Port: ${REDIS_PORT}"
    echo "  Connection String: redis://localhost:${REDIS_PORT}"
}

function show_logs() {
    if [ "$2" == "-f" ]; then
        echo -e "${YELLOW}Following logs (Ctrl+C to exit)...${NC}"
        docker compose -f "${COMPOSE_FILE}" logs -f
    else
        docker compose -f "${COMPOSE_FILE}" logs --tail=100
    fi
}

function list_containers() {
    docker compose -f "${COMPOSE_FILE}" ps -a
}

function clean_services() {
    echo -e "${RED}WARNING: This will remove all containers and volumes, deleting all data!${NC}"
    read -p "Are you sure? (yes/no): " -r
    echo

    if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        echo -e "${YELLOW}Cleaning up services and volumes...${NC}"
        docker compose -f "${COMPOSE_FILE}" down -v

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Cleanup complete!${NC}"
        else
            echo -e "${RED}Failed to clean up services${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}Cleanup cancelled${NC}"
    fi
}

# Check Docker before running commands
check_docker

# Main script logic
case "${1:-}" in
    start)
        start_services
        ;;
    stop)
        stop_services
        ;;
    restart)
        restart_services
        ;;
    status)
        show_status
        ;;
    logs)
        show_logs "$@"
        ;;
    ps)
        list_containers
        ;;
    clean)
        clean_services
        ;;
    *)
        print_usage
        exit 1
        ;;
esac
