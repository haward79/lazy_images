
FROM sonarsource/sonar-scanner-cli:12.1.0.3225_8.0.1

USER root

ENV SCRIPT_PATH=/usr/local/bin/entry.bash

RUN cat > $SCRIPT_PATH <<'EOF'
#!/bin/bash

export SONAR_USER_HOME="${CI_PROJECT_DIR}/.sonar"
export GIT_DEPTH="0"

sonar-scanner \
  -Dsonar.host.url="${SONAR_HOST_URL}" \
  -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
  -Dsonar.qualitygate.wait=true \
  -Dsonar.python.version="${SONAR_PYTHON_VERSION:-3.12}"
EOF

RUN chown scanner-cli: $SCRIPT_PATH
RUN chmod 555 $SCRIPT_PATH

USER scanner-cli

ENTRYPOINT ["/bin/bash"]
