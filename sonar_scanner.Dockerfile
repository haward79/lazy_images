
FROM sonarsource/sonar-scanner-cli:12.1.0.3225_8.0.1

ARG CI_PROJECT_DIR

ENV SONAR_USER_HOME="${CI_PROJECT_DIR}/.sonar"
ENV GIT_DEPTH="0"

RUN cat > /entry.bash <<'EOF'
#!/bin/bash

sonar-scanner \
  -Dsonar.host.url="${SONAR_HOST_URL}" \
  -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
  -Dsonar.qualitygate.wait=true \
  -Dsonar.python.version="${SONAR_PYTHON_VERSION:-3.12}"
EOF

ENTRYPOINT [""]
CMD ["/bin/bash", "/entry.bash"]
