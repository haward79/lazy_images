
FROM sonarsource/sonar-scanner-cli:12.1.0.3225_8.0.1

USER root

ENV SCRIPT_PATH=/usr/local/bin/entry.bash

RUN cat > $SCRIPT_PATH <<'EOF'
#!/bin/bash

[[ $GIT_DEPTH -eq 0 ]] || {
  echo 'Please set env var $GIT_DEPTH to 0 in your CI job'
  exit 1
}

export SONAR_USER_HOME="${CI_PROJECT_DIR}/.sonar"
export SONAR_PROJECT_VERSION="${CI_COMMIT_SHORT_SHA}"

sonar-scanner \
  -Dsonar.host.url="${SONAR_HOST_URL}" \
  -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
  -Dsonar.projectVersion="${SONAR_PROJECT_VERSION}" \
  -Dsonar.python.version="${SONAR_PYTHON_VERSION:-3.12}" \
  -Dsonar.qualitygate.wait=true
EOF

RUN chown scanner-cli: $SCRIPT_PATH
RUN chmod 555 $SCRIPT_PATH

USER scanner-cli

ENTRYPOINT [""]
