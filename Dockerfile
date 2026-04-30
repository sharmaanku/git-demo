# -----------------------------
# 1. Base Image
# -----------------------------
FROM python:3.9-slim

# -----------------------------
# 2. Metadata (optional but good practice)
# -----------------------------
LABEL maintainer="trainer@example.com"
LABEL app="student-docker-app"
LABEL version="1.0"

# -----------------------------
# 3. Environment Variables
# -----------------------------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV APP_HOME=/app

# -----------------------------
# 4. Set Working Directory
# -----------------------------
WORKDIR $APP_HOME

# -----------------------------
# 5. Install System Dependencies (if needed)
# -----------------------------
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# 6. Copy Requirements First (for caching optimization)
# -----------------------------
COPY requirements.txt .

# -----------------------------
# 7. Install Python Dependencies
# -----------------------------
RUN pip install --no-cache-dir -r requirements.txt

# -----------------------------
# 8. Copy Application Code
# -----------------------------
COPY . .

# -----------------------------
# 9. Create Non-root User (Security Best Practice)
# -----------------------------
RUN useradd -m appuser
USER appuser

# -----------------------------
# 10. Expose Port
# -----------------------------
EXPOSE 5000

# -----------------------------
# 11. Default Command
# -----------------------------
CMD ["python", "app.py"]
