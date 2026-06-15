FROM node:20-bookworm-slim AS frontend

WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install --legacy-peer-deps
COPY frontend/ ./
RUN npm run build

FROM python:3.12-slim

WORKDIR /app
COPY backend ./backend
COPY --from=frontend /app/frontend/dist ./frontend/dist

RUN pip install --no-cache-dir -r backend/requirements.txt

ENV PYTHONPATH=/app/backend
ENV AUTO_SEED_DEMO=1
ENV AI_MODE=real

WORKDIR /app/backend
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8001}"]
