# ecommerce-database

PostgreSQL database repository for the end-to-end Ecommerce project.

## Start

```bash
docker compose up -d
```

Database:
- Host: localhost
- Port: 5432
- Database: ecommerce
- User: ecommerce
- Password: ecommerce

The SQL scripts automatically create tables and sample data on the first database initialization.

## Stop

```bash
docker compose down
```

To remove the database volume too:

```bash
docker compose down -v
```

The backend connects using:

```text
jdbc:postgresql://localhost:5432/ecommerce
```
