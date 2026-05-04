# Unprivileged nginx; listens on 8080. Explicit USER satisfies Trivy DS-0002 (policy
# looks for a USER instruction in this Dockerfile, not only the base image metadata).
FROM nginxinc/nginx-unprivileged:1.27-alpine
COPY docs/ /usr/share/nginx/html/
USER nginx
EXPOSE 8080
